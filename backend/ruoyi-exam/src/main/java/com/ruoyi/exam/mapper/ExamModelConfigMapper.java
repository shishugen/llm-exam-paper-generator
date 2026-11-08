package com.ruoyi.exam.mapper;

import java.util.List;
import com.ruoyi.exam.domain.ExamModelConfig;

/**
 * 模型配置Mapper接口
 * 
 * @author shishugen
 * @date 2026-11-08
 */
public interface ExamModelConfigMapper 
{
    /**
     * 查询模型配置
     * 
     * @param id 模型配置主键
     * @return 模型配置
     */
    public ExamModelConfig selectExamModelConfigById(Long id);

    /**
     * 查询模型配置列表
     * 
     * @param examModelConfig 模型配置
     * @return 模型配置集合
     */
    public List<ExamModelConfig> selectExamModelConfigList(ExamModelConfig examModelConfig);

    /**
     * 新增模型配置
     * 
     * @param examModelConfig 模型配置
     * @return 结果
     */
    public int insertExamModelConfig(ExamModelConfig examModelConfig);

    /**
     * 修改模型配置
     * 
     * @param examModelConfig 模型配置
     * @return 结果
     */
    public int updateExamModelConfig(ExamModelConfig examModelConfig);

    /**
     * 删除模型配置
     * 
     * @param id 模型配置主键
     * @return 结果
     */
    public int deleteExamModelConfigById(Long id);

    /**
     * 批量删除模型配置
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteExamModelConfigByIds(Long[] ids);
}
