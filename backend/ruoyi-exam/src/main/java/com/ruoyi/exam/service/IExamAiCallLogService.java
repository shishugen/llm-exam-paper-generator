package com.ruoyi.exam.service;

import java.util.List;
import com.ruoyi.exam.domain.ExamAiCallLog;

/**
 * 大模型调用日志Service接口
 * 
 * @author shishugen
 * @date 2026-11-07
 */
public interface IExamAiCallLogService 
{
    /**
     * 查询大模型调用日志
     * 
     * @param id 大模型调用日志主键
     * @return 大模型调用日志
     */
    public ExamAiCallLog selectExamAiCallLogById(Long id);

    /**
     * 查询大模型调用日志列表
     * 
     * @param examAiCallLog 大模型调用日志
     * @return 大模型调用日志集合
     */
    public List<ExamAiCallLog> selectExamAiCallLogList(ExamAiCallLog examAiCallLog);

    /**
     * 新增大模型调用日志
     * 
     * @param examAiCallLog 大模型调用日志
     * @return 结果
     */
    public int insertExamAiCallLog(ExamAiCallLog examAiCallLog);

    /**
     * 修改大模型调用日志
     * 
     * @param examAiCallLog 大模型调用日志
     * @return 结果
     */
    public int updateExamAiCallLog(ExamAiCallLog examAiCallLog);

    /**
     * 批量删除大模型调用日志
     * 
     * @param ids 需要删除的大模型调用日志主键集合
     * @return 结果
     */
    public int deleteExamAiCallLogByIds(Long[] ids);

    /**
     * 删除大模型调用日志信息
     * 
     * @param id 大模型调用日志主键
     * @return 结果
     */
    public int deleteExamAiCallLogById(Long id);
}
