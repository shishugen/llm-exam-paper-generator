<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="课程" prop="courseId">
        <el-select v-model="queryParams.courseId" placeholder="请选择所属课程" clearable @keyup.enter="handleQuery">
          <el-option v-for="c in courseOptions" :key="c.id" :label="c.courseName" :value="c.id" />
        </el-select>
      </el-form-item>
      <el-form-item label="章节" prop="chapterId">
        <el-select v-model="queryParams.chapterId" placeholder="请选择所属章节" clearable @keyup.enter="handleQuery">
          <el-option v-for="c in chapterOptions" :key="c.id" :label="c.name" :value="c.id" />
        </el-select>
      </el-form-item>
      <el-form-item label="知识点" prop="knowledgeId">
        <el-select v-model="queryParams.knowledgeId" placeholder="请选择所属知识点" clearable @keyup.enter="handleQuery">
          <el-option v-for="k in knowledgeOptions" :key="k.id" :label="k.name" :value="k.id" />
        </el-select>
      </el-form-item>
      <el-form-item label="题型" prop="type">
        <el-select v-model="queryParams.type" placeholder="请选择题型" clearable>
          <el-option
            v-for="dict in exam_question_type"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="难度" prop="difficulty">
        <el-select v-model="queryParams.difficulty" placeholder="请选择难度" clearable>
          <el-option
            v-for="dict in exam_difficulty"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <!-- <el-form-item label="分值" prop="score">
        <el-input
          v-model="queryParams.score"
          placeholder="请输入分值"
          clearable
          @keyup.enter="handleQuery"
        /> 
      </el-form-item>-->
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option
            v-for="dict in exam_question_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="来源" prop="source">
        <el-select v-model="queryParams.source" placeholder="请选择来源" clearable>
          <el-option
            v-for="dict in exam_source"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <!-- <el-form-item label="审核人ID" prop="reviewerId">
        <el-input
          v-model="queryParams.reviewerId"
          placeholder="请输入审核人ID"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item> -->
      <!-- <el-form-item label="审核时间" prop="reviewTime">
        <el-date-picker clearable
          v-model="queryParams.reviewTime"
          type="date"
          value-format="YYYY-MM-DD"
          placeholder="请选择审核时间">
        </el-date-picker>
      </el-form-item> -->
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
          v-hasPermi="['exam:question:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['exam:question:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="primary" plain icon="MagicStick" @click="aiDialog = true"
          v-hasPermi="['exam:question:add']">AI 出题</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="CircleCheck" :disabled="multiple"
          @click="batchReviewDialog = true"
          v-hasPermi="['exam:question:edit']">统一审核</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="questionList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="所属课程" align="center" prop="courseName" />
      <el-table-column label="所属章节" align="center" prop="chapterName" />
      <el-table-column label="所属知识点" align="center" prop="knowledgeName" />
      <el-table-column label="题型" align="center" prop="type">
        <template #default="scope">
          <dict-tag :options="exam_question_type" :value="scope.row.type"/>
        </template>
      </el-table-column>
      <el-table-column label="难度" align="center" prop="difficulty">
        <template #default="scope">
          <dict-tag :options="exam_difficulty" :value="scope.row.difficulty"/>
        </template>
      </el-table-column>
      <el-table-column label="题干" align="center" prop="stem" show-overflow-tooltip />
      <el-table-column label="分值" align="center" prop="score" />
      <el-table-column label="状态" align="center" prop="status">
        <template #default="scope">
          <dict-tag :options="exam_question_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="来源" align="center" prop="source">
        <template #default="scope">
          <dict-tag :options="exam_source" :value="scope.row.source"/>
        </template>
      </el-table-column>
      
      <el-table-column label="创建时间" align="createTime" prop="createTime" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleDetail(scope.row)">查看详细</el-button>
          <el-button link type="primary" icon="CircleCheck" @click="reviewDialogId = scope.row.id; reviewDialog = true" v-hasPermi="['exam:question:edit']">审核</el-button>
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['exam:question:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['exam:question:remove']">删除</el-button>
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

    <!-- 添加或修改题库对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="questionRef" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="所属课程" prop="courseId">
              <el-select v-model="form.courseId" placeholder="请选择所属课程" style="width:100%">
                <el-option v-for="c in courseOptions" :key="c.id" :label="c.courseName" :value="c.id" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="所属章节" prop="chapterId">
              <el-select v-model="form.chapterId" placeholder="请选择所属章节" style="width:100%">
                <el-option v-for="c in chapterOptions" :key="c.id" :label="c.name" :value="c.id" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="所属知识点" prop="knowledgeId">
              <el-select v-model="form.knowledgeId" placeholder="请选择所属知识点" style="width:100%">
                <el-option v-for="k in knowledgeOptions" :key="k.id" :label="k.name" :value="k.id" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="题型" prop="type">
              <el-select v-model="form.type" placeholder="请选择题型">
                <el-option
                  v-for="dict in exam_question_type"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="难度" prop="difficulty">
              <el-select v-model="form.difficulty" placeholder="请选择难度">
                <el-option
                  v-for="dict in exam_difficulty"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="题干" prop="stem">
              <el-input v-model="form.stem" type="textarea" placeholder="请输入内容" />
            </el-form-item>
          </el-col>
          <el-col :span="24" v-if="isChoiceType(form.type)">
            <el-form-item label="选项" prop="options">
              <div v-for="(opt, idx) in optList" :key="opt.key" class="opt-row">
                <span class="opt-key">{{ opt.key }}</span>
                <el-input v-model="opt.value" :placeholder="'请输入选项 ' + opt.key + ' 的内容'" />
              </div>
            </el-form-item>
          </el-col>
          <el-col :span="24" v-if="isChoiceType(form.type)">
            <el-form-item label="参考答案" prop="answer">
              <el-radio-group v-if="form.type === '1'" v-model="form.answer">
                <el-radio v-for="opt in optList" :key="opt.key" :value="opt.key">{{ opt.key }}</el-radio>
              </el-radio-group>
              <el-checkbox-group v-else-if="form.type === '2'" v-model="answerMulti">
                <el-checkbox v-for="opt in optList" :key="opt.key" :value="opt.key">{{ opt.key }}</el-checkbox>
              </el-checkbox-group>
            </el-form-item>
          </el-col>
          <el-col :span="24" v-else-if="isJudgeType(form.type)">
            <el-form-item label="参考答案" prop="answer">
              <el-radio-group v-model="form.answer">
                <el-radio value="正确">正确</el-radio>
                <el-radio value="错误">错误</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="24" v-else>
            <el-form-item label="参考答案" prop="answer">
              <el-input v-model="form.answer" type="textarea" placeholder="请输入参考答案" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="试题解析" prop="analysis">
              <el-input v-model="form.analysis" type="textarea" placeholder="请输入内容" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="分值" prop="score">
              <el-input v-model="form.score" placeholder="请输入分值" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="状态" prop="status">
              <el-select v-model="form.status" placeholder="请选择状态">
                <el-option
                  v-for="dict in exam_question_status"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="来源" prop="source">
              <el-select v-model="form.source" placeholder="请选择来源">
                <el-option
                  v-for="dict in exam_source"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="驳回原因" prop="rejectReason">
              <el-input v-model="form.rejectReason" type="textarea" placeholder="请输入内容" />
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

    <!-- AI 出题 / 题目审核 / 批量审核 / 查看详细 -->
    <AiGenerateDialog v-if="aiDialog" @close="aiDialog = false" @success="getList" />
    <ReviewDialog v-if="reviewDialog" :question-id="reviewDialogId" @close="reviewDialog = false" @success="getList" />
    <BatchReviewDialog v-if="batchReviewDialog" :ids="ids" @close="batchReviewDialog = false" @success="getList" />
    <QuestionDetailDialog v-if="detailDialog" :question-id="detailDialogId" @close="detailDialog = false" />
  </div>
</template>

<script setup name="Question">
import { listQuestion, getQuestion, delQuestion, addQuestion, updateQuestion } from "@/api/exam/question"
import { listCourse } from "@/api/exam/course"
import { listChapter } from "@/api/exam/chapter"
import { listKnowledge } from "@/api/exam/knowledge"
import AiGenerateDialog from "./AiGenerateDialog"
import ReviewDialog from "./ReviewDialog"
import BatchReviewDialog from "./BatchReviewDialog"
import QuestionDetailDialog from "./QuestionDetailDialog"

const aiDialog = ref(false)
const reviewDialog = ref(false)
const reviewDialogId = ref(null)
const batchReviewDialog = ref(false)
const detailDialog = ref(false)
const detailDialogId = ref(null)

const courseOptions = ref([])
const chapterOptions = ref([])
const knowledgeOptions = ref([])
function loadOptions() {
  listCourse({ pageNum: 1, pageSize: 100 }).then(r => { courseOptions.value = r.rows })
  listChapter({ pageNum: 1, pageSize: 100 }).then(r => { chapterOptions.value = r.rows })
  listKnowledge({ pageNum: 1, pageSize: 200 }).then(r => { knowledgeOptions.value = r.rows })
}

// 选项友好编辑：单选题/多选题用 A/B/C/D 输入框，判断题/简答题无选项
const optList = ref([])
const answerMulti = ref([])
function defaultOpts() {
  return [{ key: 'A', value: '' }, { key: 'B', value: '' }, { key: 'C', value: '' }, { key: 'D', value: '' }]
}
function isChoiceType(t) { return t === '1' || t === '2' }
function isJudgeType(t) { return t === '3' }
// 把后端存的 options JSON 字符串 <-> 前端 optList 互相转换
function parseOptions(json) {
  if (!json) return defaultOpts()
  try {
    const arr = JSON.parse(json)
    if (Array.isArray(arr) && arr.length) return arr.map(o => ({ key: o.key, value: o.value }))
  } catch (e) {}
  return defaultOpts()
}
function serializeOptions() {
  const filled = optList.value.filter(o => o.value && o.value.trim() !== '')
  return JSON.stringify(filled.map(o => ({ key: o.key, value: o.value.trim() })))
}

const { proxy } = getCurrentInstance()
const { exam_source, exam_difficulty, exam_question_status, exam_question_type } = useDict('exam_source', 'exam_difficulty', 'exam_question_status', 'exam_question_type')

const questionList = ref([])
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
    courseId: undefined,
    chapterId: undefined,
    knowledgeId: undefined,
    type: undefined,
    difficulty: undefined,
    stem: undefined,
    options: undefined,
    answer: undefined,
    analysis: undefined,
    score: undefined,
    status: undefined,
    source: undefined,
    rejectReason: undefined,
    reviewerId: undefined,
    reviewTime: undefined,
  },
  rules: {
    courseId: [
      { required: true, message: "所属课程不能为空", trigger: "change" }
    ],
    type: [
      { required: true, message: "题型不能为空", trigger: "change" }
    ],
    difficulty: [
      { required: true, message: "难度不能为空", trigger: "change" }
    ],
    stem: [
      { required: true, message: "题干不能为空", trigger: "blur" }
    ],
    score: [
      { required: true, message: "分值不能为空", trigger: "blur" }
    ],
    status: [
      { required: true, message: "状态不能为空", trigger: "change" }
    ],
    source: [
      { required: true, message: "来源不能为空", trigger: "change" }
    ],
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 查询题库列表 */
function getList() {
  loading.value = true
  listQuestion(queryParams.value).then(response => {
    questionList.value = response.rows
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
    courseId: null,
    chapterId: null,
    knowledgeId: null,
    type: null,
    difficulty: null,
    stem: null,
    options: null,
    answer: null,
    analysis: null,
    score: null,
    status: null,
    source: null,
    rejectReason: null,
    reviewerId: null,
    reviewTime: null,
    createBy: null,
    createTime: null,
    updateBy: null,
    updateTime: null
  }
  optList.value = defaultOpts()
  answerMulti.value = []
  proxy.resetForm("questionRef")
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
  title.value = "添加题库"
}

/** 查看详细按钮操作 */
function handleDetail(row) {
  detailDialogId.value = row.id
  detailDialog.value = true
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _id = row.id || ids.value
  getQuestion(_id).then(response => {
    form.value = response.data
    optList.value = parseOptions(response.data.options)
    answerMulti.value = (response.data.type === '2' && response.data.answer)
      ? response.data.answer.split('') : []
    open.value = true
    title.value = "修改题库"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["questionRef"].validate(valid => {
    if (valid) {
      if (isChoiceType(form.value.type)) {
        form.value.options = serializeOptions()
        if (form.value.type === '2') form.value.answer = answerMulti.value.join('')
      } else {
        // 判断题/简答题/综合题没有选项
        form.value.options = null
      }
      if (form.value.id != null) {
        updateQuestion(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addQuestion(form.value).then(() => {
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
  // 题干太长，只取前 24 个字做提示
  const stem = row.stem && row.stem.length > 24 ? row.stem.slice(0, 24) + '……' : row.stem
  const tip = row.id
    ? '是否确认删除题目「' + stem + '」？'
    : '是否确认删除选中的 ' + ids.value.length + ' 道题目？'
  proxy.$modal.confirm(tip).then(function() {
    return delQuestion(_ids)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

getList()
loadOptions()
</script>

<style scoped>
.opt-row {
  display: flex;
  align-items: center;
  margin-bottom: 8px;
}
.opt-key {
  display: inline-block;
  width: 28px;
  height: 28px;
  line-height: 28px;
  text-align: center;
  background: #f4f4f5;
  border-radius: 4px;
  margin-right: 10px;
  font-weight: 600;
}
</style>
