<template>
  <div class="app-container">
    <div class="top-row">
      <span>课程：</span>
      <el-select v-model="courseId" placeholder="请选择课程" style="width: 240px" @change="changeCourse">
        <el-option v-for="c in courseList" :key="c.id" :label="c.courseName" :value="c.id" />
      </el-select>
      <el-button type="primary" plain icon="Plus" @click="handleAddCourse" v-hasPermi="['exam:course:add']">新增课程</el-button>
      <el-button type="primary" plain icon="Edit" :disabled="courseId == null" @click="editCourse" v-hasPermi="['exam:course:edit']">修改课程</el-button>
      <el-button type="danger" plain icon="Delete" :disabled="courseId == null" @click="deleteCourse" v-hasPermi="['exam:course:remove']">删除课程</el-button>
    </div>

    <el-row :gutter="16">
      <el-col :span="12">
        <div class="box">
          <div class="box-title">章节（点击一行查看知识点）</div>
          <el-button type="primary" plain icon="Plus" :disabled="courseId == null" @click="handleAddChapter" v-hasPermi="['exam:chapter:add']">新增章节</el-button>
          <el-table :data="chapterList" v-loading="chapterLoading" highlight-current-row @row-click="chooseChapter" style="margin-top: 10px">
            <el-table-column label="章节名称" prop="name" min-width="140" show-overflow-tooltip />
            <el-table-column label="顺序" prop="sortNo" width="70" align="center" />
            <el-table-column label="操作" width="110" align="center">
              <template #default="scope">
                <el-button link type="primary" @click="editChapter(scope.row)" v-hasPermi="['exam:chapter:edit']">修改</el-button>
                <el-button link type="primary" @click="deleteChapter(scope.row)" v-hasPermi="['exam:chapter:remove']">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </el-col>

      <el-col :span="12">
        <div class="box">
          <div class="box-title">知识点<span v-if="chapterId"> - {{ chapterName }}</span></div>
          <el-button type="primary" plain icon="Plus" :disabled="chapterId == null" @click="handleAddKnowledge" v-hasPermi="['exam:knowledge:add']">新增知识点</el-button>
          <el-table :data="knowledgeList" v-loading="knowledgeLoading" style="margin-top: 10px">
            <el-table-column label="知识点名称" prop="name" min-width="140" show-overflow-tooltip />
            <el-table-column label="权重" prop="weight" width="70" align="center" />
            <el-table-column label="顺序" prop="sortNo" width="70" align="center" />
            <el-table-column label="操作" width="110" align="center">
              <template #default="scope">
                <el-button link type="primary" @click="editKnowledge(scope.row)" v-hasPermi="['exam:knowledge:edit']">修改</el-button>
                <el-button link type="primary" @click="deleteKnowledge(scope.row)" v-hasPermi="['exam:knowledge:remove']">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </el-col>
    </el-row>

    <el-dialog title="课程" v-model="courseOpen" width="500px" append-to-body>
      <el-form ref="courseFormRef" :model="courseForm" :rules="courseRules" label-width="90px">
        <el-form-item label="课程名称" prop="courseName">
          <el-input v-model="courseForm.courseName" placeholder="请输入课程名称" />
        </el-form-item>
        <el-form-item label="课程代码" prop="courseCode">
          <el-input v-model="courseForm.courseCode" placeholder="请输入课程代码" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="courseForm.remark" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="saveCourse">确 定</el-button>
          <el-button @click="courseOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog title="章节" v-model="chapterOpen" width="500px" append-to-body>
      <el-form ref="chapterFormRef" :model="chapterForm" :rules="chapterRules" label-width="90px">
        <el-form-item label="章节名称" prop="name">
          <el-input v-model="chapterForm.name" placeholder="请输入章节名称" />
        </el-form-item>
        <el-form-item label="显示顺序" prop="sortNo">
          <el-input v-model="chapterForm.sortNo" placeholder="请输入显示顺序" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="saveChapter">确 定</el-button>
          <el-button @click="chapterOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog title="知识点" v-model="knowledgeOpen" width="500px" append-to-body>
      <el-form ref="knowledgeFormRef" :model="knowledgeForm" :rules="knowledgeRules" label-width="90px">
        <el-form-item label="知识点名称" prop="name">
          <el-input v-model="knowledgeForm.name" placeholder="请输入知识点名称" />
        </el-form-item>
        <el-form-item label="考查权重" prop="weight">
          <el-input v-model="knowledgeForm.weight" placeholder="请输入考查权重" />
        </el-form-item>
        <el-form-item label="显示顺序" prop="sortNo">
          <el-input v-model="knowledgeForm.sortNo" placeholder="请输入显示顺序" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="saveKnowledge">确 定</el-button>
          <el-button @click="knowledgeOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Basic">
import { listCourse, getCourse, addCourse, updateCourse, delCourse } from "@/api/exam/course"
import { listChapter, getChapter, addChapter, updateChapter, delChapter } from "@/api/exam/chapter"
import { listKnowledge, getKnowledge, addKnowledge, updateKnowledge, delKnowledge } from "@/api/exam/knowledge"

const { proxy } = getCurrentInstance()

const courseId = ref(null)
const chapterId = ref(null)
const chapterName = ref("")
const courseList = ref([])
const chapterList = ref([])
const knowledgeList = ref([])
const chapterLoading = ref(false)
const knowledgeLoading = ref(false)

const courseOpen = ref(false)
const chapterOpen = ref(false)
const knowledgeOpen = ref(false)
const courseForm = ref({})
const chapterForm = ref({})
const knowledgeForm = ref({})

