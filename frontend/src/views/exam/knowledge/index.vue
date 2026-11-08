<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="所属章节" prop="chapterId">
        <el-select v-model="queryParams.chapterId" placeholder="请选择章节" clearable filterable style="width: 200px">
          <el-option v-for="ch in chapterList" :key="ch.id" :label="ch.name" :value="ch.id" />
        </el-select>
      </el-form-item>
      <el-form-item label="知识点名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入知识点名称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="考查权重" prop="weight">
        <el-input
          v-model="queryParams.weight"
          placeholder="请输入考查权重"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="显示顺序" prop="sortNo">
        <el-input
          v-model="queryParams.sortNo"
          placeholder="请输入显示顺序"
          clearable
          @keyup.enter="handleQuery"
        />
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
          v-hasPermi="['exam:knowledge:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['exam:knowledge:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="knowledgeList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="知识点名称" align="left" prop="name" min-width="260" show-overflow-tooltip />
      <el-table-column label="所属章节" align="center" prop="chapterName" width="200" />
      <el-table-column label="考查权重" align="center" prop="weight" width="100" />
      <el-table-column label="显示顺序" align="center" prop="sortNo" width="100" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['exam:knowledge:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['exam:knowledge:remove']">删除</el-button>
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

    <!-- 添加或修改知识点对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="knowledgeRef" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="所属章节" prop="chapterId">
              <el-select v-model="form.chapterId" placeholder="请选择章节" filterable style="width:100%">
                <el-option v-for="ch in chapterList" :key="ch.id" :label="ch.name" :value="ch.id" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="知识点名称" prop="name">
              <el-input v-model="form.name" placeholder="请输入知识点名称" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="考查权重" prop="weight">
              <el-input v-model="form.weight" placeholder="请输入考查权重" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="显示顺序" prop="sortNo">
              <el-input v-model="form.sortNo" placeholder="请输入显示顺序" />
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

<script setup name="Knowledge">
import { listKnowledge, getKnowledge, delKnowledge, addKnowledge, updateKnowledge } from "@/api/exam/knowledge"
import { listChapter } from "@/api/exam/chapter"

const { proxy } = getCurrentInstance()

const chapterList = ref([])
const knowledgeList = ref([])
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
    chapterId: undefined,
    name: undefined,
    weight: undefined,
    sortNo: undefined,
  },
  rules: {
    chapterId: [
      { required: true, message: "所属章节不能为空", trigger: "change" }
    ],
    name: [
      { required: true, message: "知识点名称不能为空", trigger: "blur" }
    ],
  }
})

const { queryParams, form, rules } = toRefs(data)

// 章节下拉数据（新增/修改知识点时选择章节）
listChapter({ pageNum: 1, pageSize: 500 }).then(res => { chapterList.value = res.rows || [] })

/** 查询知识点列表 */
function getList() {
  loading.value = true
  listKnowledge(queryParams.value).then(response => {
    knowledgeList.value = response.rows
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
    chapterId: null,
    name: null,
    weight: null,
    sortNo: null,
    createBy: null,
    createTime: null,
    updateBy: null,
    updateTime: null
  }
  proxy.resetForm("knowledgeRef")
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
  title.value = "添加知识点"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _id = row.id || ids.value
  getKnowledge(_id).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改知识点"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["knowledgeRef"].validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        updateKnowledge(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addKnowledge(form.value).then(() => {
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
    ? '是否确认删除知识点「' + row.name + '」？'
    : '是否确认删除选中的 ' + ids.value.length + ' 个知识点？'
  proxy.$modal.confirm(tip).then(function() {
    return delKnowledge(_ids)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

getList()
</script>
