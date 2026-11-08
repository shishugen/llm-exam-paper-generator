package com.ruoyi.exam.util;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.openai.client.OpenAIClient;
import com.openai.client.okhttp.OpenAIOkHttpClient;
import com.openai.models.ResponseFormatJsonObject;
import com.openai.models.chat.completions.ChatCompletion;
import com.openai.models.chat.completions.ChatCompletionCreateParams;
import com.ruoyi.exam.domain.ExamAiCallLog;
import com.ruoyi.exam.domain.ExamModelConfig;
import com.ruoyi.exam.domain.ExamPrompt;
import com.ruoyi.exam.domain.ExamQuestion;
import com.ruoyi.exam.mapper.ExamAiCallLogMapper;
import com.ruoyi.exam.mapper.ExamModelConfigMapper;
import com.ruoyi.exam.mapper.ExamPromptMapper;

// AI 出题：拼提示词、调接口、把返回的 JSON 变成题目，最后记一条调用日志
@Component
public class AiUtil
{
    @Value("${llm.mock:true}")
    private boolean mock;

    @Autowired
    private ExamAiCallLogMapper callLogMapper;

    @Autowired
    private ExamModelConfigMapper modelConfigMapper;

    @Autowired
    private ExamPromptMapper promptMapper;

    public List<ExamQuestion> generate(String knowledgeName, String type, String difficulty,
                                       int count, String rejectReason)
    {
        long start = System.currentTimeMillis();
        int inTokens = 0, outTokens = 0;
        String status = "0", errorMsg = null;
        String modelName = mock ? "mock(离线演示)" : "";
        List<ExamQuestion> result = new ArrayList<>();
        try
        {
            String content;
            if (mock)
            {
                content = mockJson(knowledgeName, count);
                inTokens = 120;
                outTokens = count * 90;
            }
            else
            {
                ExamModelConfig config = getModelConfig();
                String promptText = getPromptText();
                modelName = config.getModelName();
                JSONObject data = null;
                String lastError = null;
                // 第一次带 JSON 模式，失败后去掉参数再试一次
                for (int i = 0; i < 2; i++)
                {
                    try
                    {
                        data = callApi(config, promptText, knowledgeName, type,
                                difficulty, count, rejectReason, i == 0);
                        break;
                    }
                    catch (Exception e)
                    {
                        lastError = e.getMessage();
                    }
                }
                if (data == null)
                {
                    throw new RuntimeException(lastError == null ? "调用大模型失败，请重试" : lastError);
                }
                content = data.getString("content");
                inTokens = data.getIntValue("inTokens");
                outTokens = data.getIntValue("outTokens");
            }
            // 模型有时会在 JSON 前后加说明或换行，先清掉
            content = content.replace("```json", "").replace("```", "")
                    .replace("\n", " ").replace("\r", " ").trim();
            result = parse(cutJsonArray(content));
        }
        catch (Exception e)
        {
            status = "1";
            errorMsg = e.getMessage();
        }
        finally
        {
            ExamAiCallLog log = new ExamAiCallLog();
            log.setTaskType("1");
            log.setModel(modelName);
            log.setPromptTokens(inTokens);
            log.setCompletionTokens(outTokens);
            log.setDurationMs(System.currentTimeMillis() - start);
            log.setCost(BigDecimal.valueOf((inTokens + outTokens) * 0.000015));
            log.setStatus(status);
            log.setErrorMsg(errorMsg == null ? null : errorMsg.substring(0, Math.min(errorMsg.length(), 480)));
            callLogMapper.insertExamAiCallLog(log);
        }
        return result;
    }

    // 取启用的那一条模型配置
    private ExamModelConfig getModelConfig()
    {
        List<ExamModelConfig> list = modelConfigMapper.selectExamModelConfigList(new ExamModelConfig());
        for (ExamModelConfig item : list)
        {
            if ("1".equals(item.getIsDefault()))
            {
                if (item.getApiKey() == null || item.getApiKey().isEmpty())
                {
                    throw new RuntimeException("请先在模型配置里填写密钥");
                }
                return item;
            }
        }
        throw new RuntimeException("请先在模型配置里启用一条记录");
    }

    // 取启用的那一条提示词
    private String getPromptText()
    {
        List<ExamPrompt> list = promptMapper.selectExamPromptList(new ExamPrompt());
        for (ExamPrompt item : list)
        {
            if ("1".equals(item.getIsDefault()))
            {
                return item.getContent();
            }
        }
        throw new RuntimeException("请先在提示词里启用一条记录");
    }

