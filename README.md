# 基于大语言模型的试卷生成系统

通过大语言模型 API 辅助生成试题、并按多约束条件自动组卷的系统。
基础框架采用若依 RuoYi-Vue（springboot3 分支）与 RuoYi-Vue3（MIT 协议），
只使用其权限与基础管理能力，业务模块自研。

## 目录结构

| 路径 | 说明 |
| --- | --- |
| `backend` | 后端服务（Spring Boot 3） |
| `frontend` | 前端页面（Vue 3） |
| `sql` | 建库、菜单清理与回滚脚本 |
| `启动系统.sh` | 本地一键启动 / 停止 / 重启 |

## 技术栈

- 前端：Vue 3 + Element Plus + Vite + Pinia
- 后端：Spring Boot 3 + MyBatis + Spring Security + JWT + MySQL 8 + Redis
- AI 能力：通过 OpenAI 兼容协议调用大语言模型 API，支持离线 mock 降级；不做模型训练，不需要 GPU
- 组卷：多约束下的贪心 + 回溯调整，配合题目去重

## 本地运行

1. 创建 MySQL 数据库 `ry-vue`，导入 `sql/` 下的脚本
2. 启动 MySQL 8 与 Redis
3. 执行 `启动系统.sh start`
4. 浏览器访问 http://localhost:5173 ，默认账号 `admin` / `admin123`

> `application.yml` 中的 `ruoyi.profile` 目前写的是本机绝对路径，换机器运行时需改成对应目录。

## 当前进度

已完成框架精简（只保留登录、用户管理、角色管理、菜单权限）与前后端全链路调通。
AI 适配层、提示词模板管理、JSON 校验重试、去重与组卷算法、试卷导出等模块开发中。

## 说明

仓库只包含系统代码与数据库脚本；论文文档、学校模板等过程材料保留在本机，不入库。
前后端依赖与构建产物（`node_modules/`、`target/`、`dist/`）不入库。
