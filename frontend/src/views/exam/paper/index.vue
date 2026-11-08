<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="所属课程" prop="courseName">
        <el-input
          v-model="queryParams.courseName"
          placeholder="输入课程名称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="试卷名称" prop="title">
        <el-input
          v-model="queryParams.title"
          placeholder="请输入试卷名称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="试卷总分" prop="totalScore">
        <el-input
          v-model="queryParams.totalScore"
          placeholder="请输入试卷总分"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option
            v-for="dict in exam_paper_status"
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
          type="primary"
          plain
          icon="Plus"
          @click="handleAdd"
          v-hasPermi="['exam:paper:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['exam:paper:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['exam:paper:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['exam:paper:export']"
        >导出</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="primary" plain icon="MagicStick" @click="composeDialog = true"
          v-hasPermi="['exam:paper:add']">一键组卷</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="info" plain icon="View" :disabled="single"
          @click="detailPaperId = ids[0]; detailVisible = true"
          v-hasPermi="['exam:paper:list']">试卷详情</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="paperList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="试卷名称" align="left" prop="title" min-width="200" show-overflow-tooltip />
      <el-table-column label="所属课程" align="center" prop="courseName" width="160" />
      <el-table-column label="试卷总分" align="center" prop="totalScore" width="90" />
      <el-table-column label="组卷配置" align="left" min-width="300" show-overflow-tooltip>
        <template #default="scope">{{ formatConfig(scope.row.configJson) }}</template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status">
        <template #default="scope">
          <dict-tag :options="exam_paper_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="260" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="openDetail(scope.row)" v-hasPermi="['exam:paper:list']">查看详情</el-button>
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['exam:paper:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['exam:paper:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改试卷对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="paperRef" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="所属课程" prop="courseId">
              <el-select v-model="form.courseId" placeholder="请选择课程" style="width:100%">
                <el-option v-for="c in courseList" :key="c.id" :label="c.courseName" :value="c.id" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="试卷名称" prop="title">
              <el-input v-model="form.title" placeholder="请输入试卷名称" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="试卷总分" prop="totalScore">
              <el-input v-model="form.totalScore" placeholder="请输入试卷总分" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="组卷配置" prop="configJson">
              <div class="cfg-readonly">
                {{ form.configJson ? formatConfig(form.configJson) : '由「一键组卷」自动生成' }}
              </div>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="状态" prop="status">
              <el-select v-model="form.status" placeholder="请选择状态">
                <el-option
                  v-for="dict in exam_paper_status"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
    <!-- 一键组卷 / 试卷详情 -->
    <ComposeDialog v-if="composeDialog" @close="composeDialog = false" @success="getList" />
    <PaperDetailDrawer v-if="detailVisible" :paper-id="detailPaperId" @close="detailVisible = false" />
</template>

<script setup name="Paper">
import { listPaper, getPaper, delPaper, addPaper, updatePaper } from "@/api/exam/paper"
import { listCourse } from "@/api/exam/course"
import ComposeDialog from "./ComposeDialog"
import PaperDetailDrawer from "./PaperDetailDrawer"

const composeDialog = ref(false)
const detailVisible = ref(false)
const detailPaperId = ref(null)
const courseList = ref([])

const { proxy } = getCurrentInstance()
const { exam_paper_status } = useDict('exam_paper_status')

const paperList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    courseName: undefined,
    title: undefined,
    totalScore: undefined,
    configJson: undefined,
    status: undefined,
  },
  rules: {
    courseId: [
      { required: true, message: "所属课程不能为空", trigger: "change" }
    ],
    title: [
      { required: true, message: "试卷名称不能为空", trigger: "blur" }
    ],
    totalScore: [
      { required: true, message: "试卷总分不能为空", trigger: "blur" }
    ],
    status: [
      { required: true, message: "状态不能为空", trigger: "change" }
    ],
  }
})

const { queryParams, form, rules } = toRefs(data)

// 组卷配置里题型和难度存的是数字，显示时换成中文名称
const typeNames = { '1': '单选', '2': '多选', '3': '判断', '4': '简答', '5': '综合' }
const diffNames = { '1': '容易', '2': '中等', '3': '较难', '4': '困难' }

/** 把 config_json 转成一句中文：总分 100 ｜ 题型 单选 6 道 ｜ 难度 容易 3 道 ｜ 覆盖率 60% */
function formatConfig(json) {
  if (!json) return '—'
  let c
  try {
    c = JSON.parse(json)
  } catch (e) {
    return '—'
  }
  const parts = []
  if (c.totalScore) parts.push('总分 ' + c.totalScore)
  if (c.chapterNames && c.chapterNames.length) parts.push('章节 ' + c.chapterNames.join('、'))
  if (c.typeRatio) {
    const t = Object.keys(c.typeRatio).map(k => (typeNames[k] || k) + ' ' + c.typeRatio[k] + ' 道')
    if (t.length) parts.push('题型 ' + t.join('、'))
  }
  if (c.difficultyRatio) {
    const d = Object.keys(c.difficultyRatio).map(k => (diffNames[k] || k) + ' ' + c.difficultyRatio[k] + ' 道')
    if (d.length) parts.push('难度 ' + d.join('、'))
  }
  if (c.coverage !== undefined && c.coverage !== null) {
    parts.push('覆盖率 ' + Math.round(c.coverage * 100) + '%')
  }
  return parts.length ? parts.join(' ｜ ') : '—'
}

// 课程下拉数据（新增/修改试卷时选择课程）
listCourse({ pageNum: 1, pageSize: 200 }).then(res => { courseList.value = res.rows || [] })

/** 查询试卷列表 */
function getList() {
  loading.value = true
  listPaper(queryParams.value).then(response => {
    paperList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

/** 查看试卷详情：列出这份卷子的所有题目 */
function openDetail(row) {
  detailPaperId.value = row.id
  detailVisible.value = true
}

/** 取消按钮 */
function cancel() {
  open.value = false
  reset()
}

/** 表单重置 */
function reset() {
  form.value = {
    id: null,
    courseId: null,
    title: null,
    totalScore: null,
    configJson: null,
    status: null,
    createBy: null,
    createTime: null,
    updateBy: null,
    updateTime: null
  }
  proxy.resetForm("paperRef")
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

/** 多选框选中数据 */
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.id)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

/** 新增按钮操作 */
function handleAdd() {
  reset()
  open.value = true
  title.value = "添加试卷"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _id = row.id || ids.value
  getPaper(_id).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改试卷"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["paperRef"].validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        updatePaper(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addPaper(form.value).then(() => {
          proxy.$modal.msgSuccess("新增成功")
          open.value = false
          getList()
        })
      }
    }
  })
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _ids = row.id || ids.value
  const tip = row.id
    ? '是否确认删除试卷「' + row.title + '」？'
    : '是否确认删除选中的 ' + ids.value.length + ' 份试卷？'
  proxy.$modal.confirm(tip).then(function() {
    return delPaper(_ids)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('exam/paper/export', {
    ...queryParams.value
  }, `paper_${new Date().getTime()}.xlsx`)
}

getList()
</script>

<style scoped>
.cfg-readonly {
  width: 100%;
  min-height: 32px;
  padding: 4px 11px;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  background: #f5f7fa;
  color: #606266;
  font-size: 13px;
  line-height: 1.7;
}
</style>
