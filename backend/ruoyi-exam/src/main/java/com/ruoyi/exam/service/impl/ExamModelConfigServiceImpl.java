package com.ruoyi.exam.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.exam.mapper.ExamModelConfigMapper;
import com.ruoyi.exam.domain.ExamModelConfig;
import com.ruoyi.exam.service.IExamModelConfigService;

/**
 * 模型配置Service业务层处理
 * 
 * @author shishugen
 * @date 2026-11-08
 */
@Service
public class ExamModelConfigServiceImpl implements IExamModelConfigService 
{
    @Autowired
    private ExamModelConfigMapper examModelConfigMapper;

    /**
     * 查询模型配置
     * 
     * @param id 模型配置主键
     * @return 模型配置
     */
    @Override
    public ExamModelConfig selectExamModelConfigById(Long id)
    {
        return examModelConfigMapper.selectExamModelConfigById(id);
    }

    /**
     * 查询模型配置列表
     * 
     * @param examModelConfig 模型配置
     * @return 模型配置
     */
    @Override
    public List<ExamModelConfig> selectExamModelConfigList(ExamModelConfig examModelConfig)
    {
        return examModelConfigMapper.selectExamModelConfigList(examModelConfig);
    }

    /**
     * 新增模型配置
     * 
     * @param examModelConfig 模型配置
     * @return 结果
     */
    @Override
    public int insertExamModelConfig(ExamModelConfig examModelConfig)
    {
        examModelConfig.setCreateTime(DateUtils.getNowDate());
        return examModelConfigMapper.insertExamModelConfig(examModelConfig);
    }

    /**
     * 修改模型配置
     * 
     * @param examModelConfig 模型配置
     * @return 结果
     */
    @Override
    public int updateExamModelConfig(ExamModelConfig examModelConfig)
    {
        examModelConfig.setUpdateTime(DateUtils.getNowDate());
        return examModelConfigMapper.updateExamModelConfig(examModelConfig);
    }

    /**
     * 批量删除模型配置
     * 
     * @param ids 需要删除的模型配置主键
     * @return 结果
     */
    @Override
    public int deleteExamModelConfigByIds(Long[] ids)
    {
        return examModelConfigMapper.deleteExamModelConfigByIds(ids);
    }

    /**
     * 删除模型配置信息
     * 
     * @param id 模型配置主键
     * @return 结果
     */
    @Override
    public int deleteExamModelConfigById(Long id)
    {
        return examModelConfigMapper.deleteExamModelConfigById(id);
    }
}
