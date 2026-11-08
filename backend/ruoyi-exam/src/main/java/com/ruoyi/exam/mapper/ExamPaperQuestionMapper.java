package com.ruoyi.exam.mapper;

import java.util.List;
import com.ruoyi.exam.domain.ExamPaperQuestion;

/**
 * 试卷明细Mapper接口
 * 
 * @author shishugen
 * @date 2026-11-07
 */
public interface ExamPaperQuestionMapper 
{
    /**
     * 查询试卷明细
     * 
     * @param id 试卷明细主键
     * @return 试卷明细
     */
    public ExamPaperQuestion selectExamPaperQuestionById(Long id);

    /**
     * 查询试卷明细列表
     * 
     * @param examPaperQuestion 试卷明细
     * @return 试卷明细集合
     */
    public List<ExamPaperQuestion> selectExamPaperQuestionList(ExamPaperQuestion examPaperQuestion);

    /**
     * 新增试卷明细
     * 
     * @param examPaperQuestion 试卷明细
     * @return 结果
     */
    public int insertExamPaperQuestion(ExamPaperQuestion examPaperQuestion);

    /**
     * 修改试卷明细
     * 
     * @param examPaperQuestion 试卷明细
     * @return 结果
     */
    public int updateExamPaperQuestion(ExamPaperQuestion examPaperQuestion);

    /**
     * 删除试卷明细
     * 
     * @param id 试卷明细主键
     * @return 结果
     */
    public int deleteExamPaperQuestionById(Long id);

    /**
     * 批量删除试卷明细
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteExamPaperQuestionByIds(Long[] ids);
}
