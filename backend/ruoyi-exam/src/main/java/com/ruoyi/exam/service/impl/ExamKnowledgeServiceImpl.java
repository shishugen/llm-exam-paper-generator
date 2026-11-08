package com.ruoyi.exam.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.exam.mapper.ExamKnowledgeMapper;
import com.ruoyi.exam.domain.ExamKnowledge;
import com.ruoyi.exam.service.IExamKnowledgeService;

/**
 * 知识点Service业务层处理
 * 
 * @author shishugen
 * @date 2026-11-07
 */
@Service
public class ExamKnowledgeServiceImpl implements IExamKnowledgeService 
{
    @Autowired
    private ExamKnowledgeMapper examKnowledgeMapper;

    /**
     * 查询知识点
     * 
     * @param id 知识点主键
     * @return 知识点
     */
    @Override
    public ExamKnowledge selectExamKnowledgeById(Long id)
    {
        return examKnowledgeMapper.selectExamKnowledgeById(id);
    }

    /**
     * 查询知识点列表
     * 
     * @param examKnowledge 知识点
     * @return 知识点
     */
    @Override
    public List<ExamKnowledge> selectExamKnowledgeList(ExamKnowledge examKnowledge)
    {
        return examKnowledgeMapper.selectExamKnowledgeList(examKnowledge);
    }

    /**
     * 新增知识点
     * 
     * @param examKnowledge 知识点
     * @return 结果
     */
    @Override
    public int insertExamKnowledge(ExamKnowledge examKnowledge)
    {
        examKnowledge.setCreateTime(DateUtils.getNowDate());
        return examKnowledgeMapper.insertExamKnowledge(examKnowledge);
    }

    /**
     * 修改知识点
     * 
     * @param examKnowledge 知识点
     * @return 结果
     */
    @Override
    public int updateExamKnowledge(ExamKnowledge examKnowledge)
    {
        examKnowledge.setUpdateTime(DateUtils.getNowDate());
        return examKnowledgeMapper.updateExamKnowledge(examKnowledge);
    }

    /**
     * 批量删除知识点
     * 
     * @param ids 需要删除的知识点主键
     * @return 结果
     */
    @Override
    public int deleteExamKnowledgeByIds(Long[] ids)
    {
        return examKnowledgeMapper.deleteExamKnowledgeByIds(ids);
    }

    /**
     * 删除知识点信息
     * 
     * @param id 知识点主键
     * @return 结果
     */
    @Override
    public int deleteExamKnowledgeById(Long id)
    {
        return examKnowledgeMapper.deleteExamKnowledgeById(id);
    }
}
