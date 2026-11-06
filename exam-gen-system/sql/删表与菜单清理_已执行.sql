-- 删除无用表与菜单行（2026-11-06 已执行）
-- 执行前全库备份：sql/ry-vue_全库备份_删除前_20261106.sql
-- 恢复整库：mysql -uroot < sql/ry-vue_全库备份_删除前_20261106.sql
--
-- 前提：ruoyi-quartz 模块、monitor controller、notice 全套后端代码、
--       以及对应前端页面均已从工程移除，这些表才没有任何引用。
-- QRTZ_* 之间有外键，先关掉外键检查再整组删除。

SET FOREIGN_KEY_CHECKS = 0;

-- 1. 公告（前端页面 + HeaderNotice + 后端全套已删）
DROP TABLE IF EXISTS sys_notice_read;
DROP TABLE IF EXISTS sys_notice;

-- 2. 定时任务（ruoyi-quartz 模块已删）
DROP TABLE IF EXISTS sys_job_log;
DROP TABLE IF EXISTS sys_job;
DROP TABLE IF EXISTS QRTZ_BLOB_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_CALENDARS;
DROP TABLE IF EXISTS QRTZ_CRON_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_FIRED_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_JOB_DETAILS;
DROP TABLE IF EXISTS QRTZ_LOCKS;
DROP TABLE IF EXISTS QRTZ_PAUSED_TRIGGER_GRPS;
DROP TABLE IF EXISTS QRTZ_SCHEDULER_STATE;
DROP TABLE IF EXISTS QRTZ_SIMPLE_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_SIMPROP_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_TRIGGERS;

-- 3. 菜单行：真正删除被隐藏的菜单及其按钮权限
--    保留：1 用户与权限（目录）、3 系统工具（目录，代码生成器用）、
--          100 用户管理、101 角色管理、102 菜单管理、116 代码生成
DELETE FROM sys_menu WHERE menu_type = 'F' AND parent_id IN (
  SELECT menu_id FROM (SELECT menu_id FROM sys_menu WHERE menu_type IN ('M','C') AND visible = '1') AS t
);
DELETE FROM sys_menu WHERE menu_type IN ('M','C') AND visible = '1';
DELETE FROM sys_role_menu WHERE menu_id NOT IN (SELECT menu_id FROM sys_menu);

SET FOREIGN_KEY_CHECKS = 1;

-- 4. 不删的表及原因（删了登录或用户管理会崩）
--    sys_user / sys_role / sys_menu / sys_user_role / sys_role_menu  权限核心
--    sys_dept / sys_post / sys_user_post / sys_role_dept            用户管理新增编辑会写
--    sys_config                                                    登录时读验证码开关、重置密码读初始密码
--    sys_dict_type / sys_dict_data                                  用户/角色/菜单页的状态字典、代码生成器下拉
--    sys_oper_log / sys_logininfor                                  日志切面与登录异步任务会写
--    gen_table / gen_table_column                                   代码生成器（用户明确要求先保留）
