package com.ruoyi.exam.service;

import java.util.List;
import com.ruoyi.exam.domain.ExamKnowledge;

/**
 * 知识点Service接口
 * 
 * @author shishugen
 * @date 2026-11-07
 */
public interface IExamKnowledgeService 
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
     * 批量删除知识点
     * 
     * @param ids 需要删除的知识点主键集合
     * @return 结果
     */
    public int deleteExamKnowledgeByIds(Long[] ids);

    /**
     * 删除知识点信息
     * 
     * @param id 知识点主键
     * @return 结果
     */
    public int deleteExamKnowledgeById(Long id);
}
