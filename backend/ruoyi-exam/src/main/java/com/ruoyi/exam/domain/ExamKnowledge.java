package com.ruoyi.exam.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 知识点对象 exam_knowledge
 * 
 * @author shishugen
 * @date 2026-11-07
 */
public class ExamKnowledge extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 知识点ID */
    private Long id;

    /** 所属章节ID */
    private Long chapterId;

    /** 所属章节名称（关联 exam_chapter 查出来，不存表） */
    @Excel(name = "所属章节")
    private String chapterName;

    /** 知识点名称 */
    @Excel(name = "知识点名称")
    private String name;

    /** 考查权重（1-10，越大越重要） */
    @Excel(name = "考查权重", readConverterExp = "1=-10，越大越重要")
    private Integer weight;

    /** 显示顺序 */
    @Excel(name = "显示顺序")
    private Integer sortNo;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setChapterId(Long chapterId) 
    {
        this.chapterId = chapterId;
    }

    public Long getChapterId() 
    {
        return chapterId;
    }

    public void setChapterName(String chapterName) 
    {
        this.chapterName = chapterName;
    }

    public String getChapterName() 
    {
        return chapterName;
    }

    public void setName(String name) 
    {
        this.name = name;
    }

    public String getName() 
    {
        return name;
    }

    public void setWeight(Integer weight) 
    {
        this.weight = weight;
    }

    public Integer getWeight() 
    {
        return weight;
    }

    public void setSortNo(Integer sortNo) 
    {
        this.sortNo = sortNo;
    }

    public Integer getSortNo() 
    {
        return sortNo;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("chapterId", getChapterId())
            .append("name", getName())
            .append("weight", getWeight())
            .append("sortNo", getSortNo())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
