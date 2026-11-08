-- ============================================================================
-- 删除「课程 / 章节 / 知识点」三条重复菜单
-- 原因：三个模块已合并到「课程章节知识点」页面（exam/basic/index）
-- 执行：mysql -uroot ry-vue < 删除_课程章节知识点_重复菜单.sql
--
-- 只删 3 条菜单（C 类型），**保留 12 条按钮权限（F 类型）**：
--   合并页的按钮用的就是 exam:course:add / exam:chapter:edit / exam:knowledge:remove
--   这三套 perms，删了 F 记录角色管理里就没这些权限项了。
--   所以把它们改挂到合并页菜单下，避免变成孤儿记录。
--
-- 页面文件 exam/course/index.vue 等三个原页面不删，只是侧边栏不再有入口。
-- 本脚本可重复执行（第 2 步重复执行无影响，第 3 步匹配不到行）。
-- 执行前已备份：sql/备份_课程章节知识点菜单删除前_20261108.sql
-- ============================================================================

SET NAMES utf8mb4;

SET @basicMenuId = (SELECT menu_id FROM sys_menu WHERE component = 'exam/basic/index' AND menu_type = 'C' LIMIT 1);

-- ---------------------------------------------------------------------------
-- 1. 清掉这三条菜单的角色授权关联（当前查到是 0 条，写上以防以后分配过）
-- ---------------------------------------------------------------------------
DELETE FROM sys_role_menu WHERE menu_id IN (
  SELECT menu_id FROM (
    SELECT menu_id FROM sys_menu
     WHERE component IN ('exam/course/index', 'exam/chapter/index', 'exam/knowledge/index')
       AND menu_type = 'C'
  ) x
);

-- ---------------------------------------------------------------------------
-- 2. 三组按钮权限改挂到合并页下
-- ---------------------------------------------------------------------------
UPDATE sys_menu SET parent_id = @basicMenuId
 WHERE menu_type = 'F'
   AND (perms LIKE 'exam:course:%' OR perms LIKE 'exam:chapter:%' OR perms LIKE 'exam:knowledge:%');

-- ---------------------------------------------------------------------------
-- 3. 删三条菜单本身
-- ---------------------------------------------------------------------------
DELETE FROM sys_menu
 WHERE component IN ('exam/course/index', 'exam/chapter/index', 'exam/knowledge/index')
   AND menu_type = 'C';

-- ---------------------------------------------------------------------------
-- 【验证】
-- SELECT menu_id, menu_name, parent_id, component, menu_type FROM sys_menu
--  WHERE menu_name = '课程章节知识点'
--     OR parent_id = (SELECT menu_id FROM (SELECT menu_id FROM sys_menu WHERE menu_name='课程章节知识点') x)
--  ORDER BY menu_id;
-- SELECT COUNT(*) FROM sys_menu
--  WHERE component IN ('exam/course/index','exam/chapter/index','exam/knowledge/index') AND menu_type='C';
--
-- 【回滚】备份里含删除前的完整 sys_menu + sys_role_menu（也包含新加的「大模型管理」菜单），
--   直接导入即可回到删除前状态：
--   mysql -uroot ry-vue < sql/备份_课程章节知识点菜单删除前_20261108.sql
-- ============================================================================
