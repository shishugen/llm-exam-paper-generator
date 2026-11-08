package com.ruoyi.exam.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 试卷明细对象 exam_paper_question
 * 
 * @author shishugen
 * @date 2026-11-07
 */
public class ExamPaperQuestion extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 明细ID */
    private Long id;

    /** 试卷ID */
    private Long paperId;

    /** 试卷名称（关联 exam_paper 查出来，不存表） */
    @Excel(name = "试卷名称")
    private String paperName;

    /** 题目ID */
    private Long questionId;

    /** 题目题干（关联 exam_question 查出来，不存表） */
    @Excel(name = "题目")
    private String questionStem;

    /** 题号顺序 */
    @Excel(name = "题号顺序")
    private Integer sortNo;

    /** 本卷中该题分值（分） */
    @Excel(name = "本卷中该题分值", readConverterExp = "分=")
    private Integer score;

    /** 是否锁定（0否 1是，替换时跳过） */
    @Excel(name = "是否锁定", readConverterExp = "0=否,1=是，替换时跳过")
    private String locked;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setPaperId(Long paperId) 
    {
        this.paperId = paperId;
    }

    public Long getPaperId() 
    {
        return paperId;
    }

    public void setPaperName(String paperName) 
    {
        this.paperName = paperName;
    }

    public String getPaperName() 
    {
        return paperName;
    }

    public void setQuestionId(Long questionId) 
    {
        this.questionId = questionId;
    }

    public Long getQuestionId() 
    {
        return questionId;
    }

    public void setQuestionStem(String questionStem) 
    {
        this.questionStem = questionStem;
    }

    public String getQuestionStem() 
    {
        return questionStem;
    }

    public void setSortNo(Integer sortNo) 
    {
        this.sortNo = sortNo;
    }

    public Integer getSortNo() 
    {
        return sortNo;
    }

    public void setScore(Integer score) 
    {
        this.score = score;
    }

    public Integer getScore() 
    {
        return score;
    }

    public void setLocked(String locked) 
    {
        this.locked = locked;
    }

    public String getLocked() 
    {
        return locked;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("paperId", getPaperId())
            .append("questionId", getQuestionId())
            .append("sortNo", getSortNo())
            .append("score", getScore())
            .append("locked", getLocked())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