const courseRules = {
  courseName: [{ required: true, message: "课程名称不能为空", trigger: "blur" }]
}
const chapterRules = {
  name: [{ required: true, message: "章节名称不能为空", trigger: "blur" }]
}
const knowledgeRules = {
  name: [{ required: true, message: "知识点名称不能为空", trigger: "blur" }]
}

function loadCourse() {
  listCourse({ pageNum: 1, pageSize: 200 }).then(res => {
    courseList.value = res.rows || []
    if (courseId.value == null && courseList.value.length > 0) {
      courseId.value = courseList.value[0].id
      loadChapter()
    }
  })
}

function loadChapter() {
  if (courseId.value == null) {
    chapterList.value = []
    return
  }
  chapterLoading.value = true
  listChapter({ pageNum: 1, pageSize: 200, courseId: courseId.value }).then(res => {
    chapterList.value = res.rows || []
    chapterLoading.value = false
  })
}

function loadKnowledge() {
  if (chapterId.value == null) {
    knowledgeList.value = []
    return
  }
  knowledgeLoading.value = true
  listKnowledge({ pageNum: 1, pageSize: 500, chapterId: chapterId.value }).then(res => {
    knowledgeList.value = res.rows || []
    knowledgeLoading.value = false
  })
}

// 换课程后重新查章节，知识点清空
function changeCourse() {
  chapterId.value = null
  chapterName.value = ""
  knowledgeList.value = []
  loadChapter()
}

// 点章节的一行，查这一章的知识点
function chooseChapter(row) {
  chapterId.value = row.id
  chapterName.value = row.name
  loadKnowledge()
}

function resetCourse() {
  courseForm.value = { id: null, courseName: null, courseCode: null, remark: null }
  proxy.resetForm("courseFormRef")
}

function handleAddCourse() {
  resetCourse()
  courseOpen.value = true
}

function editCourse() {
  getCourse(courseId.value).then(res => {
    courseForm.value = res.data
    courseOpen.value = true
  })
}

function saveCourse() {
  proxy.$refs["courseFormRef"].validate(ok => {
    if (!ok) return
    if (courseForm.value.id != null) {
      updateCourse(courseForm.value).then(() => {
        proxy.$modal.msgSuccess("修改成功")
        courseOpen.value = false
        loadCourse()
      })
    } else {
      addCourse(courseForm.value).then(() => {
        proxy.$modal.msgSuccess("新增成功")
        courseOpen.value = false
        loadCourse()
      })
    }
  })
}

function deleteCourse() {
  const c = courseList.value.find(item => item.id === courseId.value)
  proxy.$modal.confirm('是否确认删除课程「' + (c ? c.courseName : '') + '」？').then(() => {
    return delCourse(courseId.value)
  }).then(() => {
    courseId.value = null
    chapterId.value = null
    chapterList.value = []
    knowledgeList.value = []
    loadCourse()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

function resetChapter() {
  chapterForm.value = { id: null, courseId: null, name: null, sortNo: null }
  proxy.resetForm("chapterFormRef")
}

function handleAddChapter() {
  resetChapter()
  chapterForm.value.courseId = courseId.value
  chapterOpen.value = true
}

function editChapter(row) {
  getChapter(row.id).then(res => {
    chapterForm.value = res.data
    chapterOpen.value = true
  })
}

function saveChapter() {
  proxy.$refs["chapterFormRef"].validate(ok => {
    if (!ok) return
    if (chapterForm.value.id != null) {
      updateChapter(chapterForm.value).then(() => {
        proxy.$modal.msgSuccess("修改成功")
        chapterOpen.value = false
        loadChapter()
        loadKnowledge()
      })
    } else {
      addChapter(chapterForm.value).then(() => {
        proxy.$modal.msgSuccess("新增成功")
        chapterOpen.value = false
        loadChapter()
        loadKnowledge()
      })
    }
  })
}

function deleteChapter(row) {
  proxy.$modal.confirm('是否确认删除章节「' + row.name + '」？').then(() => {
    return delChapter(row.id)
  }).then(() => {
    if (chapterId.value === row.id) {
      chapterId.value = null
      chapterName.value = ""
    }
    loadChapter()
    loadKnowledge()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

function resetKnowledge() {
  knowledgeForm.value = { id: null, chapterId: null, name: null, weight: null, sortNo: null }
  proxy.resetForm("knowledgeFormRef")
}

function handleAddKnowledge() {
  resetKnowledge()
  knowledgeForm.value.chapterId = chapterId.value
  knowledgeOpen.value = true
}

function editKnowledge(row) {
  getKnowledge(row.id).then(res => {
    knowledgeForm.value = res.data
    knowledgeOpen.value = true
  })
}

function saveKnowledge() {
  proxy.$refs["knowledgeFormRef"].validate(ok => {
    if (!ok) return
    if (knowledgeForm.value.id != null) {
      updateKnowledge(knowledgeForm.value).then(() => {
        proxy.$modal.msgSuccess("修改成功")
        knowledgeOpen.value = false
        loadKnowledge()
      })
    } else {
      addKnowledge(knowledgeForm.value).then(() => {
        proxy.$modal.msgSuccess("新增成功")
        knowledgeOpen.value = false
        loadKnowledge()
      })
    }
  })
}

function deleteKnowledge(row) {
  proxy.$modal.confirm('是否确认删除知识点「' + row.name + '」？').then(() => {
    return delKnowledge(row.id)
  }).then(() => {
    loadKnowledge()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

loadCourse()
</script>

<style scoped>
.top-row { margin-bottom: 16px; }
.top-row .el-button { margin-left: 8px; }
.box { border: 1px solid #dcdfe6; padding: 12px; }
.box-title { font-size: 15px; font-weight: bold; margin-bottom: 10px; }
</style>
