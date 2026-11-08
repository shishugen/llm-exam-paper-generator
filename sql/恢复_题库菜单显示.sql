-- 恢复「题库」菜单显示（AI 出题入口在题库页里）
-- 现象：侧边栏看不到「题库」
-- 原因：sys_menu 里 menu_id=2019 的 visible='1'（隐藏）、status='1'（停用），
--       若依取动态路由时只拿 visible='0' AND status='0' 的菜单，所以整条不返回。
--       这不是删三条重复菜单造成的，那条脚本只删了 course/chapter/knowledge 三条 C 记录。
-- 执行：mysql -uroot ry-vue < 恢复_题库菜单显示.sql

SET NAMES utf8mb4;

UPDATE sys_menu SET visible = '0', status = '0'
 WHERE menu_id = 2019 AND menu_name = '题库' AND menu_type = 'C';

-- 【验证】
-- SELECT menu_id, menu_name, visible, status, component FROM sys_menu WHERE menu_id = 2019;
--
-- 【回滚】要重新隐藏题库时执行：
-- UPDATE sys_menu SET visible = '1', status = '1' WHERE menu_id = 2019 AND menu_type = 'C';
