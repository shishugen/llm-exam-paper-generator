package com.ruoyi.exam.controller;

import java.util.List;
import java.util.Map;
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
import com.ruoyi.exam.domain.ExamAiCallLog;
import com.ruoyi.exam.mapper.ExamAiCallLogMapper;
import com.ruoyi.exam.service.IExamAiCallLogService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 大模型调用日志Controller
 * 
 * @author shishugen
 * @date 2026-11-07
 */
@RestController
@RequestMapping("/exam/aiCallLog")
public class ExamAiCallLogController extends BaseController
{
    @Autowired
    private IExamAiCallLogService examAiCallLogService;
    @Autowired
    private ExamAiCallLogMapper aiCallLogMapper;

    /**
     * 查询大模型调用日志列表
     */
    @PreAuthorize("@ss.hasPermi('exam:aiCallLog:list')")
    @GetMapping("/list")
    public TableDataInfo list(ExamAiCallLog examAiCallLog)
    {
        startPage();
        List<ExamAiCallLog> list = examAiCallLogService.selectExamAiCallLogList(examAiCallLog);
        return getDataTable(list);
    }

    /**
     * 导出大模型调用日志列表
     */
    @PreAuthorize("@ss.hasPermi('exam:aiCallLog:export')")
    @Log(title = "大模型调用日志", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ExamAiCallLog examAiCallLog)
    {
        List<ExamAiCallLog> list = examAiCallLogService.selectExamAiCallLogList(examAiCallLog);
        ExcelUtil<ExamAiCallLog> util = new ExcelUtil<ExamAiCallLog>(ExamAiCallLog.class);
        util.exportExcel(response, list, "大模型调用日志数据");
    }

    /**
     * 获取大模型调用日志详细信息
     */
    @PreAuthorize("@ss.hasPermi('exam:aiCallLog:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(examAiCallLogService.selectExamAiCallLogById(id));
    }

    /**
     * 新增大模型调用日志
     */
    @PreAuthorize("@ss.hasPermi('exam:aiCallLog:add')")
    @Log(title = "大模型调用日志", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ExamAiCallLog examAiCallLog)
    {
        return toAjax(examAiCallLogService.insertExamAiCallLog(examAiCallLog));
    }

    /**
     * 修改大模型调用日志
     */
    @PreAuthorize("@ss.hasPermi('exam:aiCallLog:edit')")
    @Log(title = "大模型调用日志", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ExamAiCallLog examAiCallLog)
    {
        return toAjax(examAiCallLogService.updateExamAiCallLog(examAiCallLog));
    }

    /**
     * 删除大模型调用日志
     */
    @PreAuthorize("@ss.hasPermi('exam:aiCallLog:remove')")
    @Log(title = "大模型调用日志", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(examAiCallLogService.deleteExamAiCallLogByIds(ids));
    }

    // 调用统计：次数、token、平均耗时、费用、成功率
    @GetMapping("/stats")
    public AjaxResult stats()
    {
        Map<String, Object> data = aiCallLogMapper.selectCallStats();
        double total = Double.parseDouble(String.valueOf(data.get("totalCalls")));
        double ok = Double.parseDouble(String.valueOf(data.get("successCalls")));
        double rate = total == 0 ? 0 : ok * 100.0 / total;
        data.put("successRate", Math.round(rate * 100) / 100.0);
        return success(data);
    }
}
