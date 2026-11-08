package com.ruoyi.exam.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 题库对象 exam_question
 * 
 * @author shishugen
 * @date 2026-11-07
 */
public class ExamQuestion extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 题目ID */
    private Long id;

    /** 所属课程ID */
    private Long courseId;

    /** 所属章节ID */
    private Long chapterId;

    /** 所属知识点ID */
    private Long knowledgeId;

    /** 所属课程名称（联表查询得到，不入库） */
    @Excel(name = "所属课程")
    private String courseName;

    /** 所属章节名称（联表查询得到，不入库） */
    @Excel(name = "所属章节")
    private String chapterName;

    /** 所属知识点名称（联表查询得到，不入库） */
    @Excel(name = "所属知识点")
    private String knowledgeName;

    /** 题型（1单选 2多选 3判断 4简答 5综合） */
    @Excel(name = "题型", readConverterExp = "1=单选,2=多选,3=判断,4=简答,5=综合")
    private String type;

    /** 难度（1容易 2中等 3较难 4困难） */
    @Excel(name = "难度", readConverterExp = "1=容易,2=中等,3=较难,4=困难")
    private String difficulty;

    /** 题干 */
    @Excel(name = "题干")
    private String stem;

    /** 选项JSON，简答题/判断题为NULL */
    @Excel(name = "选项JSON，简答题/判断题为NULL")
    private String options;

    /** 参考答案 */
    @Excel(name = "参考答案")
    private String answer;

    /** 试题解析 */
    @Excel(name = "试题解析")
    private String analysis;

    /** 建议分值（分） */
    @Excel(name = "建议分值", readConverterExp = "分=")
    private Integer score;

    /** 状态（0草稿 1待审 2已通过 3已驳回） */
    @Excel(name = "状态", readConverterExp = "0=草稿,1=待审,2=已通过,3=已驳回")
    private String status;

    /** 来源（0人工录入 1AI生成） */
    @Excel(name = "来源", readConverterExp = "0=人工录入,1=AI生成")
    private String source;

    /** 驳回原因（下次生成时拼进Prompt开头） */
    @Excel(name = "驳回原因", readConverterExp = "下=次生成时拼进Prompt开头")
    private String rejectReason;

    /** 审核人ID（sys_user.user_id） */
    @Excel(name = "审核人ID", readConverterExp = "s=ys_user.user_id")
    private Long reviewerId;

    /** 审核人名称（联表 sys_user.user_name，不入库，靠 resultMap 映射） */
    private String reviewerName;

    /** 审核时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "审核时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date reviewTime;

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

    public void setChapterId(Long chapterId) 
    {
        this.chapterId = chapterId;
    }

    public Long getChapterId() 
    {
        return chapterId;
    }

    public void setKnowledgeId(Long knowledgeId) 
    {
        this.knowledgeId = knowledgeId;
    }

    public Long getKnowledgeId() 
    {
        return knowledgeId;
    }

    public void setCourseName(String courseName) 
    {
        this.courseName = courseName;
    }

    public String getCourseName() 
    {
        return courseName;
    }

    public void setChapterName(String chapterName) 
    {
        this.chapterName = chapterName;
    }

    public String getChapterName() 
    {
        return chapterName;
    }

    public void setKnowledgeName(String knowledgeName) 
    {
        this.knowledgeName = knowledgeName;
    }

    public String getKnowledgeName() 
    {
        return knowledgeName;
    }

    public void setType(String type) 
    {
        this.type = type;
    }

    public String getType() 
    {
        return type;
    }

    public void setDifficulty(String difficulty) 
    {
        this.difficulty = difficulty;
    }

    public String getDifficulty() 
    {
        return difficulty;
    }

    public void setStem(String stem) 
    {
        this.stem = stem;
    }

    public String getStem() 
    {
        return stem;
    }

    public void setOptions(String options) 
    {
        this.options = options;
    }

    public String getOptions() 
    {
        return options;
    }

    public void setAnswer(String answer) 
    {
        this.answer = answer;
    }

    public String getAnswer() 
    {
        return answer;
    }

    public void setAnalysis(String analysis) 
    {
        this.analysis = analysis;
    }

    public String getAnalysis() 
    {
        return analysis;
    }

    public void setScore(Integer score) 
    {
        this.score = score;
    }

    public Integer getScore() 
    {
        return score;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    public void setSource(String source) 
    {
        this.source = source;
    }

    public String getSource() 
    {
        return source;
    }

    public void setRejectReason(String rejectReason) 
    {
        this.rejectReason = rejectReason;
    }

    public String getRejectReason() 
    {
        return rejectReason;
    }

    public void setReviewerId(Long reviewerId) 
    {
        this.reviewerId = reviewerId;
    }

    public Long getReviewerId() 
    {
        return reviewerId;
    }

    public void setReviewerName(String reviewerName)
    {
        this.reviewerName = reviewerName;
    }

    public String getReviewerName()
    {
        return reviewerName;
    }

    public void setReviewTime(Date reviewTime) 
    {
        this.reviewTime = reviewTime;
    }

    public Date getReviewTime() 
    {
        return reviewTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("courseId", getCourseId())
            .append("chapterId", getChapterId())
            .append("knowledgeId", getKnowledgeId())
            .append("courseName", getCourseName())
            .append("chapterName", getChapterName())
            .append("knowledgeName", getKnowledgeName())
            .append("type", getType())
            .append("difficulty", getDifficulty())
            .append("stem", getStem())
            .append("options", getOptions())
            .append("answer", getAnswer())
            .append("analysis", getAnalysis())
            .append("score", getScore())
            .append("status", getStatus())
            .append("source", getSource())
            .append("rejectReason", getRejectReason())
            .append("reviewerId", getReviewerId())
            .append("reviewTime", getReviewTime())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
