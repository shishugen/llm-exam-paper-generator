<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="配置名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入配置名称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="模型名称" prop="modelName">
        <el-input
          v-model="queryParams.modelName"
          placeholder="请输入模型名称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="是否启用" prop="isDefault">
        <el-select v-model="queryParams.isDefault" placeholder="请选择是否启用" clearable>
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
          v-hasPermi="['exam:modelConfig:add']"
        >新增</el-button>
      </el-col>
           <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['exam:modelConfig:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="modelConfigList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="配置名称" align="center" prop="name" />
      <el-table-column label="接口地址" align="center" prop="baseUrl" />
      <el-table-column label="模型名称" align="center" prop="modelName" />
      <el-table-column label="是否启用" align="center" prop="isDefault">
        <template #default="scope">
          <dict-tag :options="exam_yes_no" :value="scope.row.isDefault"/>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['exam:modelConfig:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['exam:modelConfig:remove']">删除</el-button>
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

    <!-- 添加或修改模型配置对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="modelConfigRef" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="配置名称" prop="name">
              <el-input v-model="form.name" placeholder="请输入配置名称" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="接口地址" prop="baseUrl">
              <el-input v-model="form.baseUrl" placeholder="请输入接口地址" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="密钥" prop="apiKey">
              <div v-if="form.id != null" class="key-tip">密钥已设置。如需更换请重新输入，留空表示保持不变。</div>
              <el-input v-model="form.apiKey" type="password" show-password
                        :placeholder="form.id != null ? '留空表示不修改' : '请输入密钥'" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="模型名称" prop="modelName">
              <el-input v-model="form.modelName" placeholder="请输入模型名称" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="是否启用" prop="isDefault">
              <el-select v-model="form.isDefault" placeholder="请选择是否启用">
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

<script setup name="ModelConfig">
import { listModelConfig, getModelConfig, delModelConfig, addModelConfig, updateModelConfig } from "@/api/exam/modelConfig"

const { proxy } = getCurrentInstance()
const { exam_yes_no } = useDict('exam_yes_no')

const modelConfigList = ref([])
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
    name: undefined,
    baseUrl: undefined,
    modelName: undefined,
    isDefault: undefined,
  },
  rules: {
    name: [
      { required: true, message: "配置名称不能为空", trigger: "blur" }
    ],
    baseUrl: [
      { required: true, message: "接口地址不能为空", trigger: "blur" }
    ],
    modelName: [
      { required: true, message: "模型名称不能为空", trigger: "blur" }
    ],
    isDefault: [
      { required: true, message: "是否启用不能为空", trigger: "change" }
    ],
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 查询模型配置列表 */
function getList() {
  loading.value = true
  listModelConfig(queryParams.value).then(response => {
    modelConfigList.value = response.rows
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
    name: null,
    baseUrl: null,
    apiKey: null,
    modelName: null,
    isDefault: null,
    createBy: null,
    createTime: null,
    updateBy: null,
    updateTime: null
  }
  proxy.resetForm("modelConfigRef")
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
  title.value = "添加模型配置"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _id = row.id || ids.value
  getModelConfig(_id).then(response => {
    form.value = response.data
    form.value.apiKey = ""
    open.value = true
    title.value = "修改模型配置"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["modelConfigRef"].validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        updateModelConfig(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addModelConfig(form.value).then(() => {
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
  proxy.$modal.confirm('是否确认删除模型配置编号为"' + _ids + '"的数据项？').then(function() {
    return delModelConfig(_ids)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('exam/modelConfig/export', {
    ...queryParams.value
  }, `modelConfig_${new Date().getTime()}.xlsx`)
}

getList()
</script>

<style scoped>
.key-tip { color: #909399; font-size: 12px; margin-bottom: 6px; }
</style>
