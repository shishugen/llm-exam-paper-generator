package com.ruoyi.exam.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ruoyi.exam.domain.ExamPaper;
import com.ruoyi.exam.domain.ExamPaperQuestion;
import com.ruoyi.exam.domain.ExamQuestion;
import com.ruoyi.exam.mapper.ExamPaperMapper;
import com.ruoyi.exam.mapper.ExamPaperQuestionMapper;
import com.ruoyi.exam.mapper.ExamQuestionMapper;

// 组卷：按题型和难度的配额随机抽题，覆盖率只算出来给页面看
@Component
public class PaperComposeUtil
{
    @Autowired
    private ExamPaperMapper paperMapper;
    @Autowired
    private ExamPaperQuestionMapper paperQuestionMapper;
    @Autowired
    private ExamQuestionMapper questionMapper;

    // 预览只抽题不写库；chapterIds 为空表示整门课程
    public Map<String, Object> preview(ExamPaper paper, Map<String, Integer> typeRatio,
                                       Map<String, Integer> diffRatio, List<Long> chapterIds)
    {
        List<ExamQuestion> picked = new ArrayList<>();
        List<String> difficulties = expand(diffRatio);
        List<Long> used = new ArrayList<>();
        List<Long> usedKnowledge = new ArrayList<>();
        int totalCount = 0;
        for (int n : typeRatio.values())
        {
            totalCount = totalCount + n;
        }
        int perScore = totalCount == 0 ? 0 : paper.getTotalScore() / totalCount;
        int sortNo = 1;
        String warning = null;
        for (Map.Entry<String, Integer> entry : typeRatio.entrySet())
        {
            for (int i = 0; i < entry.getValue(); i++)
            {
                String diff = difficulties.isEmpty() ? "2"
                        : difficulties.get((sortNo - 1) % difficulties.size());
                sortNo++;
                List<ExamQuestion> questions = questionMapper.selectRandomQuestions(
                        paper.getCourseId(), entry.getKey(), diff, chapterIds, used, usedKnowledge, 1);
                if (questions.isEmpty())
                {
                    // 没覆盖过的知识点里没题了，放开条件再抽一次
                    questions = questionMapper.selectRandomQuestions(
                            paper.getCourseId(), entry.getKey(), diff, chapterIds, used, null, 1);
                }
                if (questions.isEmpty())
                {
                    warning = "题型 " + entry.getKey() + " 在难度 " + diff + " 下题量不足，请先补题";
                    continue;
                }
                ExamQuestion q = questions.get(0);
                used.add(q.getId());
                if (q.getKnowledgeId() != null)
                {
                    usedKnowledge.add(q.getKnowledgeId());
                }
                picked.add(q);
            }
        }
        // 覆盖率：抽中的题覆盖了多少知识点
        Set<Long> covered = new HashSet<>();
        for (ExamQuestion q : picked)
        {
            if (q.getKnowledgeId() != null)
            {
                covered.add(q.getKnowledgeId());
            }
        }
        int total = (chapterIds != null && !chapterIds.isEmpty())
                ? paperMapper.countKnowledgeTotalByChapters(chapterIds)
                : paperMapper.countKnowledgeTotal(paper.getCourseId());
        Map<String, Object> coverage = new HashMap<>();
        double rate = total == 0 ? 0 : covered.size() * 100.0 / total;
        coverage.put("covered", covered.size());
        coverage.put("total", total);
        coverage.put("rate", Math.round(rate * 100) / 100.0);

        Map<String, Object> result = new HashMap<>();
        result.put("questions", picked);
        result.put("questionCount", picked.size());
        result.put("perScore", perScore);
        result.put("warning", warning);
        result.put("coverage", coverage);
        return result;
    }

    // 确认保存：按预览出来的题号顺序写试卷和明细
    public Map<String, Object> save(ExamPaper paper, List<Long> chapterIds, List<Long> questionIds)
    {
        paperMapper.insertExamPaper(paper);
        int count = questionIds.size();
        int perScore = count == 0 ? 0 : paper.getTotalScore() / count;
        int rest = paper.getTotalScore() - perScore * count;
        int sortNo = 1;
        for (Long qid : questionIds)
        {
            ExamPaperQuestion d = new ExamPaperQuestion();
            d.setPaperId(paper.getId());
            d.setQuestionId(qid);
            d.setSortNo(sortNo);
            d.setScore(perScore + (sortNo == count ? rest : 0));
            d.setLocked("0");
            paperQuestionMapper.insertExamPaperQuestion(d);
            sortNo++;
        }
        Map<String, Object> result = new HashMap<>();
        result.put("paperId", paper.getId());
        result.put("questionCount", count);
        result.put("coverage", coverage(paper.getId(), paper.getCourseId(), chapterIds));
        return result;
    }

    // 选了章节时，分母只算这些章节的知识点
    public Map<String, Object> coverage(Long paperId, Long courseId, List<Long> chapterIds)
    {
        int covered = paperMapper.countKnowledgeInPaper(paperId);
        int total = (chapterIds != null && !chapterIds.isEmpty())
                ? paperMapper.countKnowledgeTotalByChapters(chapterIds)
                : paperMapper.countKnowledgeTotal(courseId);
        Map<String, Object> data = new HashMap<>();
        double rate = total == 0 ? 0 : covered * 100.0 / total;
        data.put("covered", covered);
        data.put("total", total);
        data.put("rate", Math.round(rate * 100) / 100.0);
        return data;
    }

    // 单题替换：锁定题跳过，按原题的题型和难度重抽一道
    public boolean replace(Long paperId, Long detailId)
    {
        ExamPaperQuestion d = paperQuestionMapper.selectExamPaperQuestionById(detailId);
        if (d == null || "1".equals(d.getLocked()))
        {
            return false;
        }
        ExamQuestion old = questionMapper.selectExamQuestionById(d.getQuestionId());
        ExamPaperQuestion query = new ExamPaperQuestion();
        query.setPaperId(paperId);
        List<Long> used = new ArrayList<>();
        for (ExamPaperQuestion x : paperQuestionMapper.selectExamPaperQuestionList(query))
        {
            used.add(x.getQuestionId());
        }
        List<ExamQuestion> questions = questionMapper.selectRandomQuestions(
                old.getCourseId(), old.getType(), old.getDifficulty(), null, used, null, 1);
        if (questions.isEmpty())
        {
            return false;
        }
        d.setQuestionId(questions.get(0).getId());
        return paperQuestionMapper.updateExamPaperQuestion(d) > 0;
    }

    // 把难度配额展开成序列，抽第 n 题时按顺序取一个难度
    private List<String> expand(Map<String, Integer> ratio)
    {
        List<String> list = new ArrayList<>();
        if (ratio == null)
        {
            return list;
        }
        for (Map.Entry<String, Integer> e : ratio.entrySet())
        {
            for (int i = 0; i < e.getValue(); i++)
            {
                list.add(e.getKey());
            }
        }
        return list;
    }
}
