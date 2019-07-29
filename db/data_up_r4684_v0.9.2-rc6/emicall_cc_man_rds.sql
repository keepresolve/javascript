-- MySQL dump 10.13  Distrib 5.5.54, for debian-linux-gnu (x86_64)
--
-- Host: emicall-cr-ext.mysql.rds.aliyuncs.com    Database: emicall_cc_man
-- ------------------------------------------------------
-- Server version	5.7.20-log

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

DROP DATABASE IF EXISTS `emicall_cc_man`;
CREATE DATABASE `emicall_cc_man` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
use emicall_cc_man;

--
-- Table structure for table `access`
--

DROP TABLE IF EXISTS `access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `permission_id` bigint(20) unsigned NOT NULL COMMENT '权限ID',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  `data` json NOT NULL COMMENT '能访问的数据清单',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `permission_id` (`permission_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `async_task`
--

DROP TABLE IF EXISTS `async_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `async_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '外呼任务ID, task_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `slug` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '任务标识',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '任务状态：0-等待中 1-进行中 2-已完成',
  `type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '任务类型：1-导入 2-导出',
  `module` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所属模块',
  `condition` longtext COLLATE utf8mb4_unicode_ci COMMENT '导出查询条件',
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '存储路径',
  `file_origin_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件原名',
  `file_extension` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '扩展名',
  `file_size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '大小,单位字节',
  `result_file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '结果文件存储路径',
  `start_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `creator_userid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建人用户ID',
  `creator_username` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建人用户名',
  `owner_userid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '归属人用户ID',
  `owner_username` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '归属人用户名',
  `total_count` int(10) NOT NULL DEFAULT '0' COMMENT '处理记录数总计',
  `success_count` int(10) NOT NULL DEFAULT '0' COMMENT '成功处理记录数',
  `failed_count` int(10) NOT NULL DEFAULT '0' COMMENT '失败处理记录数',
  `process_time` int(10) NOT NULL DEFAULT '0' COMMENT '处理耗时',
  `is_new` tinyint(2) NOT NULL DEFAULT '1' COMMENT '是否为新记录',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `seid_ccgeid_task_name` (`seid`,`ccgeid`,`task_name`),
  KEY `slug` (`slug`),
  KEY `status` (`status`),
  KEY `type` (`type`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `owner_userid` (`owner_userid`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='导入导出异步任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `batch_call_customer`
--

DROP TABLE IF EXISTS `batch_call_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_call_customer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '任务ID',
  `job_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '批次ID',
  `task_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '批次类型 0:普通批次 1,重呼批次',
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '通话记录唯一标识',
  `cm_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '客户名称',
  `cm_mobile` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '客户号码',
  `cm_data` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户标识',
  `area_code` char(4) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户号码归属地区号',
  `is_called` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '联系结果，0-未联系，1-已联系 2-已失效',
  `cm_result_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户处理结果ID',
  `cm_result` int(10) DEFAULT NULL COMMENT '客户呼叫结果',
  `call_count` int(10) NOT NULL DEFAULT '0' COMMENT '呼叫次数',
  `talk_count` int(10) NOT NULL DEFAULT '0' COMMENT '成功呼叫次数',
  `call_result` tinyint(4) DEFAULT NULL COMMENT '呼叫结果',
  `call_start_time` int(10) NOT NULL DEFAULT '0' COMMENT '开始呼叫客户时间',
  `customer_ring_time` int(10) NOT NULL DEFAULT '0' COMMENT '客户振铃时间',
  `customer_answer_time` int(10) NOT NULL DEFAULT '0' COMMENT '客户摘机时间',
  `start_play_time` int(10) NOT NULL DEFAULT '0' COMMENT '开始放音时间',
  `start_transfer_time` int(10) NOT NULL DEFAULT '0' COMMENT '开始转接技能组时间',
  `call_seat_time` int(10) NOT NULL DEFAULT '0' COMMENT '呼叫坐席时间',
  `seat_ring_time` int(10) NOT NULL DEFAULT '0' COMMENT '坐席振铃时间',
  `seat_connect_time` int(10) NOT NULL DEFAULT '0' COMMENT '坐席接通时间',
  `call_end_time` int(10) NOT NULL DEFAULT '0' COMMENT '通话结束时间',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`task_id`),
  UNIQUE KEY `task_id_job_id_cm_mobile` (`task_id`,`job_id`,`cm_mobile`),
  KEY `seid` (`seid`),
  KEY `ccgeid` (`ccgeid`),
  KEY `job_id` (`job_id`),
  KEY `cc_number` (`cc_number`),
  KEY `cm_mobile` (`cm_mobile`),
  KEY `cm_result_id` (`cm_result_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='批量外呼客户号码表'
/*!50100 PARTITION BY HASH (task_id)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `batch_call_seat`
--

DROP TABLE IF EXISTS `batch_call_seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_call_seat` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '任务id',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组gid',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户uid',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `task_id_gid_uid` (`seid`,`ccgeid`,`task_id`,`gid`,`uid`),
  KEY `ccgeid` (`ccgeid`),
  KEY `task_id` (`task_id`),
  KEY `gid` (`gid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='批量外呼坐席表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `batch_call_stat_job`
--

DROP TABLE IF EXISTS `batch_call_stat_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_call_stat_job` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned DEFAULT '0' COMMENT '企业ID',
  `task_id` bigint(20) unsigned DEFAULT '0' COMMENT '任务ID',
  `job_id` bigint(20) unsigned DEFAULT '0' COMMENT '批次ID',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0-未开始 1-进行中 2-暂停中 3-已完成 4-已结束',
  `call_progress` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '外呼进度',
  `customer_pickup_rate` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '客户接通率',
  `seat_pickup_rate` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '坐席接通率',
  `queue_quit_rate` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '排队放弃率',
  `avg_ring_time` float NOT NULL DEFAULT '0' COMMENT '平均振铃时长',
  `customer_num` int(11) NOT NULL DEFAULT '0' COMMENT '客户总数',
  `finished_customer_num` int(11) NOT NULL DEFAULT '0' COMMENT '已呼叫客户数',
  `unfinish_customer_num` int(11) NOT NULL DEFAULT '0' COMMENT '未呼叫客户数',
  `customer_pickup_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户接起数',
  `seat_pickup_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '坐席接起数',
  `queue_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排队总数',
  `queue_quit_num` int(11) NOT NULL DEFAULT '0' COMMENT '排队放弃数',
  `other_num` int(11) NOT NULL DEFAULT '0' COMMENT '其他状态客户数目',
  `call_result` text COLLATE utf8mb4_unicode_ci COMMENT '呼叫结果统计',
  `cm_result` text COLLATE utf8mb4_unicode_ci COMMENT '客户通话结果',
  `created_at` int(10) NOT NULL,
  `updated_at` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ccgeid` (`ccgeid`),
  KEY `task_id` (`task_id`),
  KEY `job_id` (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='批量外呼批次统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `batch_call_stat_seat`
--

DROP TABLE IF EXISTS `batch_call_stat_seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_call_stat_seat` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) DEFAULT NULL COMMENT '超级企业ID',
  `ccgeid` bigint(20) DEFAULT NULL COMMENT '企业ID',
  `task_id` bigint(20) DEFAULT NULL COMMENT '批量外呼任务ID',
  `job_id` bigint(20) DEFAULT NULL COMMENT '批量外呼批次ID',
  `gid` bigint(20) NOT NULL COMMENT '技能组或者坐席ID',
  `uid` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '技能组或者坐席名称',
  `seat_pickup_num` int(20) NOT NULL DEFAULT '0' COMMENT '坐席接起数',
  `ring_no_answ_num` int(10) NOT NULL DEFAULT '0' COMMENT '坐席未接数-流转给别的坐席接听',
  `total_talk_time` float NOT NULL DEFAULT '0' COMMENT '总通话时长',
  `average_talk_time` float NOT NULL DEFAULT '0' COMMENT '平均通话时长',
  `created_at` int(10) NOT NULL,
  `updated_at` int(10) NOT NULL,
  `seat_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '坐席分机号',
  `seat_work_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '坐席工号',
  `seat_call_rate` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '呼入接听率',
  `ring_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '振铃放弃数',
  `total_ring_times` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '总的振铃次数',
  `total_ring_time` float NOT NULL DEFAULT '0' COMMENT '总的振铃时长',
  `avg_ring_time` float NOT NULL DEFAULT '0' COMMENT '平均振铃时长',
  PRIMARY KEY (`id`),
  KEY `job_id` (`job_id`),
  KEY `task_id` (`task_id`),
  KEY `ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='批量外呼坐席统计表';
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `batch_call_statistic_customer_call`;
CREATE TABLE `batch_call_statistic_customer_call` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '批量重呼任务ID',
  `job_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '批量重呼批次ID',
  `signed_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '标记数',
  `result_id` bigint(20) NOT NULL COMMENT '结果选项ID',
  `result_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '结果选项名称',
  `parent_result_id` bigint(20) DEFAULT '0' COMMENT '父级结果选项ID',
  `parent_result_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '父级结果选项名称',
  `created_at` int(10) NOT NULL,
  `updated_at` int(10) NOT NULL,
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `task_job_result` (`seid`,`ccgeid`,`task_id`,`job_id`,`result_id`,`parent_result_id`),
  KEY `task_job_id` (`task_id`,`job_id`),
  KEY `result_id` (`result_id`),
  KEY `parent_result_id` (`parent_result_id`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='批量外呼客户通话统计表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;


DROP TABLE IF EXISTS `batch_call_statistic_result`;
CREATE TABLE `batch_call_statistic_result` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '批量重呼任务ID',
  `job_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '批量重呼批次ID',
  `signed_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '标记数',
  `result_id` bigint(20) NOT NULL COMMENT '结果选项ID',
  `result_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '结果选项名称',
  `parent_result_id` bigint(20) DEFAULT '0' COMMENT '父级结果选项ID',
  `parent_result_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '父级结果选项名称',
  `created_at` int(10) NOT NULL,
  `updated_at` int(10) NOT NULL,
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `task_job_result` (`seid`,`ccgeid`,`task_id`,`job_id`,`result_id`,`parent_result_id`),
  KEY `task_job_id` (`task_id`,`job_id`),
  KEY `result_id` (`result_id`),
  KEY `parent_result_id` (`parent_result_id`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='批量外呼话后处理统计表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;


--
-- Table structure for table `batch_call_task`
--

DROP TABLE IF EXISTS `batch_call_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_call_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '外呼任务ID, task_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0-未开始 1-进行中 2-暂停中 3-已完成 4-已结束',
  `preset_start_time` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '08:00' COMMENT '外呼时段开始时间',
  `preset_end_time` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '20:00' COMMENT '外呼时段结束时间',
  `preset_call_rate` float NOT NULL DEFAULT '0.8' COMMENT '外呼速率',
  `preset_connection_rate` float NOT NULL DEFAULT '0.8' COMMENT '预设接通率',
  `isset_switch_number` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否配置总机号码 0-否 1-是',
  `switch_number_mode` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '总机号码模式 0-本企业号码呼出 1-按号码归属地呼出 2-选择其他企业号码呼出',
  `switch_number_call_mode` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '总机号码呼叫模式 0-随机 1-按顺序',
  `switch_number_list` longtext COLLATE utf8mb4_unicode_ci COMMENT '总机号码列表',
  `auto_answer` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否自动接听 0-否 1-是',
  `isset_pickup_voice` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否配置接听语音 0-否 1-是',
  `pickup_voice_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '接听语音文件ID',
  `pickup_voice_source` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '接听语音来源 0-系统生成 1-上传自制',
  `pickup_voice_content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '接听语音文本内容',
  `switch_work_number_broadcast` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启工号播报',
  `seat_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '坐席总数',
  `customer_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户号码总数',
  `finished_customer_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已完成号码数',
  `call_progress` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '外呼进度',
  `customer_pickup_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户接起数',
  `customer_unpickup_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户未接数',
  `customer_pickup_rate` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '客户接通率',
  `queue_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排队数',
  `queue_quit_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排队放弃数',
  `queue_quit_rate` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '排队放弃率',
  `seat_pickup_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '坐席接起数',
  `seat_pickup_rate` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '坐席接通率',
  `last_start_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最近一次开始时间',
  `last_end_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最近一次结束时间',
  `is_new` tinyint(2) NOT NULL DEFAULT '1' COMMENT '是否为新记录',
  `task_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '任务执行时长',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `avg_ring_time` float NOT NULL DEFAULT '0' COMMENT '平均振铃时长',
  `target` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'seat 坐席、group 技能组',
  `uid_list` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'uid列表',
  `seat_refuse_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '坐席流转数',
  `seat_ring_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '坐席振铃数',
  `total_ring_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '坐席振铃总时长',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `seid_ccgeid_task_name` (`seid`,`ccgeid`,`task_name`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='批量外呼任务表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `batch_call_task_job`
--

DROP TABLE IF EXISTS `batch_call_task_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_call_task_job` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '外呼批次ID, job_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '外呼任务ID',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '批量类型 0:普通批次,1:重呼批次',
  `unique_id` varchar(13) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '导入批次',
  `job_name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '批次名称',
  `customer_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户号码总数',
  `deduplication_task_ids` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '去重任务ID',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0-未开始 1-进行中 2-暂停中 3-已完成 4-已结束',
  `call_progress` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '外呼进度',
  `finished_customer_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已完成号码数',
  `customer_pickup_rate` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '客户接通率',
  `seat_pickup_rate` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '坐席接通率',
  `queue_quit_rate` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '排队放弃率',
  `customer_pickup_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户接起数',
  `queue_quit_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排队放弃数',
  `seat_pickup_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '坐席接起数',
  `avg_ring_time` float NOT NULL DEFAULT '0' COMMENT '平均振铃时长',
  `target` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'seat 坐席、group 技能组',
  PRIMARY KEY (`id`,`task_id`),
  UNIQUE KEY `task_id_job_name` (`task_id`,`job_name`),
  KEY `task_id` (`seid`),
  KEY `ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='批量外呼任务批次表'
/*!50100 PARTITION BY HASH (task_id)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blacklist_of_incall`
--

DROP TABLE IF EXISTS `blacklist_of_incall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blacklist_of_incall` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '号码',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '号码类型：0-完整号码 1-号码前缀',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `number` (`seid`,`ccgeid`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='呼入黑名单表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blacklist_of_outcall`
--

DROP TABLE IF EXISTS `blacklist_of_outcall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blacklist_of_outcall` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '号码',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '号码类型：0-完整号码 1-号码前缀',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `number` (`seid`,`ccgeid`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='呼出黑名单表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `call_cc_number`
--

DROP TABLE IF EXISTS `call_cc_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_cc_number` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '呼叫ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `initiate_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话开始时间',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`cc_number`),
  UNIQUE KEY `cc_number` (`cc_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通话唯一标识表'
/*!50100 PARTITION BY KEY (cc_number)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `call_detail`
--

DROP TABLE IF EXISTS `call_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心超级企业id',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心全局企业id',
  `cr_detail_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '运营平台通话详情ID',
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '呼叫ID',
  `call_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0-客户呼入；1-座席呼出；2-语音通知；3-预测式外呼；4-内部呼出；5-内部呼入；6-转接座席；7-转接外线；8-班长监听；',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组id',
  `gid_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '技能组名称',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席id',
  `flow_number` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '流转id，每次更改技能组或座席或外线时，该值增1：',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '座席分机号',
  `display_name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '坐席名称',
  `work_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '工号',
  `switch_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户呼入/呼出总机号',
  `outline_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户号码（或内部呼叫被叫号码）',
  `state` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '通话状态',
  `initiate_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫开始时间',
  `enqueue_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '排队时间',
  `lock_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席锁定时间',
  `query_msg_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '发送呼叫通知消息时间',
  `answer_msg_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '收到座席应答消息时间',
  `invite_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫设备时间',
  `ring_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '设备振铃时间',
  `confirm_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席（设备）接通时间',
  `announcing_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '播报开始时间',
  `conversation_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话开始时间',
  `disconnect_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席挂断时间',
  `post_call_end_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席话后处理结束时间',
  `hold_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '座席保持总时长',
  `queue_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排队时长(秒)',
  `duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '座席实际接通时长',
  `valid_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '座席有效通话时长',
  `cm_result_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户话后处理结果id',
  `cm_result` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '客户话后处理结果',
  `stop_reason` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '通话结束原因',
  `cm_fail_reason` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户未接通原因',
  `customer_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户振铃时长(秒)',
  `seat_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '坐席振铃时长(秒)',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `call_flow` (`ccgeid`,`cc_number`,`gid`,`uid`,`flow_number`),
  KEY `cc_number` (`cc_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通话详情表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `call_ivr_path`
--

DROP TABLE IF EXISTS `call_ivr_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_ivr_path` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心企业全局id',
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '通话id',
  `ivr_node_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr节点id',
  `ivr_node_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ivr节点名称',
  `ivr_version` int(10) unsigned DEFAULT '0' COMMENT 'ivr版本号',
  `index` int(10) unsigned DEFAULT '0' COMMENT '索引',
  `key_in` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ivr节点输入键值',
  `enter_ivr_time` bigint(20) unsigned DEFAULT '0' COMMENT '进入ivr时间',
  `leave_ivr_time` bigint(20) unsigned DEFAULT '0' COMMENT '离开ivr时间',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `call_ivr_index` (`ccgeid`,`cc_number`,`index`),
  KEY `ivr_enterprise_version` (`ccgeid`,`ivr_version`),
  KEY `cc_number` (`cc_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通话IVR路径表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `call_record`
--

DROP TABLE IF EXISTS `call_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `sid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业通话唯一id值',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ccdid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `eid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'PBX企业ID',
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '呼叫ID',
  `verdor_id` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '机构ID（用户自定义）',
  `branch_id` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '网点ID（用户自定义）',
  `call_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0-客户呼入；1-座席呼出；2-语音通知；3-预测式外呼；10-内部通话；',
  `auto_route_call` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0-非智能路由；1-智能路由（发起方）；2-智能路由（落地方）；',
  `auto_route_peer_ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '智能路由对端企业ID',
  `auto_route_peer_eid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '智能路由对端PBX企业ID',
  `outline_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户号码（或内部呼叫被叫号码）',
  `encrypted_outline_number` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '加密的客户号码',
  `switch_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户呼入/呼出总机号',
  `initiator` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '通话发起者：0-客户（呼入）；1-PC客户端；2-API；3-系统通知；4-预测式外呼；',
  `initiator_callId` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发起方的通话标识：客户，为cc_number（=callId）；PC，callId；API，api_callId；管理系统通知，callId；预测式外呼，callId。',
  `initiator_task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '系统通知或预测式外呼任务ID',
  `initiator_pcall_id` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '预测式外呼pcall_id',
  `service_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '服务号码（首个接听或发起座席号码）',
  `service_uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `service_seat_mobile` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席手机号码',
  `service_seat_worknumber` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席工号',
  `service_seat_name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席名称',
  `service_gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席所在技能组ID',
  `service_group_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的技能组名称',
  `state` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '通话状态',
  `initiate_time` timestamp NULL DEFAULT NULL COMMENT '通话发起时间',
  `ring_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户振铃时间（呼出）',
  `confirm_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户接通时间（呼出）',
  `disconnect_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户挂断时间',
  `enter_ivr_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话进入ivr时间',
  `last_enqueue_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话最后一次进入排队时间',
  `enqueue_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '通话排队次数',
  `total_enqueue_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '通话排队总时长',
  `last_seat_lock_time` int(10) DEFAULT '0' COMMENT '最后一个座席锁定事件',
  `last_seat_ring_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最后一个座席振铃时间（不包括通话中转接的座席）',
  `seat_confirm_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席接通时间',
  `seat_disconnect_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席挂断时间（最后一个）',
  `announcing_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '播报开始时间',
  `conversation_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话开始时间（桥接成功且双向接通）',
  `record_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录音开始时间',
  `evaluate_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '满意度调查开始时间',
  `duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户实际有效通话时长（桥接时长,s）',
  `hold_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '保持总时长',
  `seat_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '坐席振铃时长(秒)',
  `customer_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户振铃时长(秒)',
  `ivr_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'IVR时长(秒)',
  `record_status` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '录音状态',
  `record_filename` varchar(511) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '录音文件名',
  `record_res_token` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '录音下载token',
  `evaluate_key` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '满意度调查按键值',
  `evaluate_value` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '满意度调查得分',
  `cm_result_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '话后处理结果id',
  `cm_result` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '话后处理结果',
  `attribution` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户号码归属地',
  `stop_reason` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话结束原因',
  `customer_fail_reason` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户未接原因',
  `customer_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户ID',
  `customer_name` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户姓名',
  `customer_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户地址',
  `customer_company` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户公司名称',
  `group_names` text COLLATE utf8mb4_unicode_ci COMMENT '所有技能组名称',
  `seat_names` text COLLATE utf8mb4_unicode_ci COMMENT '所有座席名称',
  `seat_numbers` text COLLATE utf8mb4_unicode_ci COMMENT '所有座席分机号',
  `seat_work_numbers` text COLLATE utf8mb4_unicode_ci COMMENT '所有座席工号',
  `match_content` text COLLATE utf8mb4_unicode_ci COMMENT '模糊匹配文本',
  `stat_status` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '统计状态：0-未统计；1-统计中；2-已统计',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `e_sid` (`seid`,`ccgeid`,`sid`),
  UNIQUE KEY `s_c_cc_number` (`seid`,`ccgeid`,`cc_number`),
  KEY `initiator_task_id` (`initiator_task_id`),
  KEY `switch_number` (`switch_number`),
  KEY `cm_result_id` (`cm_result_id`),
  KEY `stop_reason` (`stop_reason`),
  KEY `call_record_stat` (`stat_status`),
  KEY `s_c_initiate_time` (`seid`,`ccgeid`,`initiate_time`),
  KEY `s_c_outline_number` (`seid`,`ccgeid`,`outline_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通话记录表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `call_record_per_group`
--

DROP TABLE IF EXISTS `call_record_per_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_record_per_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ccdid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `eid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'PBX企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '呼叫ID',
  `verdor_id` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '机构ID（用户自定义）',
  `branch_id` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '网点ID（用户自定义）',
  `call_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0-客户呼入；1-座席呼出；2-语音通知；3-预测式外呼；10-内部通话；',
  `auto_route_call` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0-非智能路由；1-智能路由（发起方）；2-智能路由（落地方）；',
  `auto_route_peer_ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '智能路由对端企业ID',
  `auto_route_peer_eid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '智能路由对端PBX企业ID',
  `outline_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户号码（或内部呼叫被叫号码）',
  `encrypted_outline_number` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '加密的客户号码',
  `switch_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户呼入/呼出总机号',
  `initiator` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '通话发起者：0-客户（呼入）；1-PC客户端；2-API；3-系统通知；4-预测式外呼；',
  `initiator_callId` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发起方的通话标识：客户，为cc_number（=callId）；PC，callId；API，api_callId；管理系统通知，callId；预测式外呼，callId。',
  `initiator_task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '系统通知或预测式外呼任务ID',
  `initiator_pcall_id` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '预测式外呼pcall_id',
  `service_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '服务号码（首个接听或发起座席号码）',
  `service_uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `service_seat_mobile` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席手机号码',
  `service_seat_worknumber` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席工号',
  `service_seat_name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席名称',
  `service_gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席所在技能组ID',
  `service_group_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的技能组名称',
  `state` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '通话状态',
  `initiate_time` timestamp NULL DEFAULT NULL COMMENT '通话发起时间',
  `ring_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户振铃时间（呼出）',
  `confirm_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户接通时间（呼出）',
  `disconnect_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户挂断时间',
  `enter_ivr_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话进入ivr时间',
  `last_enqueue_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话最后一次进入排队时间',
  `enqueue_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '通话排队次数',
  `total_enqueue_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '通话排队总时长',
  `last_seat_lock_time` int(10) DEFAULT '0' COMMENT '最后一个座席锁定事件',
  `last_seat_ring_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最后一个座席振铃时间（不包括通话中转接的座席）',
  `seat_confirm_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席接通时间',
  `seat_disconnect_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席挂断时间（最后一个）',
  `announcing_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '播报开始时间',
  `conversation_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话开始时间（桥接成功且双向接通）',
  `record_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录音开始时间',
  `evaluate_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '满意度调查开始时间',
  `duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户实际有效通话时长（桥接时长,s）',
  `hold_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '保持总时长',
  `seat_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '坐席振铃时长(秒)',
  `customer_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户振铃时长(秒)',
  `ivr_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'IVR时长(秒)',
  `record_status` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '录音状态',
  `record_filename` varchar(511) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '录音文件名',
  `record_res_token` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '录音下载token',
  `evaluate_key` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '满意度调查按键值',
  `evaluate_value` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '满意度调查得分',
  `cm_result_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '话后处理结果id',
  `cm_result` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '话后处理结果',
  `attribution` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户号码归属地',
  `stop_reason` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话结束原因',
  `customer_fail_reason` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户未接原因',
  `customer_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户ID',
  `customer_name` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户姓名',
  `customer_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户地址',
  `customer_company` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户公司名称',
  `group_names` text COLLATE utf8mb4_unicode_ci COMMENT '所有技能组名称',
  `seat_names` text COLLATE utf8mb4_unicode_ci COMMENT '所有座席名称',
  `seat_numbers` text COLLATE utf8mb4_unicode_ci COMMENT '所有座席分机号',
  `seat_work_numbers` text COLLATE utf8mb4_unicode_ci COMMENT '所有座席工号',
  `match_content` text COLLATE utf8mb4_unicode_ci COMMENT '模糊匹配文本',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `seid_gid_call` (`seid`,`ccgeid`,`gid`,`cc_number`),
  KEY `initiator_task_id` (`initiator_task_id`),
  KEY `switch_number` (`switch_number`),
  KEY `cm_result_id` (`cm_result_id`),
  KEY `stop_reason` (`stop_reason`),
  KEY `s_c_initiate_time` (`seid`,`ccgeid`,`initiate_time`),
  KEY `s_c_outline_number` (`seid`,`ccgeid`,`outline_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能组通话记录表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `call_record_per_group_seat`
--

DROP TABLE IF EXISTS `call_record_per_group_seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_record_per_group_seat` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ccdid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `eid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'PBX企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席ID',
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '呼叫ID',
  `verdor_id` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '机构ID（用户自定义）',
  `branch_id` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '网点ID（用户自定义）',
  `call_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0-客户呼入；1-座席呼出；2-语音通知；3-预测式外呼；10-内部通话；',
  `auto_route_call` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0-非智能路由；1-智能路由（发起方）；2-智能路由（落地方）；',
  `auto_route_peer_ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '智能路由对端企业ID',
  `auto_route_peer_eid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '智能路由对端PBX企业ID',
  `outline_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户号码（或内部呼叫被叫号码）',
  `encrypted_outline_number` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '加密的客户号码',
  `switch_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户呼入/呼出总机号',
  `initiator` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '通话发起者：0-客户（呼入）；1-PC客户端；2-API；3-系统通知；4-预测式外呼；',
  `initiator_callId` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发起方的通话标识：客户，为cc_number（=callId）；PC，callId；API，api_callId；管理系统通知，callId；预测式外呼，callId。',
  `initiator_task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '系统通知或预测式外呼任务ID',
  `initiator_pcall_id` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '预测式外呼pcall_id',
  `service_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '服务号码（首个接听或发起座席号码）',
  `service_uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `service_seat_mobile` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席手机号码',
  `service_seat_worknumber` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席工号',
  `service_seat_name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席名称',
  `service_gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席所在技能组ID',
  `service_group_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的技能组名称',
  `state` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '通话状态',
  `initiate_time` timestamp NULL DEFAULT NULL COMMENT '通话发起时间',
  `ring_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户振铃时间（呼出）',
  `confirm_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户接通时间（呼出）',
  `disconnect_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户挂断时间',
  `enter_ivr_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话进入ivr时间',
  `last_enqueue_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话最后一次进入排队时间',
  `enqueue_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '通话排队次数',
  `total_enqueue_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '通话排队总时长',
  `last_seat_lock_time` int(10) DEFAULT '0' COMMENT '最后一个座席锁定事件',
  `last_seat_ring_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最后一个座席振铃时间（不包括通话中转接的座席）',
  `seat_confirm_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席接通时间',
  `seat_disconnect_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席挂断时间（最后一个）',
  `announcing_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '播报开始时间',
  `conversation_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话开始时间（桥接成功且双向接通）',
  `record_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录音开始时间',
  `evaluate_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '满意度调查开始时间',
  `duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户实际有效通话时长（桥接时长,s）',
  `hold_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '保持总时长',
  `seat_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '坐席振铃时长(秒)',
  `customer_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户振铃时长(秒)',
  `ivr_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'IVR时长(秒)',
  `record_status` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '录音状态',
  `record_filename` varchar(511) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '录音文件名',
  `record_res_token` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '录音下载token',
  `evaluate_key` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '满意度调查按键值',
  `evaluate_value` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '满意度调查得分',
  `cm_result_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '话后处理结果id',
  `cm_result` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '话后处理结果',
  `attribution` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户号码归属地',
  `stop_reason` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话结束原因',
  `customer_fail_reason` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户未接原因',
  `customer_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户ID',
  `customer_name` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户姓名',
  `customer_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户地址',
  `customer_company` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户公司名称',
  `group_names` text COLLATE utf8mb4_unicode_ci COMMENT '所有技能组名称',
  `seat_names` text COLLATE utf8mb4_unicode_ci COMMENT '所有座席名称',
  `seat_numbers` text COLLATE utf8mb4_unicode_ci COMMENT '所有座席分机号',
  `seat_work_numbers` text COLLATE utf8mb4_unicode_ci COMMENT '所有座席工号',
  `match_content` text COLLATE utf8mb4_unicode_ci COMMENT '模糊匹配文本',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `seid_gid_uid_call` (`seid`,`ccgeid`,`gid`,`uid`,`cc_number`),
  KEY `initiator_task_id` (`initiator_task_id`),
  KEY `switch_number` (`switch_number`),
  KEY `cm_result_id` (`cm_result_id`),
  KEY `stop_reason` (`stop_reason`),
  KEY `s_c_initiate_time` (`seid`,`ccgeid`,`initiate_time`),
  KEY `s_c_outline_number` (`seid`,`ccgeid`,`outline_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能组座席通话记录表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `call_record_per_seat`
--

DROP TABLE IF EXISTS `call_record_per_seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_record_per_seat` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ccdid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `eid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'PBX企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席ID',
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '呼叫ID',
  `verdor_id` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '机构ID（用户自定义）',
  `branch_id` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '网点ID（用户自定义）',
  `call_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0-客户呼入；1-座席呼出；2-语音通知；3-预测式外呼；10-内部通话；',
  `auto_route_call` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0-非智能路由；1-智能路由（发起方）；2-智能路由（落地方）；',
  `auto_route_peer_ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '智能路由对端企业ID',
  `auto_route_peer_eid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '智能路由对端PBX企业ID',
  `outline_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户号码（或内部呼叫被叫号码）',
  `encrypted_outline_number` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '加密的客户号码',
  `switch_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户呼入/呼出总机号',
  `initiator` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '通话发起者：0-客户（呼入）；1-PC客户端；2-API；3-系统通知；4-预测式外呼；',
  `initiator_callId` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发起方的通话标识：客户，为cc_number（=callId）；PC，callId；API，api_callId；管理系统通知，callId；预测式外呼，callId。',
  `initiator_task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '系统通知或预测式外呼任务ID',
  `initiator_pcall_id` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '预测式外呼pcall_id',
  `service_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '服务号码（首个接听或发起座席号码）',
  `service_uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `service_seat_mobile` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席手机号码',
  `service_seat_worknumber` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席工号',
  `service_seat_name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席名称',
  `service_gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席所在技能组ID',
  `service_group_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的技能组名称',
  `state` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '通话状态',
  `initiate_time` timestamp NULL DEFAULT NULL COMMENT '通话发起时间',
  `ring_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户振铃时间（呼出）',
  `confirm_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户接通时间（呼出）',
  `disconnect_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户挂断时间',
  `enter_ivr_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话进入ivr时间',
  `last_enqueue_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话最后一次进入排队时间',
  `enqueue_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '通话排队次数',
  `total_enqueue_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '通话排队总时长',
  `last_seat_lock_time` int(10) DEFAULT '0' COMMENT '最后一个座席锁定事件',
  `last_seat_ring_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最后一个座席振铃时间（不包括通话中转接的座席）',
  `seat_confirm_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席接通时间',
  `seat_disconnect_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席挂断时间（最后一个）',
  `announcing_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '播报开始时间',
  `conversation_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话开始时间（桥接成功且双向接通）',
  `record_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '录音开始时间',
  `evaluate_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '满意度调查开始时间',
  `duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户实际有效通话时长（桥接时长,s）',
  `hold_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '保持总时长',
  `seat_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '坐席振铃时长(秒)',
  `customer_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户振铃时长(秒)',
  `ivr_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'IVR时长(秒)',
  `record_status` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '录音状态',
  `record_filename` varchar(511) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '录音文件名',
  `record_res_token` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '录音下载token',
  `evaluate_key` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '满意度调查按键值',
  `evaluate_value` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '满意度调查得分',
  `cm_result_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '话后处理结果id',
  `cm_result` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '话后处理结果',
  `attribution` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户号码归属地',
  `stop_reason` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话结束原因',
  `customer_fail_reason` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户未接原因',
  `customer_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户ID',
  `customer_name` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户姓名',
  `customer_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户地址',
  `customer_company` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户公司名称',
  `group_names` text COLLATE utf8mb4_unicode_ci COMMENT '所有技能组名称',
  `seat_names` text COLLATE utf8mb4_unicode_ci COMMENT '所有座席名称',
  `seat_numbers` text COLLATE utf8mb4_unicode_ci COMMENT '所有座席分机号',
  `seat_work_numbers` text COLLATE utf8mb4_unicode_ci COMMENT '所有座席工号',
  `match_content` text COLLATE utf8mb4_unicode_ci COMMENT '模糊匹配文本',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `uid_call` (`seid`,`ccgeid`,`uid`,`cc_number`),
  KEY `initiator_task_id` (`initiator_task_id`),
  KEY `switch_number` (`switch_number`),
  KEY `cm_result_id` (`cm_result_id`),
  KEY `stop_reason` (`stop_reason`),
  KEY `s_c_initiate_time` (`seid`,`ccgeid`,`initiate_time`),
  KEY `s_c_outline_number` (`seid`,`ccgeid`,`outline_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='座席通话记录表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `call_record_recording`
--

DROP TABLE IF EXISTS `call_record_recording`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_record_recording` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `cc_number` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '通话记录唯一标识',
  `upload_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '上传类型  0：网盘  1：FTP  2：网盘+FTP',
  `recording_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '录音类型 1：混音  2：多轨',
  `status` tinyint(1) NOT NULL COMMENT '状态：1：录音开始  2：录音结束 3：录音丢弃  4：录音上传中  5：录音上传完成：',
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件名称',
  `token_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'token类型  0:混音  1:mp3  2:wav',
  `token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '下载token',
  `duration` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '录音时长',
  `created_at` int(10) NOT NULL,
  `updated_at` int(10) NOT NULL,
  PRIMARY KEY (`id`,`cc_number`),
  KEY `cc_number` (`cc_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通话记录录音状态表'
/*!50100 PARTITION BY KEY (cc_number)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `call_statistic_record`
--

DROP TABLE IF EXISTS `call_statistic_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_statistic_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `host_name` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '主机名',
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '通话唯一标识',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心超级企业id',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心全局企业id',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '通话统计状态：0-未统计 1-处理中 2-处理完成',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`),
  UNIQUE KEY `cc_number` (`seid`,`cc_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通话统计记录表'
/*!50100 PARTITION BY HASH (seid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_app_version`
--

DROP TABLE IF EXISTS `client_app_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_app_version` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `name` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户端名称',
  `label` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户端标识，与source保持一致',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT '客户端版本号',
  `full_version` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户端完整版本号',
  `is_mandatory` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否强制升级：0-非强制；1-强制',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `package_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '存储路径',
  `package_origin_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件原名',
  `package_extension` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '扩展名',
  `package_size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '大小,单位字节',
  `package_md5hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'md5 hash值',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `label_version` (`label`,`version`),
  KEY `seid` (`seid`),
  KEY `ccgeid` (`ccgeid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='客户端软件版本表';
/*!40101 SET character_set_client = @saved_cs_client */;


INSERT INTO `client_app_version`(`name`, `label`, `version`, `full_version`, `is_mandatory`, `description`, `package_path`, `package_origin_name`, `package_extension`, `package_size`, `package_md5hash`) VALUES ('PC普通客户端', 'client.pc.common', '55726', '6.0.10.55726', '0', '', 'package/client.pc.common/55726/EmicallCenter_Setup.msi', 'EmicallCenter_Setup.msi', 'msi', '0', '');
INSERT INTO `client_app_version`(`name`, `label`, `version`, `full_version`, `is_mandatory`, `description`, `package_path`, `package_origin_name`, `package_extension`, `package_size`, `package_md5hash`) VALUES ('PC普通客户端', 'client.pc.common', '55756', '6.0.10.55756', '0', '', 'package/client.pc.common/55756/EmicallCenter_Setup.msi', 'EmicallCenter_Setup.msi', 'msi', '0', '');


--
-- Table structure for table `con_statis_enterprise`
--

DROP TABLE IF EXISTS `con_statis_enterprise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `con_statis_enterprise` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '子企业ID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当前时间戳',
  `stat_type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '统计类型 1:实时统计 2:历史最高统计 3:半小时统计 4:天统计 5:月统计',
  `concurrent_type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '并发数的类型 1:通话并发 2:线路并发 3:排队并发',
  `concurrent_number` bigint(20) NOT NULL DEFAULT '0' COMMENT '并发数量',
  `concurrent_number_pstn` bigint(20) NOT NULL DEFAULT '0' COMMENT '电路类型线路并发数量',
  `line_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '设备类型 0非线路 1电路 2网路',
  `server_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '服务器名称',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `con_statis_enterprise` (`ccgeid`,`stat_type`,`concurrent_type`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业并发峰值表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `con_statis_group`
--

DROP TABLE IF EXISTS `con_statis_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `con_statis_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '子企业ID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当前时间戳',
  `stat_type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '统计类型 1:实时统计 2:历史最高统计 3:半小时统计 4:天统计 5:月统计',
  `concurrent_type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '并发数的类型 1:通话并发 2:线路并发 3:排队并发',
  `concurrent_number` bigint(20) NOT NULL DEFAULT '0' COMMENT '并发数量',
  `group_id` bigint(20) unsigned NOT NULL COMMENT '技能组ID',
  `server_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '服务器名称',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `con_statis_group` (`ccgeid`,`group_id`,`stat_type`,`concurrent_type`,`timestamp`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能组并发峰值表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `con_statis_province`
--

DROP TABLE IF EXISTS `con_statis_province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `con_statis_province` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ccdid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当前时间戳',
  `stat_type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '统计类型 1:实时统计 2:历史最高统计 3:半小时统计 4:天统计 5:月统计',
  `concurrent_type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '并发数的类型 1:通话并发 2:线路并发 3:排队并发',
  `concurrent_number` bigint(20) NOT NULL DEFAULT '0' COMMENT '并发数量',
  `concurrent_number_pstn` bigint(20) NOT NULL DEFAULT '0' COMMENT '电路类型线路并发数量',
  `line_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '设备类型 0非线路 1电路 2网路',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `con_statis_province` (`ccdid`,`stat_type`,`concurrent_type`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='省份并发峰值表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `con_statis_server`
--

DROP TABLE IF EXISTS `con_statis_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `con_statis_server` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `server_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '服务器名称',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当前时间戳',
  `stat_type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '统计类型 1:实时统计 2:历史最高统计 3:半小时统计 4:天统计 5:月统计',
  `concurrent_type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '并发数的类型 1:通话并发 2:线路并发 3:排队并发',
  `concurrent_number` bigint(20) NOT NULL DEFAULT '0' COMMENT '并发数量',
  `concurrent_number_pstn` bigint(20) NOT NULL DEFAULT '0' COMMENT '电路类型线路并发数量',
  `line_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '设备类型 0非线路 1电路 2网路',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `con_statis_server` (`server_name`,`stat_type`,`concurrent_type`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='服务器并发峰值表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `con_statis_super_enterprise`
--

DROP TABLE IF EXISTS `con_statis_super_enterprise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `con_statis_super_enterprise` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当前时间戳',
  `stat_type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '统计类型 1:实时统计 2:历史最高统计 3:半小时统计 4:天统计 5:月统计',
  `concurrent_type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '并发数的类型 1:通话并发 2:线路并发 3:排队并发',
  `concurrent_number` bigint(20) NOT NULL DEFAULT '0' COMMENT '并发数量',
  `concurrent_number_pstn` bigint(20) NOT NULL DEFAULT '0' COMMENT '电路类型线路并发数量',
  `line_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '设备类型 0非线路 1电路 2网路',
  `server_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '服务器名称',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `con_statis_super_enterprise` (`seid`,`stat_type`,`concurrent_type`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='超级企业并发峰值表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `con_statis_system`
--

DROP TABLE IF EXISTS `con_statis_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `con_statis_system` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当前时间戳',
  `stat_type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '统计类型 1:实时统计 2:历史最高统计 3:半小时统计 4:天统计 5:月统计',
  `concurrent_type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '并发数的类型 1:通话并发 2:线路并发 3:排队并发',
  `concurrent_number` bigint(20) NOT NULL DEFAULT '0' COMMENT '并发数量',
  `concurrent_number_pstn` bigint(20) NOT NULL DEFAULT '0' COMMENT '电路类型线路并发数量',
  `line_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '设备类型 0非线路 1电路 2网路',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `con_statis_system` (`stat_type`,`concurrent_type`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统并发峰值表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concurrent_record`
--

DROP TABLE IF EXISTS `concurrent_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concurrent_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ccdid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '通话唯一标识',
  `customer_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '客户号码（或内部呼叫被叫号码）',
  `seat_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '坐席分机号码',
  `action` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '动作:1客户Ua排队,2客户Ua出队,3通话建立,4通过结束,5客户Ua振铃,6客户Ua挂断,7坐席Ua振铃,8 坐席Ua挂断',
  `server_ip` varchar(31) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '服务器IP',
  `server_name` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '主机名',
  `group_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `group_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '技能组名称',
  `line_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '表示类型:1电路,2网络',
  `action_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '动作发生时间',
  `cr_create_time` timestamp NULL DEFAULT NULL COMMENT '在CR的创建时间',
  `cr_update_time` timestamp NULL DEFAULT NULL COMMENT '在CR的更新时间',
  `queue_flow_id` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '排队id',
  `seat_line_flow_id` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '线路id',
  `statistic_status` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '通话并发统计状态：0-未统计 1-已统计',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `call_action_flow` (`seid`,`ccgeid`,`cc_number`,`action`,`server_name`,`group_id`,`ccdid`,`queue_flow_id`,`seat_line_flow_id`),
  KEY `ccgeid` (`ccgeid`),
  KEY `cc_number` (`cc_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通话并发记录表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_result`
--

DROP TABLE IF EXISTS `customer_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_result` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `group_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '技能组名称',
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '通话唯一标识',
  `cr_detail_id` bigint(20) NOT NULL COMMENT 'cr生成的通话详情ID',
  `result_id` bigint(20) NOT NULL COMMENT '结果选项ID',
  `result_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '结果选项名称',
  `parent_result_id` bigint(20) unsigned DEFAULT '0' COMMENT '父结果ID',
  `parent_result_name` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '父级结果选项名称',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `operator_uid` bigint(20) unsigned DEFAULT '0' COMMENT '操作坐席id',
  `operator_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '操作坐席分机号码',
  `operator_displayname` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '操作坐席名称',
  `static_state` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '通话统计状态：0-未统计 1-已统计',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `scc_number` (`seid`,`cc_number`,`cr_detail_id`),
  KEY `ccgeid` (`ccgeid`),
  KEY `parent_id` (`parent_result_id`),
  KEY `cc_number` (`cc_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='话后处理结果表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_result_scheme`
--

DROP TABLE IF EXISTS `customer_result_scheme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_result_scheme` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned DEFAULT '0' COMMENT '企业ID',
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '结果选项名称',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父结果ID',
  `order` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '排序序号',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `seid_ccgeid_parent_name` (`seid`,`ccgeid`,`parent_id`,`name`),
  KEY `ccgeid` (`ccgeid`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='话后处理结果选项表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `day_work_time`
--

DROP TABLE IF EXISTS `day_work_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `day_work_time` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `day` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '日期：YYYY-MM-DD',
  `work_status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '本日工作状态：0-不工作；1-工作',
  `work_time_range` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '08:00-18:00' COMMENT '工作时间段，可以允许多段工作时间',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '工作时间类型：0-企业工作时间 1-技能组工作时间',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `e_gid_day` (`seid`,`ccgeid`,`gid`,`day`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='日工作时间表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '设备名称',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '设备类型：0-AudioCodes 1-IMS 2-网经 3-NGN',
  `domain` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '设备域名',
  `port` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '设备端口',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='设备表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `district`
--

DROP TABLE IF EXISTS `district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `district` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '地区ID, ccdid',
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地区名称',
  `mt_server_ip` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '运维服务器IP',
  `mt_server_domain` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '运维服务器域名',
  `mt_http_port` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '运维服务器http端口',
  `mt_https_port` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '运维服务器https端口',
  `created_at` bigint(20) NOT NULL DEFAULT '0',
  `updated_at` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `mt_server_ip` (`mt_server_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='地区表';
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (1, '江苏', '112.80.5.243', 'yzj.10010js.com', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (2, '上海', '112.64.17.132', 'sh.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (3, '浙江', '124.160.11.216', 'zj.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (4, '安徽', '112.122.7.71', 'ah.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (5, '福建', '210.13.199.161', 'fj.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (6, '陕西', '123.138.182.42', 'sn.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (7, '河北', '61.55.151.26', 'www.woyzj.com', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (8, '北京', '123.127.255.83', 'bj.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (9, '广西', '121.31.40.24', 'emic.gx10010.com', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (10, '湖南', '211.91.224.92', 'hn.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (11, '西藏', '221.13.79.133', 'xz.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (12, '江西', '118.212.149.34', 'jx.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (13, '河南', '125.46.37.157', 'yzj.online.ha.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (14, '天津', '202.99.75.154', 'yzj.tjunicom.com', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (15, '贵州', '58.16.129.242', 'gz.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (16, '广东', '122.13.0.41', 'gd.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (17, '云南', '14.204.84.191', 'yn.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (18, '重庆', '113.207.68.64', 'cq.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (19, '四川', '101.207.248.3', 'sc.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (20, '山西', '221.204.48.145', 'sx.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (21, '甘肃', '180.95.129.171', 'gs.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (22, '辽宁', '60.18.206.82', 'ln.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (23, '山东', '119.188.162.225', 'sd.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (24, '海南', '113.59.36.171', 'han.emicloud.com', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (25, '湖北', '113.57.146.179', 'hub.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (100, '江苏开发测试服务器', '112.80.5.131', 'cses.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (101, '江苏专用测试环境', '112.80.5.155', 'kfyw.emic.com.cn', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (102, '江苏开发验证环境', '112.80.5.66', '112.80.5.66', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (128, '中国电信系统集成公司', '106.39.30.158', '106.39.30.158', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (129, '淄博电信', '58.57.109.203', '58.57.109.203', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (136, '测试', '10.0.1.60', '10.0.1.60', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (139, '测试21', '10.0.0.90', '10.0.0.90', '1046', '1047');
INSERT INTO `district` (`id`, `name`, `mt_server_ip`, `mt_server_domain`, `mt_http_port`, `mt_https_port`) VALUES (140, '测试27', '10.0.0.27', '10.0.0.27', '1046', '1047');

--
-- Table structure for table `district_number`
--

DROP TABLE IF EXISTS `district_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `district_number` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `ccdid` bigint(20) unsigned NOT NULL COMMENT '地区ID',
  `number` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '区号',
  `created_at` bigint(20) NOT NULL DEFAULT '0',
  `updated_at` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='区号表';
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `district_number`(`id`, `ccdid`, `number`) VALUES ('1', '1', '025'),('2', '8', '010'),('3', '101', '025'),('4', '1', '0510'),('5', '1', '0511'),('6', '1', '0512'),('7', '1', '0513'),('8', '1', '0514'),('9', '1', '0515'),('10', '1', '0516'),('11', '1', '0517'),('12', '1', '0518'),('13', '1', '0519'),('14', '1', '0523'),('15', '1', '0527'),('16', '2', '021'),('17', '3', '0570'),('18', '3', '0571'),('19', '3', '0572'),('20', '3', '0573'),('21', '3', '0574'),('22', '3', '0575'),('23', '3', '0576'),('24', '3', '0577'),('25', '3', '0578'),('26', '3', '0579'),('27', '3', '0580'),('28', '4', '0550'),('29', '4', '0551'),('30', '4', '0552'),('31', '4', '0553'),('32', '4', '0554'),('33', '4', '0555'),('34', '4', '0556'),('35', '4', '0557'),('36', '4', '0558'),('37', '4', '0559'),('38', '4', '0561'),('39', '4', '0562'),('40', '4', '0563'),('41', '4', '0564'),('42', '4', '0565'),('43', '4', '0566'),('44', '5', '0591'),('45', '5', '0592'),('46', '5', '0593'),('47', '5', '0594'),('48', '5', '0595'),('49', '5', '0596'),('50', '5', '0597'),('51', '5', '0598'),('52', '5', '0599'),('53', '6', '029'),('54', '6', '0911'),('55', '6', '0912'),('56', '6', '0913'),('57', '6', '0914'),('58', '6', '0915'),('59', '6', '0916'),('60', '6', '0917'),('61', '6', '0919'),('62', '7', '0310'),('63', '7', '0311'),('64', '7', '0312'),('65', '7', '0313'),('66', '7', '0314'),('67', '7', '0315'),('68', '7', '0316'),('69', '7', '0317'),('70', '7', '0318'),('71', '7', '0319'),('72', '7', '0335'),('73', '9', '0770'),('74', '9', '0771'),('75', '9', '0772'),('76', '9', '0773'),('77', '9', '0774'),('78', '9', '0775'),('79', '9', '0776'),('80', '9', '0777'),('81', '9', '0778'),('82', '9', '0779'),('83', '10', '0730'),('84', '10', '0731'),('85', '10', '0734'),('86', '10', '0735'),('87', '10', '0736'),('88', '10', '0737'),('89', '10', '0738'),('90', '10', '0739'),('91', '10', '0743'),('92', '10', '0744'),('93', '10', '0745'),('94', '10', '0746'),('95', '11', '0891'),('96', '11', '0892'),('97', '11', '0893'),('98', '11', '0894'),('99', '11', '0895'),('100', '11', '0896'),('101', '11', '0897'),('102', '12', '0701'),('103', '12', '0790'),('104', '12', '0791'),('105', '12', '0792'),('106', '12', '0793'),('107', '12', '0794'),('108', '12', '0795'),('109', '12', '0796'),('110', '12', '0797'),('111', '12', '0798'),('112', '12', '0799'),('113', '13', '0370'),('114', '13', '0371'),('115', '13', '0372'),('116', '13', '0373'),('117', '13', '0374'),('118', '13', '0375'),('119', '13', '0376'),('120', '13', '0377'),('121', '13', '0378'),('122', '13', '0379'),('123', '13', '0391'),('124', '13', '0392'),('125', '13', '0393'),('126', '13', '0394'),('127', '13', '0395'),('128', '13', '0396'),('129', '13', '0398'),('130', '14', '022'),('131', '15', '0851'),('132', '15', '0852'),('133', '15', '0853'),('134', '15', '0854'),('135', '15', '0855'),('136', '15', '0856'),('137', '15', '0857'),('138', '15', '0858'),('139', '15', '0859'),('140', '16', '020'),('141', '16', '0660'),('142', '16', '0662'),('143', '16', '0663'),('144', '16', '0668'),('145', '16', '0750'),('146', '16', '0751'),('147', '16', '0752'),('148', '16', '0753'),('149', '16', '0754'),('150', '16', '0755'),('151', '16', '0756'),('152', '16', '0757'),('153', '16', '0758'),('154', '16', '0759'),('155', '16', '0760'),('156', '16', '0762'),('157', '16', '0763'),('158', '16', '0766'),('159', '16', '0768'),('160', '16', '0769'),('161', '17', '0691'),('162', '17', '0692'),('163', '17', '0870'),('164', '17', '0871'),('165', '17', '0872'),('166', '17', '0873'),('167', '17', '0874'),('168', '17', '0875'),('169', '17', '0876'),('170', '17', '0877'),('171', '17', '0878'),('172', '17', '0879'),('173', '17', '0883'),('174', '17', '0886'),('175', '17', '0887'),('176', '17', '0888'),('177', '18', '023'),('178', '19', '028'),('179', '19', '0812'),('180', '19', '0813'),('181', '19', '0816'),('182', '19', '0817'),('183', '19', '0818'),('184', '19', '0825'),('185', '19', '0826'),('186', '19', '0827'),('187', '19', '0830'),('188', '19', '0831'),('189', '19', '0832'),('190', '19', '0833'),('191', '19', '0834'),('192', '19', '0835'),('193', '19', '0836'),('194', '19', '0837'),('195', '19', '0838'),('196', '19', '0839'),('197', '20', '0349'),('198', '20', '0350'),('199', '20', '0351'),('200', '20', '0352'),('201', '20', '0353'),('202', '20', '0354'),('203', '20', '0355'),('204', '20', '0356'),('205', '20', '0357'),('206', '20', '0358'),('207', '20', '0359'),('208', '21', '0930'),('209', '21', '0931'),('210', '21', '0932'),('211', '21', '0933'),('212', '21', '0934'),('213', '21', '0935'),('214', '21', '0936'),('215', '21', '0937'),('216', '21', '0938'),('217', '21', '0939'),('218', '21', '0941'),('219', '21', '0943'),('220', '22', '024'),('221', '22', '0411'),('222', '22', '0412'),('223', '22', '0415'),('224', '22', '0416'),('225', '22', '0417'),('226', '22', '0418'),('227', '22', '0419'),('228', '22', '0421'),('229', '22', '0427'),('230', '22', '0429'),('231', '23', '0530'),('232', '23', '0531'),('233', '23', '0532'),('234', '23', '0533'),('235', '23', '0534'),('236', '23', '0535'),('237', '23', '0536'),('238', '23', '0537'),('239', '23', '0538'),('240', '23', '0539'),('241', '23', '0543'),('242', '23', '0546'),('243', '23', '0631'),('244', '23', '0632'),('245', '23', '0633'),('246', '23', '0634'),('247', '23', '0635'),('248', '24', '0898'),('1000', '128', '010'),('1001', '129', '0533'),('10000', '100', '025'),('10001', '2', '010'),('10002', '2', '028'),('10003', '2', '020'),('10004', '2', '0755'),('10005', '2', '023'),('10006', '102', '025'),('10007', '150', '022'),('10008', '151', '022');

--
-- Table structure for table `enterprise`
--

DROP TABLE IF EXISTS `enterprise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccdid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '企业名称',
  `epcode` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '企业唯一编号（BSS）',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '企业状态 0-停用 1-启用',
  `b_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '业务状态 0、收费-签单 1、不收费-试用 2、演示 3、联通自用企业 4、调试企业',
  `expire_date` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '截止日期',
  `cc_domain_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心域ID',
  `eid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ES企业ID',
  `server_ip` varchar(31) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '企业服务器IP',
  `server_domain` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '企业服务器域名',
  `server_http_port` smallint(5) unsigned NOT NULL COMMENT '企业服务器http端口',
  `server_https_port` smallint(5) unsigned NOT NULL COMMENT '企业服务器https端口',
  `server_sip_port` smallint(5) unsigned DEFAULT NULL COMMENT '企业服务器SIP登录端口号',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deid` (`ccdid`,`eid`),
  KEY `seid` (`seid`),
  KEY `eid` (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `enterprise_numbers`
--

DROP TABLE IF EXISTS `enterprise_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_numbers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心全局企业id',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分机号',
  `state` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '分机号状态：0-未使用；1-座席使用；2-SIP话机使用',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `enterprise_number` (`ccgeid`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='呼叫中心企业分机号码表'
/*!50100 PARTITION BY KEY (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `enterprise_setting`
--

DROP TABLE IF EXISTS `enterprise_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `key` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置名称',
  `value` varchar(4055) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置值',
  `description` varchar(511) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置描述',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `ccgeid_key` (`ccgeid`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='企业配置表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='队列任务失败记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '技能组名称',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组父级ID',
  `level` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '技能组级别',
  `seat_policy` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '座席选择策略：0-最大空闲优先；1-随机选择；2-轮流选择',
  `flow_number` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '流转次数：0-不流转',
  `flow_timeout` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '流转超时时间：10-40',
  `vip_priority` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'VIP客户优先：0-VIP不优先；1-VIP绝对优先；2-10，优先权重',
  `queue_duration` int(11) unsigned NOT NULL DEFAULT '30' COMMENT '技能组排队时长, 默认30, 单位秒',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`),
  KEY `gid` (`gid`),
  KEY `s_c_gid` (`seid`,`ccgeid`,`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能组表'
/*!50100 PARTITION BY HASH (seid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;




DROP TABLE IF EXISTS `group_realtime_state`;
CREATE TABLE `group_realtime_state` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `state_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '状态ID',
  `state_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '状态名称',
  `state_switch_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '状态上次变化时间',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `seid` (`seid`,`ccgeid`,`gid`),
  KEY `state_id` (`state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能组实时状态表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;


DROP TABLE IF EXISTS `group_seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_seat` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `role` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '坐席角色：0-普通坐席 1-班长坐席',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`),
  UNIQUE KEY `ccgeid_gid_uid` (`seid`,`ccgeid`,`gid`,`uid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='组-坐席关联表'
/*!50100 PARTITION BY HASH (seid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group_setting`
--

DROP TABLE IF EXISTS `group_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `key` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '键',
  `value` mediumtext COLLATE utf8mb4_unicode_ci COMMENT '值',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`),
  UNIQUE KEY `ccgeid_gid_key` (`seid`,`ccgeid`,`gid`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能组配置表'
/*!50100 PARTITION BY HASH (seid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivr_flow`
--

DROP TABLE IF EXISTS `ivr_flow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivr_flow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id, ivr_flow_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '草稿所属用户ID',
  `flow_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '所属流程ID，此值不为0的时候，此流程为其他流程的草稿',
  `ivr_flow_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ivr流程名称',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT 'ivr流程类型 0-系统流程 1-普通流程 2-子流程 3-非工作时间流程 4-满意度评价流程',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为默认流程',
  `is_modify` tinyint(1) NOT NULL DEFAULT '0' COMMENT '为草稿时，是否被修改过',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr状态 0-未编译 1-已编译 2-使用中',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  KEY `user_id` (`user_id`),
  KEY `flow_id` (`flow_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR流程表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivr_flow_variable`
--

DROP TABLE IF EXISTS `ivr_flow_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivr_flow_variable` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ivr_flow_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr流程Id',
  `type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '变量类型',
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '变量名',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '变量值名称',
  `data_type` tinyint(255) DEFAULT NULL COMMENT '变量值类型',
  `default_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '变量默认值',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ivr_flow_id` (`ivr_flow_id`),
  KEY `ivr_enterprise_version` (`seid`,`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR节点变量表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivr_node`
--

DROP TABLE IF EXISTS `ivr_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivr_node` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长Id, ivr_node_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ivr_flow_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr流程Id',
  `ivr_node_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ivr节点名称',
  `ivr_node_slug` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ivr节点唯一标识',
  `ivr_node_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '节点类型',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `ivr_flow_node` (`seid`,`ccgeid`,`ivr_flow_id`,`ivr_node_name`),
  UNIQUE KEY `ivr_flow_node_slug` (`seid`,`ccgeid`,`ivr_flow_id`,`ivr_node_slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR节点表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivr_node_event`
--

DROP TABLE IF EXISTS `ivr_node_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivr_node_event` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID, ivr_node_event_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ivr_node_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr节点Id',
  `event_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '事件类型',
  `next_node_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '下一节点Id',
  `ivr_flow_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr流程Id',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `ivr_node_event` (`seid`,`ccgeid`,`ivr_node_id`,`event_type`),
  KEY `ivr_enterprise_version` (`ccgeid`),
  KEY `ivr_flow_id` (`ivr_flow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR节点事件表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivr_node_param`
--

DROP TABLE IF EXISTS `ivr_node_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivr_node_param` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID, ivr_node_param_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ivr_node_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr节点Id',
  `param_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '参数类型',
  `param_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数值',
  `ivr_flow_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr流程Id',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `ivr_node_param` (`seid`,`ccgeid`,`ivr_node_id`,`param_type`),
  KEY `ivr_enterprise_version` (`ccgeid`),
  KEY `ivr_flow_id` (`ivr_flow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR节点参数表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivr_node_set_variable`
--

DROP TABLE IF EXISTS `ivr_node_set_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivr_node_set_variable` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ivr_flow_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr流程Id',
  `ivr_node_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr节点Id',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '变量名称',
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '变量值',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ivr_node_id` (`ivr_node_id`),
  KEY `ivr_enterprise_version` (`seid`,`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR节点参数表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivr_version`
--

DROP TABLE IF EXISTS `ivr_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivr_version` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ivr_flow_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr流程Id',
  `ivr_version` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心企业ivr版本号',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `ivr_enterprise_version` (`seid`,`ccgeid`,`ivr_version`),
  KEY `ivr_flow_id` (`ivr_flow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR版本表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivr_voice`
--

DROP TABLE IF EXISTS `ivr_voice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivr_voice` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '存储路径',
  `origin_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件原名',
  `extension` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '扩展名',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '大小,单位字节',
  `md5hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'md5 hash值',
  `duration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '语音文件时长',
  `text` text COLLATE utf8mb4_unicode_ci COMMENT '转语音文本',
  `status` tinyint(255) NOT NULL DEFAULT '1' COMMENT '语音生成状态',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR语音文件表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('1', 'voice/default/default_ivr_welcome.wav', 'default_ivr_welcome.wav', 'wav', '37408', '940e700a278d60b5110ac629290d2c82', '00:00:02.34', '欢迎致电呼叫中心企业');
INSERT INTO `ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('2', 'voice/default/level3_satisfy_notice.wav', 'level3_satisfy_notice.wav', 'wav', '144332', '93953e554886c3b8386fe93e2b3dba59', '00:00:09.02', '请对我们的服务进行评价：满意请按1，一般请按2，不满意请按3，重听请按0');
INSERT INTO `ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('3', 'voice/default/level5_satisfy_notice.wav', 'level5_satisfy_notice.wav', 'wav', '214152', '1de6e2947a7aab3eb0157ded4a324815', '00:00:13.38', '请对我们的服务进行评价：非常满意请按1，满意请按2，一般请按3，不满意请按4，非常不满意请按5，重听请按0');
INSERT INTO `ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('4', 'voice/default/offWork_ivr_default_bell.wav', 'offWork_ivr_default_bell.wav', 'wav', '104610', '59cf6ba484eb31c3894fb1f3b873dccc', '00:00:06.54', '您好，现在是非工作时间，暂不提供服务，感谢您的配合');
INSERT INTO `ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('8', 'voice/default/point5_satisfy_notice.wav', 'point5_satisfy_notice.wav', 'wav', '204078', 'cda7bf5070190ca543fa374d97f326bb', '00:00:12.75', '请对我们的服务进行评价：1分 非常满意，2分 满意，3分 一般，4分 不满意，5分 非常不满意，重听请按0');
INSERT INTO `ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('9', 'voice/default/satisfy_over_notice.wav', 'satisfy_over_notice.wav', 'wav', '23446', '2956502c60ac0b4834358df1476f8ca7', '00:00:01.46', '感谢您的配合');
INSERT INTO `ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('10', 'voice/default/work_number_broadcast_voice.wav', 'work_number_broadcast_voice.wav', 'wav', '66548', 'cfb04f3921ef594b66dbb8ada929ae9d', '00:00:04.16', '您好，一二三四五六号话务员为您服务');
INSERT INTO `ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('11', 'voice/default/work_number_broadcast_forward_voice.wav', 'work_number_broadcast_forward_voice.wav', 'wav', '10482', '5b3b53d5b75343c2e635183591988561', '00:00:00.65', '您好');
INSERT INTO `ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('12', 'voice/default/work_number_broadcast_backward_voice.wav', 'work_number_broadcast_backward_voice.wav', 'wav', '30386', 'bcc99ac162cf20c810055e9ca9a53c0b', '00:00:01.90', '号话务员为您服务');
INSERT INTO `ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('13', 'voice/default/work_number_broadcast_default_number.wav', 'work_number_broadcast_default_number.wav', 'wav', '22070', 'acef4a1f3f2c1829d7b154e763403cb9', '00:00:01.38', '一二三四五六');
INSERT INTO `ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('14', 'voice/default/customer_memory_default_voice.wav', 'customer_memory_default_voice.wav', 'wav', '54174', '020657f5b0c896f3cb4543968326b123', '00:00:03.38', '当前坐席全忙，请您稍后再拨');
INSERT INTO `ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('15', 'voice/default/call_hold_voice_default.wav', 'call_hold_voice_default.wav', 'wav', '40290', '6143bf9fcecefdd81e2ee5b9b4397e53', '00:00:02.52', '通话保持中，请稍候');
INSERT INTO `ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('16', 'voice/default/wait_in_line_voice.wav', 'wait_in_line_voice.wav', 'wav', '1279022', 'a1c9c79f4da6f38a289f695321c0bc2c', '00:00:39.97', null);
INSERT INTO `ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('17', 'voice/default/seat_busy_voice.wav', 'seat_busy_voice.wav', 'wav', '83210', '8c8919aed5d02f8c230cbd5722d6e0b9', '00:00:05.20', '当前坐席正忙，继续等待请按1，结束请挂机');
INSERT INTO `ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('18', 'voice/default/seat_disabled_voice.wav', 'seat_disabled_voice.wav', 'wav', '98644', '15515afde85066fef56dd603b2078ffb', '00:00:06.16', '该坐席已被停用，转系统语音导航请按1，结束请挂机');
INSERT INTO `ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('19', 'voice/default/seat_missed_voice.wav', 'seat_missed_voice.wav', 'wav', '96648', '13e4cc501801ac7047583b1d034aa70d', '00:00:06.04', '坐席正在处理其他业务，继续等待请按1，结束请挂机');

--
-- Table structure for table `mobile_state`
--

DROP TABLE IF EXISTS `mobile_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_state` (
  `mobile_code` int(11) unsigned NOT NULL COMMENT '手机号段（前7位）',
  `area_code` smallint(6) unsigned NOT NULL COMMENT '区号',
  UNIQUE KEY `mobile_code` (`mobile_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='手机号段区号表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `operation_log`
--

DROP TABLE IF EXISTS `operation_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operation_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL COMMENT '操作类型',
  `module` tinyint(4) DEFAULT NULL COMMENT '操作对象',
  `user_type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户类型',
  `user_id` bigint(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `user` longtext COLLATE utf8mb4_unicode_ci COMMENT '用户详情数据',
  `seid` bigint(11) NOT NULL DEFAULT '0' COMMENT '超级企业id',
  `ccgeid` bigint(11) NOT NULL DEFAULT '0' COMMENT '企业id',
  `enterprise` longtext COLLATE utf8mb4_unicode_ci COMMENT '企业详情数据',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作标题',
  `ip` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作IP',
  `source` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求来源',
  `created_at` bigint(20) DEFAULT NULL COMMENT '操作时间',
  `updated_at` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`seid`),
  KEY `user_type` (`user_type`,`user_id`),
  KEY `ccgeid` (`ccgeid`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作日志表'
/*!50100 PARTITION BY HASH (seid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `operation_log_data`
--

DROP TABLE IF EXISTS `operation_log_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operation_log_data` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `log_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '操作ID',
  `origin_data` text COLLATE utf8mb4_unicode_ci COMMENT '原数据',
  `data` text COLLATE utf8mb4_unicode_ci COMMENT '新数据',
  `created_at` bigint(20) NOT NULL,
  `updated_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `log_id` (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作日志数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID, permission_id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '上级权限ID',
  `order` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `icon` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '页面展示图标',
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '权限名称',
  `slug` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '权限标识',
  `http_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求的HTTP方法',
  `http_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求的地址',
  `is_menu` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否作为菜单显示：0-非菜单 1-系统后台菜单 2-企业后台菜单',
  `menu_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `frontend_route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '前端路由',
  `is_protected` tinyint(4) NOT NULL DEFAULT '0' COMMENT '权限是否受保护，0-不限制 1-禁用 2-自建角色受限(超级企业级别) 3-自建角色受限(企业级别)',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_permissions_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1', '0', '0', 'icon-shouye-', '首页（系统后台）', null, '[]', '', '1', '首页', 'sysHome', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('2', '0', '0', 'icon-qiyeguanlidianji', '企业管理（系统后台）', null, '[]', '', '1', '企业管理', 'epMgt', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('3', '0', '0', 'icon-tongji', '通话统计（系统后台）', null, '[]', '', '1', '通话统计', '/', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('4', '3', '0', '', '并发统计（系统后台）', null, '[]', '', '1', '并发统计', 'callReportSystem', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('5', '0', '0', 'icon-caozuorizhi', '操作日志（系统后台）', null, '[]', '', '1', '操作日志', 'sysOperationLog', '1', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('6', '0', '0', 'icon-zhanghuziliao', '权限管理（系统后台）', null, '[]', '', '1', '权限管理', '/', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('7', '6', '0', '', '系统角色管理（系统后台）', null, '[]', '', '1', '系统角色管理', 'systemRoleMgt', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('8', '6', '0', '', '系统用户管理（系统后台）', null, '[]', '', '1', '系统用户管理', 'systemUserMgt', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1000', '0', '0', 'icon-shouye-', '首页', null, '[]', '', '2', '首页', 'epHome', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1100', '0', '0', 'icon-zhanghuziliao', '权限管理', null, '[]', '', '2', '权限管理', '/', '3', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1101', '1100', '0', '', '企业管理员管理', null, '[]', '', '2', '企业管理员管理', 'epAdminMgt', '3', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1102', '1100', '0', '', '角色用户管理', null, '[]', '', '2', '角色用户管理', 'customRoleUserMgt', '2', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1103', '1100', '0', '', '操作日志（权限管理）', null, '[]', '', '2', '操作日志', 'permissionOperationLog', '1', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1200', '0', '0', 'icon-qunzuduoren', '坐席与技能组', null, '[]', '', '2', '坐席与技能组', '/', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1201', '1200', '0', '', '坐席分配', null, '[]', '', '2', '坐席分配', 'seatAsg', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1202', '1200', '0', '', '坐席管理', null, '[]', '', '2', '坐席管理', 'seatMgt', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1203', '1200', '0', '', '技能组管理', null, '[]', '', '2', '技能组管理', 'groupMgt', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1204', '1200', '0', '', '忙碌状态管理', null, '[]', '', '2', '忙碌状态管理', 'seatState', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1205', '1200', '0', '', '操作日志（坐席管理）', null, '[]', '', '2', '操作日志', 'seatOperationLog', '1', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1300', '0', '0', 'icon-tonghuajilu-', '通话记录', null, '[]', '', '2', '通话记录', '/', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1301', '1300', '0', '', '客户通话', null, '[]', '', '2', '客户通话', 'callRecord', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1302', '1300', '0', '', '内部通话', null, '[]', '', '2', ' 内部通话', 'callInside', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1400', '0', '0', 'icon-tongji', '统计中心', null, '[]', '', '2', '统计中心', '/', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1401', '1400', '0', '', '整体统计', null, '[]', '', '2', '整体统计', 'integratedReport', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1402', '1400', '0', '', '技能组统计', null, '[]', '', '2', '技能组统计', 'groupReport', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1403', '1400', '0', '', '坐席统计', null, '[]', '', '2', '坐席统计', 'seatReport', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1404', '1400', '0', '', '并发统计', null, '[]', '', '2', '并发统计', 'concurrentReport', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1405', '1400', '0', '', '话后处理统计', null, '[]', '', '2', '话后处理统计', 'callResultReport', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1406', '1400', '0', '', '统计配置', null, '[]', '', '2', '统计配置', 'statisticsConfig', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1500', '0', '0', 'icon-IVRguanlidianji', 'IVR流程', null, '[]', '', '2', 'IVR流程', 'ivrMgt', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1600', '0', '0', 'icon-caozuorizhi', '外呼管理', null, '[]', '', '2', '总机号码管理', '/', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1601', '1600', '0', '', '总机号码管理', null, '[]', '', '2', '总机号码管理', 'switchNumberMgt', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1602', '1600', '0', '', '直线号码管理', null, '[]', '', '2', '直线号码管理', 'directNumberMgt', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1603', '1600', '0', '', '外呼模式配置', null, '[]', '', '2', '外呼模式配置', 'outcallModeConfig', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1604', '1600', '0', '', '操作日志（外呼管理）', null, '[]', '', '2', '操作日志', 'outcallOperationLog', '1', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1700', '0', '0', 'icon-dianhua4', '外呼任务管理', null, '[]', '', '2', '外呼任务管理', '/', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1701', '1700', '0', '', '外呼任务列表', null, '[]', '', '2', '外呼任务列表', 'taskList', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1702', '1700', '0', '', '外呼结果统计', null, '[]', '', '2', '外呼结果统计', 'resultStatic', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1703', '1700', '0', '', '外呼实时数据', null, '[]', '', '2', '外呼实时数据', 'realTimeData', '1', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1800', '0', '0', 'icon1-huajiguanli', '话机管理', null, '[]', '', '2', '话机管理', '/', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1801', '1800', '0', '', '回拨话机管理', null, '[]', '', '2', '回拨话机管理', 'terminalMgt', '1', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1802', '1800', '0', '', 'SIP话机管理', null, '[]', '', '2', 'SIP话机管理', 'sipTelMgt', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1900', '0', '0', 'icon1-heibaimingdan', '黑白名单管理', null, '[]', '', '2', '黑白名单管理', '/', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1901', '1900', '0', '', '黑名单管理', null, '[]', '', '2', '黑名单管理', 'blackListMgt', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1902', '1900', '0', '', '白名单管理', null, '[]', '', '2', '白名单管理', 'whiteListMgt', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1903', '1900', '0', '', '黑白名单配置', null, '[]', '', '2', '黑白名单配置', 'listConfig', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('1904', '1900', '0', '', '操作日志（黑白名单）', null, '[]', '', '2', '操作日志', 'listOperationLog', '1', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('9000', '0', '0', 'icon1-peizhizhongxin', '配置中心', null, '[]', '', '2', '配置中心', '/', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('9001', '9000', '0', '', '工作时间配置', null, '[]', '', '2', '工作时间配置', 'workTimeConfig', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('9002', '9000', '0', '', '满意度配置', null, '[]', '', '2', '满意度配置', 'satisfactionConfig', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('9003', '9000', '0', '', '防骚扰配置', null, '[]', '', '2', '防骚扰配置', 'harassmentConfig', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('9004', '9000', '0', '', '号码隐藏配置', null, '[]', '', '2', '号码隐藏配置', 'concealConfig', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('9005', '9000', '0', '', '工号播报配置', null, '[]', '', '2', '工号播报配置', 'numBroadcastConfig', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('9006', '9000', '0', '', '熟客记忆配置', null, '[]', '', '2', '熟客记忆配置', 'remFrequentConfig', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('9007', '9000', '0', '', '话后处理配置', null, '[]', '', '2', '话后处理配置', 'callResultConfig', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('9008', '9000', '0', '', '智能路由配置', null, '[]', '', '2', '智能路由配置', 'intelligentRouter', '0', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('9009', '9000', '0', '', '客户端转接配置', null, '[]', '', '2', '客户端转接配置', 'transferConfig', '3', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('9010', '9000', '0', '', '语音文件配置', null, '[]', '', '2', '语音文件配置', 'voiceFileConfig', '3', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('9011', '9000', '0', '', '录音文件名配置', null, '[]', '', '2', '录音文件名配置', 'recordFileConfig', '3', '');
INSERT INTO `permission` (`id`, `parent_id`, `order`, `icon`, `name`, `slug`, `http_method`, `http_path`, `is_menu`, `menu_name`, `frontend_route`, `is_protected`, `description`) VALUES ('9100', '0', '0', 'icon-caozuorizhi', '操作日志', null, '[]', '', '2', '操作日志', 'operation', '1', '');


--
-- Table structure for table `pub_account`
--

DROP TABLE IF EXISTS `pub_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pub_account` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '外线ID, paid',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `device_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '设备ID',
  `outline_name` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '外线名称',
  `area_code` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '区号',
  `outline_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '外线号码，完整号码（区号+裸号）',
  `physical_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '物理号码，NGN适用',
  `out_call_prefix` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '呼出前缀，一般为9',
  `province_city` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '归属地',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '外线类型：0-总机-switchnumber 1-直线-directnumber 2-会议-mettingnumber',
  `status` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '号码状态：0-开通 1-欠费停机  2-欠费半停机-只允许呼入 3-用户申请停机',
  `uri` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联通认证所需',
  `proxy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联通认证所需',
  `port` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '端口',
  `registrar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'device_domain:port',
  `realm` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth_username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '认证用户名',
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `gw_mode` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '是否向联通注册该号码：1-regs mode 2-sip trunk',
  `max_in_call` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最大呼入并发数',
  `max_out_call` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最大呼出并发数',
  `max_in_out_call` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最大呼叫并发数',
  `call_permission` tinyint(4) unsigned NOT NULL DEFAULT '2' COMMENT '呼叫权限：0-内线 1-市话 2-国内长途 3-国际长途，默认为2',
  `change_flag` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否为呼叫中继（是否可以改号）：0:否 1:是',
  `dtmf_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '收号方式：0:Rfc2833 1:inbind',
  `attribute` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '外线号码属性：0-公共 1-技能组专属 2-坐席专属',
  `disabled` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '外线号码是否禁用：0-否 1-是',
  `is_allow_outcall` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '是否允许外呼：0-否 1-是',
  `ivr_flow_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '绑定IVR流程ID',
  `ivr_ingress_node_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '绑定IVR流程入口节点ID',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `outline_number` (`outline_number`),
  KEY `seid` (`seid`),
  KEY `ccgeid` (`ccgeid`),
  KEY `type` (`type`),
  KEY `attribute` (`attribute`),
  KEY `disabled` (`disabled`)
) ENGINE=InnoDB AUTO_INCREMENT=1000000000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='外线表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pub_account_attribution`
--

DROP TABLE IF EXISTS `pub_account_attribution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pub_account_attribution` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `paid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '外线ID',
  `outline_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '外线号码，完整号码（区号+裸号）',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `paid_gid_uid` (`seid`,`ccgeid`,`paid`,`gid`,`uid`),
  KEY `ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='外线号码归属配置表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `result_statistics_of_ep`
--

DROP TABLE IF EXISTS `result_statistics_of_ep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `result_statistics_of_ep` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `state_type` tinyint(4) NOT NULL COMMENT '统计类型(1:天/2:月/3:年)',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '时间戳(当天/当月第一天/当年第一天)',
  `result_id` bigint(20) NOT NULL COMMENT '结果选项ID',
  `result_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '结果选项名称',
  `parent_result_id` bigint(20) DEFAULT '0' COMMENT '父级结果选项ID',
  `parent_result_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '父级结果选项名称',
  `signed_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '标记数',
  PRIMARY KEY (`id`,`seid`),
  UNIQUE KEY `ccgeid_timestamp` (`seid`,`ccgeid`,`state_type`,`timestamp`,`parent_result_name`,`result_name`),
  KEY `result_name` (`result_name`),
  KEY `parent_result_name` (`parent_result_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业话后处理统计表'
  /*!50100 PARTITION BY HASH (seid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `result_statistics_of_group`
--

DROP TABLE IF EXISTS `result_statistics_of_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `result_statistics_of_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `state_type` tinyint(4) NOT NULL COMMENT '统计类型(1:天/2:月/3:年)',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组GID',
  `group_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '技能组名称',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '时间戳(当天/当月第一天/当年第一天)',
  `result_id` bigint(20) NOT NULL COMMENT '结果选项ID',
  `result_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '结果选项名称',
  `parent_result_id` bigint(20) DEFAULT '0' COMMENT '父级结果选项ID',
  `parent_result_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '父级结果选项名称',
  `signed_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '标记数',
  PRIMARY KEY (`id`,`seid`),
  UNIQUE KEY `ccgeid_gid_timestamp` (`seid`,`ccgeid`,`gid`,`state_type`,`timestamp`,`parent_result_name`,`result_name`),
  KEY `result_name` (`result_name`),
  KEY `parent_result_name` (`parent_result_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能组话后处理统计表'
  /*!50100 PARTITION BY HASH (seid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `result_statistics_of_seat`
--

DROP TABLE IF EXISTS `result_statistics_of_seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `result_statistics_of_seat` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `state_type` tinyint(4) NOT NULL COMMENT '统计类型(1:天/2:月/3:年)',
  `gid` bigint(20) unsigned DEFAULT '0' COMMENT '技能组GID',
  `group_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '技能组名称',
  `seat_id` bigint(20) unsigned NOT NULL COMMENT '坐席ID',
  `seat_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '分机号码',
  `seat_displayname` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '坐席名称',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '时间戳(当天/当月第一天/当年第一天)',
  `result_id` bigint(20) NOT NULL COMMENT '结果选项ID',
  `result_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '结果选项名称',
  `parent_result_id` bigint(20) DEFAULT '0' COMMENT '父级结果选项ID',
  `parent_result_name` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '父级结果选项名称',
  `signed_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '标记数',
  PRIMARY KEY (`id`,`seid`),
  UNIQUE KEY `ccgeid_seatid_timestamp` (`seid`,`ccgeid`,`seat_id`,`state_type`,`timestamp`,`parent_result_name`,`result_name`),
  KEY `result_name` (`result_name`),
  KEY `parent_result_name` (`parent_result_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席话后处理统计表'
  /*!50100 PARTITION BY HASH (seid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id: role_id',
  `type` tinyint(4) unsigned NOT NULL COMMENT '角色类型：0-系统管理员；1-超级企业管理员；2-企业管理员；98-自建超级企业角色 99-自建企业角色',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名',
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色标识',
  `description` varchar(511) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '角色描述',
  `disabled` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否禁用：0-否 1-是',
  `creator_userid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建人用户ID',
  `owner_userid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '归属人用户ID',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`),
  UNIQUE KEY `admin_roles_name_unique` (`seid`,`name`),
  KEY `owner_userid` (`owner_userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色表'
/*!50100 PARTITION BY HASH (seid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `role`(`id`,`type`,`seid`,`name`,`slug`) values (1,0,0,'系统管理员','system.manager');
INSERT INTO `role`(`id`,`type`,`seid`,`name`,`slug`) values (2,1,0,'超级企业管理员','super.enterprise.manager');
INSERT INTO `role`(`id`,`type`,`seid`,`name`,`slug`) values (3,2,0,'企业管理员','enterprise.manager');

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_permission` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `role_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '角色ID',
  `permission_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '权限ID',
  `parameter` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '允许请求的参数，为空则允许请求所有参数',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`role_id`),
  KEY `admin_role_permissions_role_id_permission_id_index` (`role_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色权限表'
/*!50100 PARTITION BY HASH (role_id)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('1', '1');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('1', '2');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('1', '3');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('1', '4');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('1', '5');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('1', '6');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('1', '7');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('1', '8');

INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1000');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1100');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1101');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1102');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1103');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1200');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1201');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1202');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1203');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1204');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1300');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1301');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1302');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1400');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1401');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1402');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1403');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1404');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1405');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1406');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1500');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1600');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1601');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1602');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1603');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1604');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1700');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1701');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1702');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1703');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1800');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1801');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1802');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1900');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1901');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1902');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1903');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '1904');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '9000');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '9001');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '9002');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '9003');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '9004');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '9005');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '9006');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '9007');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '9008');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '9009');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '9010');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '9011');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('2', '9100');

INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1000');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1100');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1102');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1103');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1200');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1201');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1202');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1203');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1204');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1300');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1301');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1302');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1400');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1401');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1402');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1403');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1404');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1405');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1406');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1500');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1600');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1601');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1602');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1603');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1604');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1700');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1701');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1702');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1703');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1800');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1801');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1802');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1900');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1901');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1902');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1903');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '1904');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '9000');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '9001');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '9002');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '9003');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '9004');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '9005');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '9006');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '9007');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '9008');
INSERT INTO `role_permission` ( `role_id`, `permission_id`) VALUES ('3', '9100');


--
-- Table structure for table `role_user`
--

DROP TABLE IF EXISTS `role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `role_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '角色ID',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `enterprise_group_role_user` (`seid`,`ccgeid`,`gid`,`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业角色用户表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `role_user` (`id`, `seid`, `ccgeid`, `user_id`, `role_id`) VALUES (1, 0, 0, 1, 1);

--
-- Table structure for table `seat`
--

DROP TABLE IF EXISTS `seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seat` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长用户id:uid',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `displayname` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '坐席名称',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分机号码',
  `get_number_type` tinyint(4) unsigned DEFAULT '1' COMMENT '获取分机号方式,1：系统分配 2:手动输入',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `work_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '工号',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号码',
  `device_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '（话机）设备号码',
  `device_binded` enum('Y','N') CHARACTER SET ascii NOT NULL DEFAULT 'N' COMMENT '是否已绑定设备：N-不是；Y-是',
  `m_operator` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机归属运营商简称：联通（CNC），电信（CTC） ，移动（CMCC）',
  `m_area_code` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机归属区号',
  `duty` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '职务',
  `address` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  `paid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '绑定直线ID',
  `direct_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '绑定直线号码',
  `callintype` tinyint(4) unsigned NOT NULL DEFAULT '2' COMMENT '外呼方式：1-电话直拨 2-网络通话 4-总机回拨 5-SIP话机',
  `seat_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '用户类型：0-正常坐席；1-外转坐席；2-专职在线客户座席',
  `is_online_seat` enum('Y','N') CHARACTER SET ascii NOT NULL DEFAULT 'N' COMMENT '是否在线客服(user_type=0,2)：N-不是；Y-是',
  `is_mobile_seat` enum('Y','N') CHARACTER SET ascii NOT NULL DEFAULT 'N' COMMENT '是否移动坐席(user_type=0,1)：N-不是；Y-是',
  `mobile_verified` enum('Y','N') CHARACTER SET ascii NOT NULL DEFAULT 'N' COMMENT '手机号码是否已验证：0-未验证；1-已验证',
  `disabled` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否禁用 0-否 1-是',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`),
  UNIQUE KEY `work_number` (`seid`,`ccgeid`,`work_number`),
  UNIQUE KEY `uid_paid` (`id`,`seid`,`ccgeid`,`paid`),
  KEY `s_c_number` (`seid`,`ccgeid`,`number`),
  KEY `s_c_mobile` (`seid`,`ccgeid`,`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席表'
/*!50100 PARTITION BY HASH (seid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seat_c_state_record`
--

DROP TABLE IF EXISTS `seat_c_state_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seat_c_state_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '对应cr记录表的id',
  `uid` bigint(20) unsigned NOT NULL COMMENT '用户id',
  `seat_name` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '坐席名称',
  `seat_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '坐席分机号码',
  `seat_work_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '坐席工号',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `c_state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '座席状态：0-离线；1-已注册；2-空闲；3-忙碌；4-锁定；5-消息振铃；6-设备接续；7-设备振铃；8-通话中；9-话后处理；',
  `busy_state_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '忙碌子状态ID',
  `busy_state_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '忙绿子状态名称',
  `state_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席状态变化时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '统计状态：0-未统计 1-统计中 2-已统计',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`),
  KEY `ccgeid_uid` (`seid`,`ccgeid`,`uid`),
  KEY `state` (`c_state`,`busy_state_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席状态记录表'
/*!50100 PARTITION BY HASH (seid)
PARTITIONS 128 */;

/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seat_realtime_state`
--

DROP TABLE IF EXISTS `seat_realtime_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seat_realtime_state` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `state_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席状态ID',
  `state_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '坐席状态名称',
  `sub_state_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席子状态ID',
  `sub_state_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '坐席子状态名称',
  `state_switch_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席状态上次变化时间',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`),
  UNIQUE KEY `seid` (`seid`,`ccgeid`,`uid`),
  KEY `state` (`state_id`,`sub_state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席实时状态表'
/*!50100 PARTITION BY HASH (seid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seat_setting`
--

DROP TABLE IF EXISTS `seat_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seat_setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `key` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '键',
  `value` mediumtext COLLATE utf8mb4_unicode_ci COMMENT '值',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`),
  UNIQUE KEY `ccgeid_uid_key` (`seid`,`ccgeid`,`uid`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席配置表'
/*!50100 PARTITION BY HASH (seid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seat_state_config`
--

DROP TABLE IF EXISTS `seat_state_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seat_state_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `seid` bigint(20) unsigned DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned DEFAULT '0' COMMENT '企业ID',
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '状态名称',
  `description` varchar(511) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父状态ID',
  `order` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '排序序号',
  `visible` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否显示 0-否 1-是',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_state` (`ccgeid`,`name`),
  KEY `seid` (`seid`),
  KEY `ccgeid` (`ccgeid`),
  KEY `parent_id` (`parent_id`),
  KEY `visible` (`visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席状态配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `seat_state_config` (`id`, `name`, `parent_id`, `order`, `visible`) VALUES (1, '离线', 0, 1, 0);
INSERT INTO `seat_state_config` (`id`, `name`, `parent_id`, `order`, `visible`) VALUES (2, '空闲', 0, 2, 0);
INSERT INTO `seat_state_config` (`id`, `name`, `parent_id`, `order`, `visible`) VALUES (3, '振铃中', 0, 3, 0);
INSERT INTO `seat_state_config` (`id`, `name`, `parent_id`, `order`, `visible`) VALUES (4, '通话中', 0, 4, 0);
INSERT INTO `seat_state_config` (`id`, `name`, `parent_id`, `order`, `visible`) VALUES (5, '忙碌', 0, 5, 0);
INSERT INTO `seat_state_config` (`id`, `name`, `parent_id`, `order`, `visible`) VALUES (6, '话后处理', 0, 6, 0);

--
-- Table structure for table `secret`
--

DROP TABLE IF EXISTS `secret`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `secret` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '秘钥名称',
  `value` varchar(511) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '秘钥',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='签名秘钥表';
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `secret` (`id`, `name`, `value`, `description`) VALUES (1, 'es_cm_default_secret', 'es.cm.default.secret.bbb369c1602db5f6c', 'ES请求CM的默认签名秘钥');
INSERT INTO `secret` (`id`, `name`, `value`, `description`) VALUES (2, 'cm_cr_default_secret', 'cm.cr.default.secret.a88340c41ae72733e', 'CM请求CR的默认签名秘钥');
INSERT INTO `secret` (`id`, `name`, `value`, `description`) VALUES (3, 'cr_cm_default_secret', 'cr.cm.default.secret.5606c655fd6e0b3ds', 'CR请求CM的默认签名秘钥');
INSERT INTO `secret` (`id`, `name`, `value`, `description`) VALUES (4, 'api_cm_default_secret', 'api.cm.default.secret.da388235780e6fy5', 'API请求CM的默认签名秘钥');
INSERT INTO `secret` (`id`, `name`, `value`, `description`) VALUES (5, 'cp_cm_default_secret', 'cp.cm.default.secret.ce2d748857d0a09fd', 'CP请求CM的默认签名秘钥');

--
-- Table structure for table `setting`
--

DROP TABLE IF EXISTS `setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '键',
  `value` varchar(511) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '值',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('environment', 'production', '开发环境/测试环境/生产环境:development/testing/production');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('anti_repeat_request', '0', '是否开启接口防重复请求(是否校验header头 nonce参数)');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('signature_validate', '1', '是否开启签名认证签名校验');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('timestamp_validate', '0', '是否开启请求时间戳误差校验');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('primary_domain', 'emic.com.cn', '管理平台主域名');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('system_sub_domain', 'cc', '系统后台二级域名');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('cc_running_ip', '10.0.1.49', '运营平台IP');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('cc_running_domain', '10.0.1.49', '运营平台域名');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('cc_running_http_port', '80', '运营平台HTTP端口');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('cc_running_https_port', '81', '运营平台HTTPS端口');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('user_default_pwd', '123456', '用户默认初始密码');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('record_kss_ak', 'AKLT0ChC2dqZRK6viMM8BwGZLQ', '金山云录音密钥账户');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('record_kss_sk', 'OON5JF1+0bNybjpIQFEarsC07rsg5bldKtcE08q+ok6ZSdXbQona788JRj1CiuRPbg==', '金山云录音下载密钥');

--
-- Table structure for table `sip_number`
--

DROP TABLE IF EXISTS `sip_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sip_number` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '基础平台SIP用户ID',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分机号码',
  `username` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '话机状态，0-离线，1-在线',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '绑定状态，0-未绑定，1-已绑定',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'SIP话机类型，0-IP话机，1-IAD',
  `mac_address` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'MAC地址',
  `description` varchar(511) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `is_bind_seat` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否绑定坐席 0-否 1-是',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `e_number` (`seid`,`ccgeid`,`number`),
  KEY `type` (`type`),
  KEY `is_bind_seat` (`is_bind_seat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='SIP话机号码表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sip_server`
--

DROP TABLE IF EXISTS `sip_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sip_server` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_type` tinyint(4) NOT NULL COMMENT '产品类型 0-呼叫中心 1-云总机',
  `arch_type` tinyint(4) NOT NULL COMMENT '新老架构 0-新架构 1-老架构',
  `ccdid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `district_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地区名称',
  `cc_domain_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心域ID（分组）',
  `sip_server_domain` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'SIP服务器域名',
  `sipphone_server_domain` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'SIP话机服务器域名',
  `sip_server_port` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'SIP端口',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_arch_ccdid_cc_domain_id` (`product_type`,`arch_type`,`ccdid`,`cc_domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='SIP服务器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sipphone_c_state_record`
--

DROP TABLE IF EXISTS `sipphone_c_state_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sipphone_c_state_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'SIP分机号码',
  `c_state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '话机状态：0-离线；1-在线',
  `state_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '话机状态变化时间',
  `logined_uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '登录的坐席UID',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  KEY `ccgeid_time_number` (`seid`,`ccgeid`,`number`,`c_state`),
  KEY `c_state` (`seid`,`ccgeid`,`c_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='sip话机状态记录表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `state_dict`
--

DROP TABLE IF EXISTS `state_dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state_dict` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `province` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '省',
  `city` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '市',
  `village` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '乡镇区',
  `province_city` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '显示的名称',
  `area_code` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '区号',
  `sub_number` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '号码前几位，用于区分同区号下不同地市的情况',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_state_dict_area_code_sub_number` (`area_code`,`sub_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='区号字典表';
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `state_dict`(province,city,province_city,area_code,sub_number,village) VALUES('北京','北京','北京市','010','',''),('上海','上海','上海市','021','',''),('天津','天津','天津市','022','',''),('重庆','重庆','重庆市','023','',''),('广东','广州','广东省广州市','020','',''),('辽宁','沈阳','辽宁省沈阳市','024','',''),('江苏','南京','江苏省南京市','025','',''),('湖北','武汉','湖北省武汉市','027','',''),('四川','成都资阳眉山','四川省成都资阳眉山','028','',''),('甘肃','金昌武威','甘肃省金昌武威','0935','',''),('陕西','西安','陕西省西安市','029','',''),('陕西','西安','陕西省咸阳市','029','3',''),('河北','邯郸','河北省邯郸市','0310','',''),('河北','石家庄','河北省石家庄市','0311','',''),('河北','保定','河北省保定市','0312','',''),('河北','张家口','河北省张家口','0313','',''),('河北','承德','河北省承德市','0314','',''),('河北','唐山','河北省唐山市','0315','',''),('河北','廊坊','河北省廊坊市','0316','',''),('河北','沧州','河北省沧州市','0317','',''),('河北','衡水','河北省衡水市','0318','',''),('河北','邢台','河北省邢台市','0319','',''),('河北','秦皇岛','河北省秦皇岛市','0335','',''),('山西','朔州','山西省朔州市','0349','',''),('山西','忻州','山西省忻州市','0350','',''),('山西','太原','山西省太原市','0351','',''),('山西','大同','山西省大同市','0352','',''),('山西','阳泉','山西省阳泉市','0353','',''),('山西','晋中','山西省晋中市','0354','',''),('山西','长治','山西省长治市','0355','',''),('山西','晋城','山西省晋城市','0356','',''),('山西','临汾','山西省临汾市','0357','',''),('山西','吕梁','山西省吕梁市','0358','',''),('山西','运城','山西省运城市','0359','',''),('河南','商丘','河南省商丘市','0370','',''),('河南','郑州','河南省郑州市','0371','',''),('河南','安阳','河南省安阳市','0372','',''),('河南','新乡','河南省新乡市','0373','',''),('河南','许昌','河南省许昌市','0374','',''),('河南','平顶山','河南省平顶山市','0375','',''),('河南','信阳','河南省信阳市','0376','',''),('河南','南阳','河南省南阳市','0377','',''),('河南','开封','河南省开封市','0378','',''),('河南','洛阳','河南省洛阳市','0379','',''),('河南','焦作','河南省焦作市','0391','',''),('河南','鹤壁','河南省鹤壁市','0392','',''),('河南','濮阳','河南省濮阳市','0393','',''),('河南','周口','河南省周口市','0394','',''),('河南','漯河','河南省漯河市','0395','',''),('河南','驻马店','河南省驻马店市','0396','',''),('河南','潢川','河南省潢川市','0397','',''),('河南','三门峡','河南省三门峡市','0398','',''),('辽宁','铁岭','辽宁省铁岭市','0410','',''),('辽宁','大连','辽宁省大连市','0411','',''),('辽宁','鞍山','辽宁省鞍山市','0412','',''),('辽宁','抚顺','辽宁省抚顺市','0413','',''),('辽宁','本溪','辽宁省本溪市','0414','',''),('辽宁','丹东','辽宁省丹东市','0415','',''),('辽宁','锦州','辽宁省锦州市','0416','',''),('辽宁','营口','辽宁省营口市','0417','',''),('辽宁','阜新','辽宁省阜新市','0418','',''),('辽宁','辽阳','辽宁省辽阳市','0419','',''),('辽宁','朝阳','辽宁省朝阳市','0421','',''),('辽宁','盘锦','辽宁省盘锦市','0427','',''),('辽宁','葫芦岛','辽宁省葫芦岛市','0429','',''),('吉林','长春','吉林省长春市','0431','',''),('吉林','吉林','吉林省吉林市','0432','',''),('吉林','延吉','吉林省延吉市','0433','',''),('吉林','四平','吉林省四平市','0434','',''),('吉林','通化','吉林省通化市','0435','',''),('吉林','白城','吉林省白城市','0436','',''),('吉林','辽源','吉林省辽源市','0437','',''),('吉林','松原','吉林省松原市','0438','',''),('吉林','白山','吉林省白山市','0439','',''),('黑龙江','哈尔滨','黑龙江省哈尔滨市','0451','',''),('黑龙江','齐齐哈尔','黑龙江省齐齐哈尔市','0452','',''),('黑龙江','牡丹江','黑龙江省牡丹江市','0453','',''),('黑龙江','佳木斯','黑龙江省佳木斯市','0454','',''),('黑龙江','绥化','黑龙江省绥化市','0455','',''),('黑龙江','黑河','黑龙江省黑河市','0456','',''),('黑龙江','大兴安岭','黑龙江省大兴安岭市','0457','',''),('黑龙江','伊春','黑龙江省伊春市','0458','',''),('黑龙江','大庆','黑龙江省大庆市','0459','',''),('黑龙江','七台河','黑龙江省七台河市','0464','',''),('黑龙江','鸡西','黑龙江省鸡西市','0467','',''),('黑龙江','鹤岗','黑龙江省鹤岗市','0468','',''),('黑龙江','双鸭山','黑龙江省双鸭山市','0469','',''),('内蒙','呼伦贝尔','内蒙古呼伦贝尔市','0470','',''),('内蒙','呼和浩特','内蒙古呼和浩特市','0471','',''),('内蒙','包头','内蒙古包头市','0472','',''),('内蒙','乌海','内蒙古乌海市','0473','',''),('内蒙','乌兰查布','内蒙古乌兰查布市','0474','',''),('内蒙','通辽','内蒙古通辽市','0475','',''),('内蒙','赤峰','内蒙古赤峰市','0476','',''),('内蒙','鄂尔多斯','内蒙古鄂尔多斯市','0477','',''),('内蒙','巴彦淖尔','内蒙古巴彦淖尔市','0478','',''),('内蒙','锡林浩特','内蒙古锡林浩特市','0479','',''),('内蒙','兴安盟','内蒙古兴安盟市','0482','',''),('内蒙','阿盟','内蒙古阿盟市','0483','',''),('江苏','无锡','江苏省无锡市','0510','',''),('江苏','镇江','江苏省镇江市','0511','',''),('江苏','苏州','江苏省苏州市','0512','',''),('江苏','南通','江苏省南通市','0513','',''),('江苏','扬州','江苏省扬州市','0514','',''),('江苏','盐城','江苏省盐城市','0515','',''),('江苏','徐州','江苏省徐州市','0516','',''),('江苏','淮安','江苏省淮安市','0517','',''),('江苏','连云港','江苏省连云港市','0518','',''),('江苏','常州','江苏省常州市','0519','',''),('江苏','泰州','江苏省泰州市','0523','',''),('江苏','宿迁','江苏省宿迁市','0527','',''),('山东','菏泽','山东省菏泽市','0530','',''),('山东','济南','山东省济南市','0531','',''),('山东','青岛','山东省青岛市','0532','',''),('山东','淄博','山东省淄博市','0533','',''),('山东','德州','山东省德州市','0534','',''),('山东','烟台','山东省烟台市','0535','',''),('山东','潍坊','山东省潍坊市','0536','',''),('山东','济宁','山东省济宁市','0537','',''),('山东','泰安','山东省泰安市','0538','',''),('山东','临沂','山东省临沂市','0539','',''),('山东','滨州','山东省滨州市','0543','',''),('山东','东营','山东省东营市','0546','',''),('安徽','滁州','安徽省滁州市','0550','',''),('安徽','合肥','安徽省合肥市','0551','',''),('安徽','蚌埠','安徽省蚌埠市','0552','',''),('安徽','芜湖','安徽省芜湖市','0553','',''),('安徽','淮南','安徽省淮南市','0554','',''),('安徽','马鞍山','安徽省马鞍山市','0555','',''),('安徽','安庆','安徽省安庆市','0556','',''),('安徽','宿州','安徽省宿州市','0557','',''),('安徽','阜阳','安徽省阜阳市','0558','',''),('安徽','黄山','安徽省黄山市','0559','',''),('安徽','淮北','安徽省淮北市','0561','',''),('安徽','铜陵','安徽省铜陵市','0562','',''),('安徽','宣城','安徽省宣城市','0563','',''),('安徽','六安','安徽省六安市','0564','',''),('安徽','巢湖','安徽省巢湖市','0565','',''),('安徽','池州','安徽省池州市','0566','',''),('浙江','衢州','浙江省衢州市','0570','',''),('浙江','杭州','浙江省杭州市','0571','',''),('浙江','湖州','浙江省湖州市','0572','',''),('浙江','嘉兴','浙江省嘉兴市','0573','',''),('浙江','宁波','浙江省宁波市','0574','',''),('浙江','绍兴','浙江省绍兴市','0575','',''),('浙江','台州','浙江省台州市','0576','',''),('浙江','温州','浙江省温州市','0577','',''),('浙江','丽水','浙江省丽水市','0578','',''),('浙江','金华','浙江省金华市','0579','',''),('浙江','舟山','浙江省舟山市','0580','',''),('福建','福州','福建省福州市','0591','',''),('福建','厦门','福建省厦门市','0592','',''),('福建','宁德','福建省宁德市','0593','',''),('福建','莆田','福建省莆田市','0594','',''),('福建','泉州','福建省泉州市','0595','',''),('福建','漳州','福建省漳州市','0596','',''),('福建','龙岩','福建省龙岩市','0597','',''),('福建','三明','福建省三明市','0598','',''),('福建','南平','福建省南平市','0599','',''),('山东','威海','山东省威海市','0631','',''),('山东','枣庄','山东省枣庄市','0632','',''),('山东','日照','山东省日照市','0633','',''),('山东','莱芜','山东省莱芜市','0634','',''),('山东','聊城','山东省聊城市','0635','',''),('广东','汕尾','广东省汕尾市','0660','',''),('广东','阳江','广东省阳江市','0662','',''),('广东','揭阳','广东省揭阳市','0663','',''),('广东','茂名','广东省茂名市','0668','',''),('云南','西双版纳','云南省西双版纳市','0691','',''),('云南','德宏','云南省德宏市','0692','',''),('江西','鹰潭','江西省鹰潭市','0701','',''),('湖北','襄樊','湖北省襄樊市','0710','',''),('湖北','鄂州','湖北省鄂州市','0711','',''),('湖北','孝感','湖北省孝感市','0712','',''),('湖北','黄冈','湖北省黄冈市','0713','',''),('湖北','黄石','湖北省黄石市','0714','',''),('湖北','咸宁','湖北省咸宁市','0715','',''),('湖北','荆州','湖北省荆州市','0716','',''),('湖北','宜昌','湖北省宜昌市','0717','',''),('湖北','恩施','湖北省恩施市','0718','',''),('湖北','十堰','湖北省十堰市','0719','',''),('湖北','随州','湖北省随州市','0722','',''),('湖北','荆门','湖北省荆门市','0724','',''),('湖北','仙桃','湖北省仙桃市','0728','',''),('湖南','岳阳','湖南省岳阳市','0730','',''),('湖南','长沙','湖南省长沙市','0731','',''),('湖南','湘潭','湖南省湘潭市','0732','',''),('湖南','株洲','湖南省株洲市','0733','',''),('湖南','衡阳','湖南省衡阳市','0734','',''),('湖南','郴州','湖南省郴州市','0735','',''),('湖南','常德','湖南省常德市','0736','',''),('湖南','益阳','湖南省益阳市','0737','',''),('湖南','娄底','湖南省娄底市','0738','',''),('湖南','邵阳','湖南省邵阳市','0739','',''),('湖南','吉首','湖南省吉首市','0743','',''),('湖南','张家界','湖南省张家界市','0744','',''),('湖南','怀化','湖南省怀化市','0745','',''),('湖南','永州','湖南省永州市','0746','',''),('广东','江门','广东省江门市','0750','',''),('广东','韶关','广东省韶关市','0751','',''),('广东','惠州','广东省惠州市','0752','',''),('广东','梅州','广东省梅州市','0753','',''),('广东','汕头','广东省汕头市','0754','',''),('广东','深圳','广东省深圳市','0755','',''),('广东','珠海','广东省珠海市','0756','',''),('广东','佛山','广东省佛山市','0757','',''),('广东','肇庆','广东省肇庆市','0758','',''),('广东','湛江','广东省湛江市','0759','',''),('广东','中山','广东省中山市','0760','',''),('广东','河源','广东省河源市','0762','',''),('广东','清远','广东省清远市','0763','',''),('广东','云浮','广东省云浮市','0766','',''),('广东','潮州','广东省潮州市','0768','',''),('广东','东莞','广东省东莞市','0769','',''),('广西','防城港','防城港','0770','',''),('广西','南宁','南宁','0771','',''),('广西','南宁','南宁','0771','25','城区'),('广西','南宁','南宁','0771','46','城区'),('广西','南宁','南宁','0771','80','城区'),('广西','南宁','南宁','0771','508','城郊'),('广西','南宁','南宁','0771','505','宾阳'),('广西','南宁','南宁','0771','776','宾阳'),('广西','南宁','南宁','0771','344','武鸣'),('广西','南宁','南宁','0771','506','武鸣'),('广西','南宁','南宁','0771','509','横县'),('广西','南宁','南宁','0771','775','横县'),('广西','南宁','南宁','0771','343','马山'),('广西','南宁','南宁','0771','504','马山'),('广西','南宁','南宁','0771','770','上林'),('广西','南宁','南宁','0771','340','隆安'),('广西','南宁','南宁','0771','501','隆安'),('广西','崇左','崇左','0771','342','江州区'),('广西','崇左','崇左','0771','503','江州区'),('广西','崇左','崇左','0771','346','凭祥'),('广西','崇左','崇左','0771','778','凭祥'),('广西','崇左','崇左','0771','345','扶绥'),('广西','崇左','崇左','0771','507','扶绥'),('广西','崇左','崇左','0771','777','扶绥'),('广西','崇左','崇左','0771','771','大新'),('广西','崇左','崇左','0771','341','宁明'),('广西','崇左','崇左','0771','502','宁明'),('广西','崇左','崇左','0771','779','宁明'),('广西','崇左','崇左','0771','772','龙州'),('广西','崇左','崇左','0771','773','天等'),('广西','柳州','柳州','0772','',''),('广西','柳州','柳州','0772','30','城区'),('广西','柳州','柳州','0772','50','城区'),('广西','柳州','柳州','0772','607','城区'),('广西','柳州','柳州','0772','608','城区'),('广西','柳州','柳州','0772','609','城区'),('广西','柳州','柳州','0772','469','柳江'),('广西','柳州','柳州','0772','603','柳江'),('广西','柳州','柳州','0772','463','鹿寨'),('广西','柳州','柳州','0772','605','鹿寨'),('广西','柳州','柳州','0772','606','鹿寨'),('广西','柳州','柳州','0772','466','柳城'),('广西','柳州','柳州','0772','468','融水'),('广西','柳州','柳州','0772','462','融安'),('广西','柳州','柳州','0772','461','三江'),('广西','来宾','来宾','0772','601','城区'),('广西','来宾','来宾','0772','602','城区'),('广西','来宾','来宾','0772','604','城区'),('广西','来宾','来宾','0772','460','武宣'),('广西','来宾','来宾','0772','465','象州'),('广西','来宾','来宾','0772','464','金秀'),('广西','来宾','来宾','0772','467','忻城'),('广西','桂林','桂林','0773','',''),('广西','贺州','贺州','0774','',''),('广西','贺州','贺州','0774','330','城区'),('广西','贺州','贺州','0774','331','城区'),('广西','贺州','贺州','0774','332','城区'),('广西','贺州','贺州','0774','333','城区'),('广西','贺州','贺州','0774','335','钟山'),('广西','贺州','贺州','0774','336','富川'),('广西','贺州','贺州','0774','339','昭平'),('广西','梧州','梧州','0774','310','城区'),('广西','梧州','梧州','0774','311','城区'),('广西','梧州','梧州','0774','312','城区'),('广西','梧州','梧州','0774','313','城区'),('广西','梧州','梧州','0774','315','城区'),('广西','梧州','梧州','0774','326','藤县'),('广西','梧州','梧州','0774','320','岑溪'),('广西','梧州','梧州','0774','323','苍梧'),('广西','梧州','梧州','0774','328','蒙山'),('广西','玉林','玉林','0775','',''),('广西','玉林','玉林','0775','571','城区'),('广西','玉林','玉林','0775','575','城区'),('广西','玉林','玉林','0775','577','城区'),('广西','玉林','玉林','0775','58','城区'),('广西','玉林','玉林','0775','578','博白'),('广西','玉林','玉林','0775','576','北流'),('广西','玉林','玉林','0775','579','北流'),('广西','玉林','玉林','0775','570','陆川'),('广西','玉林','玉林','0775','572','容县'),('广西','玉林','玉林','0775','573','兴业'),('广西','贵港','贵港','0775','590','城区'),('广西','贵港','贵港','0775','591','城区'),('广西','贵港','贵港','0775','592','城区'),('广西','贵港','贵港','0775','593','城区'),('广西','贵港','贵港','0775','595','城区'),('广西','贵港','贵港','0775','596','城区'),('广西','贵港','贵港','0775','598','城区'),('广西','贵港','贵港','0775','599','城区'),('广西','贵港','贵港','0775','605','桂平'),('广西','贵港','贵港','0775','606','桂平'),('广西','贵港','贵港','0775','607','桂平'),('广西','贵港','贵港','0775','608','桂平'),('广西','贵港','贵港','0775','609','桂平'),('广西','贵港','贵港','0775','818','桂平'),('广西','贵港','贵港','0775','601','平南'),('广西','贵港','贵港','0775','602','平南'),('广西','贵港','贵港','0775','603','平南'),('广西','贵港','贵港','0775','811','平南'),('广西','百色','百色','0776','',''),('广西','钦州','钦州','0777','',''),('广西','河池','河池','0778','',''),('广西','北海','北海','0779','',''),('江西','新余','江西省新余市','0790','',''),('江西','南昌','江西省南昌市','0791','',''),('江西','九江','江西省九江市','0792','',''),('江西','上饶','江西省上饶市','0793','',''),('江西','抚州','江西省抚州市','0794','',''),('江西','宜春','江西省宜春市','0795','',''),('江西','吉安','江西省吉安市','0796','',''),('江西','赣州','江西省赣州市','0797','',''),('江西','景德镇','江西省景德镇','0798','',''),('江西','萍乡','江西省萍乡市','0799','',''),('四川','攀枝花','四川省攀枝花','0812','',''),('四川','自贡','四川省自贡市','0813','',''),('四川','绵阳','四川省绵阳市','0816','',''),('四川','南充','四川省南充市','0817','',''),('四川','达州','四川省达州市','0818','',''),('四川','遂宁','四川省遂宁市','0825','',''),('四川','广安','四川省广安市','0826','',''),('四川','巴中','四川省巴中市','0827','',''),('四川','泸州','四川省泸州市','0830','',''),('四川','宜宾','四川省宜宾市','0831','',''),('四川','内江','四川省内江市','0832','',''),('四川','乐山','四川省乐山市','0833','',''),('四川','凉山','四川省凉山市','0834','',''),('四川','雅安','四川省雅安市','0835','',''),('四川','甘孜州','四川省甘孜州','0836','',''),('四川','阿坝州','四川省阿坝州','0837','',''),('四川','德阳','四川省德阳市','0838','',''),('四川','广元','四川省广元市','0839','',''),('贵州','贵阳','贵州省贵阳市','0851','',''),('贵州','遵义','贵州省遵义市','0852','',''),('贵州','安顺','贵州省安顺市','0853','',''),('贵州','都匀','贵州省都匀市','0854','',''),('贵州','凯里','贵州省凯里市','0855','',''),('贵州','铜仁','贵州省铜仁市','0856','',''),('贵州','毕节','贵州省毕节市','0857','',''),('贵州','六盘水','贵州省六盘水','0858','',''),('贵州','兴义','贵州省兴义市','0859','',''),('云南','昭通','云南省昭通市','0870','',''),('云南','昆明','云南省昆明市','0871','',''),('云南','大理','云南省大理市','0872','',''),('云南','红河','云南省红河市','0873','',''),('云南','曲靖','云南省曲靖市','0874','',''),('云南','保山','云南省保山市','0875','',''),('云南','文山','云南省文山市','0876','',''),('云南','玉溪','云南省玉溪市','0877','',''),('云南','楚雄','云南省楚雄市','0878','',''),('云南','思茅','云南省思茅市','0879','',''),('云南','临沧','云南省临沧市','0883','',''),('云南','怒江','云南省怒江市','0886','',''),('云南','迪庆','云南省迪庆市','0887','',''),('云南','丽江','云南省丽江市','0888','',''),('西藏','拉萨','西藏拉萨','0891','',''),('西藏','日喀则','西藏日喀则','0892','',''),('西藏','山南','西藏山南','0893','',''),('西藏','林芝','西藏林芝','0894','',''),('西藏','昌都','西藏昌都','0895','',''),('西藏','那曲','西藏那曲','0896','',''),('西藏','阿里','西藏阿里','0897','',''),('海南','海口','海南省海口市','0898','',''),('海南','三亚','海南省三亚市','0899','',''),('新疆','塔城','新疆塔城','0901','',''),('新疆','哈密','新疆哈密','0902','',''),('新疆','和田','新疆和田','0903','',''),('新疆','阿勒泰','新疆阿勒泰','0906','',''),('新疆','克州','新疆克州','0908','',''),('新疆','博乐','新疆博乐','0909','',''),('陕西','咸阳','陕西省咸阳市','0910','',''),('陕西','延安','陕西省延安市','0911','',''),('陕西','榆林','陕西省榆林市','0912','',''),('陕西','渭南','陕西省渭南市','0913','',''),('陕西','商洛','陕西省商洛市','0914','',''),('陕西','安康','陕西省安康市','0915','',''),('陕西','汉中','陕西省汉中市','0916','',''),('陕西','宝鸡','陕西省宝鸡市','0917','',''),('陕西','铜川','陕西省铜川市','0919','',''),('甘肃','临夏','甘肃省临夏市','0930','',''),('甘肃','兰州','甘肃省兰州市','0931','',''),('甘肃','定西','甘肃省定西市','0932','',''),('甘肃','平凉','甘肃省平凉市','0933','',''),('甘肃','庆阳','甘肃省庆阳市','0934','',''),('甘肃','张掖','甘肃省张掖市','0936','',''),('甘肃','酒泉嘉峪关','甘肃省酒泉嘉峪关','0937','',''),('甘肃','天水','甘肃省天水市','0938','',''),('甘肃','陇南','甘肃省陇南市','0939','',''),('甘肃','甘南','甘肃省甘南市','0941','',''),('甘肃','白银','甘肃省白银市','0943','',''),('宁夏','银川','宁夏银川','0951','',''),('宁夏','石嘴山','宁夏石嘴山','0952','',''),('宁夏','吴忠','宁夏吴忠','0953','',''),('宁夏','固原','宁夏固原','0954','',''),('宁夏','中卫','宁夏中卫','0955','',''),('青海','海北州','青海海北州','0970','',''),('青海','西宁','青海西宁','0971','',''),('青海','海东','青海海东','0972','',''),('青海','黄南','青海黄南','0973','',''),('青海','海南州','青海海南州','0974','',''),('青海','果洛','青海果洛','0975','',''),('青海','玉树','青海玉树','0976','',''),('青海','海西州','青海海西州','0977','',''),('青海','格尔木','青海格尔木','0979','',''),('新疆','克拉玛依','新疆克拉玛依','0990','',''),('新疆','乌鲁木齐','新疆乌鲁木齐','0991','',''),('新疆','奎屯','新疆奎屯','0992','',''),('新疆','石河子','新疆石河子','0993','',''),('新疆','昌吉','新疆昌吉','0994','',''),('新疆','吐鲁番','新疆吐鲁番','0995','',''),('新疆','库尔勒','新疆库尔勒','0996','',''),('新疆','阿克苏','新疆阿克苏','0997','',''),('新疆','喀什','新疆喀什','0998','',''),('新疆','伊犁','新疆伊犁','0999','','');

--
-- Table structure for table `statistics_of_ep_call`
--

DROP TABLE IF EXISTS `statistics_of_ep_call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_ep_call` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `enterprise_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '企业名称',
  `stat_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '时间类型0:半小时,1:天,2:月',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '时间戳',
  `total_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话总数',
  `internal_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '内部通话总数',
  `internal_call_answer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '内部通话接听数',
  `internal_call_time_s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '内部通话总时长-秒',
  `internal_call_time_m` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '内部通话总时长-分',
  `internal_call_time_6s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '内部通话总时长-6秒',
  `in_total_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话数',
  `in_intercept_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入拦截数',
  `in_ivr_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '菜单放弃数',
  `in_group_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '到达技能组数',
  `in_line_up_group` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '技能组排队数',
  `in_line_up_group_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队放弃数',
  `in_seat_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '到达坐席数',
  `in_seat_ring_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '坐席振铃数',
  `in_seat_incall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入接听数',
  `in_seat_incall_rate` float NOT NULL DEFAULT '0' COMMENT '呼入接听率',
  `in_seat_miss_incall` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入未接数',
  `in_ring_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '振铃放弃数,客户主动放弃的通话数量',
  `call_average_time_s` float NOT NULL DEFAULT '0' COMMENT '平均通话时长-秒',
  `call_average_time_m` float NOT NULL DEFAULT '0' COMMENT '平均通话时长-分',
  `call_average_time_6s` float NOT NULL DEFAULT '0' COMMENT '平均通话时长-6秒',
  `in_call_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均通话时长',
  `in_line_up_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT ' 排队总时长',
  `call_total_time_s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话总时长-秒',
  `call_total_time_m` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话总时长-分',
  `call_total_time_6s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话总时长-6秒',
  `in_call_total_time_s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长-秒',
  `in_call_total_time_m` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长-分',
  `in_call_total_time_6s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长-6秒',
  `in_direct_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入直线数',
  `out_total_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话数',
  `out_intercept_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出拦截数',
  `out_total_success` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出接听数',
  `out_call_rate` float NOT NULL DEFAULT '0' COMMENT '呼出接听率',
  `out_miscall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出未接数',
  `out_average_time` float NOT NULL DEFAULT '0' COMMENT '呼出平均通话时长',
  `out_call_total_time_s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话总时长-秒',
  `out_call_total_time_m` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话总时长-分',
  `out_call_total_time_6s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话总时长-6秒',
  `success_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成功通话总数',
  `evaluate_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话评价数',
  `evaluate_count_rate` float NOT NULL DEFAULT '0' COMMENT '通话评价率',
  `evaluate_count_9` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常满意数',
  `evaluate_count_7` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '满意数',
  `evaluate_count_5` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '一般数',
  `evaluate_count_3` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '不满意数',
  `evaluate_count_1` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常不满意数',
  `good_evaluate` float NOT NULL DEFAULT '0' COMMENT '好评率',
  `bad_evaluate` float NOT NULL DEFAULT '0' COMMENT '差评率',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `ccgeid_timestamp` (`seid`,`ccgeid`,`stat_type`,`timestamp`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业通话统计表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `statistics_of_group_call`
--

DROP TABLE IF EXISTS `statistics_of_group_call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_group_call` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `group_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '技能组名称',
  `stat_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '时间类型0:半小时,1:天,2:月,3:年',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '时间戳',
  `total_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话总数',
  `in_group_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '到达技能组数',
  `in_customer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入客户数',
  `in_line_up_group` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '技能组排队数',
  `in_line_up_group_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队放弃数',
  `in_seat_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '到达坐席数',
  `in_seat_ring_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '坐席振铃数',
  `in_seat_incall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入接听数',
  `in_seat_incall_rate` float NOT NULL DEFAULT '0' COMMENT '呼入接听率',
  `in_seat_miss_incall` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入未接数',
  `in_ring_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '振铃放弃数',
  `in_transfer_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '转接通话数',
  `in_ring_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '振铃总时长',
  `call_total_time_s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话总时长-秒',
  `call_total_time_m` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话总时长-分',
  `call_total_time_6s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话总时长-6秒',
  `in_ring_average_time` float NOT NULL DEFAULT '0' COMMENT '平均振铃时长',
  `call_average_time_s` float NOT NULL DEFAULT '0' COMMENT '平均通话时长-秒',
  `call_average_time_m` float NOT NULL DEFAULT '0' COMMENT '平均通话时长-分',
  `call_average_time_6s` float NOT NULL DEFAULT '0' COMMENT '平均通话时长-6秒',
  `in_call_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均通话时长',
  `in_line_up_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队总时长',
  `in_call_total_time_s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长-秒',
  `in_call_total_time_m` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长-分',
  `in_call_total_time_6s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长-6秒',
  `out_total_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话数',
  `out_customer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出客户数',
  `out_intercept_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出拦截数',
  `out_total_success` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出接听数',
  `out_call_rate` float NOT NULL DEFAULT '0' COMMENT '呼出接听率',
  `out_miscall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出未接数',
  `out_average_time` float NOT NULL DEFAULT '0' COMMENT '呼出平均通话时长',
  `out_total_time_s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话总时长-秒',
  `out_call_total_time_m` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话总时长-分',
  `out_call_total_time_6s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话总时长-6秒',
  `success_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成功通话总数',
  `evaluate_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话评价数',
  `evaluate_count_rate` float NOT NULL DEFAULT '0' COMMENT '通话评价率',
  `evaluate_count_9` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常满意数',
  `evaluate_count_7` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '满意数',
  `evaluate_count_5` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '一般数',
  `evaluate_count_3` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '不满意数',
  `evaluate_count_1` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常不满意数',
  `good_evaluate` float NOT NULL DEFAULT '0' COMMENT '好评率',
  `bad_evaluate` float NOT NULL DEFAULT '0' COMMENT '差评率',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `ccgeid_gid_timestamp` (`seid`,`ccgeid`,`gid`,`stat_type`,`timestamp`),
  KEY `gid` (`gid`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能组通话统计表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `statistics_of_seat_call`
--

DROP TABLE IF EXISTS `statistics_of_seat_call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_seat_call` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `seat_name` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '坐席名称',
  `seat_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '坐席分机号',
  `seat_work_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '坐席工号',
  `stat_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '时间类型0:半小时,1:天,2:月,3:年',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '时间戳',
  `total_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话总数',
  `in_seat_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '到达坐席数',
  `in_seat_ring_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '坐席振铃数',
  `in_customer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入客户数',
  `in_seat_incall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入接听数',
  `in_seat_incall_rate` float NOT NULL DEFAULT '0' COMMENT '呼入接听率',
  `in_seat_miss_incall` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入未接数',
  `in_ring_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '振铃放弃数',
  `in_tranfer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '转接通话数',
  `in_direct_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入直线数',
  `in_line_up_seat` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '坐席排队数',
  `in_line_up_seat_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队放弃数',
  `in_ring_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '振铃总时长',
  `call_total_time_s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话总时长-秒',
  `call_total_time_m` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话总时长-分',
  `call_total_time_6s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话总时长-6秒',
  `in_ring_average_time` float NOT NULL DEFAULT '0' COMMENT '平均振铃时长',
  `call_average_time_s` float NOT NULL DEFAULT '0' COMMENT '平均通话时长-秒',
  `call_average_time_m` float NOT NULL DEFAULT '0' COMMENT '平均通话时长-分',
  `call_average_time_6s` float NOT NULL DEFAULT '0' COMMENT '平均通话时长-6秒',
  `in_call_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均通话时长',
  `in_call_total_time_s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长-秒',
  `in_call_total_time_m` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长-分',
  `in_call_total_time_6s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长-6秒',
  `out_total_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话数',
  `out_intercept_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出拦截数',
  `out_customer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出客户数',
  `out_total_success` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出接听数',
  `out_call_rate` float NOT NULL DEFAULT '0' COMMENT '呼出接听率',
  `out_miscall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出未接数',
  `out_average_time` float NOT NULL DEFAULT '0' COMMENT '呼出平均通话时长',
  `out_total_time_s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话总时长-秒',
  `out_call_total_time_m` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话总时长-分',
  `out_call_total_time_6s` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话总时长-6秒',
  `success_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成功通话总数',
  `evaluate_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话评价数',
  `evaluate_count_rate` float NOT NULL DEFAULT '0' COMMENT '通话评价率',
  `evaluate_count_9` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常满意数',
  `evaluate_count_7` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '满意数',
  `evaluate_count_5` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '一般数',
  `evaluate_count_3` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '不满意数',
  `evaluate_count_1` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常不满意数',
  `good_evaluate` float NOT NULL DEFAULT '0' COMMENT '好评率',
  `bad_evaluate` float NOT NULL DEFAULT '0' COMMENT '差评率',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `ccgeid_uid_timestamp` (`seid`,`ccgeid`,`uid`,`stat_type`,`timestamp`),
  KEY `uid` (`uid`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席通话统计表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `statistics_of_seat_state_monitor`
--

DROP TABLE IF EXISTS `statistics_of_seat_state_monitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_seat_state_monitor` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `seat_name` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '坐席名称',
  `seat_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '坐席分机号码',
  `seat_work_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '坐席工号',
  `state_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '时间类型0:半小时,1:天,2:月,3:年',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '半小时/天/月/年/时间戳',
  `online_time` int(10) DEFAULT '0' COMMENT '在线总时长',
  `wait_time` int(10) DEFAULT '0' COMMENT '空闲总时长',
  `answer_time` int(10) DEFAULT '0' COMMENT '通话总时长',
  `busy_time` int(10) DEFAULT '0' COMMENT '忙碌总时长',
  `answer_after_time` int(10) DEFAULT '0' COMMENT '话后总时长',
  `latest_state_id` int(4) unsigned NOT NULL DEFAULT '0' COMMENT '坐席当前状态id 0-离线；1-已注册；2-空闲；3-忙碌；4-锁定；5-消息振铃；6-设备接续；7-设备振铃；8-通话中；9-话后处理；',
  `latest_state_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席切换为当前状态的时间戳',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `ccgeid_uid_timestamp` (`seid`,`ccgeid`,`uid`,`state_type`,`timestamp`),
  KEY `uid` (`uid`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席监控统计表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `statistics_of_seat_substate_monitor`
--

DROP TABLE IF EXISTS `statistics_of_seat_substate_monitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_seat_substate_monitor` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `seat_name` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '坐席名称',
  `seat_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '坐席分机号码',
  `seat_work_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '坐席工号',
  `state_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '时间类型0:半小时,1:天,2:月,3:年',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '半小时/天/月/年/时间戳',
  `sub_state_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '子状态ID',
  `sub_state_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '子状态名称',
  `sub_state_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '子状态时长',
  `latest_sub_state_id` int(4) unsigned NOT NULL DEFAULT '0' COMMENT '坐席当前子状态id',
  `latest_sub_state_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '当前子状态名称',
  `latest_sub_state_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席切换为当前子状态的时间戳',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `ccgeid_uid_timestamp_sub_state_id` (`seid`,`ccgeid`,`uid`,`timestamp`,`state_type`,`sub_state_id`),
  KEY `uid` (`uid`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席子状态监控统计表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `super_enterprise`
--

DROP TABLE IF EXISTS `super_enterprise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `super_enterprise` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID, seid',
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '超级企业名称',
  `domain` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '访问域名',
  `status` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '超级企业状态 0-停用 1-启用',
  `cc_domain_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心域ID',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='超级企业表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `super_enterprise_setting`
--

DROP TABLE IF EXISTS `super_enterprise_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `super_enterprise_setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `key` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置名称',
  `value` varchar(2047) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置值',
  `description` varchar(511) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置描述',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `seid_key` (`seid`,`key`),
  KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='超级企业配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sync`
--

DROP TABLE IF EXISTS `sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `type` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据类型',
  `action` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据变更类型',
  `data` longtext COLLATE utf8mb4_unicode_ci COMMENT '数据对象序列化数据',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`),
  KEY `action` (`action`),
  KEY `seid_ccgeid` (`seid`,`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据同步表'
/*!50100 PARTITION BY HASH (seid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `terminal_number`
--

DROP TABLE IF EXISTS `terminal_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terminal_number` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `mobile` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '终端话机号码',
  `call_type` tinyint(4) unsigned NOT NULL DEFAULT '5' COMMENT '呼叫限制 0-允许呼出 5-禁止呼出',
  `auto_answer` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '自动接听 0-否 1-是',
  `enable_headest` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '启用耳机 0-否 1-是',
  `auto_answer_tone` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '自动接听提示音 0-无 1-短促',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `is_bind_seat` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否绑定坐席 0-否 1-是',
  `is_bind_imei` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否绑定imei 0-否 1-是',
  PRIMARY KEY (`id`,`seid`),
  UNIQUE KEY `seid_mobile` (`seid`,`mobile`),
  KEY `is_bind_seat` (`is_bind_seat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='终端话机号码表'
/*!50100 PARTITION BY HASH (seid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `terminal_tel`
--

DROP TABLE IF EXISTS `terminal_tel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terminal_tel` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `imei` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'imei号码',
  `sim` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'sim卡号码',
  `mobile` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号码',
  `tel_number` bigint(20) DEFAULT NULL COMMENT '分机号码',
  `switch_number` bigint(20) DEFAULT NULL COMMENT '总机号码',
  `product_model` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品型号',
  `manufacturer` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生产厂家',
  `soft_version` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '软件版本',
  `hard_version` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '硬件版本',
  `net_type` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '网络制式',
  `produced_time` bigint(20) DEFAULT NULL COMMENT '生产日期',
  `import_time` bigint(20) DEFAULT NULL COMMENT '导入日期',
  `is_reg` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '是否需要注册0不需要1需要',
  `is_set` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '是否被绑定0强制绑定1未被操作',
  `local_dail` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '1允许本机SIM卡直接呼出 0不允许',
  `flow_use` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否消耗流量 1是 0否',
  `flow_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '流量地址',
  `flow_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '流量次数',
  `update_config` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '1更新配置 0不更新配置',
  `update_config_time` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '更新配置时间',
  `delete_message` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除话机短信 1是 0否',
  `reset` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否恢复出厂设置 1是 0否',
  `reboot_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '重启次数',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`),
  UNIQUE KEY `seid_imei` (`seid`,`imei`),
  KEY `mobile` (`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='终端话机表'
/*!50100 PARTITION BY HASH (seid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trans_outline_number`
--

DROP TABLE IF EXISTS `trans_outline_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trans_outline_number` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `outline_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '外线号码',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `seid_ccgeid_outline_number` (`seid`,`ccgeid`,`outline_number`),
  KEY `outline_number` (`outline_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='转接外线号码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业id',
  `username` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `is_email_verified` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '邮箱是否验证：0-未验证；1-已验证',
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机',
  `is_mobile_verified` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '手机是否验证：0-未验证；1-已验证',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '姓名',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '头像',
  `last_login_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最近登录时间',
  `last_login_ip` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '最近登录IP',
  `login_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '登录成功次数',
  `login_error_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '登录失败次数',
  `creator_userid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建人用户ID',
  `owner_userid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '归属人用户ID',
  `data_access_level` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '数据权限级别：0-系统级别；1-超级企业级别；2-企业级别',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`username`),
  UNIQUE KEY `admin_users_username_unique` (`username`,`seid`),
  KEY `owner_userid` (`owner_userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表'
/*!50100 PARTITION BY KEY (username)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `user` (`id`, `seid`, `username`, `password`, `email`, `is_email_verified`, `name`) VALUES (1, 0, 'admin', '4af871980831e46084c07e9e09ec85ce7802d626e7b3f5cb1c361ce1634039da', 'emicnet-tech@emicnet.com', 1, '系统管理员');

--
-- Table structure for table `user_setting`
--

DROP TABLE IF EXISTS `user_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `key` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置名称',
  `value` varchar(2047) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置值',
  `description` varchar(511) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置描述',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_key` (`user_id`,`key`),
  KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `week_work_time`
--

DROP TABLE IF EXISTS `week_work_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `week_work_time` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `week` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '周（1-7）',
  `work_status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '本日工作状态：0-不工作；1-工作',
  `work_time_range` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '08:00-18:00' COMMENT '工作时间段，可以允许多段工作时间',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '工作时间类型：0-企业工作时间 1-技能组工作时间',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `e_gid_week` (`seid`,`ccgeid`,`gid`,`week`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='周工作时间表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `whitelist_of_incall`
--

DROP TABLE IF EXISTS `whitelist_of_incall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `whitelist_of_incall` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '号码',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '号码类型：0-完整号码 1-号码前缀',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `number` (`seid`,`ccgeid`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='呼入白名单表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `whitelist_of_outcall`
--

DROP TABLE IF EXISTS `whitelist_of_outcall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `whitelist_of_outcall` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '号码',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '号码类型：0-完整号码 1-号码前缀',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `number` (`seid`,`ccgeid`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='呼出白名单表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;


INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('cc_man_db_version', '4479', '数据库初始化版本') ON DUPLICATE KEY UPDATE `value`=VALUES(`value`);

--
-- Dumping events for database 'emicall_cc_man'
--

--
-- Dumping routines for database 'emicall_cc_man'
--
/*!50003 DROP FUNCTION IF EXISTS `isFieldExisting` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE FUNCTION `isFieldExisting`(table_name_IN VARCHAR(255), field_name_IN VARCHAR(255)) RETURNS int(11)
RETURN (
    SELECT COUNT(COLUMN_NAME)
    FROM INFORMATION_SCHEMA.columns
    WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = table_name_IN
    AND COLUMN_NAME = field_name_IN
) ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `isIndexExisting` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE FUNCTION `isIndexExisting`(table_name_IN VARCHAR(255), index_name_IN VARCHAR(255)) RETURNS int(11)
RETURN (
    SELECT COUNT(INDEX_NAME)
    FROM INFORMATION_SCHEMA.statistics
    WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = table_name_IN
    AND INDEX_NAME = index_name_IN
) ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addFieldIfNotExists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `addFieldIfNotExists`(
    IN table_name_IN VARCHAR(255)
    , IN field_name_IN VARCHAR(255)
    , IN field_definition_IN VARCHAR(255)
)
BEGIN
    SET @isFieldThere = isFieldExisting(table_name_IN, field_name_IN);
    IF (@isFieldThere = 0) THEN
        SET @ddl = CONCAT('ALTER TABLE ', table_name_IN);
        SET @ddl = CONCAT(@ddl, ' ', 'ADD COLUMN') ;
        SET @ddl = CONCAT(@ddl, ' ', field_name_IN);
        SET @ddl = CONCAT(@ddl, ' ', field_definition_IN);
        PREPARE stmt FROM @ddl;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddIndexIfNotExists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE  PROCEDURE `AddIndexIfNotExists`(
    IN table_name_IN VARCHAR(255)
    , IN index_name_IN VARCHAR(255)
    , IN fields_IN VARCHAR(255)
)
BEGIN
    SET @isIndexThere = isIndexExisting(table_name_IN, index_name_IN);
    IF (@isIndexThere = 0) THEN
        SET @ddl = CONCAT('ALTER TABLE ', table_name_IN);
        SET @ddl = CONCAT(@ddl, ' ', 'ADD INDEX') ;
        SET @ddl = CONCAT(@ddl, ' ', index_name_IN);
        SET @ddl = CONCAT(@ddl, ' ', fields_IN);
        PREPARE stmt FROM @ddl;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddUniqueKeyIfNotExists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `AddUniqueKeyIfNotExists`(
    IN table_name_IN VARCHAR(255)
    , IN index_name_IN VARCHAR(255)
    , IN fields_IN VARCHAR(255)
)
BEGIN
    SET @isIndexThere = isIndexExisting(table_name_IN, index_name_IN);
    IF (@isIndexThere = 0) THEN
        SET @ddl = CONCAT('ALTER TABLE ', table_name_IN);
        SET @ddl = CONCAT(@ddl, ' ', 'ADD UNIQUE') ;
        SET @ddl = CONCAT(@ddl, ' ', index_name_IN);
        SET @ddl = CONCAT(@ddl, ' ', fields_IN);
        PREPARE stmt FROM @ddl;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `func_handle_change` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `func_handle_change`(in dbname varchar(64),in intable varchar(64),in old_name varchar(64),in new_name varchar(64),in col_type varchar(64),in col_def varchar(32))
label_pro:BEGIN
DECLARE v_sql varchar(1024) DEFAULT '';
if exists (select column_name from information_schema.columns where (CONVERT(TABLE_SCHEMA USING utf8) COLLATE utf8_unicode_ci) = dbname and (CONVERT(table_name USING utf8) COLLATE utf8_unicode_ci) = intable and (CONVERT(column_name USING utf8) COLLATE utf8_unicode_ci) = old_name) then
   if (col_def <>'') then
           set v_sql = concat("alter table ",dbname,".",intable," change ",old_name," ",new_name," ",col_type," ",col_def);
   else
           if 0 = (select instr(col_type,'int')) then
                        set v_sql = concat("alter table ",dbname,".",intable," change ",old_name," ",new_name," ",col_type," not null default ''");
           else
                        set v_sql = concat("alter table ",dbname,".",intable," change ",old_name," ",new_name," ",col_type," not null");
           end if;
   end if;

else
   leave label_pro;
end if;

IF (v_sql<>'') THEN
    SET @v_sql = v_sql;
    PREPARE stmt1 FROM @v_sql;
    EXECUTE stmt1;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `func_handle_column` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `func_handle_column`(in dbname varchar(64),in intable varchar(64),in action varchar(16),in colm_name varchar(64),in col_type varchar(64),in col_def varchar(256))
label_pro:BEGIN
DECLARE v_sql varchar(1024) DEFAULT '';
if action='add' then
   if exists (select column_name from information_schema.columns where (CONVERT(TABLE_SCHEMA USING utf8) COLLATE utf8_unicode_ci) = dbname and (CONVERT(table_name USING utf8) COLLATE utf8_unicode_ci) = intable and (CONVERT(column_name USING utf8) COLLATE utf8_unicode_ci) = colm_name) then
        leave label_pro;
   else
       if (col_def <>'') then
           set v_sql = concat("alter table ",dbname,".",intable," add ",colm_name," ",col_type," ",col_def);
       else
           if 0 = (select instr(col_type,'int')) then
                set v_sql = concat("alter table ",dbname,".",intable," add ",colm_name," ",col_type," not null default ''");
           else
                set v_sql = concat("alter table ",dbname,".",intable," add ",colm_name," ",col_type," not null");
           end if;
       end if;
   end if;
elseif action='drop' then
    if exists (select column_name from information_schema.columns where (CONVERT(TABLE_SCHEMA USING utf8) COLLATE utf8_unicode_ci) = dbname and (CONVERT(table_name USING utf8) COLLATE utf8_unicode_ci) = intable and (CONVERT(column_name USING utf8) COLLATE utf8_unicode_ci) = colm_name) then
        set v_sql = concat("alter table ",dbname,".",intable," drop ",colm_name);
    else
        leave label_pro;
    end if;
elseif action='modify' then
    if (col_def <>'') then
         set v_sql = concat("alter table ",dbname,".",intable," modify ",colm_name," ",col_type," ",col_def);
    else
        if 0 = (select instr(col_type,'int')) then
             set v_sql = concat("alter table ",dbname,".",intable," modify ",colm_name," ",col_type," not null default ''");
        else
             set v_sql = concat("alter table ",dbname,".",intable," modify ",colm_name," ",col_type," not null");
        end if;
    end if;
else
    leave label_pro;
end if;

IF (v_sql<>'') THEN
    SET @v_sql = v_sql;
    PREPARE stmt1 FROM @v_sql;
    EXECUTE stmt1;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `func_handle_index` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `func_handle_index`(in dbname varchar(64),in intable varchar(64),in action varchar(16),in index_type varchar(16),in ind_name varchar(32),in colm_name varchar(64))
label_pro:BEGIN
DECLARE v_sql varchar(1024) DEFAULT '';
if exists ( select * from information_schema.statistics where (CONVERT(TABLE_SCHEMA USING utf8) COLLATE utf8_unicode_ci) = dbname and (CONVERT(table_name USING utf8) COLLATE utf8_unicode_ci) =intable and (CONVERT(index_name USING utf8) COLLATE utf8_unicode_ci)=ind_name) then
    if action='drop' then
        set v_sql = concat("alter table ",dbname,".",intable," ",action," index ",ind_name);
    else
        leave label_pro;
    end if;
else
    if action='add' then
        set v_sql = concat("alter table ",dbname,".",intable," ",action," ",index_type," ",ind_name,"(",colm_name,")");
    end if;
end if;

IF (v_sql<>'') THEN
    SET @v_sql = v_sql;
    PREPARE stmt1 FROM @v_sql;
    EXECUTE stmt1;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `func_handle_table` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `func_handle_table`(in dbname varchar(64),in intable varchar(64))
label_pro:BEGIN
DECLARE v_sql varchar(1024) DEFAULT '';
DECLARE new_name varchar(1024) DEFAULT '';
set new_name = concat(intable,'_update',unix_timestamp(now()));
if exists (select column_name from information_schema.columns where (CONVERT(TABLE_SCHEMA USING utf8) COLLATE utf8_unicode_ci) = dbname and (CONVERT(table_name USING utf8) COLLATE utf8_unicode_ci) = intable) then
    set v_sql = concat("alter table ",dbname,".",intable," rename ",dbname,".",new_name); 
else
    leave label_pro;
end if;

IF (v_sql<>'') THEN
    SET @v_sql = v_sql;
    PREPARE stmt1 FROM @v_sql;
    EXECUTE stmt1;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RemoveFieldIfExists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `RemoveFieldIfExists`(
    IN table_name_IN VARCHAR(255)
    , IN field_name_IN VARCHAR(255)
)
BEGIN
    SET @isFieldThere = isFieldExisting(table_name_IN, field_name_IN);
    IF (@isFieldThere != 0) THEN
        SET @ddl = CONCAT('ALTER TABLE ', table_name_IN);
        SET @ddl = CONCAT(@ddl, ' ', 'DROP COLUMN') ;
        SET @ddl = CONCAT(@ddl, ' ', field_name_IN);
        PREPARE stmt FROM @ddl;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RemoveIndexIfExists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE PROCEDURE `RemoveIndexIfExists`(
    IN table_name_IN VARCHAR(255)
    , IN index_name_IN VARCHAR(255)
)
BEGIN
    SET @isIndexThere = isIndexExisting(table_name_IN, index_name_IN);
    IF (@isIndexThere != 0) THEN
        SET @ddl = CONCAT('ALTER TABLE ', table_name_IN);
        SET @ddl = CONCAT(@ddl, ' ', 'DROP INDEX') ;
        SET @ddl = CONCAT(@ddl, ' ', index_name_IN);
        PREPARE stmt FROM @ddl;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-23 14:45:48
