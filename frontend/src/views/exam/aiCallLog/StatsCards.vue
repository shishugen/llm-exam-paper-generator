<template>
  <div class="stat-row mb8">
    <el-card v-for="c in cards" :key="c.label" shadow="never" class="stat-card">
      <div class="stat-label">{{ c.label }}</div>
      <div class="stat-value">{{ c.value }}</div>
    </el-card>
  </div>
</template>

<script setup name="StatsCards">
import { getCallStats } from "@/api/exam/aiCallLog"

const cards = ref([
  { label: '调用总次数', value: 0 },
  { label: '消耗 Token', value: 0 },
  { label: '平均耗时 (ms)', value: 0 },
  { label: '累计成本 (元)', value: 0 },
  { label: '调用成功率', value: '0%' }
])

function load() {
  getCallStats().then(res => {
    const d = res.data || {}
    cards.value = [
      { label: '调用总次数', value: d.totalCalls ?? 0 },
      { label: '消耗 Token', value: d.totalTokens ?? 0 },
      { label: '平均耗时 (ms)', value: d.avgDuration ?? 0 },
      { label: '累计成本 (元)', value: d.totalCost ?? 0 },
      { label: '调用成功率', value: (d.successRate ?? 0) + '%' }
    ]
  })
}

load()
defineExpose({ load })
</script>

<style scoped>
.stat-row { display: flex; gap: 12px; }
.stat-card { flex: 1; }
.stat-label { font-size: 13px; color: #909399; }
.stat-value { font-size: 24px; font-weight: 600; margin-top: 6px; color: #303133; }
</style>
