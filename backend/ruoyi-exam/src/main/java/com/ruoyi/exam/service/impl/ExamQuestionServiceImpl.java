package com.ruoyi.exam.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.exam.mapper.ExamQuestionMapper;
import com.ruoyi.exam.domain.ExamQuestion;
import com.ruoyi.exam.service.IExamQuestionService;

/**
 * 题库Service业务层处理
 * 
 * @author shishugen
 * @date 2026-11-07
 */
@Service
public class ExamQuestionServiceImpl implements IExamQuestionService 
{
    @Autowired
    private ExamQuestionMapper examQuestionMapper;

    /**
     * 查询题库
     * 
     * @param id 题库主键
     * @return 题库
     */
    @Override
    public ExamQuestion selectExamQuestionById(Long id)
    {
        return examQuestionMapper.selectExamQuestionById(id);
    }

    /**
     * 查询题库列表
     * 
     * @param examQuestion 题库
     * @return 题库
     */
    @Override
    public List<ExamQuestion> selectExamQuestionList(ExamQuestion examQuestion)
    {
        return examQuestionMapper.selectExamQuestionList(examQuestion);
    }

    /**
     * 新增题库
     * 
     * @param examQuestion 题库
     * @return 结果
     */
    @Override
    public int insertExamQuestion(ExamQuestion examQuestion)
    {
        examQuestion.setCreateTime(DateUtils.getNowDate());
        return examQuestionMapper.insertExamQuestion(examQuestion);
    }

    /**
     * 修改题库
     * 
     * @param examQuestion 题库
     * @return 结果
     */
    @Override
    public int updateExamQuestion(ExamQuestion examQuestion)
    {
        examQuestion.setUpdateTime(DateUtils.getNowDate());
        return examQuestionMapper.updateExamQuestion(examQuestion);
    }

    /**
     * 批量删除题库
     * 
     * @param ids 需要删除的题库主键
     * @return 结果
     */
    @Override
    public int deleteExamQuestionByIds(Long[] ids)
    {
        return examQuestionMapper.deleteExamQuestionByIds(ids);
    }

    /**
     * 删除题库信息
     * 
     * @param id 题库主键
     * @return 结果
     */
    @Override
    public int deleteExamQuestionById(Long id)
    {
        return examQuestionMapper.deleteExamQuestionById(id);
    }
}
