package com.ruoyi.exam.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 题目审核记录对象 exam_review_log
 * 
 * @author shishugen
 * @date 2026-11-07
 */
public class ExamReviewLog extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 记录ID */
    private Long id;

    /** 题目ID */
    private Long questionId;

    /** 题目题干（关联 exam_question 查出来，不存表） */
    @Excel(name = "题目")
    private String questionName;

    /** 操作（1提交待审 2审核通过 3审核驳回） */
    @Excel(name = "操作", readConverterExp = "1=提交待审,2=审核通过,3=审核驳回")
    private String action;

    /** 操作说明/驳回原因 */
    @Excel(name = "操作说明/驳回原因")
    private String reason;

    /** 操作人ID（sys_user.user_id） */
    private Long reviewerId;

    /** 操作人姓名（关联 sys_user 查出来，不存表） */
    @Excel(name = "操作人")
    private String reviewerName;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setQuestionId(Long questionId) 
    {
        this.questionId = questionId;
    }

    public Long getQuestionId() 
    {
        return questionId;
    }

    public void setQuestionName(String questionName) 
    {
        this.questionName = questionName;
    }

    public String getQuestionName() 
    {
        return questionName;
    }

    public void setReviewerName(String reviewerName) 
    {
        this.reviewerName = reviewerName;
    }

    public String getReviewerName() 
    {
        return reviewerName;
    }

    public void setAction(String action) 
    {
        this.action = action;
    }

    public String getAction() 
    {
        return action;
    }

    public void setReason(String reason) 
    {
        this.reason = reason;
    }

    public String getReason() 
    {
        return reason;
    }

    public void setReviewerId(Long reviewerId) 
    {
        this.reviewerId = reviewerId;
    }

    public Long getReviewerId() 
    {
        return reviewerId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("questionId", getQuestionId())
            .append("action", getAction())
            .append("reason", getReason())
            .append("reviewerId", getReviewerId())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
