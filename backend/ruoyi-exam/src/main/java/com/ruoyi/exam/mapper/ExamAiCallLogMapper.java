package com.ruoyi.exam.mapper;

import java.util.List;
import java.util.Map;
import com.ruoyi.exam.domain.ExamAiCallLog;

/**
 * 大模型调用日志Mapper接口
 * 
 * @author shishugen
 * @date 2026-11-07
 */
public interface ExamAiCallLogMapper 
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
     * 删除大模型调用日志
     * 
     * @param id 大模型调用日志主键
     * @return 结果
     */
    public int deleteExamAiCallLogById(Long id);

    /**
     * 批量删除大模型调用日志
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteExamAiCallLogByIds(Long[] ids);

    /**
     * 调用统计：次数 / Token / 平均耗时 / 费用 / 成功次数
     */
    public Map<String, Object> selectCallStats();
}
