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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'e7c05fa4-37fb-11f1-8ee2-35c643fb23bc:1-34918';

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
INSERT INTO `exam_course` VALUES (1,'数据库原理与应用','DB301','本科必修课，每周 4 学时，期末闭卷考试',NULL,'2026-11-07 10:31:01',NULL,NULL);
/*!40000 ALTER TABLE `exam_course` ENABLE KEYS */;
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
INSERT INTO `exam_paper` VALUES (1,1,'数据库原理与应用 期末测验（A 卷·演示）',100,'{\"totalScore\":100,\"typeRatio\":{\"1\":6,\"2\":1,\"3\":1,\"4\":2},\"difficultyRatio\":{\"1\":3,\"2\":6,\"3\":1},\"coverage\":0.60}','1',NULL,'2026-11-07 10:31:01',NULL,NULL),(3,1,'数据库原理与应用 期末测验（组卷演示）2',100,'{\"totalScore\":100,\"typeRatio\":{\"1\":10,\"2\":2,\"3\":2,\"4\":2},\"difficultyRatio\":{\"1\":3,\"2\":6,\"3\":1},\"coverage\":0.8}','1',NULL,'2026-11-07 21:41:03',NULL,NULL),(6,1,'数据库原理与应用 期末测验（组卷演示）',100,'{\"totalScore\":100,\"typeRatio\":{\"1\":6,\"2\":1,\"3\":1,\"4\":2},\"difficultyRatio\":{\"1\":3,\"2\":6,\"3\":1},\"coverage\":0.6,\"chapterIds\":[1,2],\"chapterNames\":[\"第一章 数据库系统概述\",\"第二章 关系模型与关系代数\"]}','1',NULL,'2026-11-07 21:47:39',NULL,NULL),(7,1,'1章',100,'{\"totalScore\":100,\"typeRatio\":{\"1\":6,\"2\":1,\"3\":1,\"4\":2},\"difficultyRatio\":{\"1\":3,\"2\":6,\"3\":1},\"coverage\":0.7,\"chapterIds\":[1],\"chapterNames\":[\"第一章 数据库系统概述\"]}','1',NULL,'2026-11-07 21:55:47',NULL,NULL),(8,1,'数据库原理与应用 期末测验（组卷演示）',100,'{\"totalScore\":100,\"typeRatio\":{\"1\":6,\"2\":2,\"3\":2,\"4\":2},\"difficultyRatio\":{\"1\":3,\"2\":6,\"3\":1},\"coverage\":0.6,\"chapterIds\":[1],\"chapterNames\":[\"第一章 数据库系统概述\"]}','1',NULL,'2026-11-07 21:57:22',NULL,NULL);
/*!40000 ALTER TABLE `exam_paper` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-08 17:06:46
