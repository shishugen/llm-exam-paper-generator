package com.ruoyi.exam.service;

import java.util.List;
import com.ruoyi.exam.domain.ExamChapter;

/**
 * 章节Service接口
 * 
 * @author shishugen
 * @date 2026-11-07
 */
public interface IExamChapterService 
{
    /**
     * 查询章节
     * 
     * @param id 章节主键
     * @return 章节
     */
    public ExamChapter selectExamChapterById(Long id);

    /**
     * 查询章节列表
     * 
     * @param examChapter 章节
     * @return 章节集合
     */
    public List<ExamChapter> selectExamChapterList(ExamChapter examChapter);

    /**
     * 新增章节
     * 
     * @param examChapter 章节
     * @return 结果
     */
    public int insertExamChapter(ExamChapter examChapter);

    /**
     * 修改章节
     * 
     * @param examChapter 章节
     * @return 结果
     */
    public int updateExamChapter(ExamChapter examChapter);

    /**
     * 批量删除章节
     * 
     * @param ids 需要删除的章节主键集合
     * @return 结果
     */
    public int deleteExamChapterByIds(Long[] ids);

    /**
     * 删除章节信息
     * 
     * @param id 章节主键
     * @return 结果
     */
    public int deleteExamChapterById(Long id);
}
