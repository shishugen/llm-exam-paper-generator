package com.ruoyi.exam.mapper;

import java.util.List;
import com.ruoyi.exam.domain.ExamReviewLog;

/**
 * 题目审核记录Mapper接口
 * 
 * @author shishugen
 * @date 2026-11-07
 */
public interface ExamReviewLogMapper 
{
    /**
     * 查询题目审核记录
     * 
     * @param id 题目审核记录主键
     * @return 题目审核记录
     */
    public ExamReviewLog selectExamReviewLogById(Long id);

    /**
     * 查询题目审核记录列表
     * 
     * @param examReviewLog 题目审核记录
     * @return 题目审核记录集合
     */
    public List<ExamReviewLog> selectExamReviewLogList(ExamReviewLog examReviewLog);

    /**
     * 新增题目审核记录
     * 
     * @param examReviewLog 题目审核记录
     * @return 结果
     */
    public int insertExamReviewLog(ExamReviewLog examReviewLog);

    /**
     * 修改题目审核记录
     * 
     * @param examReviewLog 题目审核记录
     * @return 结果
     */
    public int updateExamReviewLog(ExamReviewLog examReviewLog);

    /**
     * 删除题目审核记录
     * 
     * @param id 题目审核记录主键
     * @return 结果
     */
    public int deleteExamReviewLogById(Long id);

    /**
     * 批量删除题目审核记录
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteExamReviewLogByIds(Long[] ids);
}
