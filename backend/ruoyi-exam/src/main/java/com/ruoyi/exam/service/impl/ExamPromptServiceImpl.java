package com.ruoyi.exam.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.exam.mapper.ExamPromptMapper;
import com.ruoyi.exam.domain.ExamPrompt;
import com.ruoyi.exam.service.IExamPromptService;

/**
 * 提示词Service业务层处理
 * 
 * @author shishugen
 * @date 2026-11-08
 */
@Service
public class ExamPromptServiceImpl implements IExamPromptService 
{
    @Autowired
    private ExamPromptMapper examPromptMapper;

    /**
     * 查询提示词
     * 
     * @param id 提示词主键
     * @return 提示词
     */
    @Override
    public ExamPrompt selectExamPromptById(Long id)
    {
        return examPromptMapper.selectExamPromptById(id);
    }

    /**
     * 查询提示词列表
     * 
     * @param examPrompt 提示词
     * @return 提示词
     */
    @Override
    public List<ExamPrompt> selectExamPromptList(ExamPrompt examPrompt)
    {
        return examPromptMapper.selectExamPromptList(examPrompt);
    }

    /**
     * 新增提示词
     * 
     * @param examPrompt 提示词
     * @return 结果
     */
    @Override
    public int insertExamPrompt(ExamPrompt examPrompt)
    {
        examPrompt.setCreateTime(DateUtils.getNowDate());
        return examPromptMapper.insertExamPrompt(examPrompt);
    }

    /**
     * 修改提示词
     * 
     * @param examPrompt 提示词
     * @return 结果
     */
    @Override
    public int updateExamPrompt(ExamPrompt examPrompt)
    {
        examPrompt.setUpdateTime(DateUtils.getNowDate());
        return examPromptMapper.updateExamPrompt(examPrompt);
    }

    /**
     * 批量删除提示词
     * 
     * @param ids 需要删除的提示词主键
     * @return 结果
     */
    @Override
    public int deleteExamPromptByIds(Long[] ids)
    {
        return examPromptMapper.deleteExamPromptByIds(ids);
    }

    /**
     * 删除提示词信息
     * 
     * @param id 提示词主键
     * @return 结果
     */
    @Override
    public int deleteExamPromptById(Long id)
    {
        return examPromptMapper.deleteExamPromptById(id);
    }
}
