<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="试卷" prop="paperName">
        <el-input
          v-model="queryParams.paperName"
          placeholder="输入试卷名称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="题目" prop="questionStem">
        <el-input
          v-model="queryParams.questionStem"
          placeholder="输入题干关键字"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="题号顺序" prop="sortNo">
        <el-input
          v-model="queryParams.sortNo"
          placeholder="请输入题号顺序"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="本卷中该题分值" prop="score">
        <el-input
          v-model="queryParams.score"
          placeholder="请输入本卷中该题分值"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="是否锁定" prop="locked">
        <el-select v-model="queryParams.locked" placeholder="请选择是否锁定" clearable>
          <el-option
            v-for="dict in exam_yes_no"
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
          v-hasPermi="['exam:paperQuestion:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['exam:paperQuestion:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="paperQuestionList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="所属试卷" align="left" prop="paperName" min-width="180" show-overflow-tooltip />
      <el-table-column label="题目" align="left" prop="questionStem" min-width="300" show-overflow-tooltip />
      <el-table-column label="题号" align="center" prop="sortNo" width="70" />
      <el-table-column label="本卷分值" align="center" prop="score" width="90" />
      <el-table-column label="是否锁定" align="center" prop="locked">
        <template #default="scope">
          <dict-tag :options="exam_yes_no" :value="scope.row.locked"/>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['exam:paperQuestion:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['exam:paperQuestion:remove']">删除</el-button>
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

    <!-- 添加或修改试卷明细对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="paperQuestionRef" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="所属试卷" prop="paperId">
              <el-select v-model="form.paperId" placeholder="请选择试卷" filterable style="width:100%">
                <el-option v-for="p in paperList" :key="p.id" :label="p.title" :value="p.id" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="题目" prop="questionId">
              <el-select v-model="form.questionId" placeholder="请选择题目" filterable style="width:100%">
                <el-option v-for="q in questionList" :key="q.id" :label="q.stem" :value="q.id" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="题号顺序" prop="sortNo">
              <el-input v-model="form.sortNo" placeholder="请输入题号顺序" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="本卷中该题分值" prop="score">
              <el-input v-model="form.score" placeholder="请输入本卷中该题分值" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="是否锁定" prop="locked">
              <el-select v-model="form.locked" placeholder="请选择是否锁定">
                <el-option
                  v-for="dict in exam_yes_no"
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
</template>

<script setup name="PaperQuestion">
import { listPaperQuestion, getPaperQuestion, delPaperQuestion, addPaperQuestion, updatePaperQuestion } from "@/api/exam/paperQuestion"
import { listPaper } from "@/api/exam/paper"
import { listQuestion } from "@/api/exam/question"

const { proxy } = getCurrentInstance()
const { exam_yes_no } = useDict('exam_yes_no')

const paperList = ref([])
const questionList = ref([])
const paperQuestionList = ref([])
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
    paperName: undefined,
    questionStem: undefined,
    sortNo: undefined,
    score: undefined,
    locked: undefined,
  },
  rules: {
    paperId: [
      { required: true, message: "所属试卷不能为空", trigger: "change" }
    ],
    questionId: [
      { required: true, message: "题目不能为空", trigger: "change" }
    ],
    score: [
      { required: true, message: "本卷中该题分值不能为空", trigger: "blur" }
    ],
    locked: [
      { required: true, message: "是否锁定不能为空", trigger: "change" }
    ],
  }
})

const { queryParams, form, rules } = toRefs(data)

// 试卷、题目下拉数据（新增/修改明细时选择，不用手填 ID）
listPaper({ pageNum: 1, pageSize: 200 }).then(res => { paperList.value = res.rows || [] })
listQuestion({ pageNum: 1, pageSize: 500 }).then(res => { questionList.value = res.rows || [] })

/** 查询试卷明细列表 */
function getList() {
  loading.value = true
  listPaperQuestion(queryParams.value).then(response => {
    paperQuestionList.value = response.rows
    total.value = response.total
    loading.value = false
  })
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
    paperId: null,
    questionId: null,
    sortNo: null,
    score: null,
    locked: null,
    createBy: null,
    createTime: null,
    updateBy: null,
    updateTime: null
  }
  proxy.resetForm("paperQuestionRef")
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
  title.value = "添加试卷明细"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _id = row.id || ids.value
  getPaperQuestion(_id).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改试卷明细"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["paperQuestionRef"].validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        updatePaperQuestion(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addPaperQuestion(form.value).then(() => {
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
    ? '是否确认删除「' + row.paperName + '」第 ' + row.sortNo + ' 题的明细？'
    : '是否确认删除选中的 ' + ids.value.length + ' 条试卷明细？'
  proxy.$modal.confirm(tip).then(function() {
    return delPaperQuestion(_ids)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

getList()
</script>
