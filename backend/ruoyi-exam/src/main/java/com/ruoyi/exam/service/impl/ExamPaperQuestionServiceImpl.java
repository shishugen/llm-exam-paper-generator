package com.ruoyi.exam.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.exam.mapper.ExamPaperQuestionMapper;
import com.ruoyi.exam.domain.ExamPaperQuestion;
import com.ruoyi.exam.service.IExamPaperQuestionService;

/**
 * 试卷明细Service业务层处理
 * 
 * @author shishugen
 * @date 2026-11-07
 */
@Service
public class ExamPaperQuestionServiceImpl implements IExamPaperQuestionService 
{
    @Autowired
    private ExamPaperQuestionMapper examPaperQuestionMapper;

    /**
     * 查询试卷明细
     * 
     * @param id 试卷明细主键
     * @return 试卷明细
     */
    @Override
    public ExamPaperQuestion selectExamPaperQuestionById(Long id)
    {
        return examPaperQuestionMapper.selectExamPaperQuestionById(id);
    }

    /**
     * 查询试卷明细列表
     * 
     * @param examPaperQuestion 试卷明细
     * @return 试卷明细
     */
    @Override
    public List<ExamPaperQuestion> selectExamPaperQuestionList(ExamPaperQuestion examPaperQuestion)
    {
        return examPaperQuestionMapper.selectExamPaperQuestionList(examPaperQuestion);
    }

    /**
     * 新增试卷明细
     * 
     * @param examPaperQuestion 试卷明细
     * @return 结果
     */
    @Override
    public int insertExamPaperQuestion(ExamPaperQuestion examPaperQuestion)
    {
        examPaperQuestion.setCreateTime(DateUtils.getNowDate());
        return examPaperQuestionMapper.insertExamPaperQuestion(examPaperQuestion);
    }

    /**
     * 修改试卷明细
     * 
     * @param examPaperQuestion 试卷明细
     * @return 结果
     */
    @Override
    public int updateExamPaperQuestion(ExamPaperQuestion examPaperQuestion)
    {
        examPaperQuestion.setUpdateTime(DateUtils.getNowDate());
        return examPaperQuestionMapper.updateExamPaperQuestion(examPaperQuestion);
    }

    /**
     * 批量删除试卷明细
     * 
     * @param ids 需要删除的试卷明细主键
     * @return 结果
     */
    @Override
    public int deleteExamPaperQuestionByIds(Long[] ids)
    {
        return examPaperQuestionMapper.deleteExamPaperQuestionByIds(ids);
    }

    /**
     * 删除试卷明细信息
     * 
     * @param id 试卷明细主键
     * @return 结果
     */
    @Override
    public int deleteExamPaperQuestionById(Long id)
    {
        return examPaperQuestionMapper.deleteExamPaperQuestionById(id);
    }
}
