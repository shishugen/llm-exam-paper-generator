package com.ruoyi.exam.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.exam.domain.ExamKnowledge;

/**
 * 知识点Mapper接口
 * 
 * @author shishugen
 * @date 2026-11-07
 */
public interface ExamKnowledgeMapper 
{
    /**
     * 查询知识点
     * 
     * @param id 知识点主键
     * @return 知识点
     */
    public ExamKnowledge selectExamKnowledgeById(Long id);

    /**
     * 查询知识点列表
     * 
     * @param examKnowledge 知识点
     * @return 知识点集合
     */
    public List<ExamKnowledge> selectExamKnowledgeList(ExamKnowledge examKnowledge);

    /**
     * 新增知识点
     * 
     * @param examKnowledge 知识点
     * @return 结果
     */
    public int insertExamKnowledge(ExamKnowledge examKnowledge);

    /**
     * 修改知识点
     * 
     * @param examKnowledge 知识点
     * @return 结果
     */
    public int updateExamKnowledge(ExamKnowledge examKnowledge);

    /**
     * 删除知识点
     * 
     * @param id 知识点主键
     * @return 结果
     */
    public int deleteExamKnowledgeById(Long id);

    /**
     * 批量删除知识点
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteExamKnowledgeByIds(Long[] ids);

    /**
     * 查知识点名称
     */
    public String selectKnowledgeName(@Param("knowledgeId") Long knowledgeId);

    /**
     * 按知识点反查所属课程
     */
    public Long selectCourseIdByKnowledge(@Param("knowledgeId") Long knowledgeId);

    /**
     * 按知识点反查所属章节
     */
    public Long selectChapterIdByKnowledge(@Param("knowledgeId") Long knowledgeId);
}
