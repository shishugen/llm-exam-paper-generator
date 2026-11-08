package com.ruoyi.exam.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.exam.domain.ExamPaper;
import com.ruoyi.exam.service.IExamPaperService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.exam.mapper.ExamPaperMapper;
import com.ruoyi.exam.mapper.ExamQuestionMapper;
import com.ruoyi.exam.util.PaperComposeUtil;
import com.ruoyi.exam.util.PaperExportUtil;

/**
 * 试卷Controller
 * 
 * @author shishugen
 * @date 2026-11-07
 */
@RestController
@RequestMapping("/exam/paper")
public class ExamPaperController extends BaseController
{
    @Autowired
    private IExamPaperService examPaperService;
    @Autowired private ExamPaperMapper paperMapper;
    @Autowired private ExamQuestionMapper questionMapper;
    @Autowired private PaperComposeUtil composeUtil;
    @Autowired private PaperExportUtil paperExportUtil;

    /**
     * 查询试卷列表
     */
    @PreAuthorize("@ss.hasPermi('exam:paper:list')")
    @GetMapping("/list")
    public TableDataInfo list(ExamPaper examPaper)
    {
        startPage();
        List<ExamPaper> list = examPaperService.selectExamPaperList(examPaper);
        return getDataTable(list);
    }

    /**
     * 导出试卷列表
     */
    @PreAuthorize("@ss.hasPermi('exam:paper:export')")
    @Log(title = "试卷", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ExamPaper examPaper)
    {
        List<ExamPaper> list = examPaperService.selectExamPaperList(examPaper);
        ExcelUtil<ExamPaper> util = new ExcelUtil<ExamPaper>(ExamPaper.class);
        util.exportExcel(response, list, "试卷数据");
    }

    /**
     * 获取试卷详细信息
     */
    @PreAuthorize("@ss.hasPermi('exam:paper:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(examPaperService.selectExamPaperById(id));
    }

    /**
     * 新增试卷
     */
    @PreAuthorize("@ss.hasPermi('exam:paper:add')")
    @Log(title = "试卷", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ExamPaper examPaper)
    {
        return toAjax(examPaperService.insertExamPaper(examPaper));
    }

    /**
     * 修改试卷
     */
    @PreAuthorize("@ss.hasPermi('exam:paper:edit')")
    @Log(title = "试卷", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ExamPaper examPaper)
    {
        return toAjax(examPaperService.updateExamPaper(examPaper));
    }

    /**
     * 删除试卷
     */
    @PreAuthorize("@ss.hasPermi('exam:paper:remove')")
    @Log(title = "试卷", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(examPaperService.deleteExamPaperByIds(ids));
    }

    // 组卷预览：只抽题不写库；选了章节就只在这些章节里抽
    // 组卷弹窗用：返回当前课程/章节下能用多少题
    @PostMapping("/availableCount")
    public AjaxResult availableCount(@RequestBody Map<String, Object> params)
    {
        Long courseId = Long.valueOf(str(params.get("courseId")));
        List<Long> chapterIds = toLongList(params.get("chapterIds"));
        return success(questionMapper.selectAvailableCount(courseId, chapterIds));
    }

    @PostMapping("/composePreview")
    public AjaxResult composePreview(@RequestBody Map<String, Object> params)
    {
        ExamPaper paper = buildPaper(params);
        Map<String, Integer> typeRatio = toIntMap((Map<String, Object>) params.get("typeRatio"));
        Map<String, Integer> diffRatio = toIntMap((Map<String, Object>) params.get("difficultyRatio"));
        List<Long> chapterIds = toLongList(params.get("chapterIds"));
        paper.setConfigJson(buildConfig(params, paper, typeRatio, diffRatio, chapterIds));
        return AjaxResult.success("预览已生成", composeUtil.preview(paper, typeRatio, diffRatio, chapterIds));
    }

    // 组卷保存：浏览确认后，按预览出来的题号顺序写库
    @PostMapping("/composeSave")
    public AjaxResult composeSave(@RequestBody Map<String, Object> params)
    {
        ExamPaper paper = buildPaper(params);
        Map<String, Integer> typeRatio = toIntMap((Map<String, Object>) params.get("typeRatio"));
        Map<String, Integer> diffRatio = toIntMap((Map<String, Object>) params.get("difficultyRatio"));
        List<Long> chapterIds = toLongList(params.get("chapterIds"));
        List<Long> questionIds = toLongList(params.get("questionIds"));
        if (questionIds.isEmpty())
        {
            return error("没有可保存的题目，请先重新组卷");
        }
        paper.setConfigJson(buildConfig(params, paper, typeRatio, diffRatio, chapterIds));
        return AjaxResult.success("试卷已保存", composeUtil.save(paper, chapterIds, questionIds));
    }

