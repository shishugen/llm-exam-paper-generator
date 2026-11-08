-- ============================================================================
-- 独立一级菜单「大模型管理」：模型配置、提示词、大模型调用日志
-- 执行：mysql -uroot ry-vue < exam_大模型管理_菜单.sql
--
-- 做什么：
--   1. 新建一级目录「大模型管理」，排在「试卷管理」后面
--   2. 挂两条新菜单：模型配置 exam/modelConfig/index、提示词 exam/prompt/index
--   3. 把原来挂在「试卷管理」下的「大模型调用日志」挪到这个目录下
--      （它下面 4 条按钮权限记录 parent_id 仍是它自己，不用动）
--
-- 本脚本可重复执行，不会插出重复菜单。
-- 只插菜单（C 类型），不插按钮权限（F 类型）：毕设用 admin 超管，* : * 全通过。
-- 执行前已备份：sql/备份_sys_menu_菜单调整前_20261108.sql
-- ============================================================================

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------------
-- 1. 一级目录
-- ---------------------------------------------------------------------------
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
SELECT '大模型管理', 0, '6', 'llm', '', 1, 0, 'M', '0', '0', '', 'code', 'admin', NOW(), '', NULL, '模型配置 / 提示词 / 调用日志'
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM (SELECT menu_id FROM sys_menu WHERE menu_name = '大模型管理' AND parent_id = 0) x);

SELECT menu_id INTO @llmParentId FROM sys_menu WHERE menu_name = '大模型管理' AND parent_id = 0 LIMIT 1;

-- ---------------------------------------------------------------------------
-- 2. 模型配置
-- ---------------------------------------------------------------------------
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
SELECT '模型配置', @llmParentId, '1', 'modelConfig', 'exam/modelConfig/index', 1, 0, 'C', '0', '0', 'exam:modelConfig:list', '#', 'admin', NOW(), '', NULL, '模型配置菜单'
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM (SELECT menu_id FROM sys_menu WHERE component = 'exam/modelConfig/index') x);

-- ---------------------------------------------------------------------------
-- 3. 提示词
-- ---------------------------------------------------------------------------
INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
SELECT '提示词', @llmParentId, '2', 'prompt', 'exam/prompt/index', 1, 0, 'C', '0', '0', 'exam:prompt:list', '#', 'admin', NOW(), '', NULL, '提示词菜单'
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM (SELECT menu_id FROM sys_menu WHERE component = 'exam/prompt/index') x);

-- ---------------------------------------------------------------------------
-- 4. 大模型调用日志：只改父目录，不动记录本身和它的按钮权限
-- ---------------------------------------------------------------------------
UPDATE sys_menu
   SET parent_id = @llmParentId, order_num = '3'
 WHERE menu_name = '大模型调用日志' AND perms = 'exam:aiCallLog:list' AND menu_type = 'C';

-- ---------------------------------------------------------------------------
-- 【验证】
-- SELECT menu_id, menu_name, parent_id, path, component, perms, order_num
--   FROM sys_menu WHERE menu_name = '大模型管理' OR parent_id = @llmParentId
--    OR menu_name = '大模型调用日志' ORDER BY parent_id, order_num;
--
-- 【回滚】（要用时手动去掉注释执行）
-- UPDATE sys_menu SET parent_id = 2000, order_num = '1'
--  WHERE menu_name = '大模型调用日志' AND perms = 'exam:aiCallLog:list' AND menu_type = 'C';
-- DELETE FROM sys_menu WHERE component IN ('exam/modelConfig/index', 'exam/prompt/index');
-- DELETE FROM sys_menu WHERE menu_name = '大模型管理' AND parent_id = 0;
-- ============================================================================
