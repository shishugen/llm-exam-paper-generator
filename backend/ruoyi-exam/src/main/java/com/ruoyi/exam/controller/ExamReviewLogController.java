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
import com.ruoyi.exam.domain.ExamReviewLog;
import com.ruoyi.exam.service.IExamReviewLogService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 题目审核记录Controller
 * 
 * @author shishugen
 * @date 2026-11-07
 */
@RestController
@RequestMapping("/exam/reviewLog")
public class ExamReviewLogController extends BaseController
{
    @Autowired
    private IExamReviewLogService examReviewLogService;

    /**
     * 查询题目审核记录列表
     */
    @PreAuthorize("@ss.hasPermi('exam:reviewLog:list')")
    @GetMapping("/list")
    public TableDataInfo list(ExamReviewLog examReviewLog)
    {
        startPage();
        List<ExamReviewLog> list = examReviewLogService.selectExamReviewLogList(examReviewLog);
        return getDataTable(list);
    }

    /**
     * 导出题目审核记录列表
     */
    @PreAuthorize("@ss.hasPermi('exam:reviewLog:export')")
    @Log(title = "题目审核记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ExamReviewLog examReviewLog)
    {
        List<ExamReviewLog> list = examReviewLogService.selectExamReviewLogList(examReviewLog);
        ExcelUtil<ExamReviewLog> util = new ExcelUtil<ExamReviewLog>(ExamReviewLog.class);
        util.exportExcel(response, list, "题目审核记录数据");
    }

    /**
     * 获取题目审核记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('exam:reviewLog:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(examReviewLogService.selectExamReviewLogById(id));
    }

    /**
     * 新增题目审核记录
     */
    @PreAuthorize("@ss.hasPermi('exam:reviewLog:add')")
    @Log(title = "题目审核记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ExamReviewLog examReviewLog)
    {
        return toAjax(examReviewLogService.insertExamReviewLog(examReviewLog));
    }

    /**
     * 修改题目审核记录
     */
    @PreAuthorize("@ss.hasPermi('exam:reviewLog:edit')")
    @Log(title = "题目审核记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ExamReviewLog examReviewLog)
    {
        return toAjax(examReviewLogService.updateExamReviewLog(examReviewLog));
    }

    /**
     * 删除题目审核记录
     */
    @PreAuthorize("@ss.hasPermi('exam:reviewLog:remove')")
    @Log(title = "题目审核记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(examReviewLogService.deleteExamReviewLogByIds(ids));
    }
}
