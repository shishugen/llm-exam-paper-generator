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
import com.ruoyi.exam.domain.ExamChapter;
import com.ruoyi.exam.service.IExamChapterService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 章节Controller
 * 
 * @author shishugen
 * @date 2026-11-07
 */
@RestController
@RequestMapping("/exam/chapter")
public class ExamChapterController extends BaseController
{
    @Autowired
    private IExamChapterService examChapterService;

    /**
     * 查询章节列表
     */
    @PreAuthorize("@ss.hasPermi('exam:chapter:list')")
    @GetMapping("/list")
    public TableDataInfo list(ExamChapter examChapter)
    {
        startPage();
        List<ExamChapter> list = examChapterService.selectExamChapterList(examChapter);
        return getDataTable(list);
    }

    /**
     * 获取章节详细信息
     */
    @PreAuthorize("@ss.hasPermi('exam:chapter:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(examChapterService.selectExamChapterById(id));
    }

    /**
     * 新增章节
     */
    @PreAuthorize("@ss.hasPermi('exam:chapter:add')")
    @Log(title = "章节", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ExamChapter examChapter)
    {
        return toAjax(examChapterService.insertExamChapter(examChapter));
    }

    /**
     * 修改章节
     */
    @PreAuthorize("@ss.hasPermi('exam:chapter:edit')")
    @Log(title = "章节", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ExamChapter examChapter)
    {
        return toAjax(examChapterService.updateExamChapter(examChapter));
    }

    /**
     * 删除章节
     */
    @PreAuthorize("@ss.hasPermi('exam:chapter:remove')")
    @Log(title = "章节", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(examChapterService.deleteExamChapterByIds(ids));
    }
}
