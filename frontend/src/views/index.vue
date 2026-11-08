<template>
  <div class="app-container home">
    <div class="hero">
      <span class="hero-badge">毕业设计作品</span>
      <h1>基于大语言模型的试卷生成系统</h1>
      <p class="subtitle">Design and Implementation of an LLM-based Exam Paper Generation System</p>
      <p class="desc">
        面向高校本科课程的命题场景，利用大语言模型辅助生成试题，按课程、章节与知识点配置约束，
        自动完成试卷生成，并支持卷面导出。
      </p>
      <div class="tags">
        <el-tag effect="plain">Vue 3 + Element Plus</el-tag>
        <el-tag effect="plain" type="success">Spring Boot 3</el-tag>
        <el-tag effect="plain" type="warning">大模型 API</el-tag>
        <el-tag effect="plain" type="info">MySQL</el-tag>
      </div>
    </div>

    <el-row :gutter="16" class="cards">
      <el-col v-for="item in goals" :key="item.no" :xs="24" :sm="8">
        <el-card shadow="hover" class="goal-card">
          <div class="goal-index">{{ item.no }}</div>
          <h3>{{ item.title }}</h3>
          <p>{{ item.desc }}</p>
        </el-card>
      </el-col>
    </el-row>

    <el-card shadow="never" class="arch">
      <template #header><span>系统构成</span></template>
      <el-row :gutter="24">
        <el-col :xs="24" :sm="12">
          <h4>基础支撑层</h4>
          <p>登录认证、用户管理、角色管理、菜单权限。基于开源脚手架构建，提供系统的基础运行能力。</p>
        </el-col>
        <el-col :xs="24" :sm="12">
          <h4>试卷业务层</h4>
          <p>知识点配置、AI 适配与提示词模板、题目生成与校验去重、自动组卷、试卷导出。为本课题的核心设计与实现内容。</p>
        </el-col>
      </el-row>
    </el-card>

    <p class="footnote">基于 RuoYi 3.9.2（MIT 协议）开源脚手架构建 · 毕业设计作品</p>
  </div>
</template>

<script setup>
const goals = [
  {
    no: '01',
    title: 'AI 辅助出题',
    desc: '按课程、章节与知识点组织提示词，调用大模型按固定格式生成试题，自动检查格式并对不合格结果重试。'
  },
  {
    no: '02',
    title: '自动组卷',
    desc: '按题型、难度与知识点分布抽题，多约束冲突时自动调整，并拦截重复题目。'
  },
  {
    no: '03',
    title: '试卷导出',
    desc: '把生成的题目按卷面格式排版，导出为可编辑文档，便于教师复核与打印。'
  }
]
</script>

<style scoped lang="scss">
.home {
  max-width: 1080px;
  margin: 0 auto;
}

.hero {
  padding: 28px 4px 24px;
  border-bottom: 1px solid #ebeef5;
  margin-bottom: 24px;
}

.hero-badge {
  display: inline-block;
  font-size: 12px;
  color: #2f6fed;
  background: #eaf2ff;
  border-radius: 12px;
  padding: 3px 12px;
  margin-bottom: 16px;
}

.hero h1 {
  font-size: 26px;
  font-weight: 500;
  color: #1f2329;
  margin: 0 0 8px;
  line-height: 1.4;
}

.subtitle {
  font-size: 13px;
  color: #909399;
  margin: 0 0 18px;
}

.desc {
  font-size: 14px;
  line-height: 1.9;
  color: #4a4f57;
  max-width: 760px;
  margin: 0 0 18px;
}

.tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.cards {
  margin-bottom: 20px;
}

.goal-card {
  height: 100%;
  border-radius: 10px;
}

.goal-index {
  font-size: 13px;
  color: #2f6fed;
  letter-spacing: 1px;
  margin-bottom: 10px;
}

.goal-card h3 {
  font-size: 16px;
  font-weight: 500;
  color: #1f2329;
  margin: 0 0 10px;
}

.goal-card p {
  font-size: 13px;
  line-height: 1.8;
  color: #6b7280;
  margin: 0;
}

.arch {
  border-radius: 10px;
  margin-bottom: 20px;
}

.arch h4 {
  font-size: 14px;
  font-weight: 500;
  color: #1f2329;
  margin: 0 0 8px;
}

.arch p {
  font-size: 13px;
  line-height: 1.9;
  color: #6b7280;
  margin: 0;
}

.footnote {
  text-align: center;
  font-size: 12px;
  color: #a8abb2;
  margin: 0 0 12px;
}
</style>
