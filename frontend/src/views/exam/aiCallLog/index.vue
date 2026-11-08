<template>
  <div class="app-container">
    <!-- 调用统计：次数 / Token / 耗时 / 成本 / 成功率 -->
    <StatsCards />
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="任务类型" prop="taskType">
        <el-select v-model="queryParams.taskType" placeholder="请选择任务类型" clearable style="width: 150px">
          <el-option
            v-for="dict in exam_task_type"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="模型" prop="model">
        <el-input
          v-model="queryParams.model"
          placeholder="输入模型名称"
          clearable
          style="width: 180px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable style="width: 130px">
          <el-option
            v-for="dict in exam_call_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['exam:aiCallLog:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 调用日志由系统自动写入，这里只做查看 -->
    <el-table v-loading="loading" :data="aiCallLogList">
      <el-table-column label="任务类型" align="center" prop="taskType" width="110">
        <template #default="scope">
          <dict-tag :options="exam_task_type" :value="scope.row.taskType"/>
        </template>
      </el-table-column>
      <el-table-column label="模型" align="left" prop="model" min-width="170" show-overflow-tooltip />
      <el-table-column label="输入 Token" align="center" prop="promptTokens" width="110" />
      <el-table-column label="输出 Token" align="center" prop="completionTokens" width="110" />
      <el-table-column label="耗时" align="center" prop="durationMs" width="100">
        <template #default="scope">{{ scope.row.durationMs }} ms</template>
      </el-table-column>
      <el-table-column label="本次费用" align="center" prop="cost" width="100">
        <template #default="scope">¥{{ scope.row.cost }}</template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status" width="90">
        <template #default="scope">
          <dict-tag :options="exam_call_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="失败原因" align="left" prop="errorMsg" min-width="200" show-overflow-tooltip>
        <template #default="scope">{{ scope.row.errorMsg || '—' }}</template>
      </el-table-column>
      <el-table-column label="调用时间" align="center" prop="createTime" width="170" />
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />
  </div>
</template>

<script setup name="AiCallLog">
import { listAiCallLog } from "@/api/exam/aiCallLog"
import StatsCards from "./StatsCards"

const { proxy } = getCurrentInstance()
const { exam_task_type, exam_call_status } = useDict('exam_task_type', 'exam_call_status')

const aiCallLogList = ref([])
const loading = ref(true)
const showSearch = ref(true)
const total = ref(0)

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  taskType: undefined,
  model: undefined,
  status: undefined
})

/** 查询大模型调用日志列表 */
function getList() {
  loading.value = true
  listAiCallLog(queryParams.value).then(response => {
    aiCallLogList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef")
  queryParams.value.taskType = undefined
  queryParams.value.model = undefined
  queryParams.value.status = undefined
  handleQuery()
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('exam/aiCallLog/export', {
    ...queryParams.value
  }, `aiCallLog_${new Date().getTime()}.xlsx`)
}

getList()
</script>
