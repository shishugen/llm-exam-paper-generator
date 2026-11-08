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
import com.ruoyi.exam.domain.ExamPrompt;
import com.ruoyi.exam.service.IExamPromptService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 提示词Controller
 * 
 * @author shishugen
 * @date 2026-11-08
 */
@RestController
@RequestMapping("/exam/prompt")
public class ExamPromptController extends BaseController
{
    @Autowired
    private IExamPromptService examPromptService;

    /**
     * 查询提示词列表
     */
    @PreAuthorize("@ss.hasPermi('exam:prompt:list')")
    @GetMapping("/list")
    public TableDataInfo list(ExamPrompt examPrompt)
    {
        startPage();
        List<ExamPrompt> list = examPromptService.selectExamPromptList(examPrompt);
        return getDataTable(list);
    }

    /**
     * 导出提示词列表
     */
    @PreAuthorize("@ss.hasPermi('exam:prompt:export')")
    @Log(title = "提示词", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ExamPrompt examPrompt)
    {
        List<ExamPrompt> list = examPromptService.selectExamPromptList(examPrompt);
        ExcelUtil<ExamPrompt> util = new ExcelUtil<ExamPrompt>(ExamPrompt.class);
        util.exportExcel(response, list, "提示词数据");
    }

    /**
     * 获取提示词详细信息
     */
    @PreAuthorize("@ss.hasPermi('exam:prompt:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(examPromptService.selectExamPromptById(id));
    }

    /**
     * 新增提示词
     */
    @PreAuthorize("@ss.hasPermi('exam:prompt:add')")
    @Log(title = "提示词", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ExamPrompt examPrompt)
    {
        return toAjax(examPromptService.insertExamPrompt(examPrompt));
    }

    /**
     * 修改提示词
     */
    @PreAuthorize("@ss.hasPermi('exam:prompt:edit')")
    @Log(title = "提示词", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ExamPrompt examPrompt)
    {
        return toAjax(examPromptService.updateExamPrompt(examPrompt));
    }

    /**
     * 删除提示词
     */
    @PreAuthorize("@ss.hasPermi('exam:prompt:remove')")
    @Log(title = "提示词", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(examPromptService.deleteExamPromptByIds(ids));
    }
}