    // 单题替换：锁定的题跳过，按原题型难度重抽
    @PostMapping("/replace")
    public AjaxResult replace(@RequestBody Map<String, Object> params)
    {
        boolean ok = composeUtil.replace(Long.valueOf(str(params.get("paperId"))),
                Long.valueOf(str(params.get("detailId"))));
        return ok ? success("已替换为同题型同难度的另一道题")
                  : error("该题已锁定，或题库中没有可替换的题目");
    }

    // 试卷详情：整卷题目 + 知识点覆盖率
    @GetMapping("/detail")
    public AjaxResult detail(@RequestParam("paperId") Long paperId)
    {
        ExamPaper paper = examPaperService.selectExamPaperById(paperId);
        if (paper == null)
        {
            return error("试卷不存在");
        }
        Map<String, Object> data = new HashMap<>();
        data.put("paper", paper);
        data.put("rows", paperMapper.selectPaperDetail(paperId));
        data.put("coverage", composeUtil.coverage(paperId, paper.getCourseId(), parseChapterIds(paper.getConfigJson())));
        return success(data);
    }

    // 导出 Word：试题卷 + 分页符 + 答案卷
    @PostMapping("/exportWord")
    public void exportWord(@RequestParam("paperId") Long paperId, HttpServletResponse response) throws IOException
    {
        ExamPaper paper = examPaperService.selectExamPaperById(paperId);
        String title = paper == null ? "试卷" : paper.getTitle();
        List<Map<String, Object>> rows = paperMapper.selectPaperDetail(paperId);
        String name = URLEncoder.encode(title + ".docx", "UTF-8").replace("+", "%20");
        response.setContentType("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
        response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + name);
        paperExportUtil.export(title, rows, response.getOutputStream());
    }

    // 从组卷参数里取出试卷对象
    private ExamPaper buildPaper(Map<String, Object> params)
    {
        ExamPaper paper = new ExamPaper();
        paper.setCourseId(Long.valueOf(str(params.get("courseId"))));
        paper.setTitle(str(params.get("title")));
        paper.setTotalScore(Integer.valueOf(str(params.getOrDefault("totalScore", 100))));
        paper.setStatus("1");
        return paper;
    }

    // 组卷配置存进 config_json，试卷列表直接拿来显示中文
    private String buildConfig(Map<String, Object> params, ExamPaper paper, Map<String, Integer> typeRatio,
                               Map<String, Integer> diffRatio, List<Long> chapterIds)
    {
        JSONObject config = new JSONObject();
        config.put("totalScore", paper.getTotalScore());
        config.put("typeRatio", typeRatio);
        config.put("difficultyRatio", diffRatio);
        config.put("coverage", params.getOrDefault("coverage", 0.6));
        config.put("chapterIds", chapterIds);
        config.put("chapterNames", toStringList(params.get("chapterNames")));
        return config.toString();
    }

    private String str(Object o)
    {
        return o == null ? "" : String.valueOf(o);
    }

    private Map<String, Integer> toIntMap(Map<String, Object> source)
    {
        Map<String, Integer> result = new LinkedHashMap<>();
        if (source != null)
        {
            for (Map.Entry<String, Object> item : source.entrySet())
            {
                int value = Integer.parseInt(String.valueOf(item.getValue()));
                if (value > 0)
                {
                    result.put(item.getKey(), value);
                }
            }
        }
        if (result.isEmpty())
        {
            result.put("1", 5);
        }
        return result;
    }

    // 前端多选章节传过来的是数组，转成 List<Long>
    private List<Long> toLongList(Object value)
    {
        List<Long> list = new ArrayList<>();
        if (value instanceof List)
        {
            for (Object item : (List<Object>) value)
            {
                if (item != null && !"".equals(String.valueOf(item)))
                {
                    list.add(Long.valueOf(String.valueOf(item)));
                }
            }
        }
        return list;
    }

    // 章节名称数组，存进 config_json 方便页面直接显示
    private List<String> toStringList(Object value)
    {
        List<String> list = new ArrayList<>();
        if (value instanceof List)
        {
            for (Object item : (List<Object>) value)
            {
                if (item != null)
                {
                    list.add(String.valueOf(item));
                }
            }
        }
        return list;
    }

    // 从 config_json 里取组卷时选的章节，用来算覆盖率分母
    private List<Long> parseChapterIds(String configJson)
    {
        List<Long> list = new ArrayList<>();
        if (configJson == null || configJson.isEmpty())
        {
            return list;
        }
        try
        {
            JSONArray arr = JSONObject.parseObject(configJson).getJSONArray("chapterIds");
            if (arr != null)
            {
                for (int i = 0; i < arr.size(); i++)
                {
                    list.add(arr.getLong(i));
                }
            }
        }
        catch (Exception e)
        {
            // 配置格式不对就当整门课程组卷
        }
        return list;
    }
}
