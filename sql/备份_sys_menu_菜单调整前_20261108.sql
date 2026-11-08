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

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'e7c05fa4-37fb-11f1-8ee2-35c643fb23bc:1-34882';

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
) ENGINE=InnoDB AUTO_INCREMENT=2050 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'用户与权限',0,1,'system',NULL,'','',1,0,'M','0','0','','system','admin','2026-11-06 15:31:59','',NULL,'系统管理目录'),(3,'系统工具',0,3,'tool',NULL,'','',1,0,'M','0','0','','tool','admin','2026-11-06 15:31:59','',NULL,'系统工具目录'),(100,'用户管理',1,1,'user','system/user/index','','',1,0,'C','0','0','system:user:list','user','admin','2026-11-06 15:31:59','',NULL,'用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','','',1,0,'C','0','0','system:role:list','peoples','admin','2026-11-06 15:31:59','',NULL,'角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','','',1,0,'C','0','0','system:menu:list','tree-table','admin','2026-11-06 15:31:59','',NULL,'菜单管理菜单'),(116,'代码生成',3,2,'gen','tool/gen/index','','',1,0,'C','0','0','tool:gen:list','code','admin','2026-11-06 15:31:59','',NULL,'代码生成菜单'),(1000,'用户查询',100,1,'','','','',1,0,'F','0','0','system:user:query','#','admin','2026-11-06 15:31:59','',NULL,''),(1001,'用户新增',100,2,'','','','',1,0,'F','0','0','system:user:add','#','admin','2026-11-06 15:31:59','',NULL,''),(1002,'用户修改',100,3,'','','','',1,0,'F','0','0','system:user:edit','#','admin','2026-11-06 15:31:59','',NULL,''),(1003,'用户删除',100,4,'','','','',1,0,'F','0','0','system:user:remove','#','admin','2026-11-06 15:31:59','',NULL,''),(1004,'用户导出',100,5,'','','','',1,0,'F','0','0','system:user:export','#','admin','2026-11-06 15:31:59','',NULL,''),(1005,'用户导入',100,6,'','','','',1,0,'F','0','0','system:user:import','#','admin','2026-11-06 15:31:59','',NULL,''),(1006,'重置密码',100,7,'','','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2026-11-06 15:31:59','',NULL,''),(1007,'角色查询',101,1,'','','','',1,0,'F','0','0','system:role:query','#','admin','2026-11-06 15:31:59','',NULL,''),(1008,'角色新增',101,2,'','','','',1,0,'F','0','0','system:role:add','#','admin','2026-11-06 15:31:59','',NULL,''),(1009,'角色修改',101,3,'','','','',1,0,'F','0','0','system:role:edit','#','admin','2026-11-06 15:31:59','',NULL,''),(1010,'角色删除',101,4,'','','','',1,0,'F','0','0','system:role:remove','#','admin','2026-11-06 15:31:59','',NULL,''),(1011,'角色导出',101,5,'','','','',1,0,'F','0','0','system:role:export','#','admin','2026-11-06 15:31:59','',NULL,''),(1012,'菜单查询',102,1,'','','','',1,0,'F','0','0','system:menu:query','#','admin','2026-11-06 15:31:59','',NULL,''),(1013,'菜单新增',102,2,'','','','',1,0,'F','0','0','system:menu:add','#','admin','2026-11-06 15:31:59','',NULL,''),(1014,'菜单修改',102,3,'','','','',1,0,'F','0','0','system:menu:edit','#','admin','2026-11-06 15:31:59','',NULL,''),(1015,'菜单删除',102,4,'','','','',1,0,'F','0','0','system:menu:remove','#','admin','2026-11-06 15:31:59','',NULL,''),(1055,'生成查询',116,1,'#','','','',1,0,'F','0','0','tool:gen:query','#','admin','2026-11-06 15:31:59','',NULL,''),(1056,'生成修改',116,2,'#','','','',1,0,'F','0','0','tool:gen:edit','#','admin','2026-11-06 15:31:59','',NULL,''),(1057,'生成删除',116,3,'#','','','',1,0,'F','0','0','tool:gen:remove','#','admin','2026-11-06 15:31:59','',NULL,''),(1058,'导入代码',116,4,'#','','','',1,0,'F','0','0','tool:gen:import','#','admin','2026-11-06 15:31:59','',NULL,''),(1059,'预览代码',116,5,'#','','','',1,0,'F','0','0','tool:gen:preview','#','admin','2026-11-06 15:31:59','',NULL,''),(1060,'生成代码',116,6,'#','','','',1,0,'F','0','0','tool:gen:code','#','admin','2026-11-06 15:31:59','',NULL,''),(2000,'试卷管理',0,5,'exam','',NULL,'',1,0,'M','0','0','','education','admin','2026-11-07 10:29:51','',NULL,'基于大语言模型的试卷生成系统'),(2001,'课程',2000,1,'course','exam/course/index',NULL,'',1,0,'C','0','0','exam:course:list','#','admin','2026-11-07 10:29:51','',NULL,'课程菜单'),(2002,'课程查询',2001,1,'#','',NULL,'',1,0,'F','0','0','exam:course:query','#','admin','2026-11-07 10:29:51','',NULL,''),(2003,'课程新增',2001,2,'#','',NULL,'',1,0,'F','0','0','exam:course:add','#','admin','2026-11-07 10:29:51','',NULL,''),(2004,'课程修改',2001,3,'#','',NULL,'',1,0,'F','0','0','exam:course:edit','#','admin','2026-11-07 10:29:51','',NULL,''),(2005,'课程删除',2001,4,'#','',NULL,'',1,0,'F','0','0','exam:course:remove','#','admin','2026-11-07 10:29:51','',NULL,''),(2007,'章节',2000,1,'chapter','exam/chapter/index',NULL,'',1,0,'C','0','0','exam:chapter:list','#','admin','2026-11-07 10:29:51','',NULL,'章节菜单'),(2008,'章节查询',2007,1,'#','',NULL,'',1,0,'F','0','0','exam:chapter:query','#','admin','2026-11-07 10:29:51','',NULL,''),(2009,'章节新增',2007,2,'#','',NULL,'',1,0,'F','0','0','exam:chapter:add','#','admin','2026-11-07 10:29:51','',NULL,''),(2010,'章节修改',2007,3,'#','',NULL,'',1,0,'F','0','0','exam:chapter:edit','#','admin','2026-11-07 10:29:51','',NULL,''),(2011,'章节删除',2007,4,'#','',NULL,'',1,0,'F','0','0','exam:chapter:remove','#','admin','2026-11-07 10:29:51','',NULL,''),(2013,'知识点',2000,1,'knowledge','exam/knowledge/index',NULL,'',1,0,'C','0','0','exam:knowledge:list','#','admin','2026-11-07 10:29:51','',NULL,'知识点菜单'),(2014,'知识点查询',2013,1,'#','',NULL,'',1,0,'F','0','0','exam:knowledge:query','#','admin','2026-11-07 10:29:51','',NULL,''),(2015,'知识点新增',2013,2,'#','',NULL,'',1,0,'F','0','0','exam:knowledge:add','#','admin','2026-11-07 10:29:51','',NULL,''),(2016,'知识点修改',2013,3,'#','',NULL,'',1,0,'F','0','0','exam:knowledge:edit','#','admin','2026-11-07 10:29:51','',NULL,''),(2017,'知识点删除',2013,4,'#','',NULL,'',1,0,'F','0','0','exam:knowledge:remove','#','admin','2026-11-07 10:29:51','',NULL,''),(2019,'题库',2000,1,'question','exam/question/index',NULL,'',1,0,'C','1','1','exam:question:list','#','admin','2026-11-07 10:29:51','admin','2026-11-08 12:52:02','题库菜单'),(2020,'题库查询',2019,1,'#','',NULL,'',1,0,'F','0','0','exam:question:query','#','admin','2026-11-07 10:29:51','',NULL,''),(2021,'题库新增',2019,2,'#','',NULL,'',1,0,'F','0','0','exam:question:add','#','admin','2026-11-07 10:29:51','',NULL,''),(2022,'题库修改',2019,3,'#','',NULL,'',1,0,'F','0','0','exam:question:edit','#','admin','2026-11-07 10:29:51','',NULL,''),(2023,'题库删除',2019,4,'#','',NULL,'',1,0,'F','0','0','exam:question:remove','#','admin','2026-11-07 10:29:51','',NULL,''),(2025,'题目审核记录',2000,1,'reviewLog','exam/reviewLog/index',NULL,'',1,0,'C','0','0','exam:reviewLog:list','#','admin','2026-11-07 10:29:51','',NULL,'题目审核记录菜单'),(2026,'题目审核记录查询',2025,1,'#','',NULL,'',1,0,'F','0','0','exam:reviewLog:query','#','admin','2026-11-07 10:29:51','',NULL,''),(2027,'题目审核记录新增',2025,2,'#','',NULL,'',1,0,'F','0','0','exam:reviewLog:add','#','admin','2026-11-07 10:29:51','',NULL,''),(2028,'题目审核记录修改',2025,3,'#','',NULL,'',1,0,'F','0','0','exam:reviewLog:edit','#','admin','2026-11-07 10:29:51','',NULL,''),(2029,'题目审核记录删除',2025,4,'#','',NULL,'',1,0,'F','0','0','exam:reviewLog:remove','#','admin','2026-11-07 10:29:51','',NULL,''),(2031,'试卷',2000,1,'paper','exam/paper/index',NULL,'',1,0,'C','0','0','exam:paper:list','#','admin','2026-11-07 10:29:51','',NULL,'试卷菜单'),(2032,'试卷查询',2031,1,'#','',NULL,'',1,0,'F','0','0','exam:paper:query','#','admin','2026-11-07 10:29:51','',NULL,''),(2033,'试卷新增',2031,2,'#','',NULL,'',1,0,'F','0','0','exam:paper:add','#','admin','2026-11-07 10:29:51','',NULL,''),(2034,'试卷修改',2031,3,'#','',NULL,'',1,0,'F','0','0','exam:paper:edit','#','admin','2026-11-07 10:29:51','',NULL,''),(2035,'试卷删除',2031,4,'#','',NULL,'',1,0,'F','0','0','exam:paper:remove','#','admin','2026-11-07 10:29:51','',NULL,''),(2036,'试卷导出',2031,5,'#','',NULL,'',1,0,'F','0','0','exam:paper:export','#','admin','2026-11-07 10:29:51','',NULL,''),(2037,'试卷明细',2000,1,'paperQuestion','exam/paperQuestion/index',NULL,'',1,0,'C','0','0','exam:paperQuestion:list','#','admin','2026-11-07 10:29:51','',NULL,'试卷明细菜单'),(2038,'试卷明细查询',2037,1,'#','',NULL,'',1,0,'F','0','0','exam:paperQuestion:query','#','admin','2026-11-07 10:29:51','',NULL,''),(2039,'试卷明细新增',2037,2,'#','',NULL,'',1,0,'F','0','0','exam:paperQuestion:add','#','admin','2026-11-07 10:29:51','',NULL,''),(2040,'试卷明细修改',2037,3,'#','',NULL,'',1,0,'F','0','0','exam:paperQuestion:edit','#','admin','2026-11-07 10:29:51','',NULL,''),(2041,'试卷明细删除',2037,4,'#','',NULL,'',1,0,'F','0','0','exam:paperQuestion:remove','#','admin','2026-11-07 10:29:51','',NULL,''),(2043,'大模型调用日志',2000,1,'aiCallLog','exam/aiCallLog/index',NULL,'',1,0,'C','0','0','exam:aiCallLog:list','#','admin','2026-11-07 10:29:51','',NULL,'大模型调用日志菜单'),(2044,'大模型调用日志查询',2043,1,'#','',NULL,'',1,0,'F','0','0','exam:aiCallLog:query','#','admin','2026-11-07 10:29:51','',NULL,''),(2045,'大模型调用日志新增',2043,2,'#','',NULL,'',1,0,'F','0','0','exam:aiCallLog:add','#','admin','2026-11-07 10:29:51','',NULL,''),(2046,'大模型调用日志修改',2043,3,'#','',NULL,'',1,0,'F','0','0','exam:aiCallLog:edit','#','admin','2026-11-07 10:29:51','',NULL,''),(2047,'大模型调用日志删除',2043,4,'#','',NULL,'',1,0,'F','0','0','exam:aiCallLog:remove','#','admin','2026-11-07 10:29:51','',NULL,''),(2049,'课程章节知识点',2000,0,'basic','exam/basic/index',NULL,'',1,0,'C','0','0','exam:basic:list','#','admin','2026-11-08 12:25:39','',NULL,'课程、章节、知识点合并维护页面');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
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

-- Dump completed on 2026-11-08 12:53:54
