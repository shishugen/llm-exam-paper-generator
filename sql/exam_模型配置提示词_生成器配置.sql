-- ============================================================================
-- 代码生成器配置 —— 只针对新导入的 2 张表
--
-- ⚠️ 执行时机：必须先在「系统工具 → 代码生成」点「导入表」，
--    勾选 exam_model_config、exam_prompt 之后，再跑本文件。
--    没导入就跑，UPDATE 会一条都匹配不上。
--
-- 执行：mysql -uroot ry-vue < exam_模型配置提示词_生成器配置.sql
-- 可重复执行，跑完在页面上刷新一下「代码生成」列表再点生成。
-- ============================================================================

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------------
-- 1. 表级配置：和现有 8 张表保持同一套（作者 / 包 / 模块）
-- ---------------------------------------------------------------------------
UPDATE `gen_table`
   SET `function_author` = 'shishugen',
       `package_name`    = 'com.ruoyi.exam',
       `module_name`     = 'exam'
 WHERE `table_name` IN ('exam_model_config', 'exam_prompt');

-- 功能名（导入时取自表注释，这里显式写一遍防止为空）
UPDATE `gen_table` SET `function_name` = '模型配置' WHERE `table_name` = 'exam_model_config';
UPDATE `gen_table` SET `function_name` = '提示词'   WHERE `table_name` = 'exam_prompt';

-- 业务名：默认按最后一个下划线取词，exam_model_config 会变成 "config"，太泛，
-- 统一改成 modelConfig / prompt，后面手写的 api 和页面路径才对得上。
UPDATE `gen_table` SET `business_name` = 'modelConfig' WHERE `table_name` = 'exam_model_config';
UPDATE `gen_table` SET `business_name` = 'prompt'      WHERE `table_name` = 'exam_prompt';

-- ---------------------------------------------------------------------------
-- 2. 基类字段不进表单 / 列表 / 查询
--    尤其要清 is_required：create_time 是 NOT NULL，若依会给它生成必填校验，
--    但表单里没有这个控件，会导致新增和修改一直提交不了。
-- ---------------------------------------------------------------------------
UPDATE `gen_table_column`
   SET `is_insert` = '0', `is_edit` = '0', `is_list` = '0',
       `is_query` = '0', `is_required` = '0'
 WHERE `java_field` IN ('createBy', 'createTime', 'updateBy', 'updateTime')
   AND `table_id` IN (
     SELECT `table_id` FROM (
       SELECT `table_id` FROM `gen_table`
        WHERE `table_name` IN ('exam_model_config', 'exam_prompt')
     ) x
   );

-- ---------------------------------------------------------------------------
-- 3. 几个列的显示方式
-- ---------------------------------------------------------------------------

-- api_key：不进列表、不进查询条件（连密文都不出现在页面上）。
-- 表单控件先留着，后面手写代码会把「新增」改成密码框、「修改」改成只提示。
UPDATE `gen_table_column` c JOIN `gen_table` t ON c.table_id = t.table_id
   SET c.is_list = '0', c.is_query = '0', c.html_type = 'input'
 WHERE t.table_name = 'exam_model_config' AND c.column_name = 'api_key';

-- content：提示词很长，用多行文本框
UPDATE `gen_table_column` c JOIN `gen_table` t ON c.table_id = t.table_id
   SET c.html_type = 'textarea'
 WHERE t.table_name = 'exam_prompt' AND c.column_name = 'content';

-- is_default：复用已有的 exam_yes_no 字典（0否 / 1是），不用再建新字典
UPDATE `gen_table_column` c JOIN `gen_table` t ON c.table_id = t.table_id
   SET c.html_type = 'select', c.dict_type = 'exam_yes_no'
 WHERE t.table_name IN ('exam_model_config', 'exam_prompt')
   AND c.column_name = 'is_default';

-- ---------------------------------------------------------------------------
-- 【验证】
-- SELECT table_name, class_name, business_name, function_name,
--        function_author, package_name, module_name
--   FROM gen_table WHERE table_name IN ('exam_model_config', 'exam_prompt');
-- ============================================================================
