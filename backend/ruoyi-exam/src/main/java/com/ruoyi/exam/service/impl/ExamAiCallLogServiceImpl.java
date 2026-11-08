package com.ruoyi.exam.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.exam.mapper.ExamAiCallLogMapper;
import com.ruoyi.exam.domain.ExamAiCallLog;
import com.ruoyi.exam.service.IExamAiCallLogService;

/**
 * 大模型调用日志Service业务层处理
 * 
 * @author shishugen
 * @date 2026-11-07
 */
@Service
public class ExamAiCallLogServiceImpl implements IExamAiCallLogService 
{
    @Autowired
    private ExamAiCallLogMapper examAiCallLogMapper;

    /**
     * 查询大模型调用日志
     * 
     * @param id 大模型调用日志主键
     * @return 大模型调用日志
     */
    @Override
    public ExamAiCallLog selectExamAiCallLogById(Long id)
    {
        return examAiCallLogMapper.selectExamAiCallLogById(id);
    }

    /**
     * 查询大模型调用日志列表
     * 
     * @param examAiCallLog 大模型调用日志
     * @return 大模型调用日志
     */
    @Override
    public List<ExamAiCallLog> selectExamAiCallLogList(ExamAiCallLog examAiCallLog)
    {
        return examAiCallLogMapper.selectExamAiCallLogList(examAiCallLog);
    }

    /**
     * 新增大模型调用日志
     * 
     * @param examAiCallLog 大模型调用日志
     * @return 结果
     */
    @Override
    public int insertExamAiCallLog(ExamAiCallLog examAiCallLog)
    {
        examAiCallLog.setCreateTime(DateUtils.getNowDate());
        return examAiCallLogMapper.insertExamAiCallLog(examAiCallLog);
    }

    /**
     * 修改大模型调用日志
     * 
     * @param examAiCallLog 大模型调用日志
     * @return 结果
     */
    @Override
    public int updateExamAiCallLog(ExamAiCallLog examAiCallLog)
    {
        examAiCallLog.setUpdateTime(DateUtils.getNowDate());
        return examAiCallLogMapper.updateExamAiCallLog(examAiCallLog);
    }

    /**
     * 批量删除大模型调用日志
     * 
     * @param ids 需要删除的大模型调用日志主键
     * @return 结果
     */
    @Override
    public int deleteExamAiCallLogByIds(Long[] ids)
    {
        return examAiCallLogMapper.deleteExamAiCallLogByIds(ids);
    }

    /**
     * 删除大模型调用日志信息
     * 
     * @param id 大模型调用日志主键
     * @return 结果
     */
    @Override
    public int deleteExamAiCallLogById(Long id)
    {
        return examAiCallLogMapper.deleteExamAiCallLogById(id);
    }
}
