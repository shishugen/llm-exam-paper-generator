package com.ruoyi.exam.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.exam.mapper.ExamReviewLogMapper;
import com.ruoyi.exam.domain.ExamReviewLog;
import com.ruoyi.exam.service.IExamReviewLogService;

/**
 * 题目审核记录Service业务层处理
 * 
 * @author shishugen
 * @date 2026-11-07
 */
@Service
public class ExamReviewLogServiceImpl implements IExamReviewLogService 
{
    @Autowired
    private ExamReviewLogMapper examReviewLogMapper;

    /**
     * 查询题目审核记录
     * 
     * @param id 题目审核记录主键
     * @return 题目审核记录
     */
    @Override
    public ExamReviewLog selectExamReviewLogById(Long id)
    {
        return examReviewLogMapper.selectExamReviewLogById(id);
    }

    /**
     * 查询题目审核记录列表
     * 
     * @param examReviewLog 题目审核记录
     * @return 题目审核记录
     */
    @Override
    public List<ExamReviewLog> selectExamReviewLogList(ExamReviewLog examReviewLog)
    {
        return examReviewLogMapper.selectExamReviewLogList(examReviewLog);
    }

    /**
     * 新增题目审核记录
     * 
     * @param examReviewLog 题目审核记录
     * @return 结果
     */
    @Override
    public int insertExamReviewLog(ExamReviewLog examReviewLog)
    {
        examReviewLog.setCreateTime(DateUtils.getNowDate());
        return examReviewLogMapper.insertExamReviewLog(examReviewLog);
    }

    /**
     * 修改题目审核记录
     * 
     * @param examReviewLog 题目审核记录
     * @return 结果
     */
    @Override
    public int updateExamReviewLog(ExamReviewLog examReviewLog)
    {
        examReviewLog.setUpdateTime(DateUtils.getNowDate());
        return examReviewLogMapper.updateExamReviewLog(examReviewLog);
    }

    /**
     * 批量删除题目审核记录
     * 
     * @param ids 需要删除的题目审核记录主键
     * @return 结果
     */
    @Override
    public int deleteExamReviewLogByIds(Long[] ids)
    {
        return examReviewLogMapper.deleteExamReviewLogByIds(ids);
    }

    /**
     * 删除题目审核记录信息
     * 
     * @param id 题目审核记录主键
     * @return 结果
     */
    @Override
    public int deleteExamReviewLogById(Long id)
    {
        return examReviewLogMapper.deleteExamReviewLogById(id);
    }
}
