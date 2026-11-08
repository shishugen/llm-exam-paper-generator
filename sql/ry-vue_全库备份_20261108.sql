-- MySQL dump 10.13  Distrib 9.6.0, for macos15.7 (arm64)
--
-- Host: localhost    Database: ry-vue
-- ------------------------------------------------------
-- Server version	9.6.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `exam_ai_call_log`
--

DROP TABLE IF EXISTS `exam_ai_call_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_ai_call_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `task_type` char(1) COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '任务类型（1AI出题 2重新生成）',
  `model` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '调用的模型名称',
  `prompt_tokens` int DEFAULT '0' COMMENT '输入token数',
  `completion_tokens` int DEFAULT '0' COMMENT '输出token数',
  `duration_ms` bigint DEFAULT '0' COMMENT '耗时（毫秒）',
  `cost` decimal(10,4) DEFAULT '0.0000' COMMENT '本次费用（元）',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0成功 1失败）',
  `error_msg` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '失败原因',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '调用时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_create_time` (`create_time`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='大模型调用日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_ai_call_log`
--

LOCK TABLES `exam_ai_call_log` WRITE;
/*!40000 ALTER TABLE `exam_ai_call_log` DISABLE KEYS */;
INSERT INTO `exam_ai_call_log` VALUES (1,'1','gpt-4o-mini',420,780,2310,0.0180,'0',NULL,NULL,'2026-11-06 15:02:11',NULL,NULL),(2,'1','gpt-4o-mini',435,812,2544,0.0192,'0',NULL,NULL,'2026-11-06 15:18:36',NULL,NULL),(3,'1','gpt-4o-mini',410,0,30012,0.0035,'1','Read timed out after 30000 ms，已提示用户重新生成',NULL,'2026-11-06 16:05:44',NULL,NULL),(4,'2','gpt-4o-mini',468,806,2103,0.0198,'0',NULL,NULL,'2026-11-07 09:28:52',NULL,NULL),(6,'1','mock(离线演示)',120,270,6,0.0059,'0',NULL,NULL,'2026-11-07 11:38:03',NULL,NULL),(7,'1','mock(离线演示)',120,180,4,0.0045,'0',NULL,NULL,'2026-11-07 12:49:03',NULL,NULL),(8,'1','mock(离线演示)',120,90,0,0.0032,'0',NULL,NULL,'2026-11-07 12:50:11',NULL,NULL),(9,'1','mock(离线演示)',120,180,5,0.0045,'0',NULL,NULL,'2026-11-07 12:58:30',NULL,NULL),(10,'1','mock(离线演示)',120,90,0,0.0032,'0',NULL,NULL,'2026-11-07 12:58:30',NULL,NULL),(11,'1','mock(离线演示)',120,180,0,0.0045,'0',NULL,NULL,'2026-11-07 12:59:07',NULL,NULL),(12,'1','mock(离线演示)',120,90,0,0.0032,'0',NULL,NULL,'2026-11-07 12:59:07',NULL,NULL),(13,'1','mock(离线演示)',120,270,0,0.0059,'0',NULL,NULL,'2026-11-07 13:04:25',NULL,NULL),(14,'1','mock(离线演示)',120,270,2,0.0059,'0',NULL,NULL,'2026-11-07 13:04:48',NULL,NULL),(15,'1','mock(离线演示)',120,270,1,0.0059,'0',NULL,NULL,'2026-11-07 13:04:54',NULL,NULL),(16,'1','mock(离线演示)',120,270,0,0.0059,'0',NULL,NULL,'2026-11-07 13:04:59',NULL,NULL),(17,'1','mock(离线演示)',120,270,1,0.0059,'0',NULL,NULL,'2026-11-07 13:07:05',NULL,NULL),(18,'1','mock(离线演示)',120,270,1,0.0059,'0',NULL,NULL,'2026-11-07 13:10:20',NULL,NULL),(19,'1','mock(离线演示)',120,270,1,0.0059,'0',NULL,NULL,'2026-11-07 13:10:33',NULL,NULL),(20,'1','mock(离线演示)',120,270,1,0.0059,'0',NULL,NULL,'2026-11-07 13:10:36',NULL,NULL),(21,'1','mock(离线演示)',120,270,0,0.0059,'0',NULL,NULL,'2026-11-07 13:10:37',NULL,NULL),(22,'1','agnes-2.5-flash',361,486,14515,0.0127,'0',NULL,NULL,'2026-11-07 13:12:06',NULL,NULL),(23,'1','agnes-2.5-flash',362,836,20985,0.0180,'1','offset 531, character 选, line 23, column 130, fastjson-version 2.0.64\n[\n  {\n    \"stem\": \"在E-R图中，用矩形表示实体，用菱形表示联系，用椭圆表示属性。下列关于E-R图元素的说法正确的是：\",\n    \"options\": [\n      {\n        \"key\": \"A\",\n        \"value\": \"一个实体只能用单一属性来描述\"\n      },\n      {\n        \"key\": \"B\",\n        \"value\": \"联系的类型可以是1:1、1:n或m:n\"\n      },\n      {\n        \"key\": \"C\",\n        \"value\": \"椭圆只能与矩形相连，不能与菱形相连\"\n      },\n      {\n        \"key\": \"D\",\n        \"value\": \"菱形不能拥有自己的属性\"\n      }\n    ],\n    \"answer\": \"B\",\n    \"ana',NULL,'2026-11-07 13:12:10',NULL,NULL),(24,'1','agnes-2.5-flash',362,759,16892,0.0168,'1','offset 36, character 多, line 3, column 31, fastjson-version 2.0.64\n[\n  {\n    \"stem\": \"在E-R图中，用于表示实体之间\"多对多\"联系的图形元素是（　　）\",\n    \"options\": [\n      {\"key\": \"A\", \"value\": \"矩形\"},\n      {\"key\": \"B\", \"value\": \"椭圆形\"},\n      {\"key\": \"C\", \"value\": \"菱形\"},\n      {\"key\": \"D\", \"value\": \"连接线\"}\n    ],\n    \"answer\": \"C\",\n    \"analysis\": \"E-R图用矩形表示实体集，用椭圆形表示属性，用菱形表示联系集，连接线用于连接实体集、属性集和联系集。联系集本身用菱形表示，而非用连接线区分联系类型。\",\n    \"score\": 2\n  },\n  {\n    \"stem\": \"某高校数据库中，学生实体与课程实体之间存在\"选课\"联系，每个学生可选多门课程，每门课程可',NULL,'2026-11-07 13:12:21',NULL,NULL),(25,'1','agnes-2.5-flash',362,633,23589,0.0149,'1','offset 36, character 多, line 3, column 31, fastjson-version 2.0.64\n[\n  {\n    \"stem\": \"在E-R图中，用于表示实体之间\"多对多\"（M:N）关系的图形符号是：\",\n    \"options\": [\n      {\"key\": \"A\", \"value\": \"矩形\"},\n      {\"key\": \"B\", \"value\": \"菱形\"},\n      {\"key\": \"C\", \"value\": \"椭圆\"},\n      {\"key\": \"D\", \"value\": \"平行四边形\"}\n    ],\n    \"answer\": \"B\",\n    \"analysis\": \"E-R图用矩形表示实体，菱形表示联系，椭圆表示属性。多对多关系通过菱形与相连实体间的连线标注M和N来表示，菱形本身是联系符号，与实体类型无关。\",\n    \"score\": 2\n  },\n  {\n    \"stem\": \"下列有关E-R图向关系模型转换的描述中，正确的是：\",\n    \"options\": [',NULL,'2026-11-07 13:12:52',NULL,NULL),(26,'1','agnes-2.5-flash',361,745,13676,0.0166,'1','offset 465, character 逻, line 15, column 24, fastjson-version 2.0.64\n[\n  {\n    \"stem\": \"数据库系统（DBS）与文件系统相比，最核心的优势在于：\",\n    \"options\": [\n      {\"key\": \"A\", \"value\": \"数据存储量更大\"},\n      {\"key\": \"B\", \"value\": \"实现了数据的结构化组织与共享，减少了数据冗余\"},\n      {\"key\": \"C\", \"value\": \"不需要专门的软件管理数据\"},\n      {\"key\": \"D\", \"value\": \"数据完全独立于应用程序，不存在耦合\"}\n    ],\n    \"answer\": \"B\",\n    \"analysis\": \"数据库系统与文件系统的核心区别在于DBS通过DBMS实现了数据的结构化组织、统一管理和共享，显著减少了数据冗余，并提高了数据的一致性。选项A不是核心优势；选项C错误，DBS需要DBMS；选项D过于绝对，数据与程序之间仍有一定耦',NULL,'2026-11-07 13:13:12',NULL,NULL),(27,'1','agnes-2.5-flash',361,628,17539,0.0148,'0',NULL,NULL,'2026-11-07 13:13:33',NULL,NULL),(28,'1','agnes-2.5-flash',392,860,15146,0.0188,'0',NULL,NULL,'2026-11-07 13:17:43',NULL,NULL),(29,'1','agnes-2.5-flash',393,667,18244,0.0159,'0',NULL,NULL,'2026-11-07 13:18:01',NULL,NULL),(30,'1','agnes-2.5-flash',392,784,17634,0.0176,'0',NULL,NULL,'2026-11-07 13:18:18',NULL,NULL),(31,'1','agnes-2.5-flash',392,806,19397,0.0180,'0',NULL,NULL,'2026-11-07 13:19:01',NULL,NULL),(32,'1','agnes-2.5-flash',393,1308,56326,0.0255,'0',NULL,NULL,'2026-11-07 13:19:15',NULL,NULL),(33,'1','agnes-2.5-flash',390,679,15916,0.0160,'0',NULL,NULL,'2026-11-07 13:19:31',NULL,NULL),(34,'1','agnes-2.5-flash',393,558,14784,0.0143,'0',NULL,NULL,'2026-11-07 13:19:46',NULL,NULL),(35,'1','agnes-2.5-flash',392,778,12896,0.0176,'0',NULL,NULL,'2026-11-07 13:20:32',NULL,NULL),(36,'1','agnes-2.5-flash',392,667,13367,0.0159,'0',NULL,NULL,'2026-11-07 13:21:14',NULL,NULL),(37,'1','agnes-2.5-flash',392,728,19102,0.0168,'0',NULL,NULL,'2026-11-07 13:21:40',NULL,NULL),(38,'1','agnes-2.5-flash',391,943,22591,0.0200,'0',NULL,NULL,'2026-11-07 13:23:34',NULL,NULL),(39,'1','agnes-2.5-flash',392,450,15889,0.0126,'0',NULL,NULL,'2026-11-07 13:23:44',NULL,NULL),(40,'1','agnes-2.5-flash',390,900,19308,0.0194,'0',NULL,NULL,'2026-11-07 13:24:35',NULL,NULL),(41,'1','agnes-2.5-flash',0,0,61400,0.0000,'1','I/O error on POST request for \"https://apihub.agnes-ai.com/v1/chat/completions\": Unexpected end of file from server',NULL,'2026-11-07 21:52:57',NULL,NULL),(42,'1','agnes-2.5-flash',392,4096,30640,0.0673,'1','Cannot invoke \"java.util.List.iterator()\" because the return value of \"com.alibaba.fastjson2.JSON.parseArray(String, java.lang.Class)\" is null',NULL,'2026-11-07 21:53:33',NULL,NULL),(43,'1','agnes-2.5-flash',392,342,3442,0.0110,'0',NULL,NULL,'2026-11-07 21:53:53',NULL,NULL),(44,'1','agnes-2.5-flash',392,831,7497,0.0183,'0',NULL,NULL,'2026-11-07 22:02:11',NULL,NULL),(45,'1','agnes-2.5-flash',0,0,60762,0.0000,'1','I/O error on POST request for \"https://apihub.agnes-ai.com/v1/chat/completions\": Unexpected end of file from server',NULL,'2026-11-07 22:16:48',NULL,NULL),(46,'1','agnes-2.5-flash',392,168,5949,0.0084,'0',NULL,NULL,'2026-11-07 22:17:04',NULL,NULL),(47,'1','agnes-2.5-flash',392,514,5349,0.0136,'0',NULL,NULL,'2026-11-08 10:09:24',NULL,NULL),(48,'1','agnes-2.5-flash',392,976,8687,0.0205,'0',NULL,NULL,'2026-11-08 11:51:14',NULL,NULL),(49,'1','agnes-2.5-flash',392,827,12301,0.0183,'0',NULL,NULL,'2026-11-08 13:14:22',NULL,NULL),(50,'1','gpt-4o-mini',0,0,69,0.0000,'1','URI is not absolute',NULL,'2026-11-08 13:22:17',NULL,NULL),(51,'1','gpt-4o-mini',0,0,84,0.0000,'1','URI is not absolute',NULL,'2026-11-08 13:23:09',NULL,NULL),(52,'1','gpt-4o-mini',0,0,3,0.0000,'1','URI is not absolute',NULL,'2026-11-08 13:24:35',NULL,NULL),(53,'1','agnes-2.5-flash',0,0,12,0.0000,'0',NULL,NULL,'2026-11-08 13:28:58',NULL,NULL),(54,'1','agnes-2.5-flash',0,0,11,0.0000,'0',NULL,NULL,'2026-11-08 13:30:05',NULL,NULL),(55,'1','agnes-2.5-flash',0,0,14,0.0000,'0',NULL,NULL,'2026-11-08 13:32:17',NULL,NULL),(56,'1','agnes-2.5-flash',0,0,5,0.0000,'0',NULL,NULL,'2026-11-08 13:33:26',NULL,NULL),(57,'1','agnes-2.5-flash',0,0,16,0.0000,'0',NULL,NULL,'2026-11-08 13:33:44',NULL,NULL),(58,'1','agnes-2.5-flash',393,628,12236,0.0153,'0',NULL,NULL,'2026-11-08 13:36:05',NULL,NULL),(59,'1','agnes-2.5-flash',393,711,7568,0.0166,'1','offset 794, character 无, line 1, column 794, fastjson-version 2.0.64 [{\"stem\":\"以下关于数据库系统基本概念的叙述，正确的是哪一项？\",\"options\":[{\"key\":\"A\",\"value\":\"数据库就是保存在磁盘上的若干文件的集合，和文件系统没有本质区别\"},{\"key\":\"B\",\"value\":\"数据库是长期存储在计算机内、有组织的、可共享的大量数据的集合，按一定的数据结构组织数据并提供访问接口\"},{\"key\":\"C\",\"value\":\"数据库只能存储数字和表格数据，不能存储文本、图像等非结构化信息\"},{\"key\":\"D\",\"value\":\"数据库系统的核心任务是编写程序代码来替代人工操作\"}],\"answer\":\"B\",\"analysis\":\"数据库是长期存储在计算机内、有组织的、可共享的数据集合，按特定数据结构组织数据并可为多种应用提供服务。A项混淆了数据库与文件系统的区别；C项说法错误，现代数据库可以存储多媒体等非结构化数据；D项描述不准确，数据库系统的',NULL,'2026-11-08 13:39:10',NULL,NULL),(60,'1','agnes-2.5-flash',393,831,13399,0.0184,'0',NULL,NULL,'2026-11-08 13:39:28',NULL,NULL),(61,'1','agnes-2.5-flash',393,444,5099,0.0126,'0',NULL,NULL,'2026-11-08 13:41:27',NULL,NULL),(62,'1','agnes-2.5-flash',394,676,14926,0.0161,'0',NULL,NULL,'2026-11-08 13:56:05',NULL,NULL),(63,'1','agnes-2.5-flash',0,0,16,0.0000,'0',NULL,NULL,'2026-11-08 16:26:45',NULL,NULL),(64,'1','agnes-2.5-flash',0,0,8,0.0000,'0',NULL,NULL,'2026-11-08 16:26:47',NULL,NULL),(65,'1','agnes-2.5-flash',0,0,18,0.0000,'0',NULL,NULL,'2026-11-08 16:27:20',NULL,NULL),(66,'1','agnes-2.5-flash',0,0,13,0.0000,'0',NULL,NULL,'2026-11-08 16:34:10',NULL,NULL),(67,'1','agnes-2.5-flash',0,0,12,0.0000,'0',NULL,NULL,'2026-11-08 16:46:43',NULL,NULL),(68,'1','agnes-2.5-flash',0,0,12,0.0000,'0',NULL,NULL,'2026-11-08 16:46:44',NULL,NULL),(69,'1','agnes-2.5-flash',0,0,19,0.0000,'0',NULL,NULL,'2026-11-08 16:46:59',NULL,NULL),(70,'1','agnes-2.5-flash',393,817,16421,0.0182,'0',NULL,NULL,'2026-11-08 16:52:56',NULL,NULL);
/*!40000 ALTER TABLE `exam_ai_call_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_chapter`
--

DROP TABLE IF EXISTS `exam_chapter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_chapter` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '章节ID',
  `course_id` bigint NOT NULL COMMENT '所属课程ID',
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '章节名称',
  `sort_no` int DEFAULT '0' COMMENT '显示顺序',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_course_sort` (`course_id`,`sort_no`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='章节';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_chapter`
--

LOCK TABLES `exam_chapter` WRITE;
/*!40000 ALTER TABLE `exam_chapter` DISABLE KEYS */;
INSERT INTO `exam_chapter` VALUES (1,1,'第一章 数据库系统概述',1,NULL,'2026-11-07 10:31:01',NULL,NULL),(2,1,'第二章 关系模型与关系代数',2,NULL,'2026-11-07 10:31:01',NULL,NULL),(3,1,'第三章 结构化查询语言 SQL',3,NULL,'2026-11-07 10:31:01',NULL,NULL),(4,1,'第四章 关系数据库设计理论',4,NULL,'2026-11-07 10:31:01',NULL,NULL),(5,1,'第五章 数据库设计',5,NULL,'2026-11-07 10:31:01',NULL,NULL),(6,1,'第六章 事务与并发控制',6,NULL,'2026-11-07 10:31:01',NULL,NULL),(7,1,'第七章 数据库恢复技术',7,NULL,'2026-11-07 10:31:01',NULL,NULL),(8,1,'第八章 数据库安全与新技术',8,NULL,'2026-11-07 10:31:01',NULL,NULL);
/*!40000 ALTER TABLE `exam_chapter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_course`
--

DROP TABLE IF EXISTS `exam_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_course` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '课程ID',
  `course_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '课程名称',
  `course_code` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '课程代码',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_course_code` (`course_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='课程';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_course`
--

LOCK TABLES `exam_course` WRITE;
/*!40000 ALTER TABLE `exam_course` DISABLE KEYS */;
INSERT INTO `exam_course` VALUES (1,'数据库原理','DB301','本科必修课，每周 4 学时，期末闭卷考试',NULL,'2026-11-07 10:31:01',NULL,'2026-11-08 17:07:58');
/*!40000 ALTER TABLE `exam_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_knowledge`
--

DROP TABLE IF EXISTS `exam_knowledge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_knowledge` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '知识点ID',
  `chapter_id` bigint NOT NULL COMMENT '所属章节ID',
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '知识点名称',
  `weight` int DEFAULT '1' COMMENT '考查权重（1-10，越大越重要）',
  `sort_no` int DEFAULT '0' COMMENT '显示顺序',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_chapter_sort` (`chapter_id`,`sort_no`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='知识点';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_knowledge`
--

LOCK TABLES `exam_knowledge` WRITE;
/*!40000 ALTER TABLE `exam_knowledge` DISABLE KEYS */;
INSERT INTO `exam_knowledge` VALUES (1,1,'数据库与数据管理的基本概念',5,1,NULL,'2026-11-07 10:31:01',NULL,NULL),(2,1,'数据模型的三要素',4,2,NULL,'2026-11-07 10:31:01',NULL,NULL),(3,1,'概念模型与 E-R 图',5,3,NULL,'2026-11-07 10:31:01',NULL,NULL),(4,1,'层次模型与网状模型',2,4,NULL,'2026-11-07 10:31:01',NULL,NULL),(5,1,'关系模型概述',5,5,NULL,'2026-11-07 10:31:01',NULL,NULL),(6,1,'数据库三级模式结构',5,6,NULL,'2026-11-07 10:31:01',NULL,NULL),(7,1,'两级映像与数据独立性',5,7,NULL,'2026-11-07 10:31:01',NULL,NULL),(8,1,'数据库管理系统的主要功能',3,8,NULL,'2026-11-07 10:31:01',NULL,NULL),(9,2,'关系、元组与属性',4,1,NULL,'2026-11-07 10:31:01',NULL,NULL),(10,2,'关系模式与关系数据库',4,2,NULL,'2026-11-07 10:31:01',NULL,NULL),(11,2,'候选码、主码与外码',5,3,NULL,'2026-11-07 10:31:01',NULL,NULL),(12,2,'关系的三类完整性约束',5,4,NULL,'2026-11-07 10:31:01',NULL,NULL),(13,2,'实体完整性规则',4,5,NULL,'2026-11-07 10:31:01',NULL,NULL),(14,2,'参照完整性规则',5,6,NULL,'2026-11-07 10:31:01',NULL,NULL),(15,2,'用户定义的完整性',3,7,NULL,'2026-11-07 10:31:01',NULL,NULL),(16,2,'关系代数：选择、投影与连接',5,8,NULL,'2026-11-07 10:31:01',NULL,NULL),(17,3,'SQL 的特点与组成',3,1,NULL,'2026-11-07 10:31:01',NULL,NULL),(18,3,'数据定义 CREATE 与 ALTER',4,2,NULL,'2026-11-07 10:31:01',NULL,NULL),(19,3,'单表查询与 WHERE 条件',5,3,NULL,'2026-11-07 10:31:01',NULL,NULL),(20,3,'聚集函数与 GROUP BY',5,4,NULL,'2026-11-07 10:31:01',NULL,NULL),(21,3,'连接查询与自身连接',5,5,NULL,'2026-11-07 10:31:01',NULL,NULL),(22,3,'嵌套查询与 EXISTS',4,6,NULL,'2026-11-07 10:31:01',NULL,NULL),(23,3,'数据更新 INSERT/UPDATE/DELETE',4,7,NULL,'2026-11-07 10:31:01',NULL,NULL),(24,3,'视图的定义与作用',3,8,NULL,'2026-11-07 10:31:01',NULL,NULL),(25,4,'函数依赖的概念',5,1,NULL,'2026-11-07 10:31:01',NULL,NULL),(26,4,'完全函数依赖与部分函数依赖',4,2,NULL,'2026-11-07 10:31:01',NULL,NULL),(27,4,'传递函数依赖',4,3,NULL,'2026-11-07 10:31:01',NULL,NULL),(28,4,'第一范式 1NF',4,4,NULL,'2026-11-07 10:31:01',NULL,NULL),(29,4,'第二范式 2NF',5,5,NULL,'2026-11-07 10:31:01',NULL,NULL),(30,4,'第三范式 3NF',5,6,NULL,'2026-11-07 10:31:01',NULL,NULL),(31,4,'BC 范式 BCNF',3,7,NULL,'2026-11-07 10:31:01',NULL,NULL),(32,4,'模式分解与无损连接性',4,8,NULL,'2026-11-07 10:31:01',NULL,NULL),(33,5,'需求分析',3,1,NULL,'2026-11-07 10:31:01',NULL,NULL),(34,5,'概念结构设计',5,2,NULL,'2026-11-07 10:31:01',NULL,NULL),(35,5,'E-R 图的设计方法',5,3,NULL,'2026-11-07 10:31:01',NULL,NULL),(36,5,'E-R 图冲突与合并',3,4,NULL,'2026-11-07 10:31:01',NULL,NULL),(37,5,'逻辑结构设计',5,5,NULL,'2026-11-07 10:31:01',NULL,NULL),(38,5,'E-R 图向关系模式转换',5,6,NULL,'2026-11-07 10:31:01',NULL,NULL),(39,5,'物理结构设计',3,7,NULL,'2026-11-07 10:31:01',NULL,NULL),(40,5,'数据库实施、运行与维护',2,8,NULL,'2026-11-07 10:31:01',NULL,NULL),(41,6,'事务的概念与特性',5,1,NULL,'2026-11-07 10:31:01',NULL,NULL),(42,6,'ACID：原子性与一致性',4,2,NULL,'2026-11-07 10:31:01',NULL,NULL),(43,6,'ACID：隔离性与持久性',4,3,NULL,'2026-11-07 10:31:01',NULL,NULL),(44,6,'并发操作带来的三类问题',5,4,NULL,'2026-11-07 10:31:01',NULL,NULL),(45,6,'丢失修改与不可重复读',4,5,NULL,'2026-11-07 10:31:01',NULL,NULL),(46,6,'读脏数据',3,6,NULL,'2026-11-07 10:31:01',NULL,NULL),(47,6,'封锁与三级封锁协议',5,7,NULL,'2026-11-07 10:31:01',NULL,NULL),(48,6,'两段锁协议与死锁',4,8,NULL,'2026-11-07 10:31:01',NULL,NULL),(49,7,'故障的种类',3,1,NULL,'2026-11-07 10:31:01',NULL,NULL),(50,7,'数据转储：静态与动态',3,2,NULL,'2026-11-07 10:31:01',NULL,NULL),(51,7,'海量转储与增量转储',2,3,NULL,'2026-11-07 10:31:01',NULL,NULL),(52,7,'日志文件的内容与作用',5,4,NULL,'2026-11-07 10:31:01',NULL,NULL),(53,7,'登记日志文件的原则',4,5,NULL,'2026-11-07 10:31:01',NULL,NULL),(54,7,'UNDO 与 REDO 操作',5,6,NULL,'2026-11-07 10:31:01',NULL,NULL),(55,7,'检查点技术',3,7,NULL,'2026-11-07 10:31:01',NULL,NULL),(56,7,'数据库恢复策略',4,8,NULL,'2026-11-07 10:31:01',NULL,NULL),(57,8,'数据库安全性概述',3,1,NULL,'2026-11-07 10:31:01',NULL,NULL),(58,8,'用户标识与鉴别',3,2,NULL,'2026-11-07 10:31:01',NULL,NULL),(59,8,'自主存取控制 DAC',4,3,NULL,'2026-11-07 10:31:01',NULL,NULL),(60,8,'强制存取控制 MAC',3,4,NULL,'2026-11-07 10:31:01',NULL,NULL),(61,8,'视图机制与审计',3,5,NULL,'2026-11-07 10:31:01',NULL,NULL),(62,8,'数据加密',2,6,NULL,'2026-11-07 10:31:01',NULL,NULL),(63,8,'分布式数据库与 NoSQL 概述',2,7,NULL,'2026-11-07 10:31:01',NULL,NULL);
/*!40000 ALTER TABLE `exam_knowledge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_paper`
--

DROP TABLE IF EXISTS `exam_paper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_paper` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '试卷ID',
  `course_id` bigint NOT NULL COMMENT '所属课程ID',
  `title` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '试卷名称',
  `total_score` int NOT NULL DEFAULT '100' COMMENT '试卷总分（分）',
  `config_json` text COLLATE utf8mb4_general_ci COMMENT '组卷配置JSON：总分/题型配比/难度分布/知识点覆盖率',
  `status` char(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '状态（0生成中 1已完成 2已导出）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_course_id` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='试卷';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_paper`
--

LOCK TABLES `exam_paper` WRITE;
/*!40000 ALTER TABLE `exam_paper` DISABLE KEYS */;
INSERT INTO `exam_paper` VALUES (1,1,'数据库原理 期末测验（A 卷·演示）',100,'{\"totalScore\":100,\"typeRatio\":{\"1\":6,\"2\":1,\"3\":1,\"4\":2},\"difficultyRatio\":{\"1\":3,\"2\":6,\"3\":1},\"coverage\":0.60}','1',NULL,'2026-11-07 10:31:01',NULL,'2026-11-08 17:07:58'),(3,1,'数据库原理 期末测验（组卷演示）2',100,'{\"totalScore\":100,\"typeRatio\":{\"1\":10,\"2\":2,\"3\":2,\"4\":2},\"difficultyRatio\":{\"1\":3,\"2\":6,\"3\":1},\"coverage\":0.8}','1',NULL,'2026-11-07 21:41:03',NULL,'2026-11-08 17:08:32'),(6,1,'数据库原理 期末测验（组卷演示）',100,'{\"totalScore\":100,\"typeRatio\":{\"1\":6,\"2\":1,\"3\":1,\"4\":2},\"difficultyRatio\":{\"1\":3,\"2\":6,\"3\":1},\"coverage\":0.6,\"chapterIds\":[1,2],\"chapterNames\":[\"第一章 数据库系统概述\",\"第二章 关系模型与关系代数\"]}','1',NULL,'2026-11-07 21:47:39',NULL,'2026-11-08 17:08:32'),(7,1,'1章',100,'{\"totalScore\":100,\"typeRatio\":{\"1\":6,\"2\":1,\"3\":1,\"4\":2},\"difficultyRatio\":{\"1\":3,\"2\":6,\"3\":1},\"coverage\":0.7,\"chapterIds\":[1],\"chapterNames\":[\"第一章 数据库系统概述\"]}','1',NULL,'2026-11-07 21:55:47',NULL,NULL),(8,1,'数据库原理 期末测验（组卷演示）',100,'{\"totalScore\":100,\"typeRatio\":{\"1\":6,\"2\":2,\"3\":2,\"4\":2},\"difficultyRatio\":{\"1\":3,\"2\":6,\"3\":1},\"coverage\":0.6,\"chapterIds\":[1],\"chapterNames\":[\"第一章 数据库系统概述\"]}','1',NULL,'2026-11-07 21:57:22',NULL,'2026-11-08 17:08:32');
/*!40000 ALTER TABLE `exam_paper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_paper_question`
--

DROP TABLE IF EXISTS `exam_paper_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_paper_question` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `paper_id` bigint NOT NULL COMMENT '试卷ID',
  `question_id` bigint NOT NULL COMMENT '题目ID',
  `sort_no` int DEFAULT '0' COMMENT '题号顺序',
  `score` int NOT NULL DEFAULT '0' COMMENT '本卷中该题分值（分）',
  `locked` char(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '是否锁定（0否 1是，替换时跳过）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_paper_question` (`paper_id`,`question_id`),
  KEY `idx_paper_id` (`paper_id`),
  KEY `idx_question_id` (`question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='试卷明细';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_paper_question`
--

LOCK TABLES `exam_paper_question` WRITE;
/*!40000 ALTER TABLE `exam_paper_question` DISABLE KEYS */;
INSERT INTO `exam_paper_question` VALUES (1,1,1,1,10,'0',NULL,'2026-11-07 10:31:01',NULL,'2026-11-07 11:02:17'),(2,1,3,2,10,'0',NULL,'2026-11-07 10:31:01',NULL,'2026-11-07 21:34:03'),(3,1,5,3,10,'1',NULL,'2026-11-07 10:31:01',NULL,NULL),(4,1,7,4,10,'0',NULL,'2026-11-07 10:31:01',NULL,NULL),(5,1,9,5,10,'0',NULL,'2026-11-07 10:31:01',NULL,NULL),(6,1,11,6,10,'0',NULL,'2026-11-07 10:31:01',NULL,NULL),(7,1,13,7,10,'1',NULL,'2026-11-07 10:31:01',NULL,NULL),(8,1,17,8,10,'0',NULL,'2026-11-07 10:31:01',NULL,NULL),(9,1,20,9,10,'0',NULL,'2026-11-07 10:31:01',NULL,NULL),(10,1,21,10,10,'0',NULL,'2026-11-07 10:31:01',NULL,NULL),(14,3,3,1,6,'0',NULL,'2026-11-07 21:41:03',NULL,NULL),(15,3,2,2,6,'0',NULL,'2026-11-07 21:41:03',NULL,NULL),(16,3,1,3,6,'0',NULL,'2026-11-07 21:41:03',NULL,NULL),(17,3,38,4,6,'0',NULL,'2026-11-07 21:41:03',NULL,NULL),(18,3,37,5,6,'0',NULL,'2026-11-07 21:41:03',NULL,NULL),(19,3,6,6,6,'0',NULL,'2026-11-07 21:41:03',NULL,NULL),(20,3,9,7,6,'0',NULL,'2026-11-07 21:41:03',NULL,NULL),(21,3,5,8,6,'0',NULL,'2026-11-07 21:41:03',NULL,NULL),(22,3,7,9,6,'0',NULL,'2026-11-07 21:41:03',NULL,NULL),(23,3,10,10,6,'0',NULL,'2026-11-07 21:41:03',NULL,NULL),(24,3,17,11,6,'0',NULL,'2026-11-07 21:41:03',NULL,NULL),(32,6,1,1,10,'0',NULL,'2026-11-07 21:47:39',NULL,NULL),(33,6,3,2,10,'0',NULL,'2026-11-07 21:47:39',NULL,NULL),(34,6,2,3,10,'0',NULL,'2026-11-07 21:47:39',NULL,NULL),(35,6,36,4,10,'0',NULL,'2026-11-07 21:47:39',NULL,NULL),(36,6,38,5,10,'0',NULL,'2026-11-07 21:47:39',NULL,NULL),(37,6,37,6,10,'0',NULL,'2026-11-07 21:47:40',NULL,NULL),(38,6,14,7,10,'0',NULL,'2026-11-07 21:47:40',NULL,NULL),(39,6,20,8,10,'0',NULL,'2026-11-07 21:47:40',NULL,NULL),(40,7,1,1,10,'0',NULL,'2026-11-07 21:55:47',NULL,NULL),(41,7,2,2,10,'0',NULL,'2026-11-07 21:55:47',NULL,NULL),(42,8,1,1,8,'0',NULL,'2026-11-07 21:57:22',NULL,NULL),(43,8,2,2,8,'0',NULL,'2026-11-07 21:57:22',NULL,NULL);
/*!40000 ALTER TABLE `exam_paper_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_prompt`
--

DROP TABLE IF EXISTS `exam_prompt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_prompt` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '提示词ID',
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '提示词名称',
  `content` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '提示词内容',
  `is_default` char(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '是否启用（0否 1是）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='提示词';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_prompt`
--

LOCK TABLES `exam_prompt` WRITE;
/*!40000 ALTER TABLE `exam_prompt` DISABLE KEYS */;
INSERT INTO `exam_prompt` VALUES (1,'默认出题提示词','你是高校命题助手。围绕知识点「{知识点}」，出 {题量} 道{题型}题，难度{难度}。{驳回原因}\n只返回 JSON 数组，不要任何解释文字。每个元素格式：\n{\"stem\":\"题干\",\"options\":[{\"key\":\"A\",\"value\":\"选项内容\"}],\"answer\":\"正确答案\",\"analysis\":\"解析\",\"score\":2}\n注意：题干、选项、解析里一律不要使用英文双引号，需要强调时用《》或括号；文字中不要换行。','1','admin','2026-11-08 12:45:42',NULL,NULL);
/*!40000 ALTER TABLE `exam_prompt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_question`
--

DROP TABLE IF EXISTS `exam_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_question` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '题目ID',
  `course_id` bigint NOT NULL COMMENT '所属课程ID',
  `chapter_id` bigint DEFAULT NULL COMMENT '所属章节ID',
  `knowledge_id` bigint DEFAULT NULL COMMENT '所属知识点ID',
  `type` char(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '题型（1单选 2多选 3判断 4简答 5综合）',
  `difficulty` char(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '2' COMMENT '难度（1容易 2中等 3较难 4困难）',
  `stem` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '题干',
  `options` text COLLATE utf8mb4_general_ci COMMENT '选项JSON，简答题/判断题为NULL',
  `answer` text COLLATE utf8mb4_general_ci COMMENT '参考答案',
  `analysis` text COLLATE utf8mb4_general_ci COMMENT '试题解析',
  `score` int NOT NULL DEFAULT '2' COMMENT '建议分值（分）',
  `status` char(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '状态（0草稿 1待审 2已通过 3已驳回）',
  `source` char(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '来源（0人工录入 1AI生成）',
  `reject_reason` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '驳回原因（下次生成时拼进Prompt开头）',
  `reviewer_id` bigint DEFAULT NULL COMMENT '审核人ID（sys_user.user_id）',
  `review_time` datetime DEFAULT NULL COMMENT '审核时间',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_filter` (`status`,`type`,`difficulty`),
  KEY `idx_knowledge` (`knowledge_id`),
  KEY `idx_course` (`course_id`),
  KEY `idx_chapter` (`chapter_id`),
  KEY `idx_stem` (`stem`(191))
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='题库';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_question`
--

LOCK TABLES `exam_question` WRITE;
/*!40000 ALTER TABLE `exam_question` DISABLE KEYS */;
INSERT INTO `exam_question` VALUES (1,1,1,1,'1','1','数据库系统的核心软件是（　）。','[{\"key\":\"A\",\"value\":\"数据库\"},{\"key\":\"B\",\"value\":\"数据库管理系统\"},{\"key\":\"C\",\"value\":\"操作系统\"},{\"key\":\"D\",\"value\":\"应用程序\"}]','B','数据库管理系统（DBMS）负责数据定义、数据操纵、运行管理与建立维护，是数据库系统的核心。',2,'2','0','',1,'2026-11-07 12:04:51',NULL,'2026-11-07 10:31:01',NULL,'2026-11-07 12:04:51'),(2,1,1,6,'1','1','在三级模式结构中，描述数据库中全体数据全局逻辑结构的是（　）。','[{\"key\":\"A\",\"value\":\"外模式\"},{\"key\":\"B\",\"value\":\"模式\"},{\"key\":\"C\",\"value\":\"内模式\"},{\"key\":\"D\",\"value\":\"存储模式\"}]','B','模式（逻辑模式）描述全体数据的整体逻辑结构，一个数据库只有一个模式。',2,'2','0','',1,'2026-11-07 12:10:04',NULL,'2026-11-07 10:31:01',NULL,'2026-11-07 12:04:51'),(3,1,2,11,'1','1','关系模型中，能唯一标识一个元组且不含多余属性的属性组称为（　）。','[{\"key\":\"A\",\"value\":\"主码\"},{\"key\":\"B\",\"value\":\"外码\"},{\"key\":\"C\",\"value\":\"候选码\"},{\"key\":\"D\",\"value\":\"全码\"}]','C','候选码具有唯一性与最小性，从多个候选码中选定一个作为主码。',2,'2','0','',1,'2026-11-07 12:05:13',NULL,'2026-11-07 10:31:01',NULL,'2026-11-07 12:05:12'),(4,1,3,20,'1','1','SQL 语句中用于对查询结果按列值分组的子句是（　）。','[{\"key\":\"A\",\"value\":\"ORDER BY\"},{\"key\":\"B\",\"value\":\"GROUP BY\"},{\"key\":\"C\",\"value\":\"WHERE\"},{\"key\":\"D\",\"value\":\"DISTINCT\"}]','B','GROUP BY 按指定列分组，常与 COUNT、SUM、AVG 等聚集函数配合使用。',2,'2','0','',1,'2026-11-07 12:05:13',NULL,'2026-11-07 10:31:01',NULL,'2026-11-07 12:05:12'),(5,1,3,24,'1','2','下列关于视图的说法，正确的是（　）。','[{\"key\":\"A\",\"value\":\"视图是实际存储数据的表\"},{\"key\":\"B\",\"value\":\"数据库中只保存视图的定义\"},{\"key\":\"C\",\"value\":\"视图上不能再做查询\"},{\"key\":\"D\",\"value\":\"视图无法基于多个基本表定义\"}]','B','视图是虚表，数据字典里只存定义，数据仍在基本表中，因此也称导出表。',2,'2','0','',1,'2026-11-07 12:05:13',NULL,'2026-11-07 10:31:01',NULL,'2026-11-07 12:05:12'),(6,1,4,29,'1','2','若关系模式 R 属于 2NF，则 R 中一定不存在（　）。','[{\"key\":\"A\",\"value\":\"非主属性对码的部分函数依赖\"},{\"key\":\"B\",\"value\":\"非主属性对码的传递函数依赖\"},{\"key\":\"C\",\"value\":\"主属性对码的依赖\"},{\"key\":\"D\",\"value\":\"多值依赖\"}]','A','2NF 在 1NF 基础上消除了非主属性对码的部分函数依赖；传递函数依赖由 3NF 消除。',2,'2','0',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(7,1,5,35,'1','2','在 E-R 图中，实体型通常用（　）表示。','[{\"key\":\"A\",\"value\":\"矩形\"},{\"key\":\"B\",\"value\":\"椭圆形\"},{\"key\":\"C\",\"value\":\"菱形\"},{\"key\":\"D\",\"value\":\"无向边\"}]','A','矩形表示实体型，椭圆表示属性，菱形表示联系，无向边用于连接。',2,'2','0',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(8,1,6,41,'1','2','事务的原子性是指（　）。','[{\"key\":\"A\",\"value\":\"事务中的操作要么全做要么全不做\"},{\"key\":\"B\",\"value\":\"事务之间互不干扰\"},{\"key\":\"C\",\"value\":\"事务提交后结果永久保存\"},{\"key\":\"D\",\"value\":\"事务执行前后数据保持一致\"}]','A','原子性由恢复子系统通过 UNDO 保证；B 是隔离性，C 是持久性，D 是一致性。',2,'2','0',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(9,1,6,47,'1','2','为避免\"不可重复读\"，并发控制至少应采用（　）。','[{\"key\":\"A\",\"value\":\"一级封锁协议\"},{\"key\":\"B\",\"value\":\"二级封锁协议\"},{\"key\":\"C\",\"value\":\"三级封锁协议\"},{\"key\":\"D\",\"value\":\"不加任何封锁\"}]','C','一级协议防丢失修改，二级协议加防读脏数据，三级协议再加防不可重复读。',2,'2','1',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(10,1,7,49,'1','3','数据库恢复的基本原理是（　）。','[{\"key\":\"A\",\"value\":\"建立冗余数据\"},{\"key\":\"B\",\"value\":\"对数据加密\"},{\"key\":\"C\",\"value\":\"建立索引\"},{\"key\":\"D\",\"value\":\"压缩存储\"}]','A','恢复靠数据转储与日志文件两类冗余，故障后用冗余数据重建正确状态。',2,'2','1',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(11,1,7,53,'1','3','登记日志文件时必须遵循的原则是（　）。','[{\"key\":\"A\",\"value\":\"先写数据库，后写日志\"},{\"key\":\"B\",\"value\":\"先写日志，后写数据库\"},{\"key\":\"C\",\"value\":\"只写日志，不写数据库\"},{\"key\":\"D\",\"value\":\"两者写入顺序不限\"}]','B','必须先写日志文件再写数据库，否则故障发生时会出现无法恢复的已提交修改。',2,'2','1',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(12,1,8,59,'1','3','下列属于按用户权限控制数据访问的安全机制是（　）。','[{\"key\":\"A\",\"value\":\"数据加密\"},{\"key\":\"B\",\"value\":\"存取控制\"},{\"key\":\"C\",\"value\":\"数据转储\"},{\"key\":\"D\",\"value\":\"检查点技术\"}]','B','存取控制通过授权与权限检查限定用户对数据的操作范围，分 DAC 与 MAC 两类。',2,'2','1',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(13,1,1,8,'2','2','数据库管理系统的主要功能包括（　）。','[{\"key\":\"A\",\"value\":\"数据定义功能\"},{\"key\":\"B\",\"value\":\"数据操纵功能\"},{\"key\":\"C\",\"value\":\"数据库的运行管理\"},{\"key\":\"D\",\"value\":\"数据库的建立与维护\"}]','A,B,C,D','DBMS 提供 DDL、DML、运行管理（并发、安全、完整性）以及建立维护等功能。',5,'2','0',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(14,1,2,12,'2','2','关系模型的三类完整性约束包括（　）。','[{\"key\":\"A\",\"value\":\"实体完整性\"},{\"key\":\"B\",\"value\":\"参照完整性\"},{\"key\":\"C\",\"value\":\"用户定义的完整性\"},{\"key\":\"D\",\"value\":\"结构完整性\"}]','A,B,C','关系模型必须支持实体完整性与参照完整性，用户定义完整性针对具体应用语义。',5,'2','0',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(15,1,6,42,'2','3','事务的 ACID 特性包括（　）。','[{\"key\":\"A\",\"value\":\"原子性\"},{\"key\":\"B\",\"value\":\"一致性\"},{\"key\":\"C\",\"value\":\"隔离性\"},{\"key\":\"D\",\"value\":\"持久性\"}]','A,B,C,D','Atomicity、Consistency、Isolation、Durability 四者共同保证事务正确执行。',5,'2','0',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(16,1,6,44,'2','3','并发操作不加控制可能带来的数据不一致问题有（　）。','[{\"key\":\"A\",\"value\":\"丢失修改\"},{\"key\":\"B\",\"value\":\"不可重复读\"},{\"key\":\"C\",\"value\":\"读脏数据\"},{\"key\":\"D\",\"value\":\"死锁\"}]','A,B,C','死锁属于封锁机制带来的问题，不是并发导致的三类数据不一致。',5,'2','0',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(17,1,3,24,'3','1','视图是从一个或多个基本表导出的虚表，数据库中只存放视图的定义而不存放其数据。',NULL,'对','视图只在数据字典中保存定义，查询视图时动态从基本表取数。',2,'2','0',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(18,1,4,31,'3','2','满足第三范式（3NF）的关系模式一定满足 BC 范式（BCNF）。',NULL,'错','BCNF 要求每一个决定因素都包含码，比 3NF 更严格；存在满足 3NF 但不满足 BCNF 的关系模式。',2,'2','0',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(19,1,6,48,'3','3','若所有事务都遵守两段锁协议，则这些事务的任何并发调度都是可串行化的。',NULL,'对','两段锁协议是并发调度可串行化的充分条件，但可能带来死锁。',2,'2','0',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(20,1,1,7,'4','2','简述数据库三级模式与两级映像是如何保证数据独立性的。',NULL,'三级模式为外模式、模式、内模式；外模式/模式映像保证数据的逻辑独立性，当模式改变时只需修改该映像而不必改应用程序；模式/内模式映像保证物理独立性，存储结构改变时模式可保持不变。','答题要点：三级模式各是什么、两级映像分别对应逻辑独立性与物理独立性、映像由 DBMS 管理。',10,'2','0',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(21,1,5,38,'4','2','简述 E-R 图向关系模式转换的基本原则。',NULL,'一个实体型转换为一个关系模式，实体的属性即为关系的属性，实体码即为关系码；1:1 联系可合并到任意一端；1:N 联系在 N 端加入 1 端的码；M:N 联系单独转换为一个关系模式，其码为两端实体码的组合。','答题要点：实体转换规则，以及 1:1、1:N、M:N 三类联系的不同处理方式。',10,'2','0',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(22,1,7,52,'4','3','简述日志文件的作用以及登记日志文件必须遵循的原则。',NULL,'日志文件记录事务对数据库的每一次更新操作，用于事务故障与系统故障的恢复，以及配合数据转储进行介质故障恢复。登记时必须严格遵循\"先写日志文件，后写数据库\"，且按并发事务执行的时间次序登记。','答题要点：日志用于 UNDO/REDO 与故障恢复；两条原则是先写日志、按时间次序登记。',10,'2','0',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(23,1,4,25,'4','2','什么是函数依赖？举例说明部分函数依赖。',NULL,'待补充参考答案（AI 生成的草稿，尚未提交审核）。','AI 生成草稿，用于演示草稿状态与人工编辑入口。',10,'0','1',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(24,1,6,48,'4','3','简述两段锁协议的内容及其与可串行化调度的关系。',NULL,'两段锁协议要求事务分加锁与解锁两个阶段，获得封锁后不得再申请新锁；遵守该协议的并发调度一定是可串行化的，但可能产生死锁。','AI 生成题目，等待教师审核通过，用于演示待审队列。',10,'1','1',NULL,NULL,NULL,NULL,'2026-11-07 10:31:01',NULL,NULL),(25,1,8,59,'4','3','试比较自主存取控制与强制存取控制的异同。',NULL,'自主存取控制由用户自主授权，灵活但安全性较低；强制存取控制由系统按密级强制判定，安全性高但灵活性差。','答题要点：授权主体不同、灵活性与安全性差异、密级与许可证级别的判定规则。',10,'3','1','题目范围过大，超出本课程章节范围，请聚焦两种存取控制的概念对比重新生成',1,'2026-11-07 09:30:00',NULL,'2026-11-07 10:31:01',NULL,NULL),(29,1,1,1,'1','2','【数据库与数据管理的基本概念】离线演示题 1（批次83424）：关于该知识点，下列说法正确的是（　）。','[{\"key\":\"A\",\"value\":\"说法正确，符合教材定义\"},{\"key\":\"B\",\"value\":\"说法错误，混淆了概念\"},{\"key\":\"C\",\"value\":\"说法不完整，缺少前提条件\"},{\"key\":\"D\",\"value\":\"以上都不对\"}]','A','离线演示题，用于答辩断网时跑通 AI 出题 → 审核 → 组卷的完整流程。',2,'0','1',NULL,NULL,NULL,NULL,'2026-11-07 11:38:03',NULL,NULL),(30,1,1,1,'1','2','【数据库与数据管理的基本概念】离线演示题 2（批次83424）：关于该知识点，下列说法正确的是（　）。','[{\"key\":\"A\",\"value\":\"说法正确，符合教材定义\"},{\"key\":\"B\",\"value\":\"说法错误，混淆了概念\"},{\"key\":\"C\",\"value\":\"说法不完整，缺少前提条件\"},{\"key\":\"D\",\"value\":\"以上都不对\"}]','A','离线演示题，用于答辩断网时跑通 AI 出题 → 审核 → 组卷的完整流程。',2,'0','1',NULL,NULL,NULL,NULL,'2026-11-07 11:38:03',NULL,NULL),(31,1,1,1,'1','2','【数据库与数据管理的基本概念】离线演示题 3（批次83424）：关于该知识点，下列说法正确的是（　）。','[{\"key\":\"A\",\"value\":\"说法正确，符合教材定义\"},{\"key\":\"B\",\"value\":\"说法错误，混淆了概念\"},{\"key\":\"C\",\"value\":\"说法不完整，缺少前提条件\"},{\"key\":\"D\",\"value\":\"以上都不对\"}]','A','离线演示题，用于答辩断网时跑通 AI 出题 → 审核 → 组卷的完整流程。',2,'0','1',NULL,NULL,NULL,NULL,'2026-11-07 11:38:03',NULL,NULL),(32,1,1,1,'1','2','测试题干A','[{\"key\":\"A\",\"value\":\"选项A\"},{\"key\":\"B\",\"value\":\"选项B\"},{\"key\":\"C\",\"value\":\"选项C\"},{\"key\":\"D\",\"value\":\"选项D\"}]','A','解析A',5,'0','1',NULL,NULL,NULL,NULL,'2026-11-07 12:49:22',NULL,NULL),(33,1,1,1,'1','2','【数据库与数据管理的基本概念】离线演示题 1（批次11244）：关于该知识点，下列说法正确的是（　）。','[{\"key\":\"A\",\"value\":\"说法正确，符合教材定义\"},{\"key\":\"B\",\"value\":\"说法错误，混淆了概念\"},{\"key\":\"C\",\"value\":\"说法不完整，缺少前提条件\"},{\"key\":\"D\",\"value\":\"以上都不对\"}]','A','离线演示题，用于答辩断网时跑通 AI 出题 → 审核 → 组卷的完整流程。',2,'0','1',NULL,NULL,NULL,NULL,'2026-11-07 12:50:11',NULL,NULL),(34,1,1,1,'1','2','【数据库与数据管理的基本概念】离线演示题 1（批次10231）：关于该知识点，下列说法正确的是（　）。','[{\"key\":\"A\",\"value\":\"说法正确，符合教材定义\"},{\"key\":\"B\",\"value\":\"说法错误，混淆了概念\"},{\"key\":\"C\",\"value\":\"说法不完整，缺少前提条件\"},{\"key\":\"D\",\"value\":\"以上都不对\"}]','A','离线演示题，用于答辩断网时跑通 AI 出题 → 审核 → 组卷的完整流程。',2,'0','1',NULL,NULL,NULL,NULL,'2026-11-07 12:58:30',NULL,NULL),(35,1,1,1,'1','2','【数据库与数据管理的基本概念】离线演示题 1（批次47492）：关于该知识点，下列说法正确的是（　）。','[{\"key\":\"A\",\"value\":\"说法正确，符合教材定义\"},{\"key\":\"B\",\"value\":\"说法错误，混淆了概念\"},{\"key\":\"C\",\"value\":\"说法不完整，缺少前提条件\"},{\"key\":\"D\",\"value\":\"以上都不对\"}]','A','离线演示题，用于答辩断网时跑通 AI 出题 → 审核 → 组卷的完整流程。',2,'0','1',NULL,NULL,NULL,NULL,'2026-11-07 12:59:07',NULL,NULL),(36,1,1,2,'1','2','数据模型的三要素是指（）。','[{\"key\":\"A\",\"value\":\"数据结构、数据操作、数据完整性\"},{\"key\":\"B\",\"value\":\"数据结构、数据操作、数据的约束条件\"},{\"key\":\"C\",\"value\":\"数据定义、数据操作、数据完整性\"},{\"key\":\"D\",\"value\":\"数据结构、数据存储、数据操作\"}]','B','数据模型由三要素构成：数据结构描述数据的类型、内容及相互联系；数据操作定义在此基础上允许执行的操作集合；数据的约束条件保证数据的正确性、有效性和相容性。三者缺一不可，其中数据结构是核心。',2,'2','1','',1,'2026-11-07 13:25:47',NULL,'2026-11-07 13:24:59',NULL,'2026-11-07 13:25:47'),(37,1,1,2,'1','2','在数据模型的三要素中，用于刻画数据的静态特征、描述数据之间的联系的是（）。','[{\"key\":\"A\",\"value\":\"数据操作\"},{\"key\":\"B\",\"value\":\"数据的约束条件\"},{\"key\":\"C\",\"value\":\"数据结构\"},{\"key\":\"D\",\"value\":\"数据类型\"}]','C','数据结构是数据模型的第一要素，它描述数据的组织形式、类型及其之间的联系，是数据模型的静态特征。数据操作是对数据结构施加的操作，数据的约束条件是数据及其联系所遵循的规则，三者共同构成完整的数据模型。',2,'2','1','',1,'2026-11-07 13:25:47',NULL,'2026-11-07 13:24:59',NULL,'2026-11-07 13:25:47'),(38,1,1,2,'1','2','关于数据模型三要素之间的关系，下列说法正确的是（）。','[{\"key\":\"A\",\"value\":\"数据结构是核心，数据操作和约束条件都是围绕数据结构定义的\"},{\"key\":\"B\",\"value\":\"数据操作是核心，数据结构只是实现数据操作的手段\"},{\"key\":\"C\",\"value\":\"数据的约束条件是核心，因为它保证了数据的质量\"},{\"key\":\"D\",\"value\":\"三要素地位平等，不存在核心与非核心的区分\"}]','A','在数据模型的三要素中，数据结构是核心要素，它决定了数据的基本组织形式；数据操作是基于数据结构定义的可执行运算集合；数据的约束条件则是对数据结构及其操作的范围限制。后两个要素都建立并服务于数据结构，因此数据结构是数据模型的灵魂。',2,'2','1','',1,'2026-11-07 13:25:47',NULL,'2026-11-07 13:24:59',NULL,'2026-11-07 13:25:47'),(39,1,1,1,'3','1','数据库系统能够有效降低数据的冗余性，实现数据共享。（ ）','[{\"key\":\"A\",\"value\":\"正确\"},{\"key\":\"B\",\"value\":\"错误\"}]','A','数据库系统通过统一管理和组织数据，实现了数据的共享和最小冗余，这是数据库系统的重要特点之一。',2,'0','1',NULL,NULL,NULL,NULL,'2026-11-07 21:54:21',NULL,NULL),(40,1,1,1,'3','1','文件系统与数据库系统相比，数据结构化程度更高，数据独立性更强。（ ）','[{\"key\":\"A\",\"value\":\"正确\"},{\"key\":\"B\",\"value\":\"错误\"}]','B','数据库系统相对于文件系统具有更高的数据结构化程度和更强的数据独立性。文件系统中的数据冗余大、共享性差、数据独立性低。',2,'0','1',NULL,NULL,NULL,NULL,'2026-11-07 21:54:21',NULL,NULL),(41,1,1,1,'1','1','数据库（DB）是指长期存储在计算机内、有组织的、可共享的大量数据的集合，以下描述正确的是（　　）。','[{\"key\":\"A\",\"value\":\"数据按一定的数据模型组织起来，冗余度小，易扩充\"},{\"key\":\"B\",\"value\":\"临时存放在内存中的数据集合\"},{\"key\":\"C\",\"value\":\"仅用于科学计算的一批数据\"},{\"key\":\"D\",\"value\":\"未经整理的手写记录照片\"}]','A','数据库是长期存贮在计算机内、有组织的、可共享的大量数据的集合，具有数据结构化、冗余度小、易扩充、由DBMS统一管理和控制等特点。',2,'0','1',NULL,NULL,NULL,NULL,'2026-11-07 22:02:38',NULL,NULL),(42,1,1,1,'1','1','DBMS是指（　　）。','[{\"key\":\"A\",\"value\":\"数据库管理系统\"},{\"key\":\"B\",\"value\":\"数据库管理员\"},{\"key\":\"C\",\"value\":\"数据库系统\"},{\"key\":\"D\",\"value\":\"数据模型\"}]','A','DBMS是Database Management System的缩写，即数据库管理系统，它是位于用户与操作系统之间的一层数据管理软件。',2,'0','1',NULL,NULL,NULL,NULL,'2026-11-07 22:02:38',NULL,NULL),(43,1,1,1,'1','1','在数据管理技术的发展过程中，先后经历了人工管理阶段、文件系统阶段和数据库系统阶段。其中数据独立性最高的是（　　）。','[{\"key\":\"A\",\"value\":\"数据库系统阶段\"},{\"key\":\"B\",\"value\":\"文件系统阶段\"},{\"key\":\"C\",\"value\":\"人工管理阶段\"},{\"key\":\"D\",\"value\":\"三个阶段的独立性相同\"}]','A','数据库系统阶段实现了数据的结构化，提供了物理独立性和逻辑独立性，数据独立性最高；文件系统阶段仅有物理独立性；人工管理阶段无独立性。',2,'0','1',NULL,NULL,NULL,NULL,'2026-11-07 22:02:38',NULL,NULL),(44,1,1,1,'1','1','下列关于数据库系统的叙述中，错误的是（　　）。','[{\"key\":\"A\",\"value\":\"数据库系统减少了数据冗余\"},{\"key\":\"B\",\"value\":\"数据库系统可以解决所有数据安全问题的\"},{\"key\":\"C\",\"value\":\"数据库系统中的数据由DBMS统一管理\"},{\"key\":\"D\",\"value\":\"数据库系统支持多用户对数据的共享使用\"}]','B','数据库系统能够减少数据冗余、支持数据共享并由DBMS统一管理，但不能解决所有的安全问题，安全还需要依靠权限控制、加密等手段共同保障。',2,'0','1',NULL,NULL,NULL,NULL,'2026-11-07 22:02:38',NULL,NULL),(45,1,1,1,'1','2','数据库系统中，负责数据库定义、建立、维护和日常运行的软件称为（）。','[{\"key\":\"A\",\"value\":\"DBMS（数据库管理系统）\"},{\"key\":\"B\",\"value\":\"OS（操作系统）\"},{\"key\":\"C\",\"value\":\"App（应用程序）\"},{\"key\":\"D\",\"value\":\"DBS（数据库系统）\"}]','A','DBMS是数据库系统的核心软件，负责数据库的定义、建立、维护和控制等功能，是用户与数据之间的接口。',2,'0','1',NULL,NULL,NULL,NULL,'2026-11-08 10:09:47',NULL,NULL),(46,1,1,1,'1','2','在数据库的三级模式结构中，描述全体数据物理存储结构和存储方式的是（）。','[{\"key\":\"A\",\"value\":\"内模式\"},{\"key\":\"B\",\"value\":\"模式\"},{\"key\":\"C\",\"value\":\"外模式\"},{\"key\":\"D\",\"value\":\"概念模式\"}]','A','三级模式包括外模式、模式和内模式。内模式又称存储模式，描述数据的物理结构和存储方式；模式是全局逻辑结构；外模式是用户视图。',2,'0','1',NULL,NULL,NULL,NULL,'2026-11-08 10:09:47',NULL,NULL),(47,1,1,1,'1','2','关于数据与信息的关系，下列说法正确的是（）。','[{\"key\":\"A\",\"value\":\"数据和信息是完全等同的概念\"},{\"key\":\"B\",\"value\":\"数据是信息的载体，信息是数据的内涵\"},{\"key\":\"C\",\"value\":\"信息是数据的载体，数据是信息的内涵\"},{\"key\":\"D\",\"value\":\"数据与信息无关，分别属于不同领域\"}]','B','数据是记录下来的客观事实，是信息的载体；信息是经过加工处理后对人们有价值的数据。二者密切相关但并非等同，信息来源于数据并被数据处理后产生。',2,'0','1',NULL,NULL,NULL,NULL,'2026-11-08 10:09:47',NULL,NULL),(48,1,1,1,'2','2','关于数据库系统的三级模式结构，下列说法正确的有','[{\"key\":\"A\",\"value\":\"模式是数据库中全体数据的全局逻辑结构和特征的描述\"},{\"key\":\"B\",\"value\":\"外模式是用户能看见和使用的局部数据的逻辑结构和特征的描述\"},{\"key\":\"C\",\"value\":\"内模式是对数据物理结构和存储方式的描述\"},{\"key\":\"D\",\"value\":\"一个数据库系统可以有多个模式\"}]','ABC','三级模式结构中，模式只有一个，描述全局逻辑结构；外模式可以有多个，面向不同用户；内模式也只有一个，描述物理存储。选项D错误。',2,'0','1',NULL,NULL,NULL,NULL,'2026-11-08 11:51:21',NULL,NULL),(49,1,1,1,'2','2','以下关于数据抽象层次的叙述中，正确的有','[{\"key\":\"A\",\"value\":\"物理数据层是数据的最底层表示，描述数据在计算机中的存储方式\"},{\"key\":\"B\",\"value\":\"概念数据层是数据的中间层，独立于具体机器和DBMS，用于描述现实世界中的数据对象及其联系\"},{\"key\":\"C\",\"value\":\"视图数据层是最高层，最接近用户，描述用户可以看见和使用的局部数据结构\"},{\"key\":\"D\",\"value\":\"概念数据层直接对应具体的物理存储设备\"}]','ABC','概念数据层是对现实世界的抽象，独立于具体机器和DBMS实现；物理数据层才与具体存储设备相关。选项D混淆了概念层与物理层的职责。',2,'0','1',NULL,NULL,NULL,NULL,'2026-11-08 11:51:21',NULL,NULL),(50,1,1,1,'2','2','下列关于数据库管理系统（DBMS）主要功能的说法中，正确的有','[{\"key\":\"A\",\"value\":\"数据定义功能：提供数据定义语言（DDL），用于定义数据库的三级模式结构\"},{\"key\":\"B\",\"value\":\"数据操纵功能：提供数据操纵语言（DML），支持数据的查询及增删改操作\"},{\"key\":\"C\",\"value\":\"数据库的运行管理功能：包括并发控制、故障恢复和数据安全性检查等\"},{\"key\":\"D\",\"value\":\"数据库的建立和维护功能：包括初始数据的装入、数据库转储和重组等\"}]','ABCD','数据库管理系统的主要功能包括数据定义、数据操纵、数据库的运行管理以及数据库的建立和维护四大类。上述四个选项均描述正确。',2,'2','1','',1,'2026-11-08 12:06:27',NULL,'2026-11-08 11:51:21',NULL,'2026-11-08 12:06:21');
/*!40000 ALTER TABLE `exam_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_review_log`
--

DROP TABLE IF EXISTS `exam_review_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_review_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `question_id` bigint NOT NULL COMMENT '题目ID',
  `action` char(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作（1提交待审 2审核通过 3审核驳回）',
  `reason` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作说明/驳回原因',
  `reviewer_id` bigint DEFAULT NULL COMMENT '操作人ID（sys_user.user_id）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_question_id` (`question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='题目审核记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_review_log`
--

LOCK TABLES `exam_review_log` WRITE;
/*!40000 ALTER TABLE `exam_review_log` DISABLE KEYS */;
INSERT INTO `exam_review_log` VALUES (1,24,'1','AI 生成完成，提交人工审核',1,NULL,'2026-11-07 09:05:00',NULL,NULL),(2,20,'2','答案要点完整，审核通过',1,NULL,'2026-11-06 16:20:00',NULL,NULL),(3,25,'3','题目范围过大，超出本课程章节范围',1,NULL,'2026-11-07 09:30:00',NULL,NULL),(6,1,'2','',1,NULL,'2026-11-07 12:04:51',NULL,NULL),(7,2,'3','答案错误',1,NULL,'2026-11-07 12:04:51',NULL,NULL),(8,3,'2','',1,NULL,'2026-11-07 12:05:12',NULL,NULL),(9,4,'2','',1,NULL,'2026-11-07 12:05:12',NULL,NULL),(10,5,'2','',1,NULL,'2026-11-07 12:05:12',NULL,NULL),(11,2,'2','',1,NULL,'2026-11-07 12:10:04',NULL,NULL),(12,38,'2','',1,NULL,'2026-11-07 13:25:47',NULL,NULL),(13,37,'2','',1,NULL,'2026-11-07 13:25:47',NULL,NULL),(14,36,'2','',1,NULL,'2026-11-07 13:25:47',NULL,NULL),(15,50,'2','',1,NULL,'2026-11-08 12:06:21',NULL,NULL),(16,50,'2','',1,NULL,'2026-11-08 12:06:27',NULL,NULL);
/*!40000 ALTER TABLE `exam_review_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) COLLATE utf8mb4_general_ci DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成功能作者',
  `form_col_num` int DEFAULT '1' COMMENT '表单布局（单列 双列 三列）',
  `gen_type` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='代码生成业务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
INSERT INTO `gen_table` VALUES (1,'exam_ai_call_log','大模型调用日志',NULL,NULL,'ExamAiCallLog','crud','element-plus','com.ruoyi.exam','exam','aiCallLog','大模型调用日志','shishugen',1,'0','/',NULL,'admin','2026-11-07 10:17:09','',NULL,NULL),(2,'exam_chapter','章节',NULL,NULL,'ExamChapter','crud','element-plus','com.ruoyi.exam','exam','chapter','章节','shishugen',1,'0','/',NULL,'admin','2026-11-07 10:17:09','',NULL,NULL),(3,'exam_course','课程',NULL,NULL,'ExamCourse','crud','element-plus','com.ruoyi.exam','exam','course','课程','shishugen',1,'0','/',NULL,'admin','2026-11-07 10:17:09','',NULL,NULL),(4,'exam_knowledge','知识点',NULL,NULL,'ExamKnowledge','crud','element-plus','com.ruoyi.exam','exam','knowledge','知识点','shishugen',1,'0','/',NULL,'admin','2026-11-07 10:17:09','',NULL,NULL),(5,'exam_paper','试卷',NULL,NULL,'ExamPaper','crud','element-plus','com.ruoyi.exam','exam','paper','试卷','shishugen',1,'0','/',NULL,'admin','2026-11-07 10:17:09','',NULL,NULL),(6,'exam_paper_question','试卷明细',NULL,NULL,'ExamPaperQuestion','crud','element-plus','com.ruoyi.exam','exam','paperQuestion','试卷明细','shishugen',1,'0','/',NULL,'admin','2026-11-07 10:17:09','',NULL,NULL),(7,'exam_question','题库',NULL,NULL,'ExamQuestion','crud','element-plus','com.ruoyi.exam','exam','question','题库','shishugen',1,'0','/',NULL,'admin','2026-11-07 10:17:09','',NULL,NULL),(8,'exam_review_log','题目审核记录',NULL,NULL,'ExamReviewLog','crud','element-plus','com.ruoyi.exam','exam','reviewLog','题目审核记录','shishugen',1,'0','/',NULL,'admin','2026-11-07 10:17:09','',NULL,NULL),(9,'exam_model_config','模型配置',NULL,NULL,'ExamModelConfig','crud','element-plus','com.ruoyi.exam','exam','modelConfig','模型配置','shishugen',1,'0','/',NULL,'admin','2026-11-08 12:46:13','',NULL,NULL),(10,'exam_prompt','提示词',NULL,NULL,'ExamPrompt','crud','element-plus','com.ruoyi.exam','exam','prompt','提示词','shishugen',1,'0','/',NULL,'admin','2026-11-08 12:46:13','',NULL,NULL);
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='代码生成业务表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
INSERT INTO `gen_table_column` VALUES (1,1,'id','日志ID','bigint','Long','id','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2026-11-07 10:17:09','',NULL),(2,1,'task_type','任务类型（1AI出题 2重新生成）','char(1)','String','taskType','0','0','0','1','1','1','1','EQ','select','exam_task_type',2,'admin','2026-11-07 10:17:09','',NULL),(3,1,'model','调用的模型名称','varchar(100)','String','model','0','0','0','1','1','1','1','EQ','input','',3,'admin','2026-11-07 10:17:09','',NULL),(4,1,'prompt_tokens','输入token数','int','Integer','promptTokens','0','0','0','1','1','1','1','EQ','input','',4,'admin','2026-11-07 10:17:09','',NULL),(5,1,'completion_tokens','输出token数','int','Integer','completionTokens','0','0','0','1','1','1','1','EQ','input','',5,'admin','2026-11-07 10:17:09','',NULL),(6,1,'duration_ms','耗时（毫秒）','bigint','Long','durationMs','0','0','0','1','1','1','1','EQ','input','',6,'admin','2026-11-07 10:17:09','',NULL),(7,1,'cost','本次费用（元）','decimal(10,4)','BigDecimal','cost','0','0','0','1','1','1','1','EQ','input','',7,'admin','2026-11-07 10:17:09','',NULL),(8,1,'status','状态（0成功 1失败）','char(1)','String','status','0','0','0','1','1','1','1','EQ','select','exam_call_status',8,'admin','2026-11-07 10:17:09','',NULL),(9,1,'error_msg','失败原因','varchar(500)','String','errorMsg','0','0','0','1','1','1','1','EQ','textarea','',9,'admin','2026-11-07 10:17:09','',NULL),(10,1,'create_by','创建者','varchar(64)','String','createBy','0','0','0','0','0','0','0','EQ','input','',10,'admin','2026-11-07 10:17:09','',NULL),(11,1,'create_time','调用时间','datetime','Date','createTime','0','0','0','0','0','0','0','EQ','datetime','',11,'admin','2026-11-07 10:17:09','',NULL),(12,1,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','0','0','0','0','EQ','input','',12,'admin','2026-11-07 10:17:09','',NULL),(13,1,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0','0','0','EQ','datetime','',13,'admin','2026-11-07 10:17:09','',NULL),(14,2,'id','章节ID','bigint','Long','id','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2026-11-07 10:17:09','',NULL),(15,2,'course_id','所属课程ID','bigint','Long','courseId','0','0','1','1','1','1','1','EQ','input','',2,'admin','2026-11-07 10:17:09','',NULL),(16,2,'name','章节名称','varchar(100)','String','name','0','0','1','1','1','1','1','LIKE','input','',3,'admin','2026-11-07 10:17:09','',NULL),(17,2,'sort_no','显示顺序','int','Integer','sortNo','0','0','0','1','1','1','1','EQ','input','',4,'admin','2026-11-07 10:17:09','',NULL),(18,2,'create_by','创建者','varchar(64)','String','createBy','0','0','0','0','0','0','0','EQ','input','',5,'admin','2026-11-07 10:17:09','',NULL),(19,2,'create_time','创建时间','datetime','Date','createTime','0','0','0','0','0','0','0','EQ','datetime','',6,'admin','2026-11-07 10:17:09','',NULL),(20,2,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','0','0','0','0','EQ','input','',7,'admin','2026-11-07 10:17:09','',NULL),(21,2,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0','0','0','EQ','datetime','',8,'admin','2026-11-07 10:17:09','',NULL),(22,3,'id','课程ID','bigint','Long','id','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2026-11-07 10:17:09','',NULL),(23,3,'course_name','课程名称','varchar(100)','String','courseName','0','0','1','1','1','1','1','LIKE','input','',2,'admin','2026-11-07 10:17:09','',NULL),(24,3,'course_code','课程代码','varchar(50)','String','courseCode','0','0','0','1','1','1','1','EQ','input','',3,'admin','2026-11-07 10:17:09','',NULL),(25,3,'remark','备注','varchar(500)','String','remark','0','0','0','1','1','1',NULL,'EQ','textarea','',4,'admin','2026-11-07 10:17:09','',NULL),(26,3,'create_by','创建者','varchar(64)','String','createBy','0','0','0','0','0','0','0','EQ','input','',5,'admin','2026-11-07 10:17:09','',NULL),(27,3,'create_time','创建时间','datetime','Date','createTime','0','0','0','0','0','0','0','EQ','datetime','',6,'admin','2026-11-07 10:17:09','',NULL),(28,3,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','0','0','0','0','EQ','input','',7,'admin','2026-11-07 10:17:09','',NULL),(29,3,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0','0','0','EQ','datetime','',8,'admin','2026-11-07 10:17:09','',NULL),(30,4,'id','知识点ID','bigint','Long','id','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2026-11-07 10:17:09','',NULL),(31,4,'chapter_id','所属章节ID','bigint','Long','chapterId','0','0','1','1','1','1','1','EQ','input','',2,'admin','2026-11-07 10:17:09','',NULL),(32,4,'name','知识点名称','varchar(100)','String','name','0','0','1','1','1','1','1','LIKE','input','',3,'admin','2026-11-07 10:17:09','',NULL),(33,4,'weight','考查权重（1-10，越大越重要）','int','Integer','weight','0','0','0','1','1','1','1','EQ','input','',4,'admin','2026-11-07 10:17:09','',NULL),(34,4,'sort_no','显示顺序','int','Integer','sortNo','0','0','0','1','1','1','1','EQ','input','',5,'admin','2026-11-07 10:17:09','',NULL),(35,4,'create_by','创建者','varchar(64)','String','createBy','0','0','0','0','0','0','0','EQ','input','',6,'admin','2026-11-07 10:17:09','',NULL),(36,4,'create_time','创建时间','datetime','Date','createTime','0','0','0','0','0','0','0','EQ','datetime','',7,'admin','2026-11-07 10:17:09','',NULL),(37,4,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','0','0','0','0','EQ','input','',8,'admin','2026-11-07 10:17:09','',NULL),(38,4,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0','0','0','EQ','datetime','',9,'admin','2026-11-07 10:17:09','',NULL),(39,5,'id','试卷ID','bigint','Long','id','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2026-11-07 10:17:09','',NULL),(40,5,'course_id','所属课程ID','bigint','Long','courseId','0','0','1','1','1','1','1','EQ','input','',2,'admin','2026-11-07 10:17:09','',NULL),(41,5,'title','试卷名称','varchar(200)','String','title','0','0','1','1','1','1','1','EQ','input','',3,'admin','2026-11-07 10:17:09','',NULL),(42,5,'total_score','试卷总分（分）','int','Integer','totalScore','0','0','1','1','1','1','1','EQ','input','',4,'admin','2026-11-07 10:17:09','',NULL),(43,5,'config_json','组卷配置JSON：总分/题型配比/难度分布/知识点覆盖率','text','String','configJson','0','0','0','1','1','1','1','EQ','textarea','',5,'admin','2026-11-07 10:17:09','',NULL),(44,5,'status','状态（0生成中 1已完成 2已导出）','char(1)','String','status','0','0','1','1','1','1','1','EQ','select','exam_paper_status',6,'admin','2026-11-07 10:17:09','',NULL),(45,5,'create_by','创建者','varchar(64)','String','createBy','0','0','0','0','0','0','0','EQ','input','',7,'admin','2026-11-07 10:17:09','',NULL),(46,5,'create_time','创建时间','datetime','Date','createTime','0','0','0','0','0','0','0','EQ','datetime','',8,'admin','2026-11-07 10:17:09','',NULL),(47,5,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','0','0','0','0','EQ','input','',9,'admin','2026-11-07 10:17:09','',NULL),(48,5,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0','0','0','EQ','datetime','',10,'admin','2026-11-07 10:17:09','',NULL),(49,6,'id','明细ID','bigint','Long','id','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2026-11-07 10:17:09','',NULL),(50,6,'paper_id','试卷ID','bigint','Long','paperId','0','0','1','1','1','1','1','EQ','input','',2,'admin','2026-11-07 10:17:09','',NULL),(51,6,'question_id','题目ID','bigint','Long','questionId','0','0','1','1','1','1','1','EQ','input','',3,'admin','2026-11-07 10:17:09','',NULL),(52,6,'sort_no','题号顺序','int','Integer','sortNo','0','0','0','1','1','1','1','EQ','input','',4,'admin','2026-11-07 10:17:09','',NULL),(53,6,'score','本卷中该题分值（分）','int','Integer','score','0','0','1','1','1','1','1','EQ','input','',5,'admin','2026-11-07 10:17:09','',NULL),(54,6,'locked','是否锁定（0否 1是，替换时跳过）','char(1)','String','locked','0','0','1','1','1','1','1','EQ','select','exam_yes_no',6,'admin','2026-11-07 10:17:09','',NULL),(55,6,'create_by','创建者','varchar(64)','String','createBy','0','0','0','0','0','0','0','EQ','input','',7,'admin','2026-11-07 10:17:09','',NULL),(56,6,'create_time','创建时间','datetime','Date','createTime','0','0','0','0','0','0','0','EQ','datetime','',8,'admin','2026-11-07 10:17:09','',NULL),(57,6,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','0','0','0','0','EQ','input','',9,'admin','2026-11-07 10:17:09','',NULL),(58,6,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0','0','0','EQ','datetime','',10,'admin','2026-11-07 10:17:09','',NULL),(59,7,'id','题目ID','bigint','Long','id','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2026-11-07 10:17:09','',NULL),(60,7,'course_id','所属课程ID','bigint','Long','courseId','0','0','1','1','1','1','1','EQ','input','',2,'admin','2026-11-07 10:17:09','',NULL),(61,7,'chapter_id','所属章节ID','bigint','Long','chapterId','0','0','0','1','1','1','1','EQ','input','',3,'admin','2026-11-07 10:17:09','',NULL),(62,7,'knowledge_id','所属知识点ID','bigint','Long','knowledgeId','0','0','0','1','1','1','1','EQ','input','',4,'admin','2026-11-07 10:17:09','',NULL),(63,7,'type','题型（1单选 2多选 3判断 4简答 5综合）','char(1)','String','type','0','0','1','1','1','1','1','EQ','select','exam_question_type',5,'admin','2026-11-07 10:17:09','',NULL),(64,7,'difficulty','难度（1容易 2中等 3较难 4困难）','char(1)','String','difficulty','0','0','1','1','1','1','1','EQ','select','exam_difficulty',6,'admin','2026-11-07 10:17:09','',NULL),(65,7,'stem','题干','text','String','stem','0','0','1','1','1','1','1','EQ','textarea','',7,'admin','2026-11-07 10:17:09','',NULL),(66,7,'options','选项JSON，简答题/判断题为NULL','text','String','options','0','0','0','1','1','1','1','EQ','textarea','',8,'admin','2026-11-07 10:17:09','',NULL),(67,7,'answer','参考答案','text','String','answer','0','0','0','1','1','1','1','EQ','textarea','',9,'admin','2026-11-07 10:17:09','',NULL),(68,7,'analysis','试题解析','text','String','analysis','0','0','0','1','1','1','1','EQ','textarea','',10,'admin','2026-11-07 10:17:09','',NULL),(69,7,'score','建议分值（分）','int','Integer','score','0','0','1','1','1','1','1','EQ','input','',11,'admin','2026-11-07 10:17:09','',NULL),(70,7,'status','状态（0草稿 1待审 2已通过 3已驳回）','char(1)','String','status','0','0','1','1','1','1','1','EQ','select','exam_question_status',12,'admin','2026-11-07 10:17:09','',NULL),(71,7,'source','来源（0人工录入 1AI生成）','char(1)','String','source','0','0','1','1','1','1','1','EQ','select','exam_source',13,'admin','2026-11-07 10:17:09','',NULL),(72,7,'reject_reason','驳回原因（下次生成时拼进Prompt开头）','varchar(500)','String','rejectReason','0','0','0','1','1','1','1','EQ','textarea','',14,'admin','2026-11-07 10:17:09','',NULL),(73,7,'reviewer_id','审核人ID（sys_user.user_id）','bigint','Long','reviewerId','0','0','0','1','1','1','1','EQ','input','',15,'admin','2026-11-07 10:17:09','',NULL),(74,7,'review_time','审核时间','datetime','Date','reviewTime','0','0','0','1','1','1','1','EQ','datetime','',16,'admin','2026-11-07 10:17:09','',NULL),(75,7,'create_by','创建者','varchar(64)','String','createBy','0','0','0','0','0','0','0','EQ','input','',17,'admin','2026-11-07 10:17:09','',NULL),(76,7,'create_time','创建时间','datetime','Date','createTime','0','0','0','0','0','0','0','EQ','datetime','',18,'admin','2026-11-07 10:17:09','',NULL),(77,7,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','0','0','0','0','EQ','input','',19,'admin','2026-11-07 10:17:09','',NULL),(78,7,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0','0','0','EQ','datetime','',20,'admin','2026-11-07 10:17:09','',NULL),(79,8,'id','记录ID','bigint','Long','id','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2026-11-07 10:17:09','',NULL),(80,8,'question_id','题目ID','bigint','Long','questionId','0','0','1','1','1','1','1','EQ','input','',2,'admin','2026-11-07 10:17:09','',NULL),(81,8,'action','操作（1提交待审 2审核通过 3审核驳回）','char(1)','String','action','0','0','1','1','1','1','1','EQ','select','exam_review_action',3,'admin','2026-11-07 10:17:09','',NULL),(82,8,'reason','操作说明/驳回原因','varchar(500)','String','reason','0','0','0','1','1','1','1','EQ','textarea','',4,'admin','2026-11-07 10:17:09','',NULL),(83,8,'reviewer_id','操作人ID（sys_user.user_id）','bigint','Long','reviewerId','0','0','0','1','1','1','1','EQ','input','',5,'admin','2026-11-07 10:17:09','',NULL),(84,8,'create_by','创建者','varchar(64)','String','createBy','0','0','0','0','0','0','0','EQ','input','',6,'admin','2026-11-07 10:17:09','',NULL),(85,8,'create_time','创建时间','datetime','Date','createTime','0','0','0','0','0','0','0','EQ','datetime','',7,'admin','2026-11-07 10:17:09','',NULL),(86,8,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','0','0','0','0','EQ','input','',8,'admin','2026-11-07 10:17:09','',NULL),(87,8,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0','0','0','EQ','datetime','',9,'admin','2026-11-07 10:17:09','',NULL),(88,9,'id','配置ID','bigint','Long','id','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2026-11-08 12:46:13','',NULL),(89,9,'name','配置名称','varchar(50)','String','name','0','0','1','1','1','1','1','LIKE','input','',2,'admin','2026-11-08 12:46:13','',NULL),(90,9,'base_url','接口地址（填到 /v1 为止）','varchar(200)','String','baseUrl','0','0','1','1','1','1','1','EQ','input','',3,'admin','2026-11-08 12:46:13','',NULL),(91,9,'api_key','密钥（存 AES 密文）','varchar(200)','String','apiKey','0','0','0','1','1','0','0','EQ','input','',4,'admin','2026-11-08 12:46:13','',NULL),(92,9,'model_name','模型名称','varchar(50)','String','modelName','0','0','1','1','1','1','1','LIKE','input','',5,'admin','2026-11-08 12:46:13','',NULL),(93,9,'is_default','是否启用（0否 1是）','char(1)','String','isDefault','0','0','1','1','1','1','1','EQ','select','exam_yes_no',6,'admin','2026-11-08 12:46:13','',NULL),(94,9,'create_by','创建者','varchar(64)','String','createBy','0','0','0','0','0','0','0','EQ','input','',7,'admin','2026-11-08 12:46:13','',NULL),(95,9,'create_time','创建时间','datetime','Date','createTime','0','0','0','0','0','0','0','EQ','datetime','',8,'admin','2026-11-08 12:46:13','',NULL),(96,9,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','0','0','0','0','EQ','input','',9,'admin','2026-11-08 12:46:13','',NULL),(97,9,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0','0','0','EQ','datetime','',10,'admin','2026-11-08 12:46:13','',NULL),(98,10,'id','提示词ID','bigint','Long','id','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2026-11-08 12:46:13','',NULL),(99,10,'name','提示词名称','varchar(50)','String','name','0','0','1','1','1','1','1','LIKE','input','',2,'admin','2026-11-08 12:46:13','',NULL),(100,10,'content','提示词内容','text','String','content','0','0','1','1','1','1','1','EQ','textarea','',3,'admin','2026-11-08 12:46:13','',NULL),(101,10,'is_default','是否启用（0否 1是）','char(1)','String','isDefault','0','0','1','1','1','1','1','EQ','select','exam_yes_no',4,'admin','2026-11-08 12:46:13','',NULL),(102,10,'create_by','创建者','varchar(64)','String','createBy','0','0','0','0','0','0','0','EQ','input','',5,'admin','2026-11-08 12:46:13','',NULL),(103,10,'create_time','创建时间','datetime','Date','createTime','0','0','0','0','0','0','0','EQ','datetime','',6,'admin','2026-11-08 12:46:13','',NULL),(104,10,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','0','0','0','0','EQ','input','',7,'admin','2026-11-08 12:46:13','',NULL),(105,10,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0','0','0','EQ','datetime','',8,'admin','2026-11-08 12:46:13','',NULL);
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_config` (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2026-11-06 15:31:59','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2026-11-06 15:31:59','',NULL,'初始化密码 123456'),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2026-11-06 15:31:59','',NULL,'深色主题theme-dark，浅色主题theme-light'),(4,'账号自助-验证码开关','sys.account.captchaEnabled','false','Y','admin','2026-11-06 15:31:59','',NULL,'是否开启验证码功能（true开启，false关闭）'),(5,'账号自助-是否开启用户注册功能','sys.account.registerUser','false','Y','admin','2026-11-06 15:31:59','',NULL,'是否开启注册用户功能（true开启，false关闭）'),(6,'用户登录-黑名单列表','sys.login.blackIPList','','Y','admin','2026-11-06 15:31:59','',NULL,'设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）'),(7,'用户管理-初始密码修改策略','sys.account.initPasswordModify','1','Y','admin','2026-11-06 15:31:59','',NULL,'0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框'),(8,'用户管理-账号密码更新周期','sys.account.passwordValidateDays','0','Y','admin','2026-11-06 15:31:59','',NULL,'密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框'),(9,'用户管理-密码字符范围','sys.account.chrtype','0','Y','admin','2026-11-06 15:31:59','',NULL,'默认任意字符范围，0任意（密码可以输入任意字符），1数字（密码只能为0-9数字），2英文字母（密码只能为a-z和A-Z字母），3字母和数字（密码必须包含字母，数字）,4字母数字和特殊字符（目前支持的特殊字符包括：~!@#$%^&*()-=_+）');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮箱',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,0,'0','若依科技',0,'若依','15888888888','ry@qq.com','0','0','admin','2026-11-06 15:31:59','',NULL),(101,100,'0,100','深圳总公司',1,'若依','15888888888','ry@qq.com','0','0','admin','2026-11-06 15:31:59','',NULL),(102,100,'0,100','长沙分公司',2,'若依','15888888888','ry@qq.com','0','0','admin','2026-11-06 15:31:59','',NULL),(103,101,'0,100,101','研发部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2026-11-06 15:31:59','',NULL),(104,101,'0,100,101','市场部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2026-11-06 15:31:59','',NULL),(105,101,'0,100,101','测试部门',3,'若依','15888888888','ry@qq.com','0','0','admin','2026-11-06 15:31:59','',NULL),(106,101,'0,100,101','财务部门',4,'若依','15888888888','ry@qq.com','0','0','admin','2026-11-06 15:31:59','',NULL),(107,101,'0,100,101','运维部门',5,'若依','15888888888','ry@qq.com','0','0','admin','2026-11-06 15:31:59','',NULL),(108,102,'0,100,102','市场部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2026-11-06 15:31:59','',NULL),(109,102,'0,100,102','财务部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2026-11-06 15:31:59','',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2026-11-06 15:31:59','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2026-11-06 15:31:59','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2026-11-06 15:31:59','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2026-11-06 15:31:59','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2026-11-06 15:31:59','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2026-11-06 15:31:59','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2026-11-06 15:31:59','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2026-11-06 15:31:59','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2026-11-06 15:31:59','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2026-11-06 15:31:59','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2026-11-06 15:31:59','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2026-11-06 15:31:59','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2026-11-06 15:31:59','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2026-11-06 15:31:59','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2026-11-06 15:31:59','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2026-11-06 15:31:59','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2026-11-06 15:31:59','',NULL,'关闭状态'),(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2026-11-06 15:31:59','',NULL,'其他操作'),(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2026-11-06 15:31:59','',NULL,'新增操作'),(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2026-11-06 15:31:59','',NULL,'修改操作'),(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2026-11-06 15:31:59','',NULL,'删除操作'),(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2026-11-06 15:31:59','',NULL,'授权操作'),(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2026-11-06 15:31:59','',NULL,'导出操作'),(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2026-11-06 15:31:59','',NULL,'导入操作'),(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2026-11-06 15:31:59','',NULL,'强退操作'),(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2026-11-06 15:31:59','',NULL,'生成操作'),(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2026-11-06 15:31:59','',NULL,'清空操作'),(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2026-11-06 15:31:59','',NULL,'正常状态'),(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2026-11-06 15:31:59','',NULL,'停用状态'),(127,1,'单选题','1','exam_question_type',NULL,'primary','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(128,2,'多选题','2','exam_question_type',NULL,'primary','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(129,3,'判断题','3','exam_question_type',NULL,'primary','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(130,4,'简答题','4','exam_question_type',NULL,'primary','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(131,5,'综合题','5','exam_question_type',NULL,'primary','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(132,1,'容易','1','exam_difficulty',NULL,'success','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(133,2,'中等','2','exam_difficulty',NULL,'primary','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(134,3,'较难','3','exam_difficulty',NULL,'warning','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(135,4,'困难','4','exam_difficulty',NULL,'danger','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(136,1,'草稿','0','exam_question_status',NULL,'info','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(137,2,'待审','1','exam_question_status',NULL,'warning','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(138,3,'已通过','2','exam_question_status',NULL,'success','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(139,4,'已驳回','3','exam_question_status',NULL,'danger','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(140,1,'人工录入','0','exam_source',NULL,'primary','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(141,2,'AI生成','1','exam_source',NULL,'success','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(142,1,'生成中','0','exam_paper_status',NULL,'warning','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(143,2,'已完成','1','exam_paper_status',NULL,'success','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(144,3,'已导出','2','exam_paper_status',NULL,'primary','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(145,1,'否','0','exam_yes_no',NULL,'info','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(146,2,'是','1','exam_yes_no',NULL,'success','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(147,1,'AI出题','1','exam_task_type',NULL,'primary','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(148,2,'重新生成','2','exam_task_type',NULL,'warning','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(149,1,'成功','0','exam_call_status',NULL,'success','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(150,2,'失败','1','exam_call_status',NULL,'danger','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(151,1,'提交待审','1','exam_review_action',NULL,'warning','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(152,2,'审核通过','2','exam_review_action',NULL,'success','N','0','admin','2026-11-07 10:28:27','',NULL,NULL),(153,3,'审核驳回','3','exam_review_action',NULL,'danger','N','0','admin','2026-11-07 10:28:27','',NULL,NULL);
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2026-11-06 15:31:59','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2026-11-06 15:31:59','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2026-11-06 15:31:59','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2026-11-06 15:31:59','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2026-11-06 15:31:59','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2026-11-06 15:31:59','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2026-11-06 15:31:59','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2026-11-06 15:31:59','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2026-11-06 15:31:59','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2026-11-06 15:31:59','',NULL,'登录状态列表'),(109,'试题题型','exam_question_type','0','admin','2026-11-07 10:28:27','',NULL,'试卷生成系统'),(110,'试题难度','exam_difficulty','0','admin','2026-11-07 10:28:27','',NULL,'试卷生成系统'),(111,'题目状态','exam_question_status','0','admin','2026-11-07 10:28:27','',NULL,'试卷生成系统'),(112,'题目来源','exam_source','0','admin','2026-11-07 10:28:27','',NULL,'试卷生成系统'),(113,'试卷状态','exam_paper_status','0','admin','2026-11-07 10:28:27','',NULL,'试卷生成系统'),(114,'是否','exam_yes_no','0','admin','2026-11-07 10:28:27','',NULL,'试卷生成系统：0否 1是'),(115,'调用任务类型','exam_task_type','0','admin','2026-11-07 10:28:27','',NULL,'试卷生成系统'),(116,'调用结果','exam_call_status','0','admin','2026-11-07 10:28:27','',NULL,'试卷生成系统'),(117,'审核操作','exam_review_action','0','admin','2026-11-07 10:28:27','',NULL,'试卷生成系统');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作系统',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (100,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-06 15:55:40'),(101,'admin','127.0.0.1','内网IP','Chrome 156','Mac OS >=10.15.7','0','登录成功','2026-11-06 15:57:57'),(102,'admin','127.0.0.1','内网IP','Chrome 156','Mac OS >=10.15.7','0','登录成功','2026-11-06 18:03:06'),(103,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-06 18:03:07'),(104,'admin','127.0.0.1','内网IP','Chrome 156','Mac OS >=10.15.7','0','退出成功','2026-11-06 18:12:50'),(105,'admin','127.0.0.1','内网IP','Chrome 156','Mac OS >=10.15.7','0','登录成功','2026-11-06 18:12:54'),(106,'admin','127.0.0.1','内网IP','Chrome 156','Mac OS >=10.15.7','0','登录成功','2026-11-06 18:20:23'),(107,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-06 18:20:47'),(108,'admin','127.0.0.1','内网IP','Chrome 156','Mac OS >=10.15.7','0','登录成功','2026-11-07 10:14:47'),(109,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 10:22:19'),(110,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 10:24:45'),(111,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 10:28:28'),(112,'admin','127.0.0.1','内网IP','Python-urllib 3.13','','0','登录成功','2026-11-07 10:30:37'),(113,'admin','127.0.0.1','内网IP','Python-urllib 3.13','','0','登录成功','2026-11-07 10:30:49'),(114,'admin','127.0.0.1','内网IP','Python-urllib 3.13','','0','登录成功','2026-11-07 10:31:02'),(115,'admin','127.0.0.1','内网IP','Python-urllib 3.13','','0','登录成功','2026-11-07 10:52:08'),(116,'admin','127.0.0.1','内网IP','Python-urllib 3.13','','0','登录成功','2026-11-07 10:57:25'),(117,'admin','127.0.0.1','内网IP','Python-urllib 3.13','','0','登录成功','2026-11-07 10:58:18'),(118,'admin','127.0.0.1','内网IP','Hacker','Hacker','0','登录成功','2026-11-07 10:59:50'),(119,'admin','127.0.0.1','内网IP','Hacker','Hacker','0','登录成功','2026-11-07 11:00:33'),(120,'admin','127.0.0.1','内网IP','Hacker','Hacker','0','登录成功','2026-11-07 11:04:53'),(121,'admin','127.0.0.1','内网IP','Hacker','Hacker','0','登录成功','2026-11-07 11:06:00'),(122,'admin','127.0.0.1','内网IP','Hacker','Hacker','0','登录成功','2026-11-07 11:07:06'),(123,'admin','127.0.0.1','内网IP','Hacker','Hacker','0','登录成功','2026-11-07 11:08:00'),(124,'admin','127.0.0.1','内网IP','Hacker','Hacker','0','登录成功','2026-11-07 11:08:39'),(125,'admin','127.0.0.1','内网IP','Python-urllib 3.13','','0','登录成功','2026-11-07 11:18:36'),(126,'admin','127.0.0.1','内网IP','Hacker','Hacker','0','登录成功','2026-11-07 11:20:04'),(127,'admin','127.0.0.1','内网IP','Hacker','Hacker','0','登录成功','2026-11-07 11:20:13'),(128,'admin','127.0.0.1','内网IP','Hacker','Hacker','0','登录成功','2026-11-07 11:20:52'),(129,'admin','127.0.0.1','内网IP','Hacker','Hacker','0','登录成功','2026-11-07 11:21:16'),(130,'admin','127.0.0.1','内网IP','Hacker','Hacker','0','登录成功','2026-11-07 11:21:36'),(131,'admin','127.0.0.1','内网IP','Hacker','Hacker','0','登录成功','2026-11-07 11:21:47'),(132,'admin','127.0.0.1','内网IP','Hacker','Hacker','0','登录成功','2026-11-07 11:22:24'),(133,'admin','127.0.0.1','内网IP','Hacker','Hacker','0','登录成功','2026-11-07 11:22:50'),(134,'admin','127.0.0.1','内网IP','Hacker','Hacker','0','登录成功','2026-11-07 11:23:11'),(135,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 11:27:49'),(136,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 11:35:42'),(137,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 11:49:03'),(138,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 11:57:04'),(139,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 12:04:07'),(140,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 12:04:27'),(141,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 12:04:51'),(142,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 12:05:12'),(143,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 12:06:17'),(144,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 12:06:41'),(145,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 12:47:27'),(146,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 12:49:03'),(147,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 12:49:22'),(148,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 12:50:11'),(149,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 12:58:30'),(150,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 12:59:07'),(151,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 13:11:48'),(152,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 13:16:53'),(153,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 13:17:42'),(154,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 13:23:11'),(155,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 13:30:13'),(156,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 13:30:18'),(157,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 13:30:22'),(158,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 13:36:42'),(159,'admin','127.0.0.1','内网IP','Chrome 156','Mac OS >=10.15.7','0','登录成功','2026-11-07 21:15:13'),(160,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 21:33:07'),(161,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 21:46:49'),(162,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 22:07:15'),(163,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 22:08:16'),(164,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 22:12:55'),(165,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 22:15:47'),(166,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-07 22:18:05'),(167,'admin','127.0.0.1','内网IP','Chrome 156','Mac OS >=10.15.7','0','登录成功','2026-11-07 22:42:39'),(168,'admin','127.0.0.1','内网IP','Chrome 156','Mac OS >=10.15.7','0','登录成功','2026-11-08 10:09:03'),(169,'admin','127.0.0.1','内网IP','Python-urllib 3.13','','0','登录成功','2026-11-08 11:37:14'),(170,'admin','127.0.0.1','内网IP','Python-urllib 3.13','','0','登录成功','2026-11-08 11:43:35'),(171,'admin','127.0.0.1','内网IP','Python-urllib 3.13','','0','登录成功','2026-11-08 11:56:48'),(172,'admin','127.0.0.1','内网IP','Chrome 156','Mac OS >=10.15.7','0','退出成功','2026-11-08 11:59:26'),(173,'admin','127.0.0.1','内网IP','Chrome 156','Mac OS >=10.15.7','0','登录成功','2026-11-08 11:59:27'),(174,'admin','127.0.0.1','内网IP','Curl 8.7.1','','0','登录成功','2026-11-08 12:48:15'),(175,'admin','127.0.0.1','内网IP','Chrome 156','Mac OS >=10.15.7','0','登录成功','2026-11-08 15:10:52'),(176,'admin','127.0.0.1','内网IP','Chrome 156','Mac OS >=10.15.7','0','登录成功','2026-11-08 16:26:35');
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '路由名称',
  `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2053 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'用户与权限',0,1,'system',NULL,'','',1,0,'M','0','0','','system','admin','2026-11-06 15:31:59','',NULL,'系统管理目录'),(3,'系统工具',0,3,'tool',NULL,'','',1,0,'M','0','0','','tool','admin','2026-11-06 15:31:59','',NULL,'系统工具目录'),(100,'用户管理',1,1,'user','system/user/index','','',1,0,'C','0','0','system:user:list','user','admin','2026-11-06 15:31:59','',NULL,'用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','','',1,0,'C','0','0','system:role:list','peoples','admin','2026-11-06 15:31:59','',NULL,'角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','','',1,0,'C','0','0','system:menu:list','tree-table','admin','2026-11-06 15:31:59','',NULL,'菜单管理菜单'),(116,'代码生成',3,2,'gen','tool/gen/index','','',1,0,'C','0','0','tool:gen:list','code','admin','2026-11-06 15:31:59','',NULL,'代码生成菜单'),(1000,'用户查询',100,1,'','','','',1,0,'F','0','0','system:user:query','#','admin','2026-11-06 15:31:59','',NULL,''),(1001,'用户新增',100,2,'','','','',1,0,'F','0','0','system:user:add','#','admin','2026-11-06 15:31:59','',NULL,''),(1002,'用户修改',100,3,'','','','',1,0,'F','0','0','system:user:edit','#','admin','2026-11-06 15:31:59','',NULL,''),(1003,'用户删除',100,4,'','','','',1,0,'F','0','0','system:user:remove','#','admin','2026-11-06 15:31:59','',NULL,''),(1004,'用户导出',100,5,'','','','',1,0,'F','0','0','system:user:export','#','admin','2026-11-06 15:31:59','',NULL,''),(1005,'用户导入',100,6,'','','','',1,0,'F','0','0','system:user:import','#','admin','2026-11-06 15:31:59','',NULL,''),(1006,'重置密码',100,7,'','','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2026-11-06 15:31:59','',NULL,''),(1007,'角色查询',101,1,'','','','',1,0,'F','0','0','system:role:query','#','admin','2026-11-06 15:31:59','',NULL,''),(1008,'角色新增',101,2,'','','','',1,0,'F','0','0','system:role:add','#','admin','2026-11-06 15:31:59','',NULL,''),(1009,'角色修改',101,3,'','','','',1,0,'F','0','0','system:role:edit','#','admin','2026-11-06 15:31:59','',NULL,''),(1010,'角色删除',101,4,'','','','',1,0,'F','0','0','system:role:remove','#','admin','2026-11-06 15:31:59','',NULL,''),(1011,'角色导出',101,5,'','','','',1,0,'F','0','0','system:role:export','#','admin','2026-11-06 15:31:59','',NULL,''),(1012,'菜单查询',102,1,'','','','',1,0,'F','0','0','system:menu:query','#','admin','2026-11-06 15:31:59','',NULL,''),(1013,'菜单新增',102,2,'','','','',1,0,'F','0','0','system:menu:add','#','admin','2026-11-06 15:31:59','',NULL,''),(1014,'菜单修改',102,3,'','','','',1,0,'F','0','0','system:menu:edit','#','admin','2026-11-06 15:31:59','',NULL,''),(1015,'菜单删除',102,4,'','','','',1,0,'F','0','0','system:menu:remove','#','admin','2026-11-06 15:31:59','',NULL,''),(1055,'生成查询',116,1,'#','','','',1,0,'F','0','0','tool:gen:query','#','admin','2026-11-06 15:31:59','',NULL,''),(1056,'生成修改',116,2,'#','','','',1,0,'F','0','0','tool:gen:edit','#','admin','2026-11-06 15:31:59','',NULL,''),(1057,'生成删除',116,3,'#','','','',1,0,'F','0','0','tool:gen:remove','#','admin','2026-11-06 15:31:59','',NULL,''),(1058,'导入代码',116,4,'#','','','',1,0,'F','0','0','tool:gen:import','#','admin','2026-11-06 15:31:59','',NULL,''),(1059,'预览代码',116,5,'#','','','',1,0,'F','0','0','tool:gen:preview','#','admin','2026-11-06 15:31:59','',NULL,''),(1060,'生成代码',116,6,'#','','','',1,0,'F','0','0','tool:gen:code','#','admin','2026-11-06 15:31:59','',NULL,''),(2000,'试卷管理',0,5,'exam','',NULL,'',1,0,'M','0','0','','education','admin','2026-11-07 10:29:51','',NULL,'基于大语言模型的试卷生成系统'),(2002,'课程查询',2049,1,'#','',NULL,'',1,0,'F','0','0','exam:course:query','#','admin','2026-11-07 10:29:51','',NULL,''),(2003,'课程新增',2049,2,'#','',NULL,'',1,0,'F','0','0','exam:course:add','#','admin','2026-11-07 10:29:51','',NULL,''),(2004,'课程修改',2049,3,'#','',NULL,'',1,0,'F','0','0','exam:course:edit','#','admin','2026-11-07 10:29:51','',NULL,''),(2005,'课程删除',2049,4,'#','',NULL,'',1,0,'F','0','0','exam:course:remove','#','admin','2026-11-07 10:29:51','',NULL,''),(2008,'章节查询',2049,1,'#','',NULL,'',1,0,'F','0','0','exam:chapter:query','#','admin','2026-11-07 10:29:51','',NULL,''),(2009,'章节新增',2049,2,'#','',NULL,'',1,0,'F','0','0','exam:chapter:add','#','admin','2026-11-07 10:29:51','',NULL,''),(2010,'章节修改',2049,3,'#','',NULL,'',1,0,'F','0','0','exam:chapter:edit','#','admin','2026-11-07 10:29:51','',NULL,''),(2011,'章节删除',2049,4,'#','',NULL,'',1,0,'F','0','0','exam:chapter:remove','#','admin','2026-11-07 10:29:51','',NULL,''),(2014,'知识点查询',2049,1,'#','',NULL,'',1,0,'F','0','0','exam:knowledge:query','#','admin','2026-11-07 10:29:51','',NULL,''),(2015,'知识点新增',2049,2,'#','',NULL,'',1,0,'F','0','0','exam:knowledge:add','#','admin','2026-11-07 10:29:51','',NULL,''),(2016,'知识点修改',2049,3,'#','',NULL,'',1,0,'F','0','0','exam:knowledge:edit','#','admin','2026-11-07 10:29:51','',NULL,''),(2017,'知识点删除',2049,4,'#','',NULL,'',1,0,'F','0','0','exam:knowledge:remove','#','admin','2026-11-07 10:29:51','',NULL,''),(2019,'题库',2000,1,'question','exam/question/index',NULL,'',1,0,'C','0','0','exam:question:list','#','admin','2026-11-07 10:29:51','admin','2026-11-08 12:52:02','题库菜单'),(2020,'题库查询',2019,1,'#','',NULL,'',1,0,'F','0','0','exam:question:query','#','admin','2026-11-07 10:29:51','',NULL,''),(2021,'题库新增',2019,2,'#','',NULL,'',1,0,'F','0','0','exam:question:add','#','admin','2026-11-07 10:29:51','',NULL,''),(2022,'题库修改',2019,3,'#','',NULL,'',1,0,'F','0','0','exam:question:edit','#','admin','2026-11-07 10:29:51','',NULL,''),(2023,'题库删除',2019,4,'#','',NULL,'',1,0,'F','0','0','exam:question:remove','#','admin','2026-11-07 10:29:51','',NULL,''),(2025,'题目审核记录',2000,1,'reviewLog','exam/reviewLog/index',NULL,'',1,0,'C','0','0','exam:reviewLog:list','#','admin','2026-11-07 10:29:51','',NULL,'题目审核记录菜单'),(2026,'题目审核记录查询',2025,1,'#','',NULL,'',1,0,'F','0','0','exam:reviewLog:query','#','admin','2026-11-07 10:29:51','',NULL,''),(2027,'题目审核记录新增',2025,2,'#','',NULL,'',1,0,'F','0','0','exam:reviewLog:add','#','admin','2026-11-07 10:29:51','',NULL,''),(2028,'题目审核记录修改',2025,3,'#','',NULL,'',1,0,'F','0','0','exam:reviewLog:edit','#','admin','2026-11-07 10:29:51','',NULL,''),(2029,'题目审核记录删除',2025,4,'#','',NULL,'',1,0,'F','0','0','exam:reviewLog:remove','#','admin','2026-11-07 10:29:51','',NULL,''),(2031,'试卷',2000,1,'paper','exam/paper/index',NULL,'',1,0,'C','0','0','exam:paper:list','#','admin','2026-11-07 10:29:51','',NULL,'试卷菜单'),(2032,'试卷查询',2031,1,'#','',NULL,'',1,0,'F','0','0','exam:paper:query','#','admin','2026-11-07 10:29:51','',NULL,''),(2033,'试卷新增',2031,2,'#','',NULL,'',1,0,'F','0','0','exam:paper:add','#','admin','2026-11-07 10:29:51','',NULL,''),(2034,'试卷修改',2031,3,'#','',NULL,'',1,0,'F','0','0','exam:paper:edit','#','admin','2026-11-07 10:29:51','',NULL,''),(2035,'试卷删除',2031,4,'#','',NULL,'',1,0,'F','0','0','exam:paper:remove','#','admin','2026-11-07 10:29:51','',NULL,''),(2036,'试卷导出',2031,5,'#','',NULL,'',1,0,'F','0','0','exam:paper:export','#','admin','2026-11-07 10:29:51','',NULL,''),(2037,'试卷明细',2000,1,'paperQuestion','exam/paperQuestion/index',NULL,'',1,0,'C','1','0','exam:paperQuestion:list','#','admin','2026-11-07 10:29:51','',NULL,'试卷明细菜单'),(2038,'试卷明细查询',2037,1,'#','',NULL,'',1,0,'F','0','0','exam:paperQuestion:query','#','admin','2026-11-07 10:29:51','',NULL,''),(2039,'试卷明细新增',2037,2,'#','',NULL,'',1,0,'F','0','0','exam:paperQuestion:add','#','admin','2026-11-07 10:29:51','',NULL,''),(2040,'试卷明细修改',2037,3,'#','',NULL,'',1,0,'F','0','0','exam:paperQuestion:edit','#','admin','2026-11-07 10:29:51','',NULL,''),(2041,'试卷明细删除',2037,4,'#','',NULL,'',1,0,'F','0','0','exam:paperQuestion:remove','#','admin','2026-11-07 10:29:51','',NULL,''),(2043,'大模型调用日志',2050,3,'aiCallLog','exam/aiCallLog/index',NULL,'',1,0,'C','0','0','exam:aiCallLog:list','#','admin','2026-11-07 10:29:51','',NULL,'大模型调用日志菜单'),(2044,'大模型调用日志查询',2043,1,'#','',NULL,'',1,0,'F','0','0','exam:aiCallLog:query','#','admin','2026-11-07 10:29:51','',NULL,''),(2045,'大模型调用日志新增',2043,2,'#','',NULL,'',1,0,'F','0','0','exam:aiCallLog:add','#','admin','2026-11-07 10:29:51','',NULL,''),(2046,'大模型调用日志修改',2043,3,'#','',NULL,'',1,0,'F','0','0','exam:aiCallLog:edit','#','admin','2026-11-07 10:29:51','',NULL,''),(2047,'大模型调用日志删除',2043,4,'#','',NULL,'',1,0,'F','0','0','exam:aiCallLog:remove','#','admin','2026-11-07 10:29:51','',NULL,''),(2049,'课程章节知识点',2000,0,'basic','exam/basic/index',NULL,'',1,0,'C','0','0','exam:basic:list','#','admin','2026-11-08 12:25:39','',NULL,'课程、章节、知识点合并维护页面'),(2050,'大模型管理',0,6,'llm','',NULL,'',1,0,'M','0','0','','code','admin','2026-11-08 12:54:10','',NULL,'模型配置 / 提示词 / 调用日志'),(2051,'模型配置',2050,1,'modelConfig','exam/modelConfig/index',NULL,'',1,0,'C','0','0','exam:modelConfig:list','#','admin','2026-11-08 12:54:10','',NULL,'模型配置菜单'),(2052,'提示词',2050,2,'prompt','exam/prompt/index',NULL,'',1,0,'C','0','0','exam:prompt:list','#','admin','2026-11-08 12:54:10','',NULL,'提示词菜单');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (100,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"exam_ai_call_log,exam_chapter,exam_course,exam_knowledge,exam_paper,exam_paper_question,exam_question,exam_review_log\",\"tplWebType\":\"element-plus\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-11-07 10:17:09',261),(101,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"exam_course,exam_chapter,exam_knowledge,exam_question,exam_review_log,exam_paper,exam_paper_question,exam_ai_call_log\"}',NULL,0,NULL,'2026-11-07 10:24:45',203),(102,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"exam_course,exam_chapter,exam_knowledge,exam_question,exam_review_log,exam_paper,exam_paper_question,exam_ai_call_log\"}',NULL,0,NULL,'2026-11-07 10:28:29',153),(103,'课程',1,'com.ruoyi.exam.controller.ExamCourseController.add()','POST',1,'admin','研发部门','/exam/course','127.0.0.1','内网IP','{\"courseCode\":\"TEST999\",\"courseName\":\"接口测试课程\",\"createTime\":\"2026-11-07 10:31:02\",\"id\":2,\"params\":{},\"remark\":\"自动验证用\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-11-07 10:31:02',16),(104,'课程',3,'com.ruoyi.exam.controller.ExamCourseController.remove()','DELETE',1,'admin','研发部门','/exam/course/2','127.0.0.1','内网IP','[2] ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-11-07 10:31:02',6),(105,'试卷',5,'com.ruoyi.exam.controller.ExamPaperController.export()','POST',1,'admin','研发部门','/exam/paper/export','127.0.0.1','内网IP','{\"pageSize\":\"10\",\"pageNum\":\"1\"}',NULL,0,NULL,'2026-11-07 10:55:00',1016),(106,'题目审核记录',5,'com.ruoyi.exam.controller.ExamReviewLogController.export()','POST',1,'admin','研发部门','/exam/reviewLog/export','127.0.0.1','内网IP','{\"params\":{}} ',NULL,0,NULL,'2026-11-07 13:30:24',1142),(107,'试卷',5,'com.ruoyi.exam.controller.ExamPaperController.export()','POST',1,'admin','研发部门','/exam/paper/export','127.0.0.1','内网IP','{\"params\":{}} ',NULL,0,NULL,'2026-11-07 13:36:54',1105),(108,'试卷明细',5,'com.ruoyi.exam.controller.ExamPaperQuestionController.export()','POST',1,'admin','研发部门','/exam/paperQuestion/export','127.0.0.1','内网IP','{\"params\":{}} ',NULL,0,NULL,'2026-11-07 13:36:54',24),(109,'章节',5,'com.ruoyi.exam.controller.ExamChapterController.export()','POST',1,'admin','研发部门','/exam/chapter/export','127.0.0.1','内网IP','{\"params\":{}} ',NULL,0,NULL,'2026-11-07 13:36:54',19),(110,'知识点',5,'com.ruoyi.exam.controller.ExamKnowledgeController.export()','POST',1,'admin','研发部门','/exam/knowledge/export','127.0.0.1','内网IP','{\"params\":{}} ',NULL,0,NULL,'2026-11-07 13:36:54',24),(111,'大模型调用日志',5,'com.ruoyi.exam.controller.ExamAiCallLogController.export()','POST',1,'admin','研发部门','/exam/aiCallLog/export','127.0.0.1','内网IP','{\"params\":{}} ',NULL,0,NULL,'2026-11-07 13:36:54',26),(112,'试卷',5,'com.ruoyi.exam.controller.ExamPaperController.export()','POST',1,'admin','研发部门','/exam/paper/export','127.0.0.1','内网IP','{\"params\":{}} ',NULL,0,NULL,'2026-11-07 13:36:59',24),(113,'试卷明细',5,'com.ruoyi.exam.controller.ExamPaperQuestionController.export()','POST',1,'admin','研发部门','/exam/paperQuestion/export','127.0.0.1','内网IP','{\"params\":{}} ',NULL,0,NULL,'2026-11-07 13:36:59',20),(114,'题目审核记录',5,'com.ruoyi.exam.controller.ExamReviewLogController.export()','POST',1,'admin','研发部门','/exam/reviewLog/export','127.0.0.1','内网IP','{\"pageSize\":\"10\",\"pageNum\":\"1\"}',NULL,0,NULL,'2026-11-07 21:39:55',167),(115,'试卷',5,'com.ruoyi.exam.controller.ExamPaperController.export()','POST',1,'admin','研发部门','/exam/paper/export','127.0.0.1','内网IP','{\"pageSize\":\"10\",\"pageNum\":\"1\"}',NULL,0,NULL,'2026-11-07 21:47:52',1182),(116,'试卷',5,'com.ruoyi.exam.controller.ExamPaperController.export()','POST',1,'admin','研发部门','/exam/paper/export','127.0.0.1','内网IP','{\"pageSize\":\"10\",\"pageNum\":\"1\"}',NULL,0,NULL,'2026-11-08 10:47:43',2195),(117,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"exam_prompt,exam_model_config\",\"tplWebType\":\"element-plus\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-11-08 12:46:13',138),(118,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"exam_model_config,exam_prompt\"}',NULL,0,NULL,'2026-11-08 12:48:15',180),(119,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"exam/question/index\",\"createTime\":\"2026-11-07 10:29:51\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2019,\"menuName\":\"题库\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"question\",\"perms\":\"exam:question:list\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-11-08 12:51:40',38),(120,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"exam/question/index\",\"createTime\":\"2026-11-07 10:29:51\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2019,\"menuName\":\"题库\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"question\",\"perms\":\"exam:question:list\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"1\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2026-11-08 12:52:02',20);
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_post`
--

DROP TABLE IF EXISTS `sys_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_post` (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='岗位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_post`
--

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` VALUES (1,'ceo','董事长',1,'0','admin','2026-11-06 15:31:59','',NULL,''),(2,'se','项目经理',2,'0','admin','2026-11-06 15:31:59','',NULL,''),(3,'hr','人力资源',3,'0','admin','2026-11-06 15:31:59','',NULL,''),(4,'user','普通员工',4,'0','admin','2026-11-06 15:31:59','',NULL,'');
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1',1,1,'0','0','admin','2026-11-06 15:31:59','',NULL,'超级管理员'),(2,'普通角色','common',2,'2',1,1,'0','0','admin','2026-11-06 15:31:59','',NULL,'普通角色');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色和部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
INSERT INTO `sys_role_dept` VALUES (2,100),(2,101),(2,105);
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (2,1),(2,3),(2,100),(2,101),(2,102),(2,116),(2,1000),(2,1001),(2,1002),(2,1003),(2,1004),(2,1005),(2,1006),(2,1007),(2,1008),(2,1009),(2,1010),(2,1011),(2,1012),(2,1013),(2,1014),(2,1015),(2,1055),(2,1056),(2,1057),(2,1058),(2,1059),(2,1060);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) COLLATE utf8mb4_general_ci DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '手机号码',
  `sex` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '密码',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,103,'admin','若依','00','ry@163.com','15888888888','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2026-11-08 16:26:35','2026-11-06 15:31:59','admin','2026-11-06 15:31:59','',NULL,'管理员'),(2,105,'ry','若依','00','ry@qq.com','15666666666','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2026-11-06 15:31:59','2026-11-06 15:31:59','admin','2026-11-06 15:31:59','',NULL,'测试员');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户与岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-08 17:13:09

-- MySQL dump 10.13  Distrib 9.6.0, for macos15.7 (arm64)
--
-- Host: localhost    Database: ry-vue
-- ------------------------------------------------------
-- Server version	9.6.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `exam_model_config`
--

DROP TABLE IF EXISTS `exam_model_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_model_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置名称',
  `base_url` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '接口地址（填到 /v1 为止）',
  `api_key` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '密钥（存 AES 密文）',
  `model_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '模型名称',
  `is_default` char(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '是否启用（0否 1是）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='模型配置';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-08 17:13:10

-- 模型配置表含加密密钥，此处只导结构不导数据；恢复后请在「大模型管理-模型配置」页面填一次 Key
