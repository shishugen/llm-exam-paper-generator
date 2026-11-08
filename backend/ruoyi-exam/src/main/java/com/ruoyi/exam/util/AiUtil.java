package com.ruoyi.exam.util;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.exam.domain.ExamAiCallLog;
import com.ruoyi.exam.domain.ExamQuestion;
import com.ruoyi.exam.mapper.ExamAiCallLogMapper;

// AI 出题：拼提示词、调接口、把返回的 JSON 变成题目，最后记一条调用日志
@Component
public class AiUtil
{
    private static final String PROMPT = "你是高校命题助手。围绕知识点「%s」，出 %d 道%s题，难度%s。%s\n"
            + "只返回 JSON 数组，不要任何解释文字。每个元素格式："
            + "{\"stem\":\"题干\",\"options\":[{\"key\":\"A\",\"value\":\"选项内容\"}],"
            + "\"answer\":\"正确答案\",\"analysis\":\"解析\",\"score\":2}\n"
            + "注意：题干、选项、解析里一律不要使用英文双引号，需要强调时用《》或括号；文字中不要换行。";

    @Value("${llm.mock:true}")
    private boolean mock;

    @Value("${llm.api-url:}")
    private String apiUrl;

    @Value("${llm.api-key:}")
    private String apiKey;

    @Value("${llm.model:gpt-4o-mini}")
    private String model;

    @Autowired
    private ExamAiCallLogMapper callLogMapper;

    public List<ExamQuestion> generate(String knowledgeName, String type, String difficulty,
                                       int count, String rejectReason)
    {
        long start = System.currentTimeMillis();
        int inTokens = 0, outTokens = 0;
        String status = "0", errorMsg = null;
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
                JSONObject data = callApi(knowledgeName, type, difficulty, count, rejectReason);
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
            log.setModel(mock ? "mock(离线演示)" : model);
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

    // 调大模型接口，取回答文字和用了多少 token
    private JSONObject callApi(String knowledgeName, String type, String difficulty,
                               int count, String rejectReason)
    {
        String tip = (rejectReason == null || rejectReason.isEmpty()) ? ""
                : "上次该知识点的题目被驳回，原因是：" + rejectReason + "，请避免同类问题。";
        String prompt = String.format(PROMPT, knowledgeName, count,
                typeName(type), difficultyName(difficulty), tip);

        JSONObject body = new JSONObject();
        body.put("model", model);
        JSONArray messages = new JSONArray();
        JSONObject sys = new JSONObject();
        sys.put("role", "system");
        sys.put("content", "只输出 JSON 数组");
        messages.add(sys);
        JSONObject user = new JSONObject();
        user.put("role", "user");
        user.put("content", prompt);
        messages.add(user);
        body.put("messages", messages);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(apiKey);
        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
        factory.setConnectTimeout(8000);
        factory.setReadTimeout(120000);
        String raw = new RestTemplate(factory)
                .postForObject(apiUrl, new HttpEntity<>(body.toString(), headers), String.class);

        JSONObject root = JSON.parseObject(raw);
        JSONObject data = new JSONObject();
        data.put("content", root.getJSONArray("choices").getJSONObject(0)
                .getJSONObject("message").getString("content"));
        JSONObject usage = root.getJSONObject("usage");
        data.put("inTokens", usage == null ? 0 : usage.getIntValue("prompt_tokens"));
        data.put("outTokens", usage == null ? 0 : usage.getIntValue("completion_tokens"));
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
