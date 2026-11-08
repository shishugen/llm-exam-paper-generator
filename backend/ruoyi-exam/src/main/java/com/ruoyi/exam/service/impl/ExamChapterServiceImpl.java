package com.ruoyi.exam.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.exam.mapper.ExamChapterMapper;
import com.ruoyi.exam.domain.ExamChapter;
import com.ruoyi.exam.service.IExamChapterService;

/**
 * 章节Service业务层处理
 * 
 * @author shishugen
 * @date 2026-11-07
 */
@Service
public class ExamChapterServiceImpl implements IExamChapterService 
{
    @Autowired
    private ExamChapterMapper examChapterMapper;

    /**
     * 查询章节
     * 
     * @param id 章节主键
     * @return 章节
     */
    @Override
    public ExamChapter selectExamChapterById(Long id)
    {
        return examChapterMapper.selectExamChapterById(id);
    }

    /**
     * 查询章节列表
     * 
     * @param examChapter 章节
     * @return 章节
     */
    @Override
    public List<ExamChapter> selectExamChapterList(ExamChapter examChapter)
    {
        return examChapterMapper.selectExamChapterList(examChapter);
    }

    /**
     * 新增章节
     * 
     * @param examChapter 章节
     * @return 结果
     */
    @Override
    public int insertExamChapter(ExamChapter examChapter)
    {
        examChapter.setCreateTime(DateUtils.getNowDate());
        return examChapterMapper.insertExamChapter(examChapter);
    }

    /**
     * 修改章节
     * 
     * @param examChapter 章节
     * @return 结果
     */
    @Override
    public int updateExamChapter(ExamChapter examChapter)
    {
        examChapter.setUpdateTime(DateUtils.getNowDate());
        return examChapterMapper.updateExamChapter(examChapter);
    }

    /**
     * 批量删除章节
     * 
     * @param ids 需要删除的章节主键
     * @return 结果
     */
    @Override
    public int deleteExamChapterByIds(Long[] ids)
    {
        return examChapterMapper.deleteExamChapterByIds(ids);
    }

    /**
     * 删除章节信息
     * 
     * @param id 章节主键
     * @return 结果
     */
    @Override
    public int deleteExamChapterById(Long id)
    {
        return examChapterMapper.deleteExamChapterById(id);
    }
}
