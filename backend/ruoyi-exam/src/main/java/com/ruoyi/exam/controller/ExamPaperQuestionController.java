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
import com.ruoyi.exam.domain.ExamPaperQuestion;
import com.ruoyi.exam.service.IExamPaperQuestionService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 试卷明细Controller
 * 
 * @author shishugen
 * @date 2026-11-07
 */
@RestController
@RequestMapping("/exam/paperQuestion")
public class ExamPaperQuestionController extends BaseController
{
    @Autowired
    private IExamPaperQuestionService examPaperQuestionService;

    /**
     * 查询试卷明细列表
     */
    @PreAuthorize("@ss.hasPermi('exam:paperQuestion:list')")
    @GetMapping("/list")
    public TableDataInfo list(ExamPaperQuestion examPaperQuestion)
    {
        startPage();
        List<ExamPaperQuestion> list = examPaperQuestionService.selectExamPaperQuestionList(examPaperQuestion);
        return getDataTable(list);
    }

    /**
     * 导出试卷明细列表
     */
    @PreAuthorize("@ss.hasPermi('exam:paperQuestion:export')")
    @Log(title = "试卷明细", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ExamPaperQuestion examPaperQuestion)
    {
        List<ExamPaperQuestion> list = examPaperQuestionService.selectExamPaperQuestionList(examPaperQuestion);
        ExcelUtil<ExamPaperQuestion> util = new ExcelUtil<ExamPaperQuestion>(ExamPaperQuestion.class);
        util.exportExcel(response, list, "试卷明细数据");
    }

    /**
     * 获取试卷明细详细信息
     */
    @PreAuthorize("@ss.hasPermi('exam:paperQuestion:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(examPaperQuestionService.selectExamPaperQuestionById(id));
    }

    /**
     * 新增试卷明细
     */
    @PreAuthorize("@ss.hasPermi('exam:paperQuestion:add')")
    @Log(title = "试卷明细", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ExamPaperQuestion examPaperQuestion)
    {
        return toAjax(examPaperQuestionService.insertExamPaperQuestion(examPaperQuestion));
    }

    /**
     * 修改试卷明细
     */
    @PreAuthorize("@ss.hasPermi('exam:paperQuestion:edit')")
    @Log(title = "试卷明细", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ExamPaperQuestion examPaperQuestion)
    {
        return toAjax(examPaperQuestionService.updateExamPaperQuestion(examPaperQuestion));
    }

    /**
     * 删除试卷明细
     */
    @PreAuthorize("@ss.hasPermi('exam:paperQuestion:remove')")
    @Log(title = "试卷明细", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(examPaperQuestionService.deleteExamPaperQuestionByIds(ids));
    }
}
