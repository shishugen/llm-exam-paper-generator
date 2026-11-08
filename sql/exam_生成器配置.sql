-- ============================================================================
-- 若依代码生成器 —— 8 张 exam_ 表的生成配置
-- 用途：表已在页面「导入表」之后执行本脚本，再点「生成代码」。
-- 执行：mysql -uroot ry-vue < exam_生成器配置.sql
--
-- 配置目标：
--   作者           shishugen
--   后端包/模块     com.ruoyi.exam / exam（独立 Maven 模块 ruoyi-exam）
--   前端目录        vue/views/exam/...、vue/api/exam/...（独立文件夹）
--   业务名          修掉默认重名（exam_review_log 与 exam_ai_call_log 都叫 log，
--                  exam_question 与 exam_paper_question 都叫 question，会互相覆盖）
--   下拉框字典      状态/题型/难度等 9 组，避免生成「请选择字典生成」的空下拉
--   Java 类型       MySQL 9 的 int 列若依默认识别成 Long，这里改回 Integer
--   基类字段        createBy/createTime/updateBy/updateTime 不进表单和列表
--
-- 本脚本只改 gen_table / gen_table_column / 两张字典表，可重复执行。
-- ============================================================================

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------------
-- 一、表级配置
-- ---------------------------------------------------------------------------
UPDATE `gen_table`
   SET `function_author` = 'shishugen',
       `package_name`    = 'com.ruoyi.exam',
       `module_name`     = 'exam'
 WHERE `table_name` LIKE 'exam\_%';

-- 修复默认业务名重名（getBusinessName 只取最后一个下划线后面的词）
UPDATE `gen_table` SET `business_name` = 'aiCallLog'     WHERE `table_name` = 'exam_ai_call_log';
UPDATE `gen_table` SET `business_name` = 'reviewLog'     WHERE `table_name` = 'exam_review_log';
UPDATE `gen_table` SET `business_name` = 'paperQuestion' WHERE `table_name` = 'exam_paper_question';

-- ---------------------------------------------------------------------------
-- 二、列级配置
-- ---------------------------------------------------------------------------

-- 1) MySQL 9 的 int 列没有显示宽度，若依会误判成 Long，统一改回 Integer
UPDATE `gen_table_column`
   SET `java_type` = 'Integer'
 WHERE `column_type` = 'int'
   AND `table_id` IN (SELECT `table_id` FROM (SELECT `table_id` FROM `gen_table` WHERE `table_name` LIKE 'exam\_%') x);

-- 2) 基类字段不出现在新增/编辑表单、列表与查询条件里（页面干净）
--    is_required 尤其要清掉：create_time 是 NOT NULL，若依会给它生成必填校验，
--    但表单里根本没有这个控件，导致新增/修改永远提交不了。
UPDATE `gen_table_column`
   SET `is_insert` = '0', `is_edit` = '0', `is_list` = '0', `is_query` = '0', `is_required` = '0'
 WHERE `java_field` IN ('createBy', 'createTime', 'updateBy', 'updateTime')
   AND `table_id` IN (SELECT `table_id` FROM (SELECT `table_id` FROM `gen_table` WHERE `table_name` LIKE 'exam\_%') x);

-- 3) 编码列绑定字典 + 统一下拉框
UPDATE `gen_table_column` c JOIN `gen_table` t ON c.table_id = t.table_id
   SET c.html_type = 'select', c.dict_type = 'exam_question_type'
 WHERE t.table_name = 'exam_question' AND c.column_name = 'type';
UPDATE `gen_table_column` c JOIN `gen_table` t ON c.table_id = t.table_id
   SET c.html_type = 'select', c.dict_type = 'exam_difficulty'
 WHERE t.table_name = 'exam_question' AND c.column_name = 'difficulty';
UPDATE `gen_table_column` c JOIN `gen_table` t ON c.table_id = t.table_id
   SET c.html_type = 'select', c.dict_type = 'exam_question_status'
 WHERE t.table_name = 'exam_question' AND c.column_name = 'status';
UPDATE `gen_table_column` c JOIN `gen_table` t ON c.table_id = t.table_id
   SET c.html_type = 'select', c.dict_type = 'exam_source'
 WHERE t.table_name = 'exam_question' AND c.column_name = 'source';
UPDATE `gen_table_column` c JOIN `gen_table` t ON c.table_id = t.table_id
   SET c.html_type = 'select', c.dict_type = 'exam_paper_status'
 WHERE t.table_name = 'exam_paper' AND c.column_name = 'status';
UPDATE `gen_table_column` c JOIN `gen_table` t ON c.table_id = t.table_id
   SET c.html_type = 'select', c.dict_type = 'exam_yes_no'
 WHERE t.table_name = 'exam_paper_question' AND c.column_name = 'locked';
