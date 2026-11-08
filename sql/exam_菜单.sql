-- ============================================================================
-- 试卷生成系统 —— 8 张业务表的菜单（由若依代码生成器产出后合并）
-- 执行时机：先 mvn package 重打后端、npm run build:prod 重打前端并重启服务，
--           确认前端 src/views/exam/ 下的页面已部署，再执行本脚本。
-- 执行：mysql -uroot ry-vue < exam_菜单.sql
--
-- 改动：生成器默认把菜单挂在「系统工具」(menu_id=3) 下，这里改成新建的
--       一级目录「试卷管理」，与独立的后端模块 / 前端 exam 文件夹对应。
--       组件路径 exam/xxx/index 与前端 src/views/exam/xxx/index.vue 一一对应。
-- ⚠️ 重复执行会产生重复菜单。要重挂，请先跑文件末尾的清理语句。
-- ============================================================================

SET NAMES utf8mb4;

-- 一级目录
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES('试卷管理', 0, '5', 'exam', '', 1, 0, 'M', '0', '0', '', 'education', 'admin', sysdate(), '', null, '基于大语言模型的试卷生成系统');
SET @examParentId = LAST_INSERT_ID();

-- ---------- 课程（courseMenu.sql） ----------
-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('课程', @examParentId, '1', 'course', 'exam/course/index', 1, 0, 'C', '0', '0', 'exam:course:list', '#', 'admin', sysdate(), '', null, '课程菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('课程查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'exam:course:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('课程新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'exam:course:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('课程修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'exam:course:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('课程删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'exam:course:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('课程导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'exam:course:export',       '#', 'admin', sysdate(), '', null, '');

-- ---------- 章节（chapterMenu.sql） ----------
-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('章节', @examParentId, '1', 'chapter', 'exam/chapter/index', 1, 0, 'C', '0', '0', 'exam:chapter:list', '#', 'admin', sysdate(), '', null, '章节菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('章节查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'exam:chapter:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('章节新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'exam:chapter:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('章节修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'exam:chapter:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('章节删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'exam:chapter:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('章节导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'exam:chapter:export',       '#', 'admin', sysdate(), '', null, '');

-- ---------- 知识点（knowledgeMenu.sql） ----------
-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('知识点', @examParentId, '1', 'knowledge', 'exam/knowledge/index', 1, 0, 'C', '0', '0', 'exam:knowledge:list', '#', 'admin', sysdate(), '', null, '知识点菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('知识点查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'exam:knowledge:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('知识点新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'exam:knowledge:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('知识点修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'exam:knowledge:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('知识点删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'exam:knowledge:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('知识点导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'exam:knowledge:export',       '#', 'admin', sysdate(), '', null, '');

-- ---------- 题库（questionMenu.sql） ----------
-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('题库', @examParentId, '1', 'question', 'exam/question/index', 1, 0, 'C', '0', '0', 'exam:question:list', '#', 'admin', sysdate(), '', null, '题库菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('题库查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'exam:question:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('题库新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'exam:question:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('题库修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'exam:question:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('题库删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'exam:question:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('题库导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'exam:question:export',       '#', 'admin', sysdate(), '', null, '');

-- ---------- 题目审核记录（reviewLogMenu.sql） ----------
-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('题目审核记录', @examParentId, '1', 'reviewLog', 'exam/reviewLog/index', 1, 0, 'C', '0', '0', 'exam:reviewLog:list', '#', 'admin', sysdate(), '', null, '题目审核记录菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('题目审核记录查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'exam:reviewLog:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('题目审核记录新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'exam:reviewLog:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('题目审核记录修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'exam:reviewLog:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('题目审核记录删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'exam:reviewLog:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('题目审核记录导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'exam:reviewLog:export',       '#', 'admin', sysdate(), '', null, '');

-- ---------- 试卷（paperMenu.sql） ----------
-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('试卷', @examParentId, '1', 'paper', 'exam/paper/index', 1, 0, 'C', '0', '0', 'exam:paper:list', '#', 'admin', sysdate(), '', null, '试卷菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('试卷查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'exam:paper:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('试卷新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'exam:paper:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('试卷修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'exam:paper:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('试卷删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'exam:paper:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('试卷导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'exam:paper:export',       '#', 'admin', sysdate(), '', null, '');

-- ---------- 试卷明细（paperQuestionMenu.sql） ----------
-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('试卷明细', @examParentId, '1', 'paperQuestion', 'exam/paperQuestion/index', 1, 0, 'C', '0', '0', 'exam:paperQuestion:list', '#', 'admin', sysdate(), '', null, '试卷明细菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('试卷明细查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'exam:paperQuestion:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('试卷明细新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'exam:paperQuestion:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('试卷明细修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'exam:paperQuestion:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('试卷明细删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'exam:paperQuestion:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('试卷明细导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'exam:paperQuestion:export',       '#', 'admin', sysdate(), '', null, '');

-- ---------- 大模型调用日志（aiCallLogMenu.sql） ----------
-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('大模型调用日志', @examParentId, '1', 'aiCallLog', 'exam/aiCallLog/index', 1, 0, 'C', '0', '0', 'exam:aiCallLog:list', '#', 'admin', sysdate(), '', null, '大模型调用日志菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('大模型调用日志查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'exam:aiCallLog:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('大模型调用日志新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'exam:aiCallLog:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('大模型调用日志修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'exam:aiCallLog:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('大模型调用日志删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'exam:aiCallLog:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('大模型调用日志导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'exam:aiCallLog:export',       '#', 'admin', sysdate(), '', null, '');

-- ============================================================================
-- 【重新挂菜单时先执行这两句清理（默认不执行）】
-- DELETE FROM sys_role_menu WHERE menu_id IN (SELECT menu_id FROM (SELECT menu_id FROM sys_menu WHERE perms LIKE 'exam:%' OR menu_name = '试卷管理') x);
-- DELETE FROM sys_menu WHERE perms LIKE 'exam:%' OR menu_name = '试卷管理';
-- ============================================================================
