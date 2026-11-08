-- 隐藏「试卷明细」菜单
-- 原因：试卷详情页的抽屉里已能查看、锁定、替换明细，独立列表是重复入口。
-- 只把菜单设成隐藏，不删记录、不动下面的按钮权限、不删页面文件/接口/数据表。
-- 执行：mysql -uroot ry-vue < 隐藏_试卷明细菜单.sql
-- 执行前已备份：sql/备份_sys_menu_隐藏试卷明细前_20261108.sql

SET NAMES utf8mb4;

UPDATE sys_menu SET visible = '1'
 WHERE menu_id = 2037 AND menu_name = '试卷明细' AND menu_type = 'C';

-- 【验证】
-- SELECT menu_id, menu_name, visible, status FROM sys_menu WHERE menu_id = 2037;
--
-- 【回滚】要重新显示时执行：
-- UPDATE sys_menu SET visible = '0' WHERE menu_id = 2037 AND menu_type = 'C';