UPDATE `gen_table_column` c JOIN `gen_table` t ON c.table_id = t.table_id
   SET c.html_type = 'select', c.dict_type = 'exam_task_type'
 WHERE t.table_name = 'exam_ai_call_log' AND c.column_name = 'task_type';
UPDATE `gen_table_column` c JOIN `gen_table` t ON c.table_id = t.table_id
   SET c.html_type = 'select', c.dict_type = 'exam_call_status'
 WHERE t.table_name = 'exam_ai_call_log' AND c.column_name = 'status';
UPDATE `gen_table_column` c JOIN `gen_table` t ON c.table_id = t.table_id
   SET c.html_type = 'select', c.dict_type = 'exam_review_action'
 WHERE t.table_name = 'exam_review_log' AND c.column_name = 'action';

-- ---------------------------------------------------------------------------
-- 三、业务字典（9 组，供生成出来的页面显示中文）
--     先清再插，重复执行不会产生重复行。
-- ---------------------------------------------------------------------------
DELETE FROM `sys_dict_data` WHERE `dict_type` LIKE 'exam\_%';
DELETE FROM `sys_dict_type` WHERE `dict_type` LIKE 'exam\_%';

INSERT INTO `sys_dict_type` (`dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `remark`) VALUES
('试题题型',   'exam_question_type',   '0', 'admin', NOW(), '试卷生成系统'),
('试题难度',   'exam_difficulty',      '0', 'admin', NOW(), '试卷生成系统'),
('题目状态',   'exam_question_status', '0', 'admin', NOW(), '试卷生成系统'),
('题目来源',   'exam_source',          '0', 'admin', NOW(), '试卷生成系统'),
('试卷状态',   'exam_paper_status',    '0', 'admin', NOW(), '试卷生成系统'),
('是否',       'exam_yes_no',          '0', 'admin', NOW(), '试卷生成系统：0否 1是'),
('调用任务类型','exam_task_type',       '0', 'admin', NOW(), '试卷生成系统'),
('调用结果',   'exam_call_status',     '0', 'admin', NOW(), '试卷生成系统'),
('审核操作',   'exam_review_action',   '0', 'admin', NOW(), '试卷生成系统');

INSERT INTO `sys_dict_data` (`dict_sort`, `dict_label`, `dict_value`, `dict_type`, `list_class`, `is_default`, `status`, `create_by`, `create_time`) VALUES
(1,'单选题','1','exam_question_type','primary','N','0','admin',NOW()),
(2,'多选题','2','exam_question_type','primary','N','0','admin',NOW()),
(3,'判断题','3','exam_question_type','primary','N','0','admin',NOW()),
(4,'简答题','4','exam_question_type','primary','N','0','admin',NOW()),
(5,'综合题','5','exam_question_type','primary','N','0','admin',NOW()),

(1,'容易','1','exam_difficulty','success','N','0','admin',NOW()),
(2,'中等','2','exam_difficulty','primary','N','0','admin',NOW()),
(3,'较难','3','exam_difficulty','warning','N','0','admin',NOW()),
(4,'困难','4','exam_difficulty','danger','N','0','admin',NOW()),

(1,'草稿','0','exam_question_status','info','N','0','admin',NOW()),
(2,'待审','1','exam_question_status','warning','N','0','admin',NOW()),
(3,'已通过','2','exam_question_status','success','N','0','admin',NOW()),
(4,'已驳回','3','exam_question_status','danger','N','0','admin',NOW()),

(1,'人工录入','0','exam_source','primary','N','0','admin',NOW()),
(2,'AI生成','1','exam_source','success','N','0','admin',NOW()),

(1,'生成中','0','exam_paper_status','warning','N','0','admin',NOW()),
(2,'已完成','1','exam_paper_status','success','N','0','admin',NOW()),
(3,'已导出','2','exam_paper_status','primary','N','0','admin',NOW()),

(1,'否','0','exam_yes_no','info','N','0','admin',NOW()),
(2,'是','1','exam_yes_no','success','N','0','admin',NOW()),

(1,'AI出题','1','exam_task_type','primary','N','0','admin',NOW()),
(2,'重新生成','2','exam_task_type','warning','N','0','admin',NOW()),

(1,'成功','0','exam_call_status','success','N','0','admin',NOW()),
(2,'失败','1','exam_call_status','danger','N','0','admin',NOW()),

(1,'提交待审','1','exam_review_action','warning','N','0','admin',NOW()),
(2,'审核通过','2','exam_review_action','success','N','0','admin',NOW()),
(3,'审核驳回','3','exam_review_action','danger','N','0','admin',NOW());

-- ============================================================================
-- 【验证】执行完可跑这一句：
-- SELECT table_name, class_name, business_name, function_name,
--        function_author, package_name, module_name
--   FROM gen_table WHERE table_name LIKE 'exam\_%' ORDER BY table_name;
-- ============================================================================
