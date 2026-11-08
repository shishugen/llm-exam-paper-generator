package com.ruoyi.exam.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import java.util.Map;
import com.ruoyi.exam.domain.ExamPaper;

/**
 * 试卷Mapper接口
 * 
 * @author shishugen
 * @date 2026-11-07
 */
public interface ExamPaperMapper 
{
    /**
     * 查询试卷
     * 
     * @param id 试卷主键
     * @return 试卷
     */
    public ExamPaper selectExamPaperById(Long id);

    /**
     * 查询试卷列表
     * 
     * @param examPaper 试卷
     * @return 试卷集合
     */
    public List<ExamPaper> selectExamPaperList(ExamPaper examPaper);

    /**
     * 新增试卷
     * 
     * @param examPaper 试卷
     * @return 结果
     */
    public int insertExamPaper(ExamPaper examPaper);

    /**
     * 修改试卷
     * 
     * @param examPaper 试卷
     * @return 结果
     */
    public int updateExamPaper(ExamPaper examPaper);

    /**
     * 删除试卷
     * 
     * @param id 试卷主键
     * @return 结果
     */
    public int deleteExamPaperById(Long id);

    /**
     * 批量删除试卷
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteExamPaperByIds(Long[] ids);

    /**
     * 试卷已覆盖的知识点数
     */
    public int countKnowledgeInPaper(@Param("paperId") Long paperId);

    /**
     * 整门课程的知识点总数（覆盖率分母）
     */
    public int countKnowledgeTotal(@Param("courseId") Long courseId);

    /**
     * 指定章节的知识点总数（限定章节组卷时的覆盖率分母）
     */
    public int countKnowledgeTotalByChapters(@Param("chapterIds") List<Long> chapterIds);

    /**
     * 试卷详情：明细联查题目，给页面和 Word 导出用
     */
    public List<Map<String, Object>> selectPaperDetail(@Param("paperId") Long paperId);
}
