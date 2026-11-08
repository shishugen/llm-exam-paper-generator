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
import com.ruoyi.exam.domain.ExamKnowledge;
import com.ruoyi.exam.service.IExamKnowledgeService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 知识点Controller
 * 
 * @author shishugen
 * @date 2026-11-07
 */
@RestController
@RequestMapping("/exam/knowledge")
public class ExamKnowledgeController extends BaseController
{
    @Autowired
    private IExamKnowledgeService examKnowledgeService;

    /**
     * 查询知识点列表
     */
    @PreAuthorize("@ss.hasPermi('exam:knowledge:list')")
    @GetMapping("/list")
    public TableDataInfo list(ExamKnowledge examKnowledge)
    {
        startPage();
        List<ExamKnowledge> list = examKnowledgeService.selectExamKnowledgeList(examKnowledge);
        return getDataTable(list);
    }

    /**
     * 导出知识点列表
     */
    @PreAuthorize("@ss.hasPermi('exam:knowledge:export')")
    @Log(title = "知识点", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ExamKnowledge examKnowledge)
    {
        List<ExamKnowledge> list = examKnowledgeService.selectExamKnowledgeList(examKnowledge);
        ExcelUtil<ExamKnowledge> util = new ExcelUtil<ExamKnowledge>(ExamKnowledge.class);
        util.exportExcel(response, list, "知识点数据");
    }

    /**
     * 获取知识点详细信息
     */
    @PreAuthorize("@ss.hasPermi('exam:knowledge:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(examKnowledgeService.selectExamKnowledgeById(id));
    }

    /**
     * 新增知识点
     */
    @PreAuthorize("@ss.hasPermi('exam:knowledge:add')")
    @Log(title = "知识点", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ExamKnowledge examKnowledge)
    {
        return toAjax(examKnowledgeService.insertExamKnowledge(examKnowledge));
    }

    /**
     * 修改知识点
     */
    @PreAuthorize("@ss.hasPermi('exam:knowledge:edit')")
    @Log(title = "知识点", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ExamKnowledge examKnowledge)
    {
        return toAjax(examKnowledgeService.updateExamKnowledge(examKnowledge));
    }

    /**
     * 删除知识点
     */
    @PreAuthorize("@ss.hasPermi('exam:knowledge:remove')")
    @Log(title = "知识点", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(examKnowledgeService.deleteExamKnowledgeByIds(ids));
    }
}
