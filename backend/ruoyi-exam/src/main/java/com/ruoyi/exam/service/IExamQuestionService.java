package com.ruoyi.exam.service;

import java.util.List;
import com.ruoyi.exam.domain.ExamQuestion;

/**
 * 题库Service接口
 * 
 * @author shishugen
 * @date 2026-11-07
 */
public interface IExamQuestionService 
{
    /**
     * 查询题库
     * 
     * @param id 题库主键
     * @return 题库
     */
    public ExamQuestion selectExamQuestionById(Long id);

    /**
     * 查询题库列表
     * 
     * @param examQuestion 题库
     * @return 题库集合
     */
    public List<ExamQuestion> selectExamQuestionList(ExamQuestion examQuestion);

    /**
     * 新增题库
     * 
     * @param examQuestion 题库
     * @return 结果
     */
    public int insertExamQuestion(ExamQuestion examQuestion);

    /**
     * 修改题库
     * 
     * @param examQuestion 题库
     * @return 结果
     */
    public int updateExamQuestion(ExamQuestion examQuestion);

    /**
     * 批量删除题库
     * 
     * @param ids 需要删除的题库主键集合
     * @return 结果
     */
    public int deleteExamQuestionByIds(Long[] ids);

    /**
     * 删除题库信息
     * 
     * @param id 题库主键
     * @return 结果
     */
    public int deleteExamQuestionById(Long id);
}
