package com.ruoyi.exam.controller;

import java.util.List;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.exam.domain.ExamModelConfig;
import com.ruoyi.exam.service.IExamModelConfigService;
import com.ruoyi.exam.util.KeyUtil;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 模型配置Controller
 * 
 * @author shishugen
 * @date 2026-11-08
 */
@RestController
@RequestMapping("/exam/modelConfig")
public class ExamModelConfigController extends BaseController
{
    @Autowired
    private IExamModelConfigService examModelConfigService;

    /**
     * 查询模型配置列表
     */
    @PreAuthorize("@ss.hasPermi('exam:modelConfig:list')")
    @GetMapping("/list")
    public TableDataInfo list(ExamModelConfig examModelConfig)
    {
        startPage();
        List<ExamModelConfig> list = examModelConfigService.selectExamModelConfigList(examModelConfig);
        for (ExamModelConfig item : list)
        {
            item.setApiKey("");
        }
        return getDataTable(list);
    }

    /**
     * 导出模型配置列表
     */
    @PreAuthorize("@ss.hasPermi('exam:modelConfig:export')")
    @Log(title = "模型配置", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ExamModelConfig examModelConfig)
    {
        List<ExamModelConfig> list = examModelConfigService.selectExamModelConfigList(examModelConfig);
        ExcelUtil<ExamModelConfig> util = new ExcelUtil<ExamModelConfig>(ExamModelConfig.class);
        util.exportExcel(response, list, "模型配置数据");
    }

    /**
     * 获取模型配置详细信息
     */
    @PreAuthorize("@ss.hasPermi('exam:modelConfig:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        ExamModelConfig config = examModelConfigService.selectExamModelConfigById(id);
        config.setApiKey("");
        return success(config);
    }

    /**
     * 新增模型配置
     */
    @PreAuthorize("@ss.hasPermi('exam:modelConfig:add')")
    @Log(title = "模型配置", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ExamModelConfig examModelConfig)
    {
        if (examModelConfig.getApiKey() == null || examModelConfig.getApiKey().isEmpty())
        {
            return error("密钥不能为空");
        }
        examModelConfig.setApiKey(KeyUtil.encrypt(examModelConfig.getApiKey()));
        return toAjax(examModelConfigService.insertExamModelConfig(examModelConfig));
    }

    /**
     * 修改模型配置
     */
    @PreAuthorize("@ss.hasPermi('exam:modelConfig:edit')")
    @Log(title = "模型配置", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ExamModelConfig examModelConfig)
    {
        String newKey = examModelConfig.getApiKey();
        if (newKey == null || newKey.isEmpty())
        {
            // 留空表示不改密钥，把数据库里的原密文填回去
            ExamModelConfig old = examModelConfigService.selectExamModelConfigById(examModelConfig.getId());
            examModelConfig.setApiKey(old.getApiKey());
        }
        else
        {
            examModelConfig.setApiKey(KeyUtil.encrypt(newKey));
        }
        return toAjax(examModelConfigService.updateExamModelConfig(examModelConfig));
    }

    /**
     * 删除模型配置
     */
    @PreAuthorize("@ss.hasPermi('exam:modelConfig:remove')")
    @Log(title = "模型配置", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(examModelConfigService.deleteExamModelConfigByIds(ids));
    }
}
