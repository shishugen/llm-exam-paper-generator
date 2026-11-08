package com.ruoyi.exam.controller;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.exam.domain.ExamQuestion;
import com.ruoyi.exam.service.IExamQuestionService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.exam.domain.ExamReviewLog;
import com.ruoyi.exam.mapper.ExamKnowledgeMapper;
import com.ruoyi.exam.mapper.ExamQuestionMapper;
import com.ruoyi.exam.mapper.ExamReviewLogMapper;
import com.ruoyi.exam.util.AiUtil;

/**
 * 题库Controller
 * 
 * @author shishugen
 * @date 2026-11-07
 */
@RestController
@RequestMapping("/exam/question")
public class ExamQuestionController extends BaseController
{
    @Autowired
    private IExamQuestionService examQuestionService;
    @Autowired private ExamKnowledgeMapper knowledgeMapper;
    @Autowired private ExamQuestionMapper questionMapper;
    @Autowired private ExamReviewLogMapper reviewLogMapper;
    @Autowired private AiUtil aiUtil;

    private static final double SIMILAR_LIMIT = 0.9;

    /**
     * 查询题库列表
     */
    @PreAuthorize("@ss.hasPermi('exam:question:list')")
    @GetMapping("/list")
    public TableDataInfo list(ExamQuestion examQuestion)
    {
        startPage();
        List<ExamQuestion> list = examQuestionService.selectExamQuestionList(examQuestion);
        return getDataTable(list);
    }

    /**
     * 获取题库详细信息
     */
    @PreAuthorize("@ss.hasPermi('exam:question:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(examQuestionService.selectExamQuestionById(id));
    }

    /**
     * 新增题库
     */
    @PreAuthorize("@ss.hasPermi('exam:question:add')")
    @Log(title = "题库", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ExamQuestion examQuestion)
    {
        return toAjax(examQuestionService.insertExamQuestion(examQuestion));
    }

    /**
     * 修改题库
     */
    @PreAuthorize("@ss.hasPermi('exam:question:edit')")
    @Log(title = "题库", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ExamQuestion examQuestion)
    {
        return toAjax(examQuestionService.updateExamQuestion(examQuestion));
    }

    /**
     * 删除题库
     */
    @PreAuthorize("@ss.hasPermi('exam:question:remove')")
    @Log(title = "题库", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(examQuestionService.deleteExamQuestionByIds(ids));
    }

    // AI 出题：生成、去重、入库
    @PostMapping("/generate")
    public AjaxResult generate(@RequestBody Map<String, Object> params)
    {
        Long knowledgeId = Long.valueOf(str(params.get("knowledgeId")));
        String type = str(params.get("type")).isEmpty() ? "1" : str(params.get("type"));
        String difficulty = str(params.get("difficulty")).isEmpty() ? "2" : str(params.get("difficulty"));
        int count = Integer.parseInt(str(params.getOrDefault("count", 3)));
        String knowledgeName = knowledgeMapper.selectKnowledgeName(knowledgeId);
        Long courseId = knowledgeMapper.selectCourseIdByKnowledge(knowledgeId);
        if (knowledgeName == null || courseId == null)
        {
            return error("知识点不存在，请先在知识点管理里维护");
        }
        String rejectReason = questionMapper.selectRejectReason(knowledgeId);
        List<ExamQuestion> list = aiUtil.generate(knowledgeName, type, difficulty, count, rejectReason);

        int saved = 0, duplicated = 0;
        List<String> oldStems = questionMapper.selectAllStems();
        for (ExamQuestion q : list)
        {
            if (q.getStem() == null || q.getStem().isEmpty() || q.getAnswer() == null)
            {
                continue;
            }
            if (isDuplicate(q.getStem(), oldStems))
            {
                duplicated++;
                continue;
            }
            q.setCourseId(courseId);
            q.setChapterId(knowledgeMapper.selectChapterIdByKnowledge(knowledgeId));
            q.setKnowledgeId(knowledgeId);
            q.setType(type);
            q.setDifficulty(difficulty);
            q.setSource("1");
            q.setStatus("0");
            questionMapper.insertExamQuestion(q);
            oldStems.add(q.getStem());
            saved++;
        }
        if (saved == 0 && duplicated == 0)
        {
            return error("生成失败，请重试或手工录入");
        }
        Map<String, Object> data = new HashMap<>();
        data.put("saved", saved);
        data.put("duplicated", duplicated);
        return AjaxResult.success("已入库 " + saved + " 道题，进入待审队列"
                + (duplicated > 0 ? "；跳过重复 " + duplicated + " 道" : ""), data);
    }

