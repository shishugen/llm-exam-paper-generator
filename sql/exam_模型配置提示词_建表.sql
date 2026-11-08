-- ============================================================================
-- 模型配置 / 提示词 两张表 —— 建表脚本
-- 库：ry-vue     字符集：utf8mb4 / utf8mb4_general_ci
-- 执行：mysql -uroot ry-vue < exam_模型配置提示词_建表.sql
--
-- 【执行顺序】
--   1. 先跑本文件（建表 + 2 条默认数据）
--   2. 去「系统工具 → 代码生成」点「导入表」，勾选 exam_model_config、exam_prompt
--   3. 跑 exam_模型配置提示词_生成器配置.sql
--   4. 点「生成代码」，把产物放进工程
--   5. 菜单 SQL 和手写代码等代码生成完再补
--
-- ⚠️ 本文件只对这 2 张新表做 DROP，不动原有 8 张业务表。
-- ⚠️ 生成器下载包里自带的 menu.sql 不要执行，菜单统一由后面单独给。
-- ============================================================================

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------------
-- 1. 模型配置
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS `exam_model_config`;
CREATE TABLE `exam_model_config` (
  `id`           bigint       NOT NULL AUTO_INCREMENT              COMMENT '配置ID',
  `name`         varchar(50)  NOT NULL                            COMMENT '配置名称',
  `base_url`     varchar(200) NOT NULL                            COMMENT '接口地址（填到 /v1 为止）',
  `api_key`      varchar(200) DEFAULT ''                         COMMENT '密钥（存 AES 密文）',
  `model_name`   varchar(50)  NOT NULL                            COMMENT '模型名称',
  `is_default`   char(1)      NOT NULL DEFAULT '0'                COMMENT '是否启用（0否 1是）',
  `create_by`    varchar(64)  DEFAULT NULL                       COMMENT '创建者',
  `create_time`  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `update_by`    varchar(64)  DEFAULT NULL                       COMMENT '更新者',
  `update_time`  datetime     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='模型配置';

-- ---------------------------------------------------------------------------
-- 2. 提示词
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS `exam_prompt`;
CREATE TABLE `exam_prompt` (
  `id`           bigint      NOT NULL AUTO_INCREMENT              COMMENT '提示词ID',
  `name`         varchar(50) NOT NULL                           COMMENT '提示词名称',
  `content`      text        NOT NULL                           COMMENT '提示词内容',
  `is_default`   char(1)     NOT NULL DEFAULT '0'                COMMENT '是否启用（0否 1是）',
  `create_by`    varchar(64) DEFAULT NULL                       COMMENT '创建者',
  `create_time`  datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `update_by`    varchar(64) DEFAULT NULL                       COMMENT '更新者',
  `update_time`  datetime    DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='提示词';

-- ---------------------------------------------------------------------------
-- 3. 默认数据（2 条，缺了出题功能就没有配置可用）
-- ---------------------------------------------------------------------------

-- base_url 只到 /v1：OpenAI SDK 会自己拼上 /chat/completions，
-- 照旧填完整地址会变成重复路径。
-- ⚠️ api_key 故意留空：真实 Key 不能写进 SQL 文件（这个文件在 git 仓库里），
--    也不能直接插明文（后面代码会对它 AES 解密，明文会解不开）。
--    等页面生成好，去「模型配置」点修改，在「换 key」那个框里填一次即可。
INSERT INTO `exam_model_config`
  (`name`, `base_url`, `api_key`, `model_name`, `is_default`, `create_by`, `create_time`)
VALUES
  ('Agnes 演示', 'https://apihub.agnes-ai.com/v1', '', 'agnes-2.5-flash', '1', 'admin', NOW());

-- 提示词原文来自 AiUtil.PROMPT，只把 %s / %d 换成中文占位符。
-- 可用占位符：{知识点} {题量} {题型} {难度} {驳回原因}
INSERT INTO `exam_prompt`
  (`name`, `content`, `is_default`, `create_by`, `create_time`)
VALUES
('默认出题提示词', '你是高校命题助手。围绕知识点「{知识点}」，出 {题量} 道{题型}题，难度{难度}。{驳回原因}
只返回 JSON 数组，不要任何解释文字。每个元素格式：
{"stem":"题干","options":[{"key":"A","value":"选项内容"}],"answer":"正确答案","analysis":"解析","score":2}
注意：题干、选项、解析里一律不要使用英文双引号，需要强调时用《》或括号；文字中不要换行。', '1', 'admin', NOW());

-- ---------------------------------------------------------------------------
-- 【验证】
-- SELECT id, name, base_url, model_name, is_default FROM exam_model_config;
-- SELECT id, name, is_default FROM exam_prompt;
-- ============================================================================
