package com.ruoyi.exam.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 试卷对象 exam_paper
 * 
 * @author shishugen
 * @date 2026-11-07
 */
public class ExamPaper extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 试卷ID */
    private Long id;

    /** 所属课程ID */
    private Long courseId;

    /** 所属课程名称（关联 exam_course 查出来，不存表） */
    @Excel(name = "所属课程")
    private String courseName;

    /** 试卷名称 */
    @Excel(name = "试卷名称")
    private String title;

    /** 试卷总分（分） */
    @Excel(name = "试卷总分", readConverterExp = "分=")
    private Integer totalScore;

    /** 组卷配置JSON：总分/题型配比/难度分布/知识点覆盖率 */
    @Excel(name = "组卷配置JSON：总分/题型配比/难度分布/知识点覆盖率")
    private String configJson;

    /** 状态（0生成中 1已完成 2已导出） */
    @Excel(name = "状态", readConverterExp = "0=生成中,1=已完成,2=已导出")
    private String status;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setCourseId(Long courseId) 
    {
        this.courseId = courseId;
    }

    public Long getCourseId() 
    {
        return courseId;
    }

    public void setCourseName(String courseName) 
    {
        this.courseName = courseName;
    }

    public String getCourseName() 
    {
        return courseName;
    }

    public void setTitle(String title) 
    {
        this.title = title;
    }

    public String getTitle() 
    {
        return title;
    }

    public void setTotalScore(Integer totalScore) 
    {
        this.totalScore = totalScore;
    }

    public Integer getTotalScore() 
    {
        return totalScore;
    }

    public void setConfigJson(String configJson) 
    {
        this.configJson = configJson;
    }

    public String getConfigJson() 
    {
        return configJson;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("courseId", getCourseId())
            .append("title", getTitle())
            .append("totalScore", getTotalScore())
            .append("configJson", getConfigJson())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
