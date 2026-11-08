-- 课程、章节、知识点合并页面的菜单
-- 页面文件：frontend/src/views/exam/basic/index.vue
-- 执行：mysql -uroot ry-vue < exam_合并页面菜单.sql
-- 只执行一次，重复执行会出现两条一样的菜单。

SET NAMES utf8mb4;

INSERT INTO sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
SELECT '课程章节知识点', t.menu_id, '0', 'basic', 'exam/basic/index', 1, 0, 'C', '0', '0', 'exam:basic:list', '#', 'admin', sysdate(), '', null, '课程、章节、知识点合并维护页面'
FROM (SELECT menu_id FROM sys_menu WHERE menu_name = '试卷管理' AND parent_id = 0 LIMIT 1) t;
