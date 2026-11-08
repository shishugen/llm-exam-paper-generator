-- ============================================================================
-- 基于大语言模型的试卷生成系统 —— 业务表建表脚本
-- 依据：系统设计_简化版.md  v2（2026-11-06）第四节「8 张业务表」
-- 库：ry-vue     字符集：utf8mb4 / utf8mb4_general_ci
-- MySQL 8+ 通用，已在 MySQL 9.6.0 实跑验证
--
-- 【执行方式】本机 root 空密码，命令行指定库，脚本里不写 USE：
--   mysql -uroot ry-vue < exam_业务建表.sql
-- 演示数据（可选）另见 exam_演示数据.sql，建完表再灌。
--
-- ⚠️ 本脚本含 DROP TABLE IF EXISTS，重复执行会清空 8 张业务表的全部数据。
--    开发调表结构阶段随便跑；正式录完演示数据后别再跑，重建前先备份。
--
-- ----------------------------------------------------------------------------
-- 【与 v2 文档的 5 处差异：都是为了少写代码、少踩若依的坑】
-- 1. 8 张表统一补若依基类字段 create_by / update_by / update_time
--    （文档只列了 create_time）。生成器识别后 domain 自动 extends
--    BaseEntity，新增/编辑表单不会冒出这些列，页面零改动。
--    create_time 给数据库默认值 CURRENT_TIMESTAMP —— 生成器产出的
--    insert 语句不写该列，也不会落成 NULL。
-- 2. exam_ai_call_log 补 cost（费用/元）。文档第二节要求「成本」统计，
--    但第四节字段清单漏了它，用 token × 单价折算后落这个字段。
-- 3. config_json / options 用 TEXT 而不是 MySQL 的 JSON 类型：
--    若依生成器会把 JSON 列映射成 Object，生成的实体与表单不好用；
--    TEXT 映射成 String，直接存 JSON 字符串即可。
-- 4. 分值（score / total_score）和考查权重 weight 用 INT 而非 DECIMAL：
--    Java 侧就是 Integer，组卷累加不用 BigDecimal，符合「写法从简」。
-- 5. 不建外键约束：若依生成器不处理外键，毕设演示又经常要批量导入、
--    清空数据。关联由应用层保证，E-R 图照画逻辑一对多即可。
--
-- 【字段取值约定 —— 写 AiUtil / PaperComposeUtil 时按这个解析】
--   type          1单选 2多选 3判断 4简答 5综合
--   difficulty    1容易 2中等 3较难 4困难
--   status 题目   0草稿 1待审 2已通过 3已驳回
--   status 试卷   0生成中 1已完成 2已导出
--   status 日志   0成功 1失败
--   source        0人工录入 1AI生成
--   locked        0未锁定 1锁定（单题替换时跳过）
--   options       JSON 字符串：[{"key":"A","value":"..."},...]，简答题为 NULL
--   answer        单选存 "A"，多选存 "A,C"，判断存 "对"/"错"，简答存文字
--   config_json   JSON 字符串，存四类组卷约束（总分/题型配比/难度分布/覆盖率）
--
-- 【表注释】按若依生成器习惯直接写成功能名（课程、章节、题库……），
--   导入代码生成后功能名、菜单名不用再改。
-- ============================================================================

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------------
-- 1. 课程
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS `exam_course`;
CREATE TABLE `exam_course` (
  `id`           bigint       NOT NULL AUTO_INCREMENT              COMMENT '课程ID',
  `course_name`  varchar(100) NOT NULL                            COMMENT '课程名称',
  `course_code`  varchar(50)  DEFAULT NULL                        COMMENT '课程代码',
  `remark`       varchar(500) DEFAULT NULL                        COMMENT '备注',
  `create_by`    varchar(64)  DEFAULT NULL                        COMMENT '创建者',
  `create_time`  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `update_by`    varchar(64)  DEFAULT NULL                        COMMENT '更新者',
  `update_time`  datetime     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_course_code` (`course_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='课程';

-- ---------------------------------------------------------------------------
-- 2. 章节（课程 1—N 章节）
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS `exam_chapter`;
CREATE TABLE `exam_chapter` (
  `id`          bigint       NOT NULL AUTO_INCREMENT              COMMENT '章节ID',
  `course_id`   bigint       NOT NULL                            COMMENT '所属课程ID',
  `name`        varchar(100) NOT NULL                            COMMENT '章节名称',
  `sort_no`     int          DEFAULT 0                           COMMENT '显示顺序',
  `create_by`   varchar(64)  DEFAULT NULL                        COMMENT '创建者',
  `create_time` datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `update_by`   varchar(64)  DEFAULT NULL                        COMMENT '更新者',
  `update_time` datetime     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_course_sort` (`course_id`, `sort_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='章节';

-- ---------------------------------------------------------------------------
-- 3. 知识点（章节 1—N 知识点，weight 是考查权重）
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS `exam_knowledge`;
CREATE TABLE `exam_knowledge` (
  `id`          bigint       NOT NULL AUTO_INCREMENT              COMMENT '知识点ID',
  `chapter_id`  bigint       NOT NULL                            COMMENT '所属章节ID',
  `name`        varchar(100) NOT NULL                            COMMENT '知识点名称',
  `weight`      int          DEFAULT 1                           COMMENT '考查权重（1-10，越大越重要）',
  `sort_no`     int          DEFAULT 0                           COMMENT '显示顺序',
  `create_by`   varchar(64)  DEFAULT NULL                        COMMENT '创建者',
  `create_time` datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `update_by`   varchar(64)  DEFAULT NULL                        COMMENT '更新者',
  `update_time` datetime     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_chapter_sort` (`chapter_id`, `sort_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='知识点';

-- ---------------------------------------------------------------------------
-- 4. 题库（题目主体：审核状态、驳回原因、审核人都在这张表，不拆表）
--    idx_stem 前缀索引服务于「题干精确比对去重」：SELECT count(*) WHERE stem = ?
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS `exam_question`;
CREATE TABLE `exam_question` (
  `id`            bigint       NOT NULL AUTO_INCREMENT              COMMENT '题目ID',
  `course_id`     bigint       NOT NULL                            COMMENT '所属课程ID',
  `chapter_id`    bigint       DEFAULT NULL                        COMMENT '所属章节ID',
  `knowledge_id`  bigint       DEFAULT NULL                        COMMENT '所属知识点ID',
  `type`          char(1)      NOT NULL DEFAULT '1'                COMMENT '题型（1单选 2多选 3判断 4简答 5综合）',
  `difficulty`    char(1)      NOT NULL DEFAULT '2'                COMMENT '难度（1容易 2中等 3较难 4困难）',
  `stem`          text         NOT NULL                            COMMENT '题干',
  `options`       text                                             COMMENT '选项JSON，简答题/判断题为NULL',
  `answer`        text                                             COMMENT '参考答案',
  `analysis`      text                                             COMMENT '试题解析',
  `score`         int          NOT NULL DEFAULT 2                  COMMENT '建议分值（分）',
  `status`        char(1)      NOT NULL DEFAULT '0'                COMMENT '状态（0草稿 1待审 2已通过 3已驳回）',
  `source`        char(1)      NOT NULL DEFAULT '0'                COMMENT '来源（0人工录入 1AI生成）',
  `reject_reason` varchar(500) DEFAULT NULL                        COMMENT '驳回原因（下次生成时拼进Prompt开头）',
  `reviewer_id`   bigint       DEFAULT NULL                        COMMENT '审核人ID（sys_user.user_id）',
  `review_time`   datetime     DEFAULT NULL                        COMMENT '审核时间',
  `create_by`     varchar(64)  DEFAULT NULL                        COMMENT '创建者',
  `create_time`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `update_by`     varchar(64)  DEFAULT NULL                        COMMENT '更新者',
  `update_time`   datetime     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_filter` (`status`, `type`, `difficulty`),
  KEY `idx_knowledge` (`knowledge_id`),
  KEY `idx_course` (`course_id`),
  KEY `idx_chapter` (`chapter_id`),
  KEY `idx_stem` (`stem`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='题库';

-- ---------------------------------------------------------------------------
-- 5. 审核记录（题目 1—N 审核留痕）
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS `exam_review_log`;
CREATE TABLE `exam_review_log` (
  `id`          bigint       NOT NULL AUTO_INCREMENT              COMMENT '记录ID',
  `question_id` bigint       NOT NULL                            COMMENT '题目ID',
  `action`      char(1)      NOT NULL                            COMMENT '操作（1提交待审 2审核通过 3审核驳回）',
  `reason`      varchar(500) DEFAULT NULL                        COMMENT '操作说明/驳回原因',
  `reviewer_id` bigint       DEFAULT NULL                        COMMENT '操作人ID（sys_user.user_id）',
  `create_by`   varchar(64)  DEFAULT NULL                        COMMENT '创建者',
  `create_time` datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `update_by`   varchar(64)  DEFAULT NULL                        COMMENT '更新者',
  `update_time` datetime     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='题目审核记录';

-- ---------------------------------------------------------------------------
-- 6. 试卷（config_json 存四类组卷约束）
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS `exam_paper`;
CREATE TABLE `exam_paper` (
  `id`          bigint       NOT NULL AUTO_INCREMENT              COMMENT '试卷ID',
  `course_id`   bigint       NOT NULL                            COMMENT '所属课程ID',
  `title`       varchar(200) NOT NULL                            COMMENT '试卷名称',
  `total_score` int          NOT NULL DEFAULT 100                COMMENT '试卷总分（分）',
  `config_json` text                                             COMMENT '组卷配置JSON：总分/题型配比/难度分布/知识点覆盖率',
  `status`      char(1)      NOT NULL DEFAULT '1'                COMMENT '状态（0生成中 1已完成 2已导出）',
  `create_by`   varchar(64)  DEFAULT NULL                        COMMENT '创建者',
  `create_time` datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `update_by`   varchar(64)  DEFAULT NULL                        COMMENT '更新者',
  `update_time` datetime     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='试卷';

-- ---------------------------------------------------------------------------
-- 7. 试卷明细（试卷 1—N 明细，locked 控制单题替换时跳过）
--    score 是组卷时分配的分值，允许与 exam_question.score 建议分值不同。
--    唯一索引防止同一道题被重复抽进同一张卷。
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS `exam_paper_question`;
CREATE TABLE `exam_paper_question` (
  `id`          bigint   NOT NULL AUTO_INCREMENT                  COMMENT '明细ID',
  `paper_id`    bigint   NOT NULL                                COMMENT '试卷ID',
  `question_id` bigint   NOT NULL                                COMMENT '题目ID',
  `sort_no`     int      DEFAULT 0                               COMMENT '题号顺序',
  `score`       int      NOT NULL DEFAULT 0                      COMMENT '本卷中该题分值（分）',
  `locked`      char(1)  NOT NULL DEFAULT '0'                    COMMENT '是否锁定（0否 1是，替换时跳过）',
  `create_by`   varchar(64)  DEFAULT NULL                        COMMENT '创建者',
  `create_time` datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `update_by`   varchar(64)  DEFAULT NULL                        COMMENT '更新者',
  `update_time` datetime     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_paper_question` (`paper_id`, `question_id`),
  KEY `idx_paper_id` (`paper_id`),
  KEY `idx_question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='试卷明细';

-- ---------------------------------------------------------------------------
-- 8. 大模型调用日志（统计页的数据来源，独立表，不关联其它业务表）
--    task_type 1=AI出题 2=重新生成；cost 按 token × 单价折算，单位元。
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS `exam_ai_call_log`;
CREATE TABLE `exam_ai_call_log` (
  `id`                bigint        NOT NULL AUTO_INCREMENT              COMMENT '日志ID',
  `task_type`         char(1)       DEFAULT '1'                          COMMENT '任务类型（1AI出题 2重新生成）',
  `model`             varchar(100)  DEFAULT NULL                        COMMENT '调用的模型名称',
  `prompt_tokens`     int           DEFAULT 0                           COMMENT '输入token数',
  `completion_tokens` int           DEFAULT 0                           COMMENT '输出token数',
  `duration_ms`       bigint        DEFAULT 0                           COMMENT '耗时（毫秒）',
  `cost`              decimal(10,4) DEFAULT 0.0000                     COMMENT '本次费用（元）',
  `status`            char(1)       DEFAULT '0'                         COMMENT '状态（0成功 1失败）',
  `error_msg`         varchar(500)  DEFAULT NULL                        COMMENT '失败原因',
  `create_by`         varchar(64)   DEFAULT NULL                        COMMENT '创建者',
  `create_time`       datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '调用时间',
  `update_by`         varchar(64)   DEFAULT NULL                        COMMENT '更新者',
  `update_time`       datetime      DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_create_time` (`create_time`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='大模型调用日志';

-- ============================================================================
-- 【附】下面这些是设计文档第七节的核心查询，复制进 Mapper XML 即可用。
--      全部注释掉，不随建表脚本执行。
-- ----------------------------------------------------------------------------
-- ① 题干精确比对去重（AiUtil 入库前判重）
-- SELECT COUNT(*) FROM exam_question WHERE stem = #{stem};
--
-- ② 题库多维筛选（生成器出的 list 里加 4 个 <if>）
-- SELECT * FROM exam_question
--  WHERE status = #{status}
--    AND type = #{type}
--    AND difficulty = #{difficulty}
--    AND knowledge_id = #{knowledgeId};
--
-- ③ 组卷按题型/难度随机抽题（只抽已审核通过的题）
-- SELECT * FROM exam_question
--  WHERE type = #{type} AND difficulty = #{difficulty} AND status = '2'
--    AND knowledge_id IN (SELECT id FROM exam_knowledge WHERE chapter_id = #{chapterId})
--  ORDER BY RAND() LIMIT #{count};
--
-- ④ 知识点覆盖率（抽完统计展示，不做硬约束）
-- SELECT COUNT(DISTINCT q.knowledge_id) AS covered,
--        (SELECT COUNT(*) FROM exam_knowledge) AS total
--   FROM exam_paper_question pq
--   JOIN exam_question q ON q.id = pq.question_id
--  WHERE pq.paper_id = #{paperId};
--
-- ⑤ 单题替换（跳过锁定题，删明细后按同条件重抽）
-- DELETE FROM exam_paper_question
--  WHERE paper_id = #{paperId} AND question_id = #{questionId} AND locked = '0';
--
-- ⑥ 调用统计页四个数字 + 成功率
-- SELECT COUNT(*)                                        AS total_calls,
--        SUM(prompt_tokens + completion_tokens)         AS total_tokens,
--        AVG(duration_ms)                               AS avg_duration,
--        SUM(cost)                                      AS total_cost,
--        SUM(status = '0')                              AS success_calls,
--        CONCAT(ROUND(SUM(status = '0') / COUNT(*) * 100, 1), '%') AS success_rate
--   FROM exam_ai_call_log;
-- 注：文档里写的 SUM(status=0) 在 MySQL 中是布尔表达式求和，与 SUM(status='0') 等价。
--
-- ⑦ 试卷导出（试题卷 / 答案卷分离，答案卷从 answer + analysis 取）
-- SELECT q.stem, q.options, q.answer, q.analysis, pq.score, pq.sort_no
--   FROM exam_paper_question pq
--   JOIN exam_question q ON q.id = pq.question_id
--  WHERE pq.paper_id = #{paperId}
--  ORDER BY pq.sort_no;
-- ============================================================================
