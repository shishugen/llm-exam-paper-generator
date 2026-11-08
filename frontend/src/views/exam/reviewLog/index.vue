<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="题目" prop="questionName">
        <el-input
          v-model="queryParams.questionName"
          placeholder="输入题干关键字"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="操作" prop="action">
        <el-select v-model="queryParams.action" placeholder="请选择操作" clearable style="width: 140px">
          <el-option
            v-for="dict in exam_review_action"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="操作人" prop="reviewerName">
        <el-input
          v-model="queryParams.reviewerName"
          placeholder="输入姓名关键字"
          clearable
          style="width: 160px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 审核记录由系统自动写入，这里只做查看，不提供新增和修改 -->
    <el-table v-loading="loading" :data="reviewLogList">
      <el-table-column label="题目" align="left" prop="questionName" min-width="280" show-overflow-tooltip />
      <el-table-column label="操作" align="center" prop="action" width="110">
        <template #default="scope">
          <dict-tag :options="exam_review_action" :value="scope.row.action"/>
        </template>
      </el-table-column>
      <el-table-column label="操作说明/驳回原因" align="left" prop="reason" min-width="220" show-overflow-tooltip>
        <template #default="scope">{{ scope.row.reason || '—' }}</template>
      </el-table-column>
      <el-table-column label="操作人" align="center" prop="reviewerName" width="120">
        <template #default="scope">{{ scope.row.reviewerName || '—' }}</template>
      </el-table-column>
      <el-table-column label="操作时间" align="center" prop="createTime" width="170" />
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

<script setup name="ReviewLog">
import { listReviewLog } from "@/api/exam/reviewLog"

const { proxy } = getCurrentInstance()
const { exam_review_action } = useDict('exam_review_action')

const reviewLogList = ref([])
const loading = ref(true)
const showSearch = ref(true)
const total = ref(0)

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  questionName: undefined,
  action: undefined,
  reviewerName: undefined
})

/** 查询题目审核记录列表 */
function getList() {
  loading.value = true
  listReviewLog(queryParams.value).then(response => {
    reviewLogList.value = response.rows
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
  queryParams.value.questionName = undefined
  queryParams.value.action = undefined
  queryParams.value.reviewerName = undefined
  handleQuery()
}

getList()
</script>
