-- MySQL dump 10.16  Distrib 10.1.31-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: sql_tutorial
-- ------------------------------------------------------
-- Server version	10.1.31-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `sql_tutorial`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `sql_tutorial` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `sql_tutorial`;

--
-- Table structure for table `tb_rider`
--

DROP TABLE IF EXISTS `tb_rider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_rider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `real_name_certify_state` int(11) NOT NULL DEFAULT '0' COMMENT '身份证认证状态',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '该用户是否还存在. 0: 不存在, 1: 存在',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '骑手等级：0普通 1铜牌 2银牌 3金牌',
  `level_city` varchar(32) NOT NULL DEFAULT '' COMMENT '配送员等级城市',
  PRIMARY KEY (`id`),
  KEY `ix_created_at` (`created_at`),
  KEY `ix_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='配送员信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_rider`
--

LOCK TABLES `tb_rider` WRITE;
/*!40000 ALTER TABLE `tb_rider` DISABLE KEYS */;
INSERT INTO `tb_rider` VALUES (1,'Stark',2,0,'2017-01-01 22:00:19','2018-01-01 06:40:01',3,'1'),(2,'Banner',2,0,'2017-04-28 12:01:19','2018-01-01 06:40:01',3,'9'),(3,'Rogers',2,0,'2017-04-10 17:24:01','2018-01-01 06:40:01',2,'1'),(4,'Thor',1,0,'2017-12-31 23:10:39','2018-01-01 06:40:01',0,'1'),(5,'Natasha',2,0,'2017-02-11 15:03:13','2018-01-01 06:40:01',1,'1'),(6,'Barton',2,0,'2017-02-11 15:04:19','2018-01-01 06:40:01',1,'9'),(7,'Coulson',2,0,'2017-01-03 23:00:22','2018-01-01 06:40:01',3,'9'),(8,'Coulson',1,0,'2017-01-05 10:10:23','2018-01-01 06:40:01',0,'2');
/*!40000 ALTER TABLE `tb_rider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_customer`
--

DROP TABLE IF EXISTS `tb_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `customer_id` varchar(100) NOT NULL DEFAULT '' COMMENT '用户id',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '用户姓名',
  `gender` varchar(30) NOT NULL DEFAULT '' COMMENT '用户性别',
  `balance` int(11) NOT NULL DEFAULT '0' COMMENT '账户余额',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_customer_id` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_customer`
--

LOCK TABLES `tb_customer` WRITE;
/*!40000 ALTER TABLE `tb_customer` DISABLE KEYS */;
INSERT INTO `tb_customer` VALUES (1,'NO100001','火火','女',18888),(2,'NO100002','拨泼抹','女',9000),(3,'NO100003','艾桥','男',7990),(4,'NO100004','水娃','女',8388);
/*!40000 ALTER TABLE `tb_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_grab_order_limit`
--

DROP TABLE IF EXISTS `tb_grab_order_limit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_grab_order_limit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `rider_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '骑手id',
  `order_grab_limit` int(11) NOT NULL DEFAULT '0' COMMENT '接单上限',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '该记录是否被删除',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `ix_rider_id` (`rider_id`),
  KEY `ix_created_at` (`created_at`),
  KEY `ix_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='自定义骑手接单上限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_grab_order_limit`
--

LOCK TABLES `tb_grab_order_limit` WRITE;
/*!40000 ALTER TABLE `tb_grab_order_limit` DISABLE KEYS */;
INSERT INTO `tb_grab_order_limit` VALUES (1,1,11,0,'2018-02-25 17:22:03','2018-02-25 17:22:03'),(2,2,9,0,'2018-02-25 17:22:21','2018-02-25 17:22:21'),(3,4,9,0,'2018-02-25 17:22:31','2018-02-25 17:22:31'),(4,6,7,0,'2018-02-25 17:22:39','2018-02-25 17:22:39'),(5,10,8,0,'2018-02-25 17:22:46','2018-02-25 17:22:46');
/*!40000 ALTER TABLE `tb_grab_order_limit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_order`
--

DROP TABLE IF EXISTS `tb_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `order_id` varchar(100) NOT NULL DEFAULT '' COMMENT '订单id',
  `customer_id` varchar(100) NOT NULL DEFAULT '' COMMENT '用户id',
  `product_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '商品id',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '商品价格',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='订单数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_order`
--

LOCK TABLES `tb_order` WRITE;
/*!40000 ALTER TABLE `tb_order` DISABLE KEYS */;
INSERT INTO `tb_order` VALUES (1,'NUM1000301','NO100001',1001,1),(2,'NUM1000302','NO100001',1002,2),(3,'NUM1000303','NO100002',1002,2),(4,'NUM1000304','NO100003',1002,1),(5,'NUM1000305','NO100001',1003,1);
/*!40000 ALTER TABLE `tb_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_product`
--

DROP TABLE IF EXISTS `tb_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `product_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '商品id',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '商品名称',
  `price` int(11) NOT NULL DEFAULT '0' COMMENT '商品价格',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='商品信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_product`
--

LOCK TABLES `tb_product` WRITE;
/*!40000 ALTER TABLE `tb_product` DISABLE KEYS */;
INSERT INTO `tb_product` VALUES (1,1001,'iPad Pro 10.5 64G WLAN',4888),(2,1002,'Macbook Pro 2017 13.3 i5/8G/256GB',13888),(3,1003,'iPhone X 64G',8388);
/*!40000 ALTER TABLE `tb_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_sample_1`
--

DROP TABLE IF EXISTS `tb_sample_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_sample_1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `ix_created_at` (`created_at`),
  KEY `ix_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='示例表1';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_sample_1`
--

LOCK TABLES `tb_sample_1` WRITE;
/*!40000 ALTER TABLE `tb_sample_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_sample_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_sample_2`
--

DROP TABLE IF EXISTS `tb_sample_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_sample_2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `ix_created_at` (`created_at`),
  KEY `ix_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='示例表2';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_sample_2`
--

LOCK TABLES `tb_sample_2` WRITE;
/*!40000 ALTER TABLE `tb_sample_2` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_sample_2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_order`
--

DROP TABLE IF EXISTS `tb_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '对外不提供，内部使用',
  `order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '运单的跟踪号（可以对外提供）',
  `rider_id` int(11) NOT NULL DEFAULT '0' COMMENT '配送员id',
  `rider_name` varchar(100) NOT NULL DEFAULT '' COMMENT '配送员名字',
  `order_state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '配送状态',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0',
  `grabbed_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '抢单时间',
  `merchant_customer_distance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商铺到顾客步行距离',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_id` (`order_id`),
  KEY `ix_created_at` (`created_at`),
  KEY `ix_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='配送单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_order`
--

LOCK TABLES `tb_order` WRITE;
/*!40000 ALTER TABLE `tb_order` DISABLE KEYS */;
INSERT INTO `tb_order` VALUES (1,300000201712300001,1,'Stark',40,0,'2017-12-30 04:34:55',2.50,'2017-12-30 12:34:17','2017-12-30 12:39:30'),(2,300000201712300002,1,'Stark',40,0,'2017-12-30 04:34:56',1.80,'2017-12-30 12:34:18','2017-12-30 12:44:27'),(3,300000201712300003,2,'Banner',40,0,'2017-12-30 05:23:12',1.80,'2017-12-30 13:20:02','2017-12-30 13:54:09'),(4,300000201712300004,5,'Natasha',40,0,'2017-12-30 05:35:03',2.70,'2017-12-30 13:34:19','2017-12-30 14:03:17'),(5,300000201712300005,1,'Stark',40,0,'2017-12-30 08:01:22',1.20,'2017-12-30 16:01:03','2017-12-30 16:08:21'),(6,300000201712300006,3,'Rogers',40,0,'2017-12-30 08:10:45',0.50,'2017-12-30 16:08:57','2017-12-30 16:34:27'),(7,300000201712310001,6,'Barton',20,0,'2017-12-31 01:12:57',1.30,'2017-12-31 09:12:07','2017-12-31 09:20:35'),(8,300000201712310002,7,'Coulson',80,0,'2017-12-31 01:15:01',2.90,'2017-12-31 09:10:33','2017-12-31 09:20:17'),(9,300000201712310003,2,'Banner',80,0,'2017-12-31 01:20:17',0.70,'2017-12-31 09:18:10','2017-12-31 09:22:24'),(10,300000201712310004,3,'Rogers',20,0,'2017-12-31 02:37:33',2.20,'2017-12-31 10:34:01','2017-12-31 10:38:09'),(11,300000201712310005,0,'',10,0,'0000-00-00 00:00:00',0.30,'2017-12-31 19:29:02','2017-12-31 19:29:02'),(12,300000201712310006,0,'',10,0,'0000-00-00 00:00:00',1.30,'2017-12-31 19:29:27','2017-12-31 19:29:27'),(13,300000201712310007,0,'',10,0,'0000-00-00 00:00:00',3.00,'2017-12-31 19:30:01','2017-12-31 19:30:01');
/*!40000 ALTER TABLE `tb_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_stu_math_score`
--

DROP TABLE IF EXISTS `tb_stu_math_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_stu_math_score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `number` varchar(50) NOT NULL DEFAULT '' COMMENT '学号',
  `grade` int(10) NOT NULL DEFAULT '0' COMMENT '年级',
  `class` int(10) NOT NULL DEFAULT '0' COMMENT '班级',
  `score` int(10) NOT NULL DEFAULT '0' COMMENT '得分',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `ix_created_at` (`created_at`),
  KEY `ix_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='学生数学成绩表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_stu_math_score`
--

LOCK TABLES `tb_stu_math_score` WRITE;
/*!40000 ALTER TABLE `tb_stu_math_score` DISABLE KEYS */;
INSERT INTO `tb_stu_math_score` VALUES (1,'柯南','010201',1,2,100,'2018-01-10 21:03:22','2018-01-10 21:03:22'),(2,'小哀','010202',1,2,100,'2018-01-10 21:03:50','2018-01-10 21:03:50'),(3,'光彦','010203',1,2,98,'2018-01-10 21:04:11','2018-01-10 21:04:11'),(4,'步美','010204',1,2,95,'2018-01-10 21:04:34','2018-01-10 21:04:34'),(5,'元太','010205',1,2,59,'2018-01-10 21:04:59','2018-01-10 21:04:59');
/*!40000 ALTER TABLE `tb_stu_math_score` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-04 18:18:44