    // 预览：生成题目但不入库
    @PostMapping("/preview")
    public AjaxResult preview(@RequestBody Map<String, Object> params)
    {
        Long knowledgeId = Long.valueOf(str(params.get("knowledgeId")));
        String type = str(params.get("type")).isEmpty() ? "1" : str(params.get("type"));
        String difficulty = str(params.get("difficulty")).isEmpty() ? "2" : str(params.get("difficulty"));
        int count = Integer.parseInt(str(params.getOrDefault("count", 3)));
        String knowledgeName = knowledgeMapper.selectKnowledgeName(knowledgeId);
        Long courseId = knowledgeMapper.selectCourseIdByKnowledge(knowledgeId);
        if (knowledgeName == null || courseId == null)
        {
            return error("知识点不存在，请先在知识点管理里维护");
        }
        String rejectReason = questionMapper.selectRejectReason(knowledgeId);
        List<ExamQuestion> list = aiUtil.generate(knowledgeName, type, difficulty, count, rejectReason);
        // 补上课程、章节、知识点，方便预览里显示
        for (ExamQuestion q : list)
        {
            if (q.getStem() == null || q.getStem().isEmpty() || q.getAnswer() == null)
            {
                q.setStatus("-1");
            }
            else
            {
                q.setCourseId(courseId);
                q.setChapterId(knowledgeMapper.selectChapterIdByKnowledge(knowledgeId));
                q.setKnowledgeId(knowledgeId);
                q.setType(type);
                q.setDifficulty(difficulty);
                q.setSource("1");
                q.setStatus("0");
            }
        }
        if (list.isEmpty())
        {
            return error("AI 没有返回可用题目，请重试；连续失败可查看「AI 调用日志」里的错误信息");
        }
        return AjaxResult.success("已生成 " + list.size() + " 道题预览", list);
    }

    // 把预览里选中的题目存进题库
    @PostMapping("/saveGenerated")
    public AjaxResult saveGenerated(@RequestBody Map<String, Object> params)
    {
        List<Map<String, Object>> questions = (List<Map<String, Object>>) params.get("questions");
        if (questions == null || questions.isEmpty())
        {
            return error("题目列表为空");
        }
        Long knowledgeId = Long.valueOf(str(params.get("knowledgeId")));
        String type = str(params.get("type"));
        String difficulty = str(params.get("difficulty"));
        String knowledgeName = knowledgeMapper.selectKnowledgeName(knowledgeId);
        Long courseId = knowledgeMapper.selectCourseIdByKnowledge(knowledgeId);
        if (knowledgeName == null || courseId == null)
        {
            return error("知识点不存在");
        }
        int saved = 0, duplicated = 0;
        List<String> oldStems = questionMapper.selectAllStems();
        for (Map<String, Object> row : questions)
        {
            ExamQuestion q = new ExamQuestion();
            q.setCourseId(courseId);
            q.setChapterId(knowledgeMapper.selectChapterIdByKnowledge(knowledgeId));
            q.setKnowledgeId(knowledgeId);
            q.setType(type);
            q.setDifficulty(difficulty);
            q.setSource("1");
            q.setStatus("0");
            q.setStem(str(row.get("stem")));
            q.setOptions(str(row.get("options")));
            q.setAnswer(str(row.get("answer")));
            q.setAnalysis(str(row.get("analysis")));
            Object score = row.get("score");
            q.setScore(score == null ? null : Integer.parseInt(String.valueOf(score)));
            if (q.getStem() == null || q.getStem().isEmpty() || q.getAnswer() == null)
            {
                continue;
            }
            if (isDuplicate(q.getStem(), oldStems))
            {
                duplicated++;
                continue;
            }
            questionMapper.insertExamQuestion(q);
            oldStems.add(q.getStem());
            saved++;
        }
        return AjaxResult.success("已入库 " + saved + " 道题，进入待审队列"
                + (duplicated > 0 ? "；跳过重复 " + duplicated + " 道" : ""));
    }