    // 调大模型接口，取回答文字和用了多少 token
    private JSONObject callApi(ExamModelConfig config, String promptText, String knowledgeName,
                               String type, String difficulty, int count, String rejectReason,
                               boolean jsonMode)
    {
        String tip = (rejectReason == null || rejectReason.isEmpty()) ? ""
                : "上次该知识点的题目被驳回，原因是：" + rejectReason + "，请避免同类问题。";
        String prompt = promptText
                .replace("{知识点}", knowledgeName)
                .replace("{题量}", String.valueOf(count))
                .replace("{题型}", typeName(type))
                .replace("{难度}", difficultyName(difficulty))
                .replace("{驳回原因}", tip);

        OpenAIClient client = OpenAIOkHttpClient.builder()
                .apiKey(KeyUtil.decrypt(config.getApiKey()))
                .baseUrl(config.getBaseUrl())
                .build();
        ChatCompletionCreateParams.Builder builder = ChatCompletionCreateParams.builder()
                .model(config.getModelName())
                .addSystemMessage("只输出 JSON 数组")
                .addUserMessage(prompt);
        if (jsonMode)
        {
            builder.responseFormat(ResponseFormatJsonObject.builder().build());
        }
        ChatCompletion completion = client.chat().completions().create(builder.build());

        JSONObject data = new JSONObject();
        data.put("content", completion.choices().get(0).message().content().orElse(""));
        int inTokens = 0, outTokens = 0;
        if (completion.usage().isPresent())
        {
            inTokens = (int) completion.usage().get().promptTokens();
            outTokens = (int) completion.usage().get().completionTokens();
        }
        data.put("inTokens", inTokens);
        data.put("outTokens", outTokens);
        return data;
    }

    // 断网时用本地题目，题干带批次号，多点几次也不会被去重全部拦掉
    private String mockJson(String knowledgeName, int count)
    {
        JSONArray arr = new JSONArray();
        String batch = String.valueOf(System.currentTimeMillis() % 100000);
        for (int i = 1; i <= Math.min(count, 10); i++)
        {
            JSONObject o = new JSONObject();
            o.put("stem", "【" + knowledgeName + "】离线演示题 " + i + "（批次" + batch + "）：关于该知识点，下列说法正确的是（　）。");
            JSONArray opts = new JSONArray();
            opts.add(option("A", "说法正确，符合教材定义"));
            opts.add(option("B", "说法错误，混淆了概念"));
            opts.add(option("C", "说法不完整，缺少前提条件"));
            opts.add(option("D", "以上都不对"));
            o.put("options", opts);
            o.put("answer", "A");
            o.put("analysis", "离线演示题，用于答辩断网时跑通 AI 出题 → 审核 → 组卷的完整流程。");
            o.put("score", 2);
            arr.add(o);
        }
        return arr.toString();
    }

    private JSONObject option(String key, String value)
    {
        JSONObject o = new JSONObject();
        o.put("key", key);
        o.put("value", value);
        return o;
    }

    // 模型会在数组前后写别的话，先截出 [ ... ] 这一段
    private String cutJsonArray(String content)
    {
        int start = content.indexOf('[');
        int end = content.lastIndexOf(']');
        if (start >= 0 && end > start)
        {
            return content.substring(start, end + 1);
        }
        return content;
    }

    private List<ExamQuestion> parse(String content)
    {
        List<ExamQuestion> list = new ArrayList<>();
        for (JSONObject o : JSON.parseArray(content, JSONObject.class))
        {
            ExamQuestion q = new ExamQuestion();
            q.setStem(o.getString("stem"));
            JSONArray opts = o.getJSONArray("options");
            q.setOptions(opts == null ? null : opts.toString());
            q.setAnswer(o.getString("answer"));
            q.setAnalysis(o.getString("analysis"));
            Integer score = o.getInteger("score");
            q.setScore(score == null ? 2 : score);
            list.add(q);
        }
        return list;
    }

    private String typeName(String type)
    {
        if ("2".equals(type)) return "多选";
        if ("3".equals(type)) return "判断";
        if ("4".equals(type)) return "简答";
        if ("5".equals(type)) return "综合";
        return "单选";
    }

    private String difficultyName(String diff)
    {
        if ("1".equals(diff)) return "容易";
        if ("3".equals(diff)) return "较难";
        if ("4".equals(diff)) return "困难";
        return "中等";
    }
}
