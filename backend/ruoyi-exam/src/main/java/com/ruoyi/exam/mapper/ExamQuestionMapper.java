package com.ruoyi.exam.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.exam.domain.ExamQuestion;

/**
 * 题库Mapper接口
 * 
 * @author shishugen
 * @date 2026-11-07
 */
public interface ExamQuestionMapper 
{
    /**
     * 查询题库
     * 
     * @param id 题库主键
     * @return 题库
     */
    public ExamQuestion selectExamQuestionById(Long id);

    /**
     * 查询题库列表
     * 
     * @param examQuestion 题库
     * @return 题库集合
     */
    public List<ExamQuestion> selectExamQuestionList(ExamQuestion examQuestion);

    /**
     * 新增题库
     * 
     * @param examQuestion 题库
     * @return 结果
     */
    public int insertExamQuestion(ExamQuestion examQuestion);

    /**
     * 修改题库
     * 
     * @param examQuestion 题库
     * @return 结果
     */
    public int updateExamQuestion(ExamQuestion examQuestion);

    /**
     * 删除题库
     * 
     * @param id 题库主键
     * @return 结果
     */
    public int deleteExamQuestionById(Long id);

    /**
     * 批量删除题库
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteExamQuestionByIds(Long[] ids);

    /**
     * 按题型/难度随机抽已通过审核的题
     * chapterIds 不为空时只在这些章节里抽，excludeIds 防止同一题重复进卷，
     * excludeKnowledgeIds 让抽题优先选还没覆盖过的知识点
     */
    public List<ExamQuestion> selectRandomQuestions(@Param("courseId") Long courseId,
                                                    @Param("type") String type,
                                                    @Param("difficulty") String difficulty,
                                                    @Param("chapterIds") List<Long> chapterIds,
                                                    @Param("excludeIds") List<Long> excludeIds,
                                                    @Param("excludeKnowledgeIds") List<Long> excludeKnowledgeIds,
                                                    @Param("limit") int limit);

    /**
     * 查已有的题干，出题时用来比对新题是不是重复
     */
    public List<String> selectAllStems();

    /**
     * 该知识点上次被驳回的原因，拼进下一次 Prompt
     */
    public String selectRejectReason(@Param("knowledgeId") Long knowledgeId);

    // 数一下当前课程/章节里能用的题，按题型和难度各数一遍
    public Map<String, Object> selectAvailableCount(@Param("courseId") Long courseId,
                                                    @Param("chapterIds") List<Long> chapterIds);
}
