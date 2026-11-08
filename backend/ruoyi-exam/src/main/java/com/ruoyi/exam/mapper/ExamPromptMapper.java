package com.ruoyi.exam.mapper;

import java.util.List;
import com.ruoyi.exam.domain.ExamPrompt;

/**
 * 提示词Mapper接口
 * 
 * @author shishugen
 * @date 2026-11-08
 */
public interface ExamPromptMapper 
{
    /**
     * 查询提示词
     * 
     * @param id 提示词主键
     * @return 提示词
     */
    public ExamPrompt selectExamPromptById(Long id);

    /**
     * 查询提示词列表
     * 
     * @param examPrompt 提示词
     * @return 提示词集合
     */
    public List<ExamPrompt> selectExamPromptList(ExamPrompt examPrompt);

    /**
     * 新增提示词
     * 
     * @param examPrompt 提示词
     * @return 结果
     */
    public int insertExamPrompt(ExamPrompt examPrompt);

    /**
     * 修改提示词
     * 
     * @param examPrompt 提示词
     * @return 结果
     */
    public int updateExamPrompt(ExamPrompt examPrompt);

    /**
     * 删除提示词
     * 
     * @param id 提示词主键
     * @return 结果
     */
    public int deleteExamPromptById(Long id);

    /**
     * 批量删除提示词
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteExamPromptByIds(Long[] ids);
}
