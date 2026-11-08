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
import com.ruoyi.exam.domain.ExamCourse;
import com.ruoyi.exam.service.IExamCourseService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 课程Controller
 * 
 * @author shishugen
 * @date 2026-11-07
 */
@RestController
@RequestMapping("/exam/course")
public class ExamCourseController extends BaseController
{
    @Autowired
    private IExamCourseService examCourseService;

    /**
     * 查询课程列表
     */
    @PreAuthorize("@ss.hasPermi('exam:course:list')")
    @GetMapping("/list")
    public TableDataInfo list(ExamCourse examCourse)
    {
        startPage();
        List<ExamCourse> list = examCourseService.selectExamCourseList(examCourse);
        return getDataTable(list);
    }

    /**
     * 获取课程详细信息
     */
    @PreAuthorize("@ss.hasPermi('exam:course:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(examCourseService.selectExamCourseById(id));
    }

    /**
     * 新增课程
     */
    @PreAuthorize("@ss.hasPermi('exam:course:add')")
    @Log(title = "课程", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ExamCourse examCourse)
    {
        return toAjax(examCourseService.insertExamCourse(examCourse));
    }

    /**
     * 修改课程
     */
    @PreAuthorize("@ss.hasPermi('exam:course:edit')")
    @Log(title = "课程", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ExamCourse examCourse)
    {
        return toAjax(examCourseService.updateExamCourse(examCourse));
    }

    /**
     * 删除课程
     */
    @PreAuthorize("@ss.hasPermi('exam:course:remove')")
    @Log(title = "课程", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(examCourseService.deleteExamCourseByIds(ids));
    }
}
