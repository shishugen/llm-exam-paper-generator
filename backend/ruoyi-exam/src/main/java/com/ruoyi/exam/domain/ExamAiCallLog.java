package com.ruoyi.exam.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 大模型调用日志对象 exam_ai_call_log
 * 
 * @author shishugen
 * @date 2026-11-07
 */
public class ExamAiCallLog extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 日志ID */
    private Long id;

    /** 任务类型（1AI出题 2重新生成） */
    @Excel(name = "任务类型", readConverterExp = "1=AI出题,2=重新生成")
    private String taskType;

    /** 调用的模型名称 */
    @Excel(name = "调用的模型名称")
    private String model;

    /** 输入token数 */
    @Excel(name = "输入token数")
    private Integer promptTokens;

    /** 输出token数 */
    @Excel(name = "输出token数")
    private Integer completionTokens;

    /** 耗时（毫秒） */
    @Excel(name = "耗时", readConverterExp = "毫=秒")
    private Long durationMs;

    /** 本次费用（元） */
    @Excel(name = "本次费用", readConverterExp = "元=")
    private BigDecimal cost;

    /** 状态（0成功 1失败） */
    @Excel(name = "状态", readConverterExp = "0=成功,1=失败")
    private String status;

    /** 失败原因 */
    @Excel(name = "失败原因")
    private String errorMsg;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setTaskType(String taskType) 
    {
        this.taskType = taskType;
    }

    public String getTaskType() 
    {
        return taskType;
    }

    public void setModel(String model) 
    {
        this.model = model;
    }

    public String getModel() 
    {
        return model;
    }

    public void setPromptTokens(Integer promptTokens) 
    {
        this.promptTokens = promptTokens;
    }

    public Integer getPromptTokens() 
    {
        return promptTokens;
    }

    public void setCompletionTokens(Integer completionTokens) 
    {
        this.completionTokens = completionTokens;
    }

    public Integer getCompletionTokens() 
    {
        return completionTokens;
    }

    public void setDurationMs(Long durationMs) 
    {
        this.durationMs = durationMs;
    }

    public Long getDurationMs() 
    {
        return durationMs;
    }

    public void setCost(BigDecimal cost) 
    {
        this.cost = cost;
    }

    public BigDecimal getCost() 
    {
        return cost;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    public void setErrorMsg(String errorMsg) 
    {
        this.errorMsg = errorMsg;
    }

    public String getErrorMsg() 
    {
        return errorMsg;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("taskType", getTaskType())
            .append("model", getModel())
            .append("promptTokens", getPromptTokens())
            .append("completionTokens", getCompletionTokens())
            .append("durationMs", getDurationMs())
            .append("cost", getCost())
            .append("status", getStatus())
            .append("errorMsg", getErrorMsg())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
