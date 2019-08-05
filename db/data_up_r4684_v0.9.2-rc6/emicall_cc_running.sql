-- MySQL dump 10.13  Distrib 5.5.54, for debian-linux-gnu (x86_64)
--
-- Host: emicall-cr-ext.mysql.rds.aliyuncs.com    Database: emicall_cc_running
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

DROP DATABASE IF EXISTS `emicall_cc_running`;
CREATE DATABASE `emicall_cc_running` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
use emicall_cc_running;

--
-- Table structure for table `cc_talk_api_push_data`
--

DROP TABLE IF EXISTS `cc_talk_api_push_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_api_push_data` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `ccgeid` bigint(20) unsigned NOT NULL COMMENT '呼叫中心全局企业id',
  `cc_number` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '通话id',
  `api_push_data` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'api推送数据',
  `calllog_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业推送id（递增）',
  `api_callid` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'API呼叫id',
  `api_push_status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'API推送状态：0-未推送；1-推送中；2-已推送',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `ccgeid` (`ccgeid`,`calllog_id`),
  KEY `cc_number` (`cc_number`),
  KEY `api_callid` (`api_callid`),
  KEY `api_push_status` (`api_push_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_batch_call_customer`
--

DROP TABLE IF EXISTS `cc_talk_batch_call_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_batch_call_customer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '任务ID',
  `job_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '批次ID',
  `task_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '批次类型 0:普通批次 1,重呼批次',
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '通话记录唯一标识',
  `cm_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '客户名称',
  `cm_mobile` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '客户号码',
  `cm_data` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '客户标识',
  `area_code` char(4) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户号码归属地区号',
  `is_called` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '联系结果，0-未联系，1-已联系',
  `cm_result_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户处理结果ID',
  `cm_result` int(10) DEFAULT '0' COMMENT '客户呼叫结果',
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
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `job_id_cm_mobile` (`ccgeid`,`job_id`,`cm_mobile`),
  KEY `seid` (`seid`),
  KEY `task_id` (`task_id`),
  KEY `job_id` (`job_id`),
  KEY `is_called` (`is_called`),
  KEY `cm_result_id` (`cm_result_id`),
  KEY `cm_mobile` (`cm_mobile`),
  KEY `cc_number` (`cc_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='批量外呼客户号码表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_batch_call_seat`
--

DROP TABLE IF EXISTS `cc_talk_batch_call_seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_batch_call_seat` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '任务id',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组gid',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户uid',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `task_id_gid_uid` (`ccgeid`,`task_id`,`gid`,`uid`),
  KEY `seid` (`seid`),
  KEY `task_id` (`task_id`),
  KEY `gid` (`gid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='批量外呼坐席表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_batch_call_stat_job`
--

DROP TABLE IF EXISTS `cc_talk_batch_call_stat_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_batch_call_stat_job` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '任务ID',
  `job_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '批次ID',
  `customer_num` int(11) NOT NULL DEFAULT '0' COMMENT '客户总数',
  `finished_customer_num` int(11) NOT NULL DEFAULT '0' COMMENT '已呼叫客户数',
  `unfinish_customer_num` int(11) NOT NULL DEFAULT '0' COMMENT '未呼叫客户数',
  `success_call_num` int(11) NOT NULL DEFAULT '0' COMMENT '成功呼叫客户数',
  `failed_call_num` int(11) NOT NULL DEFAULT '0' COMMENT '未接通客户数',
  `queue_quit_num` int(11) NOT NULL DEFAULT '0' COMMENT '排队放弃数',
  `other_num` int(11) NOT NULL DEFAULT '0' COMMENT '其他状态客户数目',
  `call_result` text COLLATE utf8mb4_unicode_ci COMMENT '呼叫结果统计',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  KEY `task_id` (`task_id`),
  KEY `job_id` (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_batch_call_stat_seat`
--

DROP TABLE IF EXISTS `cc_talk_batch_call_stat_seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_batch_call_stat_seat` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '任务ID',
  `job_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '批次ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席ID',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '技能组或者坐席名称',
  `seat_pickup_num` int(20) NOT NULL DEFAULT '0' COMMENT '坐席接起数',
  `total_talk_time` int(10) NOT NULL DEFAULT '0' COMMENT '总通话时长',
  `average_talk_time` int(10) NOT NULL DEFAULT '0' COMMENT '平均通话时长',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  KEY `job_id` (`job_id`),
  KEY `task_id` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_batch_call_task`
--

DROP TABLE IF EXISTS `cc_talk_batch_call_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_batch_call_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '外呼任务ID, task_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0-未开始 1-进行中 2-暂停中 3-已完成',
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
  `call_progress` float NOT NULL DEFAULT '0' COMMENT '外呼进度',
  `customer_pickup_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户接起数',
  `customer_unpickup_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户未接数',
  `customer_pickup_rate` float NOT NULL DEFAULT '0' COMMENT '客户接通率',
  `queue_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排队数',
  `queue_quit_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排队放弃数',
  `queue_quit_rate` float NOT NULL DEFAULT '0' COMMENT '排队放弃率',
  `seat_pickup_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '坐席接起数',
  `seat_pickup_rate` float NOT NULL DEFAULT '0' COMMENT '坐席接通率',
  `last_start_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最近一次开始时间',
  `last_end_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最近一次结束时间',
  `task_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '任务执行时长',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `ccgeid_task_name` (`ccgeid`,`task_name`),
  KEY `seid` (`seid`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='批量外呼任务表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_batch_call_task_job`
--

DROP TABLE IF EXISTS `cc_talk_batch_call_task_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_batch_call_task_job` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '外呼批次ID, job_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '外呼任务ID',
  `job_name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '批次名称',
  `customer_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户号码总数',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `task_id_job_name` (`ccgeid`,`task_id`,`job_name`),
  KEY `seid` (`seid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='批量外呼任务批次表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_blacklist_of_incall`
--

DROP TABLE IF EXISTS `cc_talk_blacklist_of_incall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_blacklist_of_incall` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '号码',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '号码类型：0-完整号码 1-号码前缀',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `number` (`ccgeid`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='呼入黑名单表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_blacklist_of_outcall`
--

DROP TABLE IF EXISTS `cc_talk_blacklist_of_outcall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_blacklist_of_outcall` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '号码',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '号码类型：0-完整号码 1-号码前缀',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `number` (`ccgeid`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='呼出黑名单表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_call_detail`
--

DROP TABLE IF EXISTS `cc_talk_call_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_call_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心超级企业id',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心全局企业id',
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '呼叫ID',
  `call_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0-客户呼入；1-座席呼出；2-语音通知；3-预测式外呼；4-内部呼出；5-内部呼入；6-转接座席；7-转接外线；8-班长监听；',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组id',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席id',
  `flow_number` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '流转id，每次更改技能组或座席或外线时，该值增1：',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '座席分机号', 
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
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `call_flow` (`ccgeid`,`cc_number`,`gid`,`uid`,`flow_number`),
  KEY `cc_number` (`cc_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通话详情表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_call_ivr_path`
--

DROP TABLE IF EXISTS `cc_talk_call_ivr_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_call_ivr_path` (
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
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `call_ivr_index` (`ccgeid`,`cc_number`,`index`),
  KEY `ivr_enterprise_version` (`ccgeid`,`ivr_version`),
  KEY `cc_number` (`cc_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通话IVR路径表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_call_record`
--

DROP TABLE IF EXISTS `cc_talk_call_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_call_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '企业通话唯一id值，对应PBX企业库通话记录id: sid',
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
  `switch_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户呼入/呼出总机号',
  `initiator` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '通话发起者：0-客户（呼入）；1-PC客户端；2-API；3-系统通知；4-预测式外呼；',
  `initiator_callId` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发起方的通话标识：客户，为cc_number（=callId）；PC，callId；API，api_callId；管理系统通知，callId；预测式外呼，callId。',
  `initiator_task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '系统通知或预测式外呼任务ID',
  `initiator_pcall_id` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '预测式外呼pcall_id',
  `service_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '服务号码（首个接听或发起座席号码）',
  `service_uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `service_gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席所在技能组ID',
  `state` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '通话状态',
  `initiate_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话发起时间',
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
  `stop_reason` bigint(20) NOT NULL DEFAULT '0' COMMENT '通话结束原因',
  `customer_fail_reason` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '客户未接原因',
  `upload_status` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '上传状态：0-通话未终结；1-未上传；2-上传中；3-已上传',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `cc_number` (`ccgeid`,`cc_number`),
  KEY `cc_number1` (`cc_number`),
  KEY `initiator_task_id` (`initiator_task_id`),
  KEY `outline_number` (`outline_number`),
  KEY `switch_number` (`switch_number`),
  KEY `initiate_time` (`initiate_time`),
  KEY `cm_result_id` (`cm_result_id`),
  KEY `upload_status` (`upload_status`)
) ENGINE=InnoDB AUTO_INCREMENT=1000000000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通话记录表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_called_statistics`
--

DROP TABLE IF EXISTS `cc_talk_called_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_called_statistics` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL COMMENT '呼叫中心超级企业id',
  `ccgeid` bigint(20) unsigned NOT NULL COMMENT '呼叫中心全局企业id',
  `called` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '被叫号码',
  `sDate` bigint(20) NOT NULL COMMENT '统计周期开始日期',
  `statType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0-日统计；1-周统计；2-月统计',
  `callTimes` bigint(20) NOT NULL COMMENT '统计周期内呼叫次数',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `ccgeid` (`seid`,`ccgeid`,`called`,`statType`,`sDate`),
  KEY `sDate` (`sDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='外呼统计表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_cc_number`
--

DROP TABLE IF EXISTS `cc_talk_cc_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_cc_number` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '呼叫ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心全局企业id',
  `initiate_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话开始时间',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`cc_number`),
  UNIQUE KEY `cc_number` (`cc_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='呼叫中心企业通话cc_number表'
/*!50100 PARTITION BY KEY (cc_number)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_common_call_mode`
--

DROP TABLE IF EXISTS `cc_talk_common_call_mode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_common_call_mode` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `rule_type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫规则类型',
  `operator_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '运营商类型',
  `format_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '号码格式类型',
  `place_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '号码归属地类型',
  `display_number` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '显示号码 0：不改号',
  `mso_charge` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '计费',
  `user_charge` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '用户侧计费',
  `perm` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `mode_type` int(10) unsigned DEFAULT NULL COMMENT '模版类型',
  `mode_name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '模版名',
  PRIMARY KEY (`id`),
  KEY `mode_type` (`mode_type`),
  KEY `rule_type` (`rule_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通用呼叫模版表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_common_scene_rule`
--

DROP TABLE IF EXISTS `cc_talk_common_scene_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_common_scene_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `rule_type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫规则类型',
  `call_scene` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫场景',
  `ua_index` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '用户索引',
  `call_introduce` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫引入',
  `pubacc_rule` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'a' COMMENT '选号规则',
  `mode_type` int(10) unsigned DEFAULT NULL COMMENT '模版类型',
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '场景规则名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `rule_type_2` (`rule_type`,`call_scene`,`ua_index`,`call_introduce`),
  KEY `rule_type` (`rule_type`),
  KEY `call_scene` (`call_scene`),
  KEY `mode_type` (`mode_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通用场景规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_concurrent_statistics`
--

DROP TABLE IF EXISTS `cc_talk_concurrent_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_concurrent_statistics` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ccdid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '呼叫ID',
  `customer_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户号码（或内部呼叫被叫号码）',
  `seat_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '座席分机号',
  `action` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫动作',
  `server_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '服务器名称',
  `group_id` bigint(20) unsigned NOT NULL COMMENT '技能组id',
  `line_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '电路类型：1-电路；2-网络',
  `action_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '动作发生时间',
  `queue_flow_id` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '排队id',
  `seat_line_flow_id` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '线路id',
  `upload_status` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '上传状态：0-未上传；1-已上传；2-正在上传',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `call_action_flow` (`ccgeid`,`cc_number`,`action`,`server_name`,`group_id`,`ccdid`,`queue_flow_id`,`seat_line_flow_id`),
  KEY `cc_number` (`cc_number`),
  KEY `upload_status` (`upload_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_config`
--

DROP TABLE IF EXISTS `cc_talk_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `config_key` varchar(63) NOT NULL COMMENT '配置名称',
  `config_value` varchar(511) NOT NULL COMMENT '配置值',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `config_key` (`config_key`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='呼叫中心运营系统配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_customer_seat_record`
--

DROP TABLE IF EXISTS `cc_talk_customer_seat_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_customer_seat_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心全局企业id',
  `customer` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户号码',
  `uid` bigint(20) DEFAULT NULL COMMENT '用户的ID',
  `seat_number` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '坐席号码',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr节点Id',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `customer_seat_record` (`seid`,`ccgeid`,`customer`,`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='熟客记忆关系表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_day_work_time`
--

DROP TABLE IF EXISTS `cc_talk_day_work_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_day_work_time` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `day` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '日期：YYYY-MM-DD',
  `work_status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '本日工作状态：0-不工作；1-工作',
  `work_time_range` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '08:00-18:00' COMMENT '工作时间段，可以允许多段工作时间',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '工作时间类型：0-企业工作时间 1-技能组工作时间',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `e_gid_day` (`ccgeid`,`gid`,`day`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='日工作时间表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_domain`
--

DROP TABLE IF EXISTS `cc_talk_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_domain` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `cc_domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心服务域id',
  `call_upload_udp_port` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '通话记录上传模块udp监听端口号',
  `api_callpush_udp_port` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'API推送模块udp监听端口号',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `bin_exec_path` varchar(511) DEFAULT NULL COMMENT '运行程序相对路径',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc_domain_id` (`cc_domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='呼叫中心域配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_enterprise`
--

DROP TABLE IF EXISTS `cc_talk_enterprise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_enterprise` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心全局企业id',
  `ccdid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `eid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ES企业ID',
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '企业名称',
  `epcode` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '企业唯一编号（BSS）',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '企业状态 0-停用 1-启用',
  `b_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '业务状态 0、收费-签单 1、不收费-试用 2、演示 3、联通自用企业 4、调试企业',
  `expire_date` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '截止日期',
  `cc_domain_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心域ID',
  `api_calllogid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'API推送记录id',
  `server_ip` varchar(31) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '企业服务器IP',
  `server_domain` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '企业服务器域名',
  `server_http_port` smallint(5) unsigned NOT NULL COMMENT '企业服务器http端口',
  `server_https_port` smallint(5) unsigned NOT NULL COMMENT '企业服务器https端口',
  `server_sip_port` smallint(5) unsigned DEFAULT NULL COMMENT '企业服务器SIP登录端口号',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deid` (`ccdid`,`eid`),
  UNIQUE KEY `ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_enterprise_config`
--

DROP TABLE IF EXISTS `cc_talk_enterprise_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_enterprise_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `key` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置名称',
  `value` varchar(2047) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置值',
  `description` varchar(511) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置描述',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `ccgeid_key` (`ccgeid`,`key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='企业配置表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_enterprise_group`
--

DROP TABLE IF EXISTS `cc_talk_enterprise_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_enterprise_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID-技能组ID：gid',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '技能组名称',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组父级ID',
  `level` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '技能组级别',
  `group_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '技能组类型：0-普通技能组；1-保留作为座席排队用；2-值班技能组；3-临时批量外呼技能组；4-临时座席技能组；5-临时外线技能组',
  `seat_policy` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '座席选择策略：0-最大空闲优先；1-随机选择；2-轮流选择',
  `flow_number` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '流转次数：0-不流转',
  `flow_timeout` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '流转超时时间：10-40',
  `vip_priority` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'VIP客户优先：0-VIP不优先；1-VIP绝对优先；2-10，优先权重',
  `queue_duration` int(11) unsigned NOT NULL DEFAULT '30' COMMENT '技能组排队时长, 默认30, 单位秒',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000000000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能组表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_enterprise_group_setting`
--

DROP TABLE IF EXISTS `cc_talk_enterprise_group_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_enterprise_group_setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `key` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '键',
  `value` mediumtext COLLATE utf8mb4_unicode_ci COMMENT '值',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `ccgeid_gid_key` (`ccgeid`,`gid`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能组配置表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_enterprise_group_user`
--

DROP TABLE IF EXISTS `cc_talk_enterprise_group_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_enterprise_group_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `role` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '坐席角色：0-普通坐席 1-班长坐席',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`) USING BTREE,
  UNIQUE KEY `ccgeid_gid_uid` (`ccgeid`,`gid`,`uid`),
  KEY `gid` (`gid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='组-坐席关联表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_enterprise_ivr_node`
--

DROP TABLE IF EXISTS `cc_talk_enterprise_ivr_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_enterprise_ivr_node` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长Id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ivr_flow_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr流程Id',
  `ivr_node_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr节点Id',
  `ivr_version` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr版本号',
  `ivr_node_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ivr节点名称',
  `ivr_node_slug` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ivr节点唯一标识',
  `ivr_node_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '节点类型',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `ivr_flow_node` (`seid`,`ccgeid`,`ivr_flow_id`,`ivr_node_name`,`ivr_version`),
  UNIQUE KEY `ivr_flow_node_slug` (`seid`,`ccgeid`,`ivr_flow_id`,`ivr_node_slug`,`ivr_version`),
  KEY `ivr_version` (`ivr_version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR节点表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_enterprise_user`
--

DROP TABLE IF EXISTS `cc_talk_enterprise_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_enterprise_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长用户',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户uid',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `displayname` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '坐席名称',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分机号码',
  `password` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `work_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '工号',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号码',
  `device_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '设备号码',
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
  `task_id` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '外呼任务ID',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `e_work_number` (`ccgeid`,`work_number`),
  UNIQUE KEY `e_uid` (`ccgeid`,`uid`),
  UNIQUE KEY `e_uid_paid` (`ccgeid`,`uid`,`paid`) USING BTREE,
  KEY `number` (`number`),
  KEY `mobile` (`mobile`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_enterprise_user_c_state_record`
--

DROP TABLE IF EXISTS `cc_talk_enterprise_user_c_state_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_enterprise_user_c_state_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `uid` bigint(20) unsigned NOT NULL COMMENT '用户id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `c_state` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席状态：0-离线；1-已注册；2-空闲；3-忙碌；4-锁定；5-消息振铃；6-设备接续；7-设备振铃；8-通话中；9-话后处理；',
  `busy_state_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '忙碌子状态ID',
  `busy_state_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '忙绿子状态名称',
  `state_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席状态变化时间',
  `upload_status` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '上传状态：0-未上传，1-上传中；2-已上传',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  KEY `state` (`c_state`,`busy_state_id`),
  KEY `uid` (`uid`),
  KEY `status_update` (`upload_status`,`update_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席状态记录表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_enterprise_user_config`
--

DROP TABLE IF EXISTS `cc_talk_enterprise_user_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_enterprise_user_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `key` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '键',
  `value` mediumtext COLLATE utf8mb4_unicode_ci COMMENT '值',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `ccgeid_uid_key` (`ccgeid`,`uid`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席配置表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_host_config`
--

DROP TABLE IF EXISTS `cc_talk_host_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_host_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `host_name` varchar(63) NOT NULL COMMENT '服务器主机名',
  `host_ip_addr` varchar(31) NOT NULL COMMENT '服务器IP地址',
  `host_domain_id` varchar(511) NOT NULL DEFAULT '' COMMENT '服务器服务域，可服务多个域，以逗号隔开（域0，即使不配置也必须运行）',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `host_name` (`host_name`),
  KEY `host_ip_addr` (`host_ip_addr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='呼叫中心运营服务器配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_ivr_flow`
--

DROP TABLE IF EXISTS `cc_talk_ivr_flow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_ivr_flow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID, ivr_flow_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '草稿所属用户ID',
  `flow_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '所属流程ID，此值不为0的时候，此流程为其他流程的草稿',
  `ivr_flow_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ivr流程名称',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr流程类型 0-默认流程 1-主流程 2-子流程 10-非工作时间默认子流程 11-非工作时间自定义子流程 12-满意度默认子流程 13-满意度自定义子流程',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为默认流程',
  `is_modify` tinyint(1) NOT NULL DEFAULT '0' COMMENT '为草稿时，是否被修改过',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr状态 0-未编译 1-已编译 2-使用中',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `ivr_enterprise_name_version` (`seid`,`ccgeid`,`ivr_flow_name`),
  KEY `status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR流程表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_ivr_flow_variable`
--

DROP TABLE IF EXISTS `cc_talk_ivr_flow_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_ivr_flow_variable` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID, ivr_node_param_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ivr_flow_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr流程Id',
  `type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '变量类型:0-输入变量 1-内部变量 2-输出变量',
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '变量名',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '变量值名称',
  `data_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '变量值类型:0-字符串 1-整形 3-浮点型',
  `default_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '变量默认值',
  `ivr_version` int(11) NOT NULL DEFAULT '0' COMMENT 'ivr版本号',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  KEY `ivr_enterprise_version` (`ccgeid`),
  KEY `ivr_flow_id` (`ivr_flow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR节点变量表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_ivr_node_event`
--

DROP TABLE IF EXISTS `cc_talk_ivr_node_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_ivr_node_event` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长Id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ivr_node_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr节点Id',
  `event_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '事件类型',
  `next_node_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '下一节点Id',
  `ivr_version` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr版本号',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `ivr_node_event` (`ccgeid`,`ivr_node_id`,`event_type`),
  KEY `ivr_version` (`ivr_version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR节点事件表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_ivr_node_param`
--

DROP TABLE IF EXISTS `cc_talk_ivr_node_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_ivr_node_param` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长Id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ivr_node_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr节点Id',
  `param_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '参数类型',
  `param_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数值',
  `ivr_version` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr版本号',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `ivr_node_param` (`ccgeid`,`ivr_node_id`,`param_type`),
  KEY `ivr_version` (`ivr_version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR节点参数表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_ivr_node_set_variable`
--

DROP TABLE IF EXISTS `cc_talk_ivr_node_set_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_ivr_node_set_variable` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID, ivr_node_param_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ivr_flow_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr流程Id',
  `ivr_node_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr节点Id',
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '变量名称',
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '变量值',
  `ivr_version` int(11) NOT NULL DEFAULT '0' COMMENT 'ivr版本号',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  KEY `ivr_enterprise_version` (`ccgeid`),
  KEY `ivr_flow_id` (`ivr_flow_id`),
  KEY `ivr_node_id` (`ivr_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR节点设置变量表'
/*!50100 PARTITION BY KEY (seid,ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_ivr_voice`
--

DROP TABLE IF EXISTS `cc_talk_ivr_voice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_ivr_voice` (
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
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3015 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR语音文件表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_pub_account`
--

DROP TABLE IF EXISTS `cc_talk_pub_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_pub_account` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `paid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '外线ID',
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
  `ivr_ingress_node_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '绑定IVR流程入口节点ID',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `ccgeid_outline_number` (`ccgeid`,`outline_number`),
  KEY `type` (`type`),
  KEY `attribute` (`attribute`),
  KEY `disabled` (`disabled`),
  KEY `outline_number` (`outline_number`),
  KEY `paid` (`paid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='外线表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_pub_account_attribution`
--

DROP TABLE IF EXISTS `cc_talk_pub_account_attribution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_pub_account_attribution` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `paid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '外线ID',
  `outline_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '外线号码，完整号码（区号+裸号）',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `paid_gid_uid` (`ccgeid`,`paid`,`gid`,`uid`),
  KEY `outline_number` (`outline_number`),
  KEY `paid` (`paid`),
  KEY `gid` (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='外线号码归属配置表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_secret`
--

DROP TABLE IF EXISTS `cc_talk_secret`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_secret` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '秘钥名称',
  `value` varchar(511) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '秘钥',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='签名秘钥表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_sip_number`
--

DROP TABLE IF EXISTS `cc_talk_sip_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_sip_number` (
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
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_bind_seat` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否绑定坐席 0-否 1-是',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `e_number` (`ccgeid`,`number`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='SIP话机号码表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_sip_number_state_record`
--

DROP TABLE IF EXISTS `cc_talk_sip_number_state_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_sip_number_state_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'SIP分机号码',
  `c_state` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席状态：0-离线；2-空闲；',
  `state_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席状态变化时间',
  `logined_uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '登录的坐席UID',
  `upload_status` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '上传状态：0-未上传，1-上传中；2-已上传',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  KEY `number` (`number`),
  KEY `upload_status` (`upload_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='sip话机状态记录表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_special_scene_rule`
--

DROP TABLE IF EXISTS `cc_talk_special_scene_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_special_scene_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `rule_type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫规则类型',
  `call_scene` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫场景',
  `ua_index` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '用户索引',
  `call_introduce` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫引入',
  `pubacc_rule` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'a' COMMENT '选号规则',
  `mode_type` int(10) unsigned DEFAULT NULL COMMENT '模版类型',
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '场景规则名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `rule_type_2` (`rule_type`,`call_scene`,`ua_index`,`call_introduce`),
  KEY `rule_type` (`rule_type`),
  KEY `call_scene` (`call_scene`),
  KEY `mode_type` (`mode_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业特殊场景规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_system_ivr_voice`
--

DROP TABLE IF EXISTS `cc_talk_system_ivr_voice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_system_ivr_voice` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `file_name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'lvr文件名',
  `duration` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  KEY `file_name` (`file_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_terminal_number`
--

DROP TABLE IF EXISTS `cc_talk_terminal_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_terminal_number` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `mobile` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '终端话机号码',
  `call_type` tinyint(4) unsigned NOT NULL DEFAULT '5' COMMENT '呼叫限制 0-允许呼出 5-禁止呼出',
  `auto_answer` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '自动接听 0-否 1-是',
  `enable_headest` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '启用耳机 0-否 1-是',
  `auto_answer_tone` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '自动接听提示音 0-无 1-短促',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_bind_seat` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否绑定坐席 0-否 1-是',
  `is_bind_imei` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否绑定IMEI 0-否 1-是',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `ccgeid_mobile` (`ccgeid`,`mobile`),
  KEY `mobile` (`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='终端话机号码表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_user_state_config`
--

DROP TABLE IF EXISTS `cc_talk_user_state_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_user_state_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `seid` bigint(20) unsigned DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned DEFAULT '0' COMMENT '企业ID',
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '状态名称',
  `description` varchar(511) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父状态ID',
  `order_id` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '排序序号',
  `visible` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否显示 0-否 1-是',
  `stateId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '状态id 对应cm表的id',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_state` (`ccgeid`,`name`,`stateId`),
  KEY `seid` (`seid`),
  KEY `ccgeid` (`ccgeid`),
  KEY `parent_id` (`parent_id`),
  KEY `visible` (`visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席状态表'; 
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_week_work_time`
--

DROP TABLE IF EXISTS `cc_talk_week_work_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_week_work_time` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `week` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '周（1-7）',
  `work_status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '本日工作状态：0-不工作；1-工作',
  `work_time_range` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '08:00-18:00' COMMENT '工作时间段，可以允许多段工作时间',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '工作时间类型：0-企业工作时间 1-技能组工作时间',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `e_gid_week` (`ccgeid`,`gid`,`week`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='周工作时间表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_whitelist_of_incall`
--

DROP TABLE IF EXISTS `cc_talk_whitelist_of_incall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_whitelist_of_incall` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '号码',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '号码类型：0-完整号码 1-号码前缀',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `number` (`ccgeid`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='呼入白名单表'
/*!50100 PARTITION BY HASH (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_talk_whitelist_of_outcall`
--

DROP TABLE IF EXISTS `cc_talk_whitelist_of_outcall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_talk_whitelist_of_outcall` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '号码',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '号码类型：0-完整号码 1-号码前缀',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`,`ccgeid`),
  UNIQUE KEY `number` (`ccgeid`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='呼出白名单表'
/*!50100 PARTITION BY KEY (ccgeid)
PARTITIONS 128 */;
/*!40101 SET character_set_client = @saved_cs_client */;


INSERT INTO `cc_talk_ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('1', 'voice/default/default_ivr_welcome.wav', 'default_ivr_welcome.wav', 'wav', '37408', '940e700a278d60b5110ac629290d2c82', '00:00:02.34', '欢迎致电呼叫中心企业');
INSERT INTO `cc_talk_ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('2', 'voice/default/level3_satisfy_notice.wav', 'level3_satisfy_notice.wav', 'wav', '144332', '93953e554886c3b8386fe93e2b3dba59', '00:00:09.02', '请对我们的服务进行评价：满意请按1，一般请按2，不满意请按3，重听请按0');
INSERT INTO `cc_talk_ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('3', 'voice/default/level5_satisfy_notice.wav', 'level5_satisfy_notice.wav', 'wav', '214152', '1de6e2947a7aab3eb0157ded4a324815', '00:00:13.38', '请对我们的服务进行评价：非常满意请按1，满意请按2，一般请按3，不满意请按4，非常不满意请按5，重听请按0');
INSERT INTO `cc_talk_ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('4', 'voice/default/offWork_ivr_default_bell.wav', 'offWork_ivr_default_bell.wav', 'wav', '104610', '59cf6ba484eb31c3894fb1f3b873dccc', '00:00:06.54', '您好，现在是非工作时间，暂不提供服务，感谢您的配合');
INSERT INTO `cc_talk_ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('8', 'voice/default/point5_satisfy_notice.wav', 'point5_satisfy_notice.wav', 'wav', '204078', 'cda7bf5070190ca543fa374d97f326bb', '00:00:12.75', '请对我们的服务进行评价：1分 非常满意，2分 满意，3分 一般，4分 不满意，5分 非常不满意，重听请按0');
INSERT INTO `cc_talk_ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('9', 'voice/default/satisfy_over_notice.wav', 'satisfy_over_notice.wav', 'wav', '23446', '2956502c60ac0b4834358df1476f8ca7', '00:00:01.46', '感谢您的配合');
INSERT INTO `cc_talk_ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('10', 'voice/default/work_number_broadcast_voice.wav', 'work_number_broadcast_voice.wav', 'wav', '66548', 'cfb04f3921ef594b66dbb8ada929ae9d', '00:00:04.16', '您好，一二三四五六号话务员为您服务');
INSERT INTO `cc_talk_ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('11', 'voice/default/work_number_broadcast_forward_voice.wav', 'work_number_broadcast_forward_voice.wav', 'wav', '10482', '5b3b53d5b75343c2e635183591988561', '00:00:00.65', '您好');
INSERT INTO `cc_talk_ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('12', 'voice/default/work_number_broadcast_backward_voice.wav', 'work_number_broadcast_backward_voice.wav', 'wav', '30386', 'bcc99ac162cf20c810055e9ca9a53c0b', '00:00:01.90', '号话务员为您服务');
INSERT INTO `cc_talk_ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('13', 'voice/default/work_number_broadcast_default_number.wav', 'work_number_broadcast_default_number.wav', 'wav', '22070', 'acef4a1f3f2c1829d7b154e763403cb9', '00:00:01.38', '一二三四五六');
INSERT INTO `cc_talk_ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('14', 'voice/default/customer_memory_default_voice.wav', 'customer_memory_default_voice.wav', 'wav', '54174', '020657f5b0c896f3cb4543968326b123', '00:00:03.38', '当前坐席全忙，请您稍后再拨');
INSERT INTO `cc_talk_ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('15', 'voice/default/call_hold_voice_default.wav', 'call_hold_voice_default.wav', 'wav', '40290', '6143bf9fcecefdd81e2ee5b9b4397e53', '00:00:02.52', '通话保持中，请稍候');
INSERT INTO `cc_talk_ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('16', 'voice/default/wait_in_line_voice.wav', 'wait_in_line_voice.wav', 'wav', '1279022', 'a1c9c79f4da6f38a289f695321c0bc2c', '00:00:39.97', null);
INSERT INTO `cc_talk_ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('17', 'voice/default/seat_busy_voice.wav', 'seat_busy_voice.wav', 'wav', '83210', '8c8919aed5d02f8c230cbd5722d6e0b9', '00:00:05.20', '当前坐席正忙，继续等待请按1，结束请挂机');
INSERT INTO `cc_talk_ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('18', 'voice/default/seat_disabled_voice.wav', 'seat_disabled_voice.wav', 'wav', '98644', '15515afde85066fef56dd603b2078ffb', '00:00:06.16', '该坐席已被停用，转系统语音导航请按1，结束请挂机');
INSERT INTO `cc_talk_ivr_voice`(`id`, `path`, `origin_name`, `extension`, `size`, `md5hash`, `duration`, `text`) VALUES ('19', 'voice/default/seat_missed_voice.wav', 'seat_missed_voice.wav', 'wav', '96648', '13e4cc501801ac7047583b1d034aa70d', '00:00:06.04', '坐席正在处理其他业务，继续等待请按1，结束请挂机');


INSERT INTO `cc_talk_config` (`config_key`, `config_value`, `description`) VALUES ('signkey_url', 'https://emicall-cmb.emicloud.com/server/signkey', '获取动态密钥URL') ON DUPLICATE KEY UPDATE `config_value`=VALUES(`config_value`),`description`=VALUES(`description`);
INSERT INTO `cc_talk_config` (`config_key`, `config_value`, `description`) VALUES ('record_upload_url', 'https://emicall-cmb.emicloud.com/call_record/upload', '通话记录上传URL') ON DUPLICATE KEY UPDATE `config_value`=VALUES(`config_value`),`description`=VALUES(`description`);
INSERT INTO `cc_talk_config` (`config_key`, `config_value`, `description`) VALUES ('seat_state_upload_url', 'https://emicall-cmb.emicloud.com/seat/realtime_state', '坐席状态上传URL') ON DUPLICATE KEY UPDATE `config_value`=VALUES(`config_value`),`description`=VALUES(`description`);
INSERT INTO `cc_talk_system_ivr_voice` (`ccgeid`, `file_name`, `duration`) values (0, 'ivr_a.wav', 112),(0, 'ivr_b.wav', 361),(0, 'ivr_c.wav', 357),(0, 'ivr_d.wav', 267),(0, 'ivr_e.wav', 334),(0, 'ivr_f.wav', 307),(0, 'ivr_g.wav', 322),(0, 'ivr_h.wav', 391),(0, 'ivr_i.wav', 296),(0, 'ivr_j.wav', 340),(0, 'ivr_k.wav', 326),(0, 'ivr_l.wav', 337),(0, 'ivr_m.wav', 285),(0, 'ivr_n.wav', 294),(0, 'ivr_o.wav', 304),(0, 'ivr_p.wav', 303),(0, 'ivr_q.wav', 273),(0, 'ivr_r.wav', 219),(0, 'ivr_s.wav', 307),(0, 'ivr_t.wav', 274),(0, 'ivr_u.wav', 222),(0, 'ivr_v.wav', 257),(0, 'ivr_w.wav', 743),(0, 'ivr_x.wav', 373),(0, 'ivr_y.wav', 333),(0, 'ivr_z.wav', 245),(0, 'ivr_digit_0.wav', 454),(0, 'ivr_digit_1.wav', 362),(0, 'ivr_digit_2.wav', 374),(0, 'ivr_digit_3.wav', 538),(0, 'ivr_digit_4.wav', 511),(0, 'ivr_digit_5.wav', 483),(0, 'ivr_digit_6.wav', 485),(0, 'ivr_digit_7.wav', 496),(0, 'ivr_digit_8.wav', 334),(0, 'ivr_digit_9.wav', 540);
INSERT INTO `cc_talk_config` (`config_key`, `config_value`, `description`) VALUES ('con_statis_upload_url', 'https://emicall-cmb.emicloud.com/call_record/concurrent/upload', '并发统计上传URL') ON DUPLICATE KEY UPDATE `config_value`=VALUES(`config_value`), `description`=VALUES(`description`);
INSERT INTO `cc_talk_config` (`config_key`, `config_value`, `description`) VALUES ('sip_phone_upload_url', 'https://emicall-cmb.emicloud.com/terminal_tel/sip/upload', 'sip话机状态上传URL') ON DUPLICATE KEY UPDATE `config_value`=VALUES(`config_value`), `description`=VALUES(`description`);

INSERT INTO `cc_talk_config` (`config_key`, `config_value`, `description`) VALUES ('cc_running_db_version', '4678', '数据库初始化版本') ON DUPLICATE KEY UPDATE `config_value`=VALUES(`config_value`);
--
-- Dumping events for database 'emicall_cc_running'
--

--
-- Dumping routines for database 'emicall_cc_running'
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
CREATE PROCEDURE `AddIndexIfNotExists`(
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
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
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
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
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
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
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
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
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

-- Dump completed on 2019-01-08 19:24:43