    // 审核：改状态，写一条审核记录
    @PostMapping("/review")
    public AjaxResult review(@RequestBody Map<String, Object> params)
    {
        Long questionId = Long.valueOf(str(params.get("questionId")));
        String action = str(params.get("action"));
        String reason = str(params.get("reason"));
        String reviewerIdText = str(params.get("reviewerId"));
        Long reviewerId = reviewerIdText.isEmpty() ? 0L : Long.valueOf(reviewerIdText);
        if (reviewerId == 0)
        {
            return error("登录信息已失效，请重新登录");
        }
        if (!"2".equals(action) && !"3".equals(action))
        {
            return error("操作类型不正确");
        }
        try
        {
            doReview(questionId, action, reason, reviewerId);
        }
        catch (RuntimeException e)
        {
            return error(e.getMessage());
        }
        return success("3".equals(action) ? "已驳回，原因将反馈给下次生成" : "审核通过，该题可用于组卷");
    }

    // 批量审核
    @PostMapping("/reviewBatch")
    public AjaxResult reviewBatch(@RequestBody Map<String, Object> params)
    {
        List<Object> idList = (List<Object>) params.get("ids");
        String action = str(params.get("action"));
        String reason = str(params.get("reason"));
        String reviewerIdText = str(params.get("reviewerId"));
        Long reviewerId = reviewerIdText.isEmpty() ? 0L : Long.valueOf(reviewerIdText);
        if (reviewerId == 0)
        {
            return error("登录信息已失效，请重新登录");
        }
        if (idList == null || idList.isEmpty())
        {
            return error("请选择至少一道题");
        }
        if (!"2".equals(action) && !"3".equals(action))
        {
            return error("操作类型不正确");
        }
        int ok = 0, fail = 0;
        for (Object id : idList)
        {
            try
            {
                doReview(Long.valueOf(String.valueOf(id)), action, reason, reviewerId);
                ok++;
            }
            catch (RuntimeException e)
            {
                fail++;
            }
        }
        return success("已审核 " + ok + " 道" + (fail > 0 ? "，失败 " + fail + " 道" : ""));
    }

    private void doReview(Long questionId, String action, String reason, Long reviewerId)
    {
        ExamQuestion q = questionMapper.selectExamQuestionById(questionId);
        if (q == null)
        {
            throw new RuntimeException("题目不存在");
        }
        q.setStatus(action);
        q.setRejectReason("3".equals(action) ? reason : "");
        q.setReviewerId(reviewerId);
        q.setReviewTime(DateUtils.getNowDate());
        questionMapper.updateExamQuestion(q);

        ExamReviewLog log = new ExamReviewLog();
        log.setQuestionId(questionId);
        log.setAction(action);
        log.setReason(reason);
        log.setReviewerId(reviewerId);
        reviewLogMapper.insertExamReviewLog(log);
    }

    // 和已有题目比一遍，相似度超过阈值就当重复
    private boolean isDuplicate(String stem, List<String> oldStems)
    {
        String newStem = cleanStem(stem);
        for (String old : oldStems)
        {
            if (old != null && similar(newStem, cleanStem(old)) >= SIMILAR_LIMIT)
            {
                return true;
            }
        }
        return false;
    }

    // 比较前先去掉空格和常见标点
    private String cleanStem(String s)
    {
        return s.toLowerCase().replace(" ", "").replace("　", "")
                .replace("，", "").replace("。", "");
    }

    // 编辑距离：把 a 改成 b 最少要增、删、换几个字
    private int distance(String a, String b)
    {
        int[][] d = new int[a.length() + 1][b.length() + 1];
        for (int i = 0; i <= a.length(); i++)
        {
            d[i][0] = i;
        }
        for (int j = 0; j <= b.length(); j++)
        {
            d[0][j] = j;
        }
        for (int i = 1; i <= a.length(); i++)
        {
            for (int j = 1; j <= b.length(); j++)
            {
                int cost = a.charAt(i - 1) == b.charAt(j - 1) ? 0 : 1;
                d[i][j] = Math.min(Math.min(d[i - 1][j] + 1, d[i][j - 1] + 1), d[i - 1][j - 1] + cost);
            }
        }
        return d[a.length()][b.length()];
    }

    private double similar(String a, String b)
    {
        int max = Math.max(a.length(), b.length());
        if (max == 0)
        {
            return 1;
        }
        return 1.0 * (max - distance(a, b)) / max;
    }

    private String str(Object o)
    {
        return o == null ? "" : String.valueOf(o);
    }
}
