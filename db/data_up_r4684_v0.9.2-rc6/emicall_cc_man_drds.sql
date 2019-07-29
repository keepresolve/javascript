-- MySQL dump 10.13  Distrib 5.5.24, for debian-linux-gnu (x86_64)
--
-- Host: drdsxzru0ml8n3a3public.drds.aliyuncs.com    Database: emicall_cc_man
-- ------------------------------------------------------
-- Server version 5.6.29-TDDL-5.3.2-1658858

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据权限表' ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access`
--

LOCK TABLES `access` WRITE;
/*!40000 ALTER TABLE `access` DISABLE KEYS */;
/*!40000 ALTER TABLE `access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blacklist_of_incall`
--

DROP TABLE IF EXISTS `blacklist_of_incall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blacklist_of_incall` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '号码',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '号码类型：0-完整号码 1-号码前缀',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`seid`,`ccgeid`,`number`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='呼入黑名单表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blacklist_of_incall`
--

LOCK TABLES `blacklist_of_incall` WRITE;
/*!40000 ALTER TABLE `blacklist_of_incall` DISABLE KEYS */;
/*!40000 ALTER TABLE `blacklist_of_incall` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blacklist_of_outcall`
--

DROP TABLE IF EXISTS `blacklist_of_outcall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blacklist_of_outcall` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '号码',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '号码类型：0-完整号码 1-号码前缀',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`seid`,`ccgeid`,`number`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='呼出黑名单表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blacklist_of_outcall`
--

LOCK TABLES `blacklist_of_outcall` WRITE;
/*!40000 ALTER TABLE `blacklist_of_outcall` DISABLE KEYS */;
/*!40000 ALTER TABLE `blacklist_of_outcall` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `call_cc_number`
--

DROP TABLE IF EXISTS `call_cc_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_cc_number` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '呼叫ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心全局企业id',
  `initiate_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '通话开始时间',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc_number` (`cc_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='呼叫中心企业通话记录ID表' dbpartition by hash(`cc_number`) tbpartition by hash(`cc_number`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call_cc_number`
--

LOCK TABLES `call_cc_number` WRITE;
/*!40000 ALTER TABLE `call_cc_number` DISABLE KEYS */;
/*!40000 ALTER TABLE `call_cc_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `call_detail`
--

DROP TABLE IF EXISTS `call_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
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
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `call_flow` (`cc_number`,`gid`,`uid`,`flow_number`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通话详情表' dbpartition by hash(`ccgeid`) tbpartition by hash(`cc_number`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call_detail`
--

LOCK TABLES `call_detail` WRITE;
/*!40000 ALTER TABLE `call_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `call_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `call_ivr_path`
--

DROP TABLE IF EXISTS `call_ivr_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_ivr_path` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `call_ivr_index` (`ccgeid`,`cc_number`,`index`),
  KEY `ivr_enterprise_version` (`ccgeid`,`ivr_version`),
  KEY `auto_shard_key_cc_number` (`cc_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通话IVR路径表' dbpartition by hash(`ccgeid`) tbpartition by hash(`cc_number`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call_ivr_path`
--

LOCK TABLES `call_ivr_path` WRITE;
/*!40000 ALTER TABLE `call_ivr_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `call_ivr_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `call_record`
--

DROP TABLE IF EXISTS `call_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长id',
  `sid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业通话唯一id值',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ccdid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `eid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'PBX企业ID',
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '呼叫ID',
  `verdor_id` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '机构ID（用户自定义）',
  `branch_id` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '网点ID（用户自定义）',
  `call_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0-客户呼入；1-座席呼出；2-语音通知；3-预测式外呼；4-内部通话；',
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
  `service_seat_name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席名称',
  `service_seat_worknumber` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席工号',
  `service_seat_mobile` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席手机号码',
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
  `ivr_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'IVR时长(秒)',
  `customer_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户振铃时长(秒)',
  `seat_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '坐席振铃时长(秒)',
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
  `stat_status` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '统计状态：0-未统计；1-统计中；2-已统计',
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc_number` (`seid`,`cc_number`),
  UNIQUE KEY `e_sid` (`seid`,`ccgeid`,`sid`),
  KEY `ccgeid` (`ccgeid`),
  KEY `initiator_task_id` (`initiator_task_id`),
  KEY `outline_number` (`outline_number`),
  KEY `switch_number` (`switch_number`),
  KEY `initiate_time` (`initiate_time`),
  KEY `duration` (`duration`),
  KEY `cm_result_id` (`cm_result_id`),
  KEY `stop_reason` (`stop_reason`),
  KEY `auto_shard_key_seid` (`seid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通话记录表' dbpartition by hash(`seid`) tbpartition by MM(`initiate_time`) tbpartitions 12;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call_record`
--

LOCK TABLES `call_record` WRITE;
/*!40000 ALTER TABLE `call_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `call_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `call_record_per_group`
--

DROP TABLE IF EXISTS `call_record_per_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_record_per_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ccdid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `eid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'PBX企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '呼叫ID',
  `verdor_id` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '机构ID（用户自定义）',
  `branch_id` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '网点ID（用户自定义）',
  `call_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0-客户呼入；1-座席呼出；2-语音通知；3-预测式外呼；4-内部通话；',
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
  `service_seat_name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席名称',
  `service_seat_worknumber` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席工号',
  `service_seat_mobile` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席手机号码',
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
  `ivr_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'IVR时长(秒)',
  `customer_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户振铃时长(秒)',
  `seat_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '坐席振铃时长(秒)',
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `seid_gid_call` (`seid`,`ccgeid`,`gid`,`cc_number`),
  KEY `cc_number` (`cc_number`),
  KEY `ccgeid` (`ccgeid`),
  KEY `initiator_task_id` (`initiator_task_id`),
  KEY `outline_number` (`outline_number`),
  KEY `switch_number` (`switch_number`),
  KEY `initiate_time` (`initiate_time`),
  KEY `duration` (`duration`),
  KEY `cm_result_id` (`cm_result_id`),
  KEY `stop_reason` (`stop_reason`),
  KEY `auto_shard_key_seid` (`seid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能组通话记录表' dbpartition by hash(`seid`) tbpartition by MM(`initiate_time`) tbpartitions 12;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call_record_per_group`
--

LOCK TABLES `call_record_per_group` WRITE;
/*!40000 ALTER TABLE `call_record_per_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `call_record_per_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `call_record_per_group_seat`
--

DROP TABLE IF EXISTS `call_record_per_group_seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_record_per_group_seat` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ccdid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `eid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'PBX企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席ID',
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '呼叫ID',
  `verdor_id` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '机构ID（用户自定义）',
  `branch_id` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '网点ID（用户自定义）',
  `call_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0-客户呼入；1-座席呼出；2-语音通知；3-预测式外呼；4-内部通话；',
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
  `service_seat_name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席名称',
  `service_seat_worknumber` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席工号',
  `service_seat_mobile` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席手机号码',
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
  `ivr_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'IVR时长(秒)',
  `customer_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户振铃时长(秒)',
  `seat_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '坐席振铃时长(秒)',
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `seid_gid_uid_call` (`seid`,`ccgeid`,`gid`,`uid`,`cc_number`),
  KEY `cc_number` (`cc_number`),
  KEY `ccgeid` (`ccgeid`),
  KEY `initiator_task_id` (`initiator_task_id`),
  KEY `outline_number` (`outline_number`),
  KEY `switch_number` (`switch_number`),
  KEY `initiate_time` (`initiate_time`),
  KEY `duration` (`duration`),
  KEY `cm_result_id` (`cm_result_id`),
  KEY `stop_reason` (`stop_reason`),
  KEY `auto_shard_key_seid` (`seid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能组座席通话记录表' dbpartition by hash(`seid`) tbpartition by MM(`initiate_time`) tbpartitions 12;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call_record_per_group_seat`
--

LOCK TABLES `call_record_per_group_seat` WRITE;
/*!40000 ALTER TABLE `call_record_per_group_seat` DISABLE KEYS */;
/*!40000 ALTER TABLE `call_record_per_group_seat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `call_record_per_seat`
--

DROP TABLE IF EXISTS `call_record_per_seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_record_per_seat` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ccdid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `eid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'PBX企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '座席ID',
  `cc_number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '呼叫ID',
  `verdor_id` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '机构ID（用户自定义）',
  `branch_id` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '网点ID（用户自定义）',
  `call_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0-客户呼入；1-座席呼出；2-语音通知；3-预测式外呼；4-内部通话；',
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
  `service_seat_name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席名称',
  `service_seat_worknumber` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席工号',
  `service_seat_mobile` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '首次接通的坐席手机号码',
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
  `ivr_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'IVR时长(秒)',
  `customer_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户振铃时长(秒)',
  `seat_ring_duration` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '坐席振铃时长(秒)',
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_call` (`seid`,`ccgeid`,`uid`,`cc_number`),
  KEY `cc_number` (`cc_number`),
  KEY `ccgeid` (`ccgeid`),
  KEY `initiator_task_id` (`initiator_task_id`),
  KEY `outline_number` (`outline_number`),
  KEY `switch_number` (`switch_number`),
  KEY `initiate_time` (`initiate_time`),
  KEY `duration` (`duration`),
  KEY `cm_result_id` (`cm_result_id`),
  KEY `stop_reason` (`stop_reason`),
  KEY `auto_shard_key_seid` (`seid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='座席通话记录表' dbpartition by hash(`seid`) tbpartition by MM(`initiate_time`) tbpartitions 12;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call_record_per_seat`
--

LOCK TABLES `call_record_per_seat` WRITE;
/*!40000 ALTER TABLE `call_record_per_seat` DISABLE KEYS */;
/*!40000 ALTER TABLE `call_record_per_seat` ENABLE KEYS */;
UNLOCK TABLES;

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
  PRIMARY KEY (`id`),
  UNIQUE KEY `cc_number` (`cc_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通话统计记录表' ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call_statistic_record`
--

LOCK TABLES `call_statistic_record` WRITE;
/*!40000 ALTER TABLE `call_statistic_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `call_statistic_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `day_work_time`
--

DROP TABLE IF EXISTS `day_work_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `day_work_time` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `day` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '日期：YYYY-MM-DD',
  `work_status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '本日工作状态：0-不工作；1-工作',
  `work_time_range` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '08:00-18:00' COMMENT '工作时间段，可以允许多段工作时间',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '工作时间类型：0-企业工作时间 1-技能组工作时间',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `e_gid_day` (`seid`,`ccgeid`,`gid`,`day`),
  KEY `auto_shard_key_seid` (`seid`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='周工作时间表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `day_work_time`
--

LOCK TABLES `day_work_time` WRITE;
/*!40000 ALTER TABLE `day_work_time` DISABLE KEYS */;
/*!40000 ALTER TABLE `day_work_time` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='设备表' ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device`
--

LOCK TABLES `device` WRITE;
/*!40000 ALTER TABLE `device` DISABLE KEYS */;
/*!40000 ALTER TABLE `device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `district`
--

DROP TABLE IF EXISTS `district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `district` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '地区ID',
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地区名称',
  `mt_server_ip` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '运维服务器IP',
  `mt_server_domain` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '运维服务器域名',
  `mt_http_port` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '运维服务器http端口',
  `mt_https_port` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '运维服务器https端口',
  `created_at` bigint(20) NOT NULL DEFAULT '0',
  `updated_at` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='地区表' ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `district`
--

LOCK TABLES `district` WRITE;
/*!40000 ALTER TABLE `district` DISABLE KEYS */;
INSERT INTO `district` VALUES (1,'江苏','112.80.5.243','yzj.10010js.com','1046','1047',0,0),(2,'上海','112.64.17.132','sh.emic.com.cn','1046','1047',0,0),(3,'浙江','124.160.11.216','zj.emic.com.cn','1046','1047',0,0),(4,'安徽','112.122.7.71','ah.emic.com.cn','1046','1047',0,0),(5,'福建','210.13.199.161','fj.emic.com.cn','1046','1047',0,0),(6,'陕西','123.138.182.42','sn.emic.com.cn','1046','1047',0,0),(7,'河北','61.55.151.26','www.woyzj.com','1046','1047',0,0),(8,'北京','123.127.255.83','bj.emic.com.cn','1046','1047',0,0),(9,'广西','121.31.40.24','emic.gx10010.com','1046','1047',0,0),(10,'湖南','211.91.224.92','hn.emic.com.cn','1046','1047',0,0),(11,'西藏','221.13.79.133','xz.emic.com.cn','1046','1047',0,0),(12,'江西','118.212.149.34','jx.emic.com.cn','1046','1047',0,0),(13,'河南','125.46.37.157','yzj.online.ha.cn','1046','1047',0,0),(14,'天津','202.99.75.154','yzj.tjunicom.com','1046','1047',0,0),(15,'贵州','58.16.129.242','gz.emic.com.cn','1046','1047',0,0),(16,'广东','122.13.0.41','gd.emic.com.cn','1046','1047',0,0),(17,'云南','14.204.84.191','yn.emic.com.cn','1046','1047',0,0),(18,'重庆','113.207.68.64','cq.emic.com.cn','1046','1047',0,0),(19,'四川','101.207.248.3','sc.emic.com.cn','1046','1047',0,0),(20,'山西','221.204.48.145','sx.emic.com.cn','1046','1047',0,0),(21,'甘肃','180.95.129.171','gs.emic.com.cn','1046','1047',0,0),(22,'辽宁','60.18.206.82','ln.emic.com.cn','1046','1047',0,0),(23,'山东','119.188.162.225','sd.emic.com.cn','1046','1047',0,0),(24,'海南','113.59.36.171','han.emicloud.com','1046','1047',0,0),(100,'江苏开发测试服务器','112.80.5.131','cses.emic.com.cn','1046','1047',0,0),(101,'江苏专用测试环境','112.80.5.155','kfyw.emic.com.cn','1046','1047',0,0),(102,'江苏开发验证环境','112.80.5.66','112.80.5.66','1046','1047',0,0),(128,'中国电信系统集成公司','106.39.30.158','106.39.30.158','1046','1047',0,0),(129,'淄博电信','58.57.109.203','58.57.109.203','1046','1047',0,0),(136,'测试','10.0.1.60','10.0.1.60','1046','1047',0,0),(139,'测试21','10.0.0.90','10.0.0.90','1046','1047',0,0);
/*!40000 ALTER TABLE `district` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=10009 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='区号表' ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `district_number`
--

LOCK TABLES `district_number` WRITE;
/*!40000 ALTER TABLE `district_number` DISABLE KEYS */;
INSERT INTO `district_number` VALUES (1,1,'025',0,0),(2,8,'010',0,0),(3,101,'025',0,0),(4,1,'0510',0,0),(5,1,'0511',0,0),(6,1,'0512',0,0),(7,1,'0513',0,0),(8,1,'0514',0,0),(9,1,'0515',0,0),(10,1,'0516',0,0),(11,1,'0517',0,0),(12,1,'0518',0,0),(13,1,'0519',0,0),(14,1,'0523',0,0),(15,1,'0527',0,0),(16,2,'021',0,0),(17,3,'0570',0,0),(18,3,'0571',0,0),(19,3,'0572',0,0),(20,3,'0573',0,0),(21,3,'0574',0,0),(22,3,'0575',0,0),(23,3,'0576',0,0),(24,3,'0577',0,0),(25,3,'0578',0,0),(26,3,'0579',0,0),(27,3,'0580',0,0),(28,4,'0550',0,0),(29,4,'0551',0,0),(30,4,'0552',0,0),(31,4,'0553',0,0),(32,4,'0554',0,0),(33,4,'0555',0,0),(34,4,'0556',0,0),(35,4,'0557',0,0),(36,4,'0558',0,0),(37,4,'0559',0,0),(38,4,'0561',0,0),(39,4,'0562',0,0),(40,4,'0563',0,0),(41,4,'0564',0,0),(42,4,'0565',0,0),(43,4,'0566',0,0),(44,5,'0591',0,0),(45,5,'0592',0,0),(46,5,'0593',0,0),(47,5,'0594',0,0),(48,5,'0595',0,0),(49,5,'0596',0,0),(50,5,'0597',0,0),(51,5,'0598',0,0),(52,5,'0599',0,0),(53,6,'029',0,0),(54,6,'0911',0,0),(55,6,'0912',0,0),(56,6,'0913',0,0),(57,6,'0914',0,0),(58,6,'0915',0,0),(59,6,'0916',0,0),(60,6,'0917',0,0),(61,6,'0919',0,0),(62,7,'0310',0,0),(63,7,'0311',0,0),(64,7,'0312',0,0),(65,7,'0313',0,0),(66,7,'0314',0,0),(67,7,'0315',0,0),(68,7,'0316',0,0),(69,7,'0317',0,0),(70,7,'0318',0,0),(71,7,'0319',0,0),(72,7,'0335',0,0),(73,9,'0770',0,0),(74,9,'0771',0,0),(75,9,'0772',0,0),(76,9,'0773',0,0),(77,9,'0774',0,0),(78,9,'0775',0,0),(79,9,'0776',0,0),(80,9,'0777',0,0),(81,9,'0778',0,0),(82,9,'0779',0,0),(83,10,'0730',0,0),(84,10,'0731',0,0),(85,10,'0734',0,0),(86,10,'0735',0,0),(87,10,'0736',0,0),(88,10,'0737',0,0),(89,10,'0738',0,0),(90,10,'0739',0,0),(91,10,'0743',0,0),(92,10,'0744',0,0),(93,10,'0745',0,0),(94,10,'0746',0,0),(95,11,'0891',0,0),(96,11,'0892',0,0),(97,11,'0893',0,0),(98,11,'0894',0,0),(99,11,'0895',0,0),(100,11,'0896',0,0),(101,11,'0897',0,0),(102,12,'0701',0,0),(103,12,'0790',0,0),(104,12,'0791',0,0),(105,12,'0792',0,0),(106,12,'0793',0,0),(107,12,'0794',0,0),(108,12,'0795',0,0),(109,12,'0796',0,0),(110,12,'0797',0,0),(111,12,'0798',0,0),(112,12,'0799',0,0),(113,13,'0370',0,0),(114,13,'0371',0,0),(115,13,'0372',0,0),(116,13,'0373',0,0),(117,13,'0374',0,0),(118,13,'0375',0,0),(119,13,'0376',0,0),(120,13,'0377',0,0),(121,13,'0378',0,0),(122,13,'0379',0,0),(123,13,'0391',0,0),(124,13,'0392',0,0),(125,13,'0393',0,0),(126,13,'0394',0,0),(127,13,'0395',0,0),(128,13,'0396',0,0),(129,13,'0398',0,0),(130,14,'022',0,0),(131,15,'0851',0,0),(132,15,'0852',0,0),(133,15,'0853',0,0),(134,15,'0854',0,0),(135,15,'0855',0,0),(136,15,'0856',0,0),(137,15,'0857',0,0),(138,15,'0858',0,0),(139,15,'0859',0,0),(140,16,'020',0,0),(141,16,'0660',0,0),(142,16,'0662',0,0),(143,16,'0663',0,0),(144,16,'0668',0,0),(145,16,'0750',0,0),(146,16,'0751',0,0),(147,16,'0752',0,0),(148,16,'0753',0,0),(149,16,'0754',0,0),(150,16,'0755',0,0),(151,16,'0756',0,0),(152,16,'0757',0,0),(153,16,'0758',0,0),(154,16,'0759',0,0),(155,16,'0760',0,0),(156,16,'0762',0,0),(157,16,'0763',0,0),(158,16,'0766',0,0),(159,16,'0768',0,0),(160,16,'0769',0,0),(161,17,'0691',0,0),(162,17,'0692',0,0),(163,17,'0870',0,0),(164,17,'0871',0,0),(165,17,'0872',0,0),(166,17,'0873',0,0),(167,17,'0874',0,0),(168,17,'0875',0,0),(169,17,'0876',0,0),(170,17,'0877',0,0),(171,17,'0878',0,0),(172,17,'0879',0,0),(173,17,'0883',0,0),(174,17,'0886',0,0),(175,17,'0887',0,0),(176,17,'0888',0,0),(177,18,'023',0,0),(178,19,'028',0,0),(179,19,'0812',0,0),(180,19,'0813',0,0),(181,19,'0816',0,0),(182,19,'0817',0,0),(183,19,'0818',0,0),(184,19,'0825',0,0),(185,19,'0826',0,0),(186,19,'0827',0,0),(187,19,'0830',0,0),(188,19,'0831',0,0),(189,19,'0832',0,0),(190,19,'0833',0,0),(191,19,'0834',0,0),(192,19,'0835',0,0),(193,19,'0836',0,0),(194,19,'0837',0,0),(195,19,'0838',0,0),(196,19,'0839',0,0),(197,20,'0349',0,0),(198,20,'0350',0,0),(199,20,'0351',0,0),(200,20,'0352',0,0),(201,20,'0353',0,0),(202,20,'0354',0,0),(203,20,'0355',0,0),(204,20,'0356',0,0),(205,20,'0357',0,0),(206,20,'0358',0,0),(207,20,'0359',0,0),(208,21,'0930',0,0),(209,21,'0931',0,0),(210,21,'0932',0,0),(211,21,'0933',0,0),(212,21,'0934',0,0),(213,21,'0935',0,0),(214,21,'0936',0,0),(215,21,'0937',0,0),(216,21,'0938',0,0),(217,21,'0939',0,0),(218,21,'0941',0,0),(219,21,'0943',0,0),(220,22,'024',0,0),(221,22,'0411',0,0),(222,22,'0412',0,0),(223,22,'0415',0,0),(224,22,'0416',0,0),(225,22,'0417',0,0),(226,22,'0418',0,0),(227,22,'0419',0,0),(228,22,'0421',0,0),(229,22,'0427',0,0),(230,22,'0429',0,0),(231,23,'0530',0,0),(232,23,'0531',0,0),(233,23,'0532',0,0),(234,23,'0533',0,0),(235,23,'0534',0,0),(236,23,'0535',0,0),(237,23,'0536',0,0),(238,23,'0537',0,0),(239,23,'0538',0,0),(240,23,'0539',0,0),(241,23,'0543',0,0),(242,23,'0546',0,0),(243,23,'0631',0,0),(244,23,'0632',0,0),(245,23,'0633',0,0),(246,23,'0634',0,0),(247,23,'0635',0,0),(248,24,'0898',0,0),(1000,128,'010',0,0),(1001,129,'0533',0,0),(10000,100,'025',0,0),(10001,2,'010',0,0),(10002,2,'028',0,0),(10003,2,'020',0,0),(10004,2,'0755',0,0),(10005,2,'023',0,0),(10006,102,'025',0,0),(10007,150,'022',0,0),(10008,151,'022',0,0);
/*!40000 ALTER TABLE `district_number` ENABLE KEYS */;
UNLOCK TABLES;

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
  `epcode` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '企业唯一编号（BSS）',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '企业状态 0-停用 1-启用',
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
  UNIQUE KEY `deid` (`ccdid`,`eid`) USING BTREE,
  KEY `seid` (`seid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业表' ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise`
--

LOCK TABLES `enterprise` WRITE;
/*!40000 ALTER TABLE `enterprise` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_numbers`
--

DROP TABLE IF EXISTS `enterprise_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_numbers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长id',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心全局企业id',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分机号',
  `state` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '分机号状态：0-未使用；1-座席使用；2-SIP话机使用',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_number` (`ccgeid`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='呼叫中心企业分机号码表' dbpartition by hash(`ccgeid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_numbers`
--

LOCK TABLES `enterprise_numbers` WRITE;
/*!40000 ALTER TABLE `enterprise_numbers` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_numbers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_setting`
--

DROP TABLE IF EXISTS `enterprise_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `key` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置名称',
  `value` varchar(2047) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置值',
  `description` varchar(511) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置描述',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_key` (`ccgeid`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='企业配置表' dbpartition by hash(`ccgeid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_setting`
--

LOCK TABLES `enterprise_setting` WRITE;
/*!40000 ALTER TABLE `enterprise_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_setting` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='队列任务失败记录表' ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长ID',
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
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ccgeid_gid` (`ccgeid`,`gid`),
  KEY `seid` (`seid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能组表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_seat`
--

DROP TABLE IF EXISTS `group_seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_seat` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `role` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '坐席角色：0-普通坐席 1-班长坐席',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_gid_uid` (`seid`,`ccgeid`,`gid`,`uid`),
  KEY `ccgeid_uid` (`ccgeid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='组-坐席关联表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_seat`
--

LOCK TABLES `group_seat` WRITE;
/*!40000 ALTER TABLE `group_seat` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_seat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_setting`
--

DROP TABLE IF EXISTS `group_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `key` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '键',
  `value` mediumtext COLLATE utf8mb4_unicode_ci COMMENT '值',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_gid_key` (`seid`,`ccgeid`,`gid`,`key`),
  KEY `ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能组配置表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_setting`
--

LOCK TABLES `group_setting` WRITE;
/*!40000 ALTER TABLE `group_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ivr_flow`
--

DROP TABLE IF EXISTS `ivr_flow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivr_flow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长id, ivr_flow_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ivr_flow_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ivr流程名称',
  `ivr_version` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr版本号',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT 'ivr流程类型 0-系统流程 1-普通流程 2-子流程 3-非工作时间流程 4-满意度评价流程',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr状态 0-未编译 1-已编译 2-使用中',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `xml_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'xml文件路径',
  `json_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'json文件路径',
  `disabled` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否禁用 0-否 1-是',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ivr_enterprise_name_version` (`seid`,`ccgeid`,`ivr_flow_name`,`ivr_version`),
  KEY `status` (`status`),
  KEY `disabled` (`disabled`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR流程表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ivr_flow`
--

LOCK TABLES `ivr_flow` WRITE;
/*!40000 ALTER TABLE `ivr_flow` DISABLE KEYS */;
/*!40000 ALTER TABLE `ivr_flow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ivr_node`
--

DROP TABLE IF EXISTS `ivr_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivr_node` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长Id, ivr_node_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ivr_flow_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr流程Id',
  `ivr_version` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr版本号',
  `ivr_node_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ivr节点名称',
  `ivr_node_slug` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ivr节点唯一标识',
  `ivr_node_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '节点类型',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ivr_flow_node` (`seid`,`ccgeid`,`ivr_flow_id`,`ivr_node_name`),
  UNIQUE KEY `ivr_flow_node_slug` (`seid`,`ccgeid`,`ivr_flow_id`,`ivr_node_slug`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR节点表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ivr_node`
--

LOCK TABLES `ivr_node` WRITE;
/*!40000 ALTER TABLE `ivr_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `ivr_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ivr_node_event`
--

DROP TABLE IF EXISTS `ivr_node_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivr_node_event` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长ID, ivr_node_event_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ivr_node_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr节点Id',
  `event_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '事件类型',
  `next_node_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '下一节点Id',
  `ivr_flow_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr流程Id',
  `ivr_version` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr版本号',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ivr_node_event` (`seid`,`ccgeid`,`ivr_node_id`,`event_type`),
  KEY `ivr_enterprise_version` (`ccgeid`,`ivr_version`),
  KEY `ivr_flow_id` (`ivr_flow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR节点事件表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ivr_node_event`
--

LOCK TABLES `ivr_node_event` WRITE;
/*!40000 ALTER TABLE `ivr_node_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `ivr_node_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ivr_node_param`
--

DROP TABLE IF EXISTS `ivr_node_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivr_node_param` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长Id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ivr_node_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr节点Id',
  `param_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '参数类型',
  `param_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参数值',
  `ivr_flow_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr流程Id',
  `ivr_version` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr版本号',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ivr_node_param` (`ivr_node_id`,`param_type`),
  KEY `ivr_enterprise_version` (`ccgeid`,`ivr_version`),
  KEY `ivr_flow_id` (`ivr_flow_id`),
  KEY `auto_shard_key_seid` (`seid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR节点参数表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ivr_node_param`
--

LOCK TABLES `ivr_node_param` WRITE;
/*!40000 ALTER TABLE `ivr_node_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `ivr_node_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ivr_version`
--

DROP TABLE IF EXISTS `ivr_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivr_version` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `ivr_flow_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr流程Id',
  `ivr_version` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '呼叫中心企业ivr版本号',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ivr_enterprise_version` (`seid`,`ccgeid`,`ivr_version`),
  KEY `ivr_flow_id` (`ivr_flow_id`),
  KEY `auto_shard_key_seid` (`seid`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR版本表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ivr_version`
--

LOCK TABLES `ivr_version` WRITE;
/*!40000 ALTER TABLE `ivr_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `ivr_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ivr_voice`
--

DROP TABLE IF EXISTS `ivr_voice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivr_voice` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '存储路径',
  `origin_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件原名',
  `extension` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '扩展名',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '大小,单位字节',
  `md5hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'md5 hash值',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`),
  KEY `auto_shard_key_seid` (`seid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR语音文件表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ivr_voice`
--

LOCK TABLES `ivr_voice` WRITE;
/*!40000 ALTER TABLE `ivr_voice` DISABLE KEYS */;
INSERT INTO `ivr_voice` VALUES (1, 0, 0, 0, 'voice/default/default_ivr_welcome.wav', 'default_ivr_welcome.wav', 'wav', 43658, '1a761f54bf75334ea571cceffe80448a', 0, 0),(2, 0, 0, 0, 'voice/default/level3_satisfy_notice.wav', 'level3_satisfy_notice.wav', 'wav', 144332, '93953e554886c3b8386fe93e2b3dba59', 0, 0),(3, 0, 0, 0, 'voice/default/level5_satisfy_notice.wav', 'level5_satisfy_notice.wav', 'wav', 214152, '1de6e2947a7aab3eb0157ded4a324815', 0, 0),(4, 0, 0, 0, 'voice/default/offWork_ivr_default_bell.wav', 'offWork_ivr_default_bell.wav', 'wav', 29696, 'c90304f64624bdff595592f903bbcd4e', 0, 0),(5, 0, 0, 0, 'voice/default/offWork_ivr_onduty_allbusy_bell.wav', 'offWork_ivr_onduty_allbusy_bell.wav', 'wav', 29696, 'd983049f23979e343b173df7918139f1', 0, 0),(6, 0, 0, 0, 'voice/default/offWork_ivr_onduty_bell.wav', 'offWork_ivr_onduty_bell.wav', 'wav', 29696, 'bc7d8a888437887a4e68c299442ddfa3', 0, 0),(7, 0, 0, 0, 'voice/default/offWork_ivr_onduty_queueTimeOut_bell.wav', 'offWork_ivr_onduty_queueTimeOut_bell.wav', 'wav', 29696, 'b20e6d367205a44ed006938428446437', 0, 0),(8, 0, 0, 0, 'voice/default/point5_satisfy_notice.wav', 'point5_satisfy_notice.wav', 'wav', 204078, 'cda7bf5070190ca543fa374d97f326bb', 0, 0),(9, 0, 0, 0, 'voice/default/satisfy_over_notice.wav', 'satisfy_over_notice.wav', 'wav', 29696, '4ce9e692dc58b8863ba0f3e5b1c38de9', 0, 0),(10, 0, 0, 0, 'voice/default/work_number_broadcast_voice.wav', 'work_number_broadcast_voice.wav', 'wav', 66572, 'e642a0ae1646214171ff7a017d62fe21', 0, 0),(11, 0, 0, 0, 'voice/default/work_number_broadcast_forward_voice.wav', 'work_number_broadcast_forward_voice.wav', 'wav', 10482, '5b3b53d5b75343c2e635183591988561', 0, 0),(12, 0, 0, 0, 'voice/default/work_number_broadcast_backward_voice.wav', 'work_number_broadcast_backward_voice.wav', 'wav', 30386, 'bcc99ac162cf20c810055e9ca9a53c0b', 0, 0);


/*!40000 ALTER TABLE `ivr_voice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operation_log`
--

DROP TABLE IF EXISTS `operation_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operation_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT BY GROUP,
  `type` tinyint(4) NOT NULL COMMENT '操作类型',
  `module` tinyint(4) DEFAULT NULL COMMENT '操作对象',
  `user_type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户类型',
  `user_id` bigint(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `seid` bigint(11) NOT NULL DEFAULT '0' COMMENT '超级企业id',
  `ccgeid` bigint(11) NOT NULL DEFAULT '0' COMMENT '企业id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作标题',
  `ip` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作IP',
  `source` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求来源',
  `created_at` bigint(20) DEFAULT NULL COMMENT '操作时间',
  `updated_at` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_type` (`user_type`,`user_id`),
  KEY `ccgeid` (`ccgeid`),
  KEY `seid` (`seid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作日志表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operation_log`
--

LOCK TABLES `operation_log` WRITE;
/*!40000 ALTER TABLE `operation_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `operation_log` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作日志数据表' ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operation_log_data`
--

LOCK TABLES `operation_log_data` WRITE;
/*!40000 ALTER TABLE `operation_log_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `operation_log_data` ENABLE KEYS */;
UNLOCK TABLES;

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
  `is_protected` tinyint(4) NOT NULL DEFAULT '0' COMMENT '权限是否受保护，0-不限制 1-禁用 2-仅自定义角色受限',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_permissions_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='权限表' ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES (1,0,0,'','首页（系统后台）',NULL,'[]','',1,'首页','sysHome',0,'',0,0),(2,0,0,'','企业管理（系统后台）',NULL,'[]','',1,'企业管理','epMgt',0,'',0,0),(3,0,0,'','操作日志（系统后台）',NULL,'[]','',1,'操作日志','sysOperationLog',0,'',0,0),(4,0,0,'','首页',NULL,'[]','',2,'首页','epHome',0,'',0,0),(5,0,0,'','权限管理',NULL,'[]','',2,'权限管理','/',2,'',0,0),(6,5,0,'','企业管理员管理',NULL,'[]','',2,'企业管理员管理','epAdminMgt',2,'',0,0),(7,5,0,'','角色用户管理',NULL,'[]','',2,'角色用户管理','customRoleUserMgt',2,'',0,0),(8,5,0,'','操作日志（权限管理）',NULL,'[]','',2,'操作日志','permissionOperationLog',0,'',0,0),(9,0,0,'','坐席管理',NULL,'[]','',2,'坐席管理','/',0,'',0,0),(10,9,0,'','坐席与技能组',NULL,'[]','',2,'坐席与技能组','seatAndGroupMgt',0,'',0,0),(11,9,0,'','坐席配置',NULL,'[]','',2,'坐席配置','seatConfig',0,'',0,0),(12,9,0,'','操作日志（坐席管理）',NULL,'[]','',2,'操作日志','seatOperationLog',0,'',0,0),(13,0,0,'','通话记录',NULL,'[]','',2,'通话记录','callRecord',0,'',0,0),(14,0,0,'','统计报表',NULL,'[]','',2,'统计报表','/',0,'',0,0),(15,14,0,'','整体报表',NULL,'[]','',2,'整体报表','integratedReport',0,'',0,0),(16,14,0,'','技能组报表',NULL,'[]','',2,'技能组报表','groupReport',0,'',0,0),(17,14,0,'','坐席报表',NULL,'[]','',2,'坐席报表','seatReport',0,'',0,0),(18,14,0,'','统计配置',NULL,'[]','',2,'统计配置','statisticsConfig',0,'',0,0),(19,0,0,'','IVR导航',NULL,'[]','',2,'IVR导航','ivrMgt',0,'',0,0),(20,0,0,'','外呼管理',NULL,'[]','',2,'总机号码管理','/',0,'',0,0),(21,20,0,'','总机号码管理',NULL,'[]','',2,'总机号码管理','switchNumberMgt',0,'',0,0),(22,20,0,'','直线号码管理',NULL,'[]','',2,'直线号码管理','directNumberMgt',0,'',0,0),(23,20,0,'','外呼模式配置',NULL,'[]','',2,'外呼模式配置','outcallModeConfig',0,'',0,0),(24,20,0,'','操作日志（外呼管理）',NULL,'[]','',2,'操作日志','outcallOperationLog',0,'',0,0),(25,0,0,'','话机管理',NULL,'[]','',2,'话机管理','/',0,'',0,0),(26,25,0,'','回拨话机管理',NULL,'[]','',2,'回拨话机管理','terminalMgt',0,'',0,0),(27,25,0,'','SIP话机管理',NULL,'[]','',2,'SIP话机管理','sipTelMgt',0,'',0,0),(28,0,0,'','黑白名单管理',NULL,'[]','',2,'黑白名单管理','/',0,'',0,0),(29,28,0,'','黑名单管理',NULL,'[]','',2,'黑名单管理','blackListMgt',0,'',0,0),(30,28,0,'','白名单管理',NULL,'[]','',2,'白名单管理','whiteListMgt',0,'',0,0),(31,28,0,'','黑白名单配置',NULL,'[]','',2,'黑白名单配置','listConfig',0,'',0,0),(32,28,0,'','操作日志（黑白名单）',NULL,'[]','',2,'操作日志','listOperationLog',0,'',0,0),(33,0,0,'','配置中心',NULL,'[]','',2,'配置中心','/',0,'',0,0),(34,33,0,'','基础配置',NULL,'[]','',2,'基础配置','generalConfig',0,'',0,0),(35,33,0,'','工作时间配置',NULL,'[]','',2,'工作时间配置','workTimeConfig',0,'',0,0),(36,33,0,'','满意度配置',NULL,'[]','',2,'满意度配置','satisfactionConfig',0,'',0,0),(37,0,0,'','操作日志',NULL,'[]','',2,'操作日志','operation',0,'',0,0);
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pub_account`
--

DROP TABLE IF EXISTS `pub_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pub_account` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '外线ID, paid',
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
) ENGINE=InnoDB AUTO_INCREMENT=1000000000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='外线表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pub_account`
--

LOCK TABLES `pub_account` WRITE;
/*!40000 ALTER TABLE `pub_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `pub_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pub_account_attribution`
--

DROP TABLE IF EXISTS `pub_account_attribution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pub_account_attribution` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长id',
  `paid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '外线ID',
  `outline_number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '外线号码，完整号码（区号+裸号）',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `paid_gid_uid` (`seid`,`ccgeid`,`paid`,`gid`,`uid`),
  KEY `ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='外线号码归属配置表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pub_account_attribution`
--

LOCK TABLES `pub_account_attribution` WRITE;
/*!40000 ALTER TABLE `pub_account_attribution` DISABLE KEYS */;
/*!40000 ALTER TABLE `pub_account_attribution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长id: role_id',
  `type` bigint(20) unsigned NOT NULL COMMENT '角色类型：0，系统管理员；1，超级企业管理员；2，企业管理员；99，企业自建角色',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名',
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色标识',
  `description` varchar(511) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '角色描述',
  `disabled` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否禁用：0-否 1-是',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_roles_name_unique` (`seid`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色表' dbpartition by hash(`seid`) tbpartition by hash(`seid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,0,0,'系统管理员','system.manager',0,0,0),(2,1,0,'企业超级管理员','enterprise.super.manager',0,0,0),(3,2,0,'企业管理员','enterprise.manager',0,0,0);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_permission` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长id',
  `role_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '角色ID',
  `permission_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '权限ID',
  `parameter` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '允许请求的参数，为空则允许请求所有参数',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `admin_role_permissions_role_id_permission_id_index` (`role_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色权限表' dbpartition by hash(`role_id`) tbpartition by hash(`role_id`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` VALUES (1,1,1,'',0,0);
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_user`
--

DROP TABLE IF EXISTS `role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `role_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '角色ID',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_group_role_user` (`seid`,`ccgeid`,`gid`,`user_id`,`role_id`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业角色用户表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_user`
--

LOCK TABLES `role_user` WRITE;
/*!40000 ALTER TABLE `role_user` DISABLE KEYS */;
INSERT INTO `role_user` VALUES (1,0,0,0,1,1,0,0);
/*!40000 ALTER TABLE `role_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_user_setting`
--

DROP TABLE IF EXISTS `role_user_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_user_setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `role_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '角色ID',
  `include_enterprises` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '企业范围：*表示全部企业',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `include_groups` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '技能组范围：*表示企业下全部技能组',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_user` (`seid`,`user_id`,`role_id`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色用户范围配置表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_user_setting`
--

LOCK TABLES `role_user_setting` WRITE;
/*!40000 ALTER TABLE `role_user_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_user_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat`
--

DROP TABLE IF EXISTS `seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seat` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长用户id:uid',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `displayname` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '坐席名称',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分机号码',
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
  `callintype` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '外呼方式：1-电话直拨 2-网络通话 4-总机回拨 5-SIP话机',
  `seat_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '用户类型：0-正常坐席；1-外转坐席；2-专职在线客户座席',
  `is_online_seat` enum('Y','N') CHARACTER SET ascii NOT NULL DEFAULT 'N' COMMENT '是否在线客服(user_type=0,2)：N-不是；Y-是',
  `is_mobile_seat` enum('Y','N') CHARACTER SET ascii NOT NULL DEFAULT 'N' COMMENT '是否移动坐席(user_type=0,1)：N-不是；Y-是',
  `mobile_verified` enum('Y','N') CHARACTER SET ascii NOT NULL DEFAULT 'N' COMMENT '手机号码是否已验证：0-未验证；1-已验证',
  `disabled` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否禁用 0-否 1-是',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `work_number` (`seid`,`ccgeid`,`work_number`),
  KEY `number` (`ccgeid`,`number`),
  KEY `mobile` (`ccgeid`,`mobile`),
  KEY `seid` (`seid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000000000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat`
--

LOCK TABLES `seat` WRITE;
/*!40000 ALTER TABLE `seat` DISABLE KEYS */;
/*!40000 ALTER TABLE `seat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat_c_state_record`
--

DROP TABLE IF EXISTS `seat_c_state_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seat_c_state_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长id',
  `uid` bigint(20) unsigned NOT NULL COMMENT '用户id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `c_state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '座席状态：0-离线；1-已注册；2-空闲；3-忙碌；4-锁定；5-消息振铃；6-设备接续；7-设备振铃；8-通话中；9-话后处理；',
  `busy_state_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '忙碌子状态ID',
  `busy_state_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '忙绿子状态名称',
  `state_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席状态变化时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '统计状态：0-未统计 1-统计中 2-已统计',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ccgeid_uid` (`seid`,`ccgeid`,`uid`),
  KEY `state` (`c_state`,`busy_state_id`),
  KEY `status` (`status`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席状态记录表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat_c_state_record`
--

LOCK TABLES `seat_c_state_record` WRITE;
/*!40000 ALTER TABLE `seat_c_state_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `seat_c_state_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat_realtime_state`
--

DROP TABLE IF EXISTS `seat_realtime_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seat_realtime_state` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长id',
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `seid` (`seid`,`ccgeid`,`uid`),
  KEY `state` (`state_id`,`sub_state_id`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席实时状态表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat_realtime_state`
--

LOCK TABLES `seat_realtime_state` WRITE;
/*!40000 ALTER TABLE `seat_realtime_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `seat_realtime_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat_setting`
--

DROP TABLE IF EXISTS `seat_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seat_setting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `key` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '键',
  `value` mediumtext COLLATE utf8mb4_unicode_ci COMMENT '值',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_uid_key` (`seid`,`ccgeid`,`uid`,`key`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席配置表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat_setting`
--

LOCK TABLES `seat_setting` WRITE;
/*!40000 ALTER TABLE `seat_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `seat_setting` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席状态表' ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat_state_config`
--

LOCK TABLES `seat_state_config` WRITE;
/*!40000 ALTER TABLE `seat_state_config` DISABLE KEYS */;
INSERT INTO `seat_state_config` VALUES (1,0,0,'离线','',0,1,0,0,0),(2,0,0,'空闲','',0,2,0,0,0),(3,0,0,'振铃中','',0,3,0,0,0),(4,0,0,'通话中','',0,4,0,0,0),(5,0,0,'忙碌','',0,5,0,0,0),(6,0,0,'话后处理','',0,6,0,0,0);
/*!40000 ALTER TABLE `seat_state_config` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='签名秘钥表' ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `secret`
--

LOCK TABLES `secret` WRITE;
/*!40000 ALTER TABLE `secret` DISABLE KEYS */;
INSERT INTO `secret` VALUES (1,'es_cm_default_secret','es.cm.default.secret.bbb369c1602db5f6c','ES请求CM的默认签名秘钥',0,0),(2,'cm_cr_default_secret','cm.cr.default.secret.a88340c41ae72733e','CM请求CR的默认签名秘钥',0,0),(3,'cr_cm_default_secret','cr.cm.default.secret.5606c655fd6e0b3ds','CR请求CM的默认签名秘钥',0,0),(4,'api_cm_default_secret','api.cm.default.secret.da388235780e6fy5','API请求CM的默认签名秘钥',0,0),(5,'cp_cm_default_secret','cp.cm.default.secret.ce2d748857d0a09fd','CP请求CM的默认签名秘钥',0,0);
/*!40000 ALTER TABLE `secret` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置表' ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setting`
--

LOCK TABLES `setting` WRITE;
/*!40000 ALTER TABLE `setting` DISABLE KEYS */;
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('environment', 'production', '开发环境/测试环境/生产环境:development/testing/production');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('anti_repeat_request', '0', '是否开启接口防重复请求(是否校验header头 nonce参数)');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('signature_validate', '1', '是否开启签名认证签名校验');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('timestamp_validate', '0', '是否开启请求时间戳误差校验');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('primary_domain', 'emic.com.cn', '管理平台主域名');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('cc_running_ip', '10.0.1.49', '运营平台IP');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('cc_running_domain', '10.0.1.49', '运营平台域名');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('cc_running_http_port', '80', '运营平台HTTP端口');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('cc_running_https_port', '81', '运营平台HTTPS端口');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('smtp_config', '{\"smtp_auth\":true,\"smtp_secure\":\"ssl\",\"smtp_host\":\"smtp.emicnet.com\",\"smtp_port\":\"465\",\"smtp_user\":\"emicnet-tech@emicnet.com\",\"smtp_pass\":\"et12345678+\",\"from_email\":\"emicnet-tech@emicnet.com\",\"from_name\":\"易米呼叫中心\"}', '邮件服务配置项');
INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('cc_man_db_version', '1319', '数据库版本') ON DUPLICATE KEY UPDATE `value`=VALUES(`value`);
/*!40000 ALTER TABLE `setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sip_number`
--

DROP TABLE IF EXISTS `sip_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sip_number` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长ID',
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `e_number` (`seid`,`ccgeid`,`number`),
  KEY `type` (`type`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='SIP话机号码表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sip_number`
--

LOCK TABLES `sip_number` WRITE;
/*!40000 ALTER TABLE `sip_number` DISABLE KEYS */;
/*!40000 ALTER TABLE `sip_number` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=855 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='区号字典表' ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state_dict`
--

LOCK TABLES `state_dict` WRITE;
/*!40000 ALTER TABLE `state_dict` DISABLE KEYS */;
INSERT INTO `state_dict` VALUES (428,'北京','北京','','北京市','010',''),(429,'上海','上海','','上海市','021',''),(430,'天津','天津','','天津市','022',''),(431,'重庆','重庆','','重庆市','023',''),(432,'广东','广州','','广东省广州市','020',''),(433,'辽宁','沈阳','','辽宁省沈阳市','024',''),(434,'江苏','南京','','江苏省南京市','025',''),(435,'湖北','武汉','','湖北省武汉市','027',''),(436,'四川','成都资阳眉山','','四川省成都资阳眉山','028',''),(437,'甘肃','金昌武威','','甘肃省金昌武威','0935',''),(438,'陕西','西安','','陕西省西安市','029',''),(439,'陕西','西安','','陕西省咸阳市','029','3'),(440,'河北','邯郸','','河北省邯郸市','0310',''),(441,'河北','石家庄','','河北省石家庄市','0311',''),(442,'河北','保定','','河北省保定市','0312',''),(443,'河北','张家口','','河北省张家口','0313',''),(444,'河北','承德','','河北省承德市','0314',''),(445,'河北','唐山','','河北省唐山市','0315',''),(446,'河北','廊坊','','河北省廊坊市','0316',''),(447,'河北','沧州','','河北省沧州市','0317',''),(448,'河北','衡水','','河北省衡水市','0318',''),(449,'河北','邢台','','河北省邢台市','0319',''),(450,'河北','秦皇岛','','河北省秦皇岛市','0335',''),(451,'山西','朔州','','山西省朔州市','0349',''),(452,'山西','忻州','','山西省忻州市','0350',''),(453,'山西','太原','','山西省太原市','0351',''),(454,'山西','大同','','山西省大同市','0352',''),(455,'山西','阳泉','','山西省阳泉市','0353',''),(456,'山西','晋中','','山西省晋中市','0354',''),(457,'山西','长治','','山西省长治市','0355',''),(458,'山西','晋城','','山西省晋城市','0356',''),(459,'山西','临汾','','山西省临汾市','0357',''),(460,'山西','吕梁','','山西省吕梁市','0358',''),(461,'山西','运城','','山西省运城市','0359',''),(462,'河南','商丘','','河南省商丘市','0370',''),(463,'河南','郑州','','河南省郑州市','0371',''),(464,'河南','安阳','','河南省安阳市','0372',''),(465,'河南','新乡','','河南省新乡市','0373',''),(466,'河南','许昌','','河南省许昌市','0374',''),(467,'河南','平顶山','','河南省平顶山市','0375',''),(468,'河南','信阳','','河南省信阳市','0376',''),(469,'河南','南阳','','河南省南阳市','0377',''),(470,'河南','开封','','河南省开封市','0378',''),(471,'河南','洛阳','','河南省洛阳市','0379',''),(472,'河南','焦作','','河南省焦作市','0391',''),(473,'河南','鹤壁','','河南省鹤壁市','0392',''),(474,'河南','濮阳','','河南省濮阳市','0393',''),(475,'河南','周口','','河南省周口市','0394',''),(476,'河南','漯河','','河南省漯河市','0395',''),(477,'河南','驻马店','','河南省驻马店市','0396',''),(478,'河南','潢川','','河南省潢川市','0397',''),(479,'河南','三门峡','','河南省三门峡市','0398',''),(480,'辽宁','铁岭','','辽宁省铁岭市','0410',''),(481,'辽宁','大连','','辽宁省大连市','0411',''),(482,'辽宁','鞍山','','辽宁省鞍山市','0412',''),(483,'辽宁','抚顺','','辽宁省抚顺市','0413',''),(484,'辽宁','本溪','','辽宁省本溪市','0414',''),(485,'辽宁','丹东','','辽宁省丹东市','0415',''),(486,'辽宁','锦州','','辽宁省锦州市','0416',''),(487,'辽宁','营口','','辽宁省营口市','0417',''),(488,'辽宁','阜新','','辽宁省阜新市','0418',''),(489,'辽宁','辽阳','','辽宁省辽阳市','0419',''),(490,'辽宁','朝阳','','辽宁省朝阳市','0421',''),(491,'辽宁','盘锦','','辽宁省盘锦市','0427',''),(492,'辽宁','葫芦岛','','辽宁省葫芦岛市','0429',''),(493,'吉林','长春','','吉林省长春市','0431',''),(494,'吉林','吉林','','吉林省吉林市','0432',''),(495,'吉林','延吉','','吉林省延吉市','0433',''),(496,'吉林','四平','','吉林省四平市','0434',''),(497,'吉林','通化','','吉林省通化市','0435',''),(498,'吉林','白城','','吉林省白城市','0436',''),(499,'吉林','辽源','','吉林省辽源市','0437',''),(500,'吉林','松原','','吉林省松原市','0438',''),(501,'吉林','白山','','吉林省白山市','0439',''),(502,'黑龙江','哈尔滨','','黑龙江省哈尔滨市','0451',''),(503,'黑龙江','齐齐哈尔','','黑龙江省齐齐哈尔市','0452',''),(504,'黑龙江','牡丹江','','黑龙江省牡丹江市','0453',''),(505,'黑龙江','佳木斯','','黑龙江省佳木斯市','0454',''),(506,'黑龙江','绥化','','黑龙江省绥化市','0455',''),(507,'黑龙江','黑河','','黑龙江省黑河市','0456',''),(508,'黑龙江','大兴安岭','','黑龙江省大兴安岭市','0457',''),(509,'黑龙江','伊春','','黑龙江省伊春市','0458',''),(510,'黑龙江','大庆','','黑龙江省大庆市','0459',''),(511,'黑龙江','七台河','','黑龙江省七台河市','0464',''),(512,'黑龙江','鸡西','','黑龙江省鸡西市','0467',''),(513,'黑龙江','鹤岗','','黑龙江省鹤岗市','0468',''),(514,'黑龙江','双鸭山','','黑龙江省双鸭山市','0469',''),(515,'内蒙','呼伦贝尔','','内蒙古呼伦贝尔市','0470',''),(516,'内蒙','呼和浩特','','内蒙古呼和浩特市','0471',''),(517,'内蒙','包头','','内蒙古包头市','0472',''),(518,'内蒙','乌海','','内蒙古乌海市','0473',''),(519,'内蒙','乌兰查布','','内蒙古乌兰查布市','0474',''),(520,'内蒙','通辽','','内蒙古通辽市','0475',''),(521,'内蒙','赤峰','','内蒙古赤峰市','0476',''),(522,'内蒙','鄂尔多斯','','内蒙古鄂尔多斯市','0477',''),(523,'内蒙','巴彦淖尔','','内蒙古巴彦淖尔市','0478',''),(524,'内蒙','锡林浩特','','内蒙古锡林浩特市','0479',''),(525,'内蒙','兴安盟','','内蒙古兴安盟市','0482',''),(526,'内蒙','阿盟','','内蒙古阿盟市','0483',''),(527,'江苏','无锡','','江苏省无锡市','0510',''),(528,'江苏','镇江','','江苏省镇江市','0511',''),(529,'江苏','苏州','','江苏省苏州市','0512',''),(530,'江苏','南通','','江苏省南通市','0513',''),(531,'江苏','扬州','','江苏省扬州市','0514',''),(532,'江苏','盐城','','江苏省盐城市','0515',''),(533,'江苏','徐州','','江苏省徐州市','0516',''),(534,'江苏','淮安','','江苏省淮安市','0517',''),(535,'江苏','连云港','','江苏省连云港市','0518',''),(536,'江苏','常州','','江苏省常州市','0519',''),(537,'江苏','泰州','','江苏省泰州市','0523',''),(538,'江苏','宿迁','','江苏省宿迁市','0527',''),(539,'山东','菏泽','','山东省菏泽市','0530',''),(540,'山东','济南','','山东省济南市','0531',''),(541,'山东','青岛','','山东省青岛市','0532',''),(542,'山东','淄博','','山东省淄博市','0533',''),(543,'山东','德州','','山东省德州市','0534',''),(544,'山东','烟台','','山东省烟台市','0535',''),(545,'山东','潍坊','','山东省潍坊市','0536',''),(546,'山东','济宁','','山东省济宁市','0537',''),(547,'山东','泰安','','山东省泰安市','0538',''),(548,'山东','临沂','','山东省临沂市','0539',''),(549,'山东','滨州','','山东省滨州市','0543',''),(550,'山东','东营','','山东省东营市','0546',''),(551,'安徽','滁州','','安徽省滁州市','0550',''),(552,'安徽','合肥','','安徽省合肥市','0551',''),(553,'安徽','蚌埠','','安徽省蚌埠市','0552',''),(554,'安徽','芜湖','','安徽省芜湖市','0553',''),(555,'安徽','淮南','','安徽省淮南市','0554',''),(556,'安徽','马鞍山','','安徽省马鞍山市','0555',''),(557,'安徽','安庆','','安徽省安庆市','0556',''),(558,'安徽','宿州','','安徽省宿州市','0557',''),(559,'安徽','阜阳','','安徽省阜阳市','0558',''),(560,'安徽','黄山','','安徽省黄山市','0559',''),(561,'安徽','淮北','','安徽省淮北市','0561',''),(562,'安徽','铜陵','','安徽省铜陵市','0562',''),(563,'安徽','宣城','','安徽省宣城市','0563',''),(564,'安徽','六安','','安徽省六安市','0564',''),(565,'安徽','巢湖','','安徽省巢湖市','0565',''),(566,'安徽','池州','','安徽省池州市','0566',''),(567,'浙江','衢州','','浙江省衢州市','0570',''),(568,'浙江','杭州','','浙江省杭州市','0571',''),(569,'浙江','湖州','','浙江省湖州市','0572',''),(570,'浙江','嘉兴','','浙江省嘉兴市','0573',''),(571,'浙江','宁波','','浙江省宁波市','0574',''),(572,'浙江','绍兴','','浙江省绍兴市','0575',''),(573,'浙江','台州','','浙江省台州市','0576',''),(574,'浙江','温州','','浙江省温州市','0577',''),(575,'浙江','丽水','','浙江省丽水市','0578',''),(576,'浙江','金华','','浙江省金华市','0579',''),(577,'浙江','舟山','','浙江省舟山市','0580',''),(578,'福建','福州','','福建省福州市','0591',''),(579,'福建','厦门','','福建省厦门市','0592',''),(580,'福建','宁德','','福建省宁德市','0593',''),(581,'福建','莆田','','福建省莆田市','0594',''),(582,'福建','泉州','','福建省泉州市','0595',''),(583,'福建','漳州','','福建省漳州市','0596',''),(584,'福建','龙岩','','福建省龙岩市','0597',''),(585,'福建','三明','','福建省三明市','0598',''),(586,'福建','南平','','福建省南平市','0599',''),(587,'山东','威海','','山东省威海市','0631',''),(588,'山东','枣庄','','山东省枣庄市','0632',''),(589,'山东','日照','','山东省日照市','0633',''),(590,'山东','莱芜','','山东省莱芜市','0634',''),(591,'山东','聊城','','山东省聊城市','0635',''),(592,'广东','汕尾','','广东省汕尾市','0660',''),(593,'广东','阳江','','广东省阳江市','0662',''),(594,'广东','揭阳','','广东省揭阳市','0663',''),(595,'广东','茂名','','广东省茂名市','0668',''),(596,'云南','西双版纳','','云南省西双版纳市','0691',''),(597,'云南','德宏','','云南省德宏市','0692',''),(598,'江西','鹰潭','','江西省鹰潭市','0701',''),(599,'湖北','襄樊','','湖北省襄樊市','0710',''),(600,'湖北','鄂州','','湖北省鄂州市','0711',''),(601,'湖北','孝感','','湖北省孝感市','0712',''),(602,'湖北','黄冈','','湖北省黄冈市','0713',''),(603,'湖北','黄石','','湖北省黄石市','0714',''),(604,'湖北','咸宁','','湖北省咸宁市','0715',''),(605,'湖北','荆州','','湖北省荆州市','0716',''),(606,'湖北','宜昌','','湖北省宜昌市','0717',''),(607,'湖北','恩施','','湖北省恩施市','0718',''),(608,'湖北','十堰','','湖北省十堰市','0719',''),(609,'湖北','随州','','湖北省随州市','0722',''),(610,'湖北','荆门','','湖北省荆门市','0724',''),(611,'湖北','仙桃','','湖北省仙桃市','0728',''),(612,'湖南','岳阳','','湖南省岳阳市','0730',''),(613,'湖南','长沙','','湖南省长沙市','0731',''),(614,'湖南','湘潭','','湖南省湘潭市','0732',''),(615,'湖南','株洲','','湖南省株洲市','0733',''),(616,'湖南','衡阳','','湖南省衡阳市','0734',''),(617,'湖南','郴州','','湖南省郴州市','0735',''),(618,'湖南','常德','','湖南省常德市','0736',''),(619,'湖南','益阳','','湖南省益阳市','0737',''),(620,'湖南','娄底','','湖南省娄底市','0738',''),(621,'湖南','邵阳','','湖南省邵阳市','0739',''),(622,'湖南','吉首','','湖南省吉首市','0743',''),(623,'湖南','张家界','','湖南省张家界市','0744',''),(624,'湖南','怀化','','湖南省怀化市','0745',''),(625,'湖南','永州','','湖南省永州市','0746',''),(626,'广东','江门','','广东省江门市','0750',''),(627,'广东','韶关','','广东省韶关市','0751',''),(628,'广东','惠州','','广东省惠州市','0752',''),(629,'广东','梅州','','广东省梅州市','0753',''),(630,'广东','汕头','','广东省汕头市','0754',''),(631,'广东','深圳','','广东省深圳市','0755',''),(632,'广东','珠海','','广东省珠海市','0756',''),(633,'广东','佛山','','广东省佛山市','0757',''),(634,'广东','肇庆','','广东省肇庆市','0758',''),(635,'广东','湛江','','广东省湛江市','0759',''),(636,'广东','中山','','广东省中山市','0760',''),(637,'广东','河源','','广东省河源市','0762',''),(638,'广东','清远','','广东省清远市','0763',''),(639,'广东','云浮','','广东省云浮市','0766',''),(640,'广东','潮州','','广东省潮州市','0768',''),(641,'广东','东莞','','广东省东莞市','0769',''),(642,'广西','防城港','','防城港','0770',''),(643,'广西','南宁','','南宁','0771',''),(644,'广西','南宁','城区','南宁','0771','25'),(645,'广西','南宁','城区','南宁','0771','46'),(646,'广西','南宁','城区','南宁','0771','80'),(647,'广西','南宁','城郊','南宁','0771','508'),(648,'广西','南宁','宾阳','南宁','0771','505'),(649,'广西','南宁','宾阳','南宁','0771','776'),(650,'广西','南宁','武鸣','南宁','0771','344'),(651,'广西','南宁','武鸣','南宁','0771','506'),(652,'广西','南宁','横县','南宁','0771','509'),(653,'广西','南宁','横县','南宁','0771','775'),(654,'广西','南宁','马山','南宁','0771','343'),(655,'广西','南宁','马山','南宁','0771','504'),(656,'广西','南宁','上林','南宁','0771','770'),(657,'广西','南宁','隆安','南宁','0771','340'),(658,'广西','南宁','隆安','南宁','0771','501'),(659,'广西','崇左','江州区','崇左','0771','342'),(660,'广西','崇左','江州区','崇左','0771','503'),(661,'广西','崇左','凭祥','崇左','0771','346'),(662,'广西','崇左','凭祥','崇左','0771','778'),(663,'广西','崇左','扶绥','崇左','0771','345'),(664,'广西','崇左','扶绥','崇左','0771','507'),(665,'广西','崇左','扶绥','崇左','0771','777'),(666,'广西','崇左','大新','崇左','0771','771'),(667,'广西','崇左','宁明','崇左','0771','341'),(668,'广西','崇左','宁明','崇左','0771','502'),(669,'广西','崇左','宁明','崇左','0771','779'),(670,'广西','崇左','龙州','崇左','0771','772'),(671,'广西','崇左','天等','崇左','0771','773'),(672,'广西','柳州','','柳州','0772',''),(673,'广西','柳州','城区','柳州','0772','30'),(674,'广西','柳州','城区','柳州','0772','50'),(675,'广西','柳州','城区','柳州','0772','607'),(676,'广西','柳州','城区','柳州','0772','608'),(677,'广西','柳州','城区','柳州','0772','609'),(678,'广西','柳州','柳江','柳州','0772','469'),(679,'广西','柳州','柳江','柳州','0772','603'),(680,'广西','柳州','鹿寨','柳州','0772','463'),(681,'广西','柳州','鹿寨','柳州','0772','605'),(682,'广西','柳州','鹿寨','柳州','0772','606'),(683,'广西','柳州','柳城','柳州','0772','466'),(684,'广西','柳州','融水','柳州','0772','468'),(685,'广西','柳州','融安','柳州','0772','462'),(686,'广西','柳州','三江','柳州','0772','461'),(687,'广西','来宾','城区','来宾','0772','601'),(688,'广西','来宾','城区','来宾','0772','602'),(689,'广西','来宾','城区','来宾','0772','604'),(690,'广西','来宾','武宣','来宾','0772','460'),(691,'广西','来宾','象州','来宾','0772','465'),(692,'广西','来宾','金秀','来宾','0772','464'),(693,'广西','来宾','忻城','来宾','0772','467'),(694,'广西','桂林','','桂林','0773',''),(695,'广西','贺州','','贺州','0774',''),(696,'广西','贺州','城区','贺州','0774','330'),(697,'广西','贺州','城区','贺州','0774','331'),(698,'广西','贺州','城区','贺州','0774','332'),(699,'广西','贺州','城区','贺州','0774','333'),(700,'广西','贺州','钟山','贺州','0774','335'),(701,'广西','贺州','富川','贺州','0774','336'),(702,'广西','贺州','昭平','贺州','0774','339'),(703,'广西','梧州','城区','梧州','0774','310'),(704,'广西','梧州','城区','梧州','0774','311'),(705,'广西','梧州','城区','梧州','0774','312'),(706,'广西','梧州','城区','梧州','0774','313'),(707,'广西','梧州','城区','梧州','0774','315'),(708,'广西','梧州','藤县','梧州','0774','326'),(709,'广西','梧州','岑溪','梧州','0774','320'),(710,'广西','梧州','苍梧','梧州','0774','323'),(711,'广西','梧州','蒙山','梧州','0774','328'),(712,'广西','玉林','','玉林','0775',''),(713,'广西','玉林','城区','玉林','0775','571'),(714,'广西','玉林','城区','玉林','0775','575'),(715,'广西','玉林','城区','玉林','0775','577'),(716,'广西','玉林','城区','玉林','0775','58'),(717,'广西','玉林','博白','玉林','0775','578'),(718,'广西','玉林','北流','玉林','0775','576'),(719,'广西','玉林','北流','玉林','0775','579'),(720,'广西','玉林','陆川','玉林','0775','570'),(721,'广西','玉林','容县','玉林','0775','572'),(722,'广西','玉林','兴业','玉林','0775','573'),(723,'广西','贵港','城区','贵港','0775','590'),(724,'广西','贵港','城区','贵港','0775','591'),(725,'广西','贵港','城区','贵港','0775','592'),(726,'广西','贵港','城区','贵港','0775','593'),(727,'广西','贵港','城区','贵港','0775','595'),(728,'广西','贵港','城区','贵港','0775','596'),(729,'广西','贵港','城区','贵港','0775','598'),(730,'广西','贵港','城区','贵港','0775','599'),(731,'广西','贵港','桂平','贵港','0775','605'),(732,'广西','贵港','桂平','贵港','0775','606'),(733,'广西','贵港','桂平','贵港','0775','607'),(734,'广西','贵港','桂平','贵港','0775','608'),(735,'广西','贵港','桂平','贵港','0775','609'),(736,'广西','贵港','桂平','贵港','0775','818'),(737,'广西','贵港','平南','贵港','0775','601'),(738,'广西','贵港','平南','贵港','0775','602'),(739,'广西','贵港','平南','贵港','0775','603'),(740,'广西','贵港','平南','贵港','0775','811'),(741,'广西','百色','','百色','0776',''),(742,'广西','钦州','','钦州','0777',''),(743,'广西','河池','','河池','0778',''),(744,'广西','北海','','北海','0779',''),(745,'江西','新余','','江西省新余市','0790',''),(746,'江西','南昌','','江西省南昌市','0791',''),(747,'江西','九江','','江西省九江市','0792',''),(748,'江西','上饶','','江西省上饶市','0793',''),(749,'江西','抚州','','江西省抚州市','0794',''),(750,'江西','宜春','','江西省宜春市','0795',''),(751,'江西','吉安','','江西省吉安市','0796',''),(752,'江西','赣州','','江西省赣州市','0797',''),(753,'江西','景德镇','','江西省景德镇','0798',''),(754,'江西','萍乡','','江西省萍乡市','0799',''),(755,'四川','攀枝花','','四川省攀枝花','0812',''),(756,'四川','自贡','','四川省自贡市','0813',''),(757,'四川','绵阳','','四川省绵阳市','0816',''),(758,'四川','南充','','四川省南充市','0817',''),(759,'四川','达州','','四川省达州市','0818',''),(760,'四川','遂宁','','四川省遂宁市','0825',''),(761,'四川','广安','','四川省广安市','0826',''),(762,'四川','巴中','','四川省巴中市','0827',''),(763,'四川','泸州','','四川省泸州市','0830',''),(764,'四川','宜宾','','四川省宜宾市','0831',''),(765,'四川','内江','','四川省内江市','0832',''),(766,'四川','乐山','','四川省乐山市','0833',''),(767,'四川','凉山','','四川省凉山市','0834',''),(768,'四川','雅安','','四川省雅安市','0835',''),(769,'四川','甘孜州','','四川省甘孜州','0836',''),(770,'四川','阿坝州','','四川省阿坝州','0837',''),(771,'四川','德阳','','四川省德阳市','0838',''),(772,'四川','广元','','四川省广元市','0839',''),(773,'贵州','贵阳','','贵州省贵阳市','0851',''),(774,'贵州','遵义','','贵州省遵义市','0852',''),(775,'贵州','安顺','','贵州省安顺市','0853',''),(776,'贵州','都匀','','贵州省都匀市','0854',''),(777,'贵州','凯里','','贵州省凯里市','0855',''),(778,'贵州','铜仁','','贵州省铜仁市','0856',''),(779,'贵州','毕节','','贵州省毕节市','0857',''),(780,'贵州','六盘水','','贵州省六盘水','0858',''),(781,'贵州','兴义','','贵州省兴义市','0859',''),(782,'云南','昭通','','云南省昭通市','0870',''),(783,'云南','昆明','','云南省昆明市','0871',''),(784,'云南','大理','','云南省大理市','0872',''),(785,'云南','红河','','云南省红河市','0873',''),(786,'云南','曲靖','','云南省曲靖市','0874',''),(787,'云南','保山','','云南省保山市','0875',''),(788,'云南','文山','','云南省文山市','0876',''),(789,'云南','玉溪','','云南省玉溪市','0877',''),(790,'云南','楚雄','','云南省楚雄市','0878',''),(791,'云南','思茅','','云南省思茅市','0879',''),(792,'云南','临沧','','云南省临沧市','0883',''),(793,'云南','怒江','','云南省怒江市','0886',''),(794,'云南','迪庆','','云南省迪庆市','0887',''),(795,'云南','丽江','','云南省丽江市','0888',''),(796,'西藏','拉萨','','西藏拉萨','0891',''),(797,'西藏','日喀则','','西藏日喀则','0892',''),(798,'西藏','山南','','西藏山南','0893',''),(799,'西藏','林芝','','西藏林芝','0894',''),(800,'西藏','昌都','','西藏昌都','0895',''),(801,'西藏','那曲','','西藏那曲','0896',''),(802,'西藏','阿里','','西藏阿里','0897',''),(803,'海南','海口','','海南省海口市','0898',''),(804,'海南','三亚','','海南省三亚市','0899',''),(805,'新疆','塔城','','新疆塔城','0901',''),(806,'新疆','哈密','','新疆哈密','0902',''),(807,'新疆','和田','','新疆和田','0903',''),(808,'新疆','阿勒泰','','新疆阿勒泰','0906',''),(809,'新疆','克州','','新疆克州','0908',''),(810,'新疆','博乐','','新疆博乐','0909',''),(811,'陕西','咸阳','','陕西省咸阳市','0910',''),(812,'陕西','延安','','陕西省延安市','0911',''),(813,'陕西','榆林','','陕西省榆林市','0912',''),(814,'陕西','渭南','','陕西省渭南市','0913',''),(815,'陕西','商洛','','陕西省商洛市','0914',''),(816,'陕西','安康','','陕西省安康市','0915',''),(817,'陕西','汉中','','陕西省汉中市','0916',''),(818,'陕西','宝鸡','','陕西省宝鸡市','0917',''),(819,'陕西','铜川','','陕西省铜川市','0919',''),(820,'甘肃','临夏','','甘肃省临夏市','0930',''),(821,'甘肃','兰州','','甘肃省兰州市','0931',''),(822,'甘肃','定西','','甘肃省定西市','0932',''),(823,'甘肃','平凉','','甘肃省平凉市','0933',''),(824,'甘肃','庆阳','','甘肃省庆阳市','0934',''),(825,'甘肃','张掖','','甘肃省张掖市','0936',''),(826,'甘肃','酒泉嘉峪关','','甘肃省酒泉嘉峪关','0937',''),(827,'甘肃','天水','','甘肃省天水市','0938',''),(828,'甘肃','陇南','','甘肃省陇南市','0939',''),(829,'甘肃','甘南','','甘肃省甘南市','0941',''),(830,'甘肃','白银','','甘肃省白银市','0943',''),(831,'宁夏','银川','','宁夏银川','0951',''),(832,'宁夏','石嘴山','','宁夏石嘴山','0952',''),(833,'宁夏','吴忠','','宁夏吴忠','0953',''),(834,'宁夏','固原','','宁夏固原','0954',''),(835,'宁夏','中卫','','宁夏中卫','0955',''),(836,'青海','海北州','','青海海北州','0970',''),(837,'青海','西宁','','青海西宁','0971',''),(838,'青海','海东','','青海海东','0972',''),(839,'青海','黄南','','青海黄南','0973',''),(840,'青海','海南州','','青海海南州','0974',''),(841,'青海','果洛','','青海果洛','0975',''),(842,'青海','玉树','','青海玉树','0976',''),(843,'青海','海西州','','青海海西州','0977',''),(844,'青海','格尔木','','青海格尔木','0979',''),(845,'新疆','克拉玛依','','新疆克拉玛依','0990',''),(846,'新疆','乌鲁木齐','','新疆乌鲁木齐','0991',''),(847,'新疆','奎屯','','新疆奎屯','0992',''),(848,'新疆','石河子','','新疆石河子','0993',''),(849,'新疆','昌吉','','新疆昌吉','0994',''),(850,'新疆','吐鲁番','','新疆吐鲁番','0995',''),(851,'新疆','库尔勒','','新疆库尔勒','0996',''),(852,'新疆','阿克苏','','新疆阿克苏','0997',''),(853,'新疆','喀什','','新疆喀什','0998',''),(854,'新疆','伊犁','','新疆伊犁','0999','');
/*!40000 ALTER TABLE `state_dict` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics_of_ep_call_per_day`
--

DROP TABLE IF EXISTS `statistics_of_ep_call_per_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_ep_call_per_day` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当天时间戳',
  `in_total_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话数',
  `in_intercept_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入拦截数',
  `in_ivr_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入菜单放弃数',
  `in_choice_group` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '到达技能组数',
  `in_line_up_group` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '技能组排队数',
  `in_line_up_group_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队放弃数',
  `in_seat_ring_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席振铃通话数',
  `in_seat_incall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席接听数',
  `in_seat_incall_rate` float NOT NULL DEFAULT '0' COMMENT '坐席接听率',
  `in_seat_miss_incall` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席未接数',
  `in_ring_customer_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '振铃放弃数,客户主动放弃的通话数量',
  `in_call_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均通话时长',
  `in_line_up_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT ' 排队总时长',
  `in_call_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长',
  `in_direct_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入直线呼入数',
  `in_incall_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入分钟数',
  `out_total_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话数',
  `out_intercept_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出拦截数',
  `out_total_success` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出接听数',
  `out_call_rate` float NOT NULL DEFAULT '0' COMMENT '呼出接听率',
  `out_miscall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出未接数',
  `out_average_time` float NOT NULL DEFAULT '0' COMMENT '呼出平均通话时长',
  `out_call_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出总通话时长',
  `out_call_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出分钟数',
  `all_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成功通话总数',
  `evaluate_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话评价数',
  `evaluate_count_rate` float NOT NULL DEFAULT '0' COMMENT '通话评价率',
  `evaluate_count_9` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常满意数',
  `evaluate_count_7` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '满意数',
  `evaluate_count_5` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '一般数',
  `evaluate_count_3` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '不满意数',
  `evaluate_count_1` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常不满意数',
  `good_evaluate` float NOT NULL DEFAULT '0' COMMENT '好评率',
  `bad_evaluate` float NOT NULL DEFAULT '0' COMMENT '差评率',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_timestamp` (`seid`,`ccgeid`,`timestamp`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业通话按天统计表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics_of_ep_call_per_day`
--

LOCK TABLES `statistics_of_ep_call_per_day` WRITE;
/*!40000 ALTER TABLE `statistics_of_ep_call_per_day` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics_of_ep_call_per_day` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics_of_ep_call_per_halfhour`
--

DROP TABLE IF EXISTS `statistics_of_ep_call_per_halfhour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_ep_call_per_halfhour` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '半小时时间戳',
  `in_total_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话数',
  `in_intercept_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入拦截数',
  `in_ivr_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入菜单放弃数',
  `in_choice_group` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '到达技能组数',
  `in_line_up_group` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '技能组排队数',
  `in_line_up_group_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队放弃数',
  `in_seat_ring_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席振铃通话数',
  `in_seat_incall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席接听数',
  `in_seat_incall_rate` float NOT NULL DEFAULT '0' COMMENT '坐席接听率',
  `in_seat_miss_incall` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席未接数',
  `in_ring_customer_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '振铃放弃数,客户主动放弃的通话数量',
  `in_call_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均通话时长',
  `in_line_up_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队总时长',
  `in_call_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长',
  `in_direct_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入直线呼入数',
  `in_incall_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入分钟数',
  `out_total_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话数',
  `out_intercept_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出拦截数',
  `out_total_success` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出接听数',
  `out_call_rate` float NOT NULL DEFAULT '0' COMMENT '呼出接听率',
  `out_miscall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出未接数',
  `out_average_time` float NOT NULL DEFAULT '0' COMMENT '呼出平均通话时长',
  `out_call_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出总通话时长',
  `out_call_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出分钟数',
  `all_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成功通话总数',
  `evaluate_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话评价数',
  `evaluate_count_rate` float NOT NULL DEFAULT '0' COMMENT '通话评价率',
  `evaluate_count_9` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常满意数',
  `evaluate_count_7` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '满意数',
  `evaluate_count_5` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '一般数',
  `evaluate_count_3` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '不满意数',
  `evaluate_count_1` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常不满意数',
  `good_evaluate` float NOT NULL DEFAULT '0' COMMENT '好评率',
  `bad_evaluate` float NOT NULL DEFAULT '0' COMMENT '差评率',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_timestamp` (`seid`,`ccgeid`,`timestamp`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业通话半小时统计表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics_of_ep_call_per_halfhour`
--

LOCK TABLES `statistics_of_ep_call_per_halfhour` WRITE;
/*!40000 ALTER TABLE `statistics_of_ep_call_per_halfhour` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics_of_ep_call_per_halfhour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics_of_ep_call_per_month`
--

DROP TABLE IF EXISTS `statistics_of_ep_call_per_month`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_ep_call_per_month` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当月首日时间戳',
  `in_total_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话数',
  `in_intercept_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入拦截数',
  `in_ivr_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入菜单放弃数',
  `in_choice_group` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '到达技能组数',
  `in_line_up_group` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '技能组排队数',
  `in_line_up_group_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队放弃数',
  `in_seat_ring_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席振铃通话数',
  `in_seat_incall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席接听数',
  `in_seat_incall_rate` float NOT NULL DEFAULT '0' COMMENT '坐席接听率',
  `in_seat_miss_incall` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席未接数',
  `in_ring_customer_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '振铃放弃数,客户主动放弃的通话数量',
  `in_call_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均通话时长',
  `in_line_up_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队总时长',
  `in_call_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长',
  `in_direct_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入直线呼入数',
  `in_incall_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入分钟数',
  `out_total_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话数',
  `out_intercept_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出拦截数',
  `out_total_success` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出接听数',
  `out_call_rate` float NOT NULL DEFAULT '0' COMMENT '呼出接听率',
  `out_miscall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出未接数',
  `out_average_time` float NOT NULL DEFAULT '0' COMMENT '呼出平均通话时长',
  `out_call_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出总通话时长',
  `out_call_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出分钟数',
  `all_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成功通话总数',
  `evaluate_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话评价数',
  `evaluate_count_rate` float NOT NULL DEFAULT '0' COMMENT '通话评价率',
  `evaluate_count_9` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常满意数',
  `evaluate_count_7` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '满意数',
  `evaluate_count_5` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '一般数',
  `evaluate_count_3` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '不满意数',
  `evaluate_count_1` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常不满意数',
  `good_evaluate` float NOT NULL DEFAULT '0' COMMENT '好评率',
  `bad_evaluate` float NOT NULL DEFAULT '0' COMMENT '差评率',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_timestamp` (`seid`,`ccgeid`,`timestamp`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='企业通话按月统计表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics_of_ep_call_per_month`
--

LOCK TABLES `statistics_of_ep_call_per_month` WRITE;
/*!40000 ALTER TABLE `statistics_of_ep_call_per_month` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics_of_ep_call_per_month` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics_of_group_call_per_day`
--

DROP TABLE IF EXISTS `statistics_of_group_call_per_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_group_call_per_day` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当天时间戳',
  `in_group_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总数',
  `in_customer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入客户数',
  `in_line_up_group` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '技能组排队数',
  `in_line_up_group_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队放弃数',
  `in_seat_incall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入到达坐席数',
  `in_seat_incall_success_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席接听数',
  `in_seat_incall_rate` float NOT NULL DEFAULT '0' COMMENT '呼入接听率',
  `in_seat_miss_incall` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席未接数',
  `in_ring_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '振铃放弃数',
  `in_transfer_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入转接通话数',
  `in_ring_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入总振铃时长',
  `in_ring_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均振铃时长',
  `in_call_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均通话时长',
  `in_line_up_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队总时长',
  `in_call_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长',
  `in_incall_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入分钟数',
  `out_total_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出总数',
  `out_customer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出客户数',
  `out_intercept_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出拦截数',
  `out_total_success` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出接听数',
  `out_call_rate` float NOT NULL DEFAULT '0' COMMENT '呼出接听率',
  `out_miscall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出未接数',
  `out_average_time` float NOT NULL DEFAULT '0' COMMENT '呼出平均通话时长',
  `out_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话总时长',
  `out_call_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出分钟数',
  `all_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成功通话总数',
  `evaluate_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话评价数',
  `evaluate_count_rate` float NOT NULL DEFAULT '0' COMMENT '通话评价率',
  `evaluate_count_9` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常满意数',
  `evaluate_count_7` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '满意数',
  `evaluate_count_5` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '一般数',
  `evaluate_count_3` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '不满意数',
  `evaluate_count_1` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常不满意数',
  `good_evaluate` float NOT NULL DEFAULT '0' COMMENT '好评率',
  `bad_evaluate` float NOT NULL DEFAULT '0' COMMENT '差评率',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_gid_timestamp` (`seid`,`ccgeid`,`gid`,`timestamp`),
  KEY `gid` (`gid`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能组通话按天统计表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics_of_group_call_per_day`
--

LOCK TABLES `statistics_of_group_call_per_day` WRITE;
/*!40000 ALTER TABLE `statistics_of_group_call_per_day` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics_of_group_call_per_day` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics_of_group_call_per_halfhour`
--

DROP TABLE IF EXISTS `statistics_of_group_call_per_halfhour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_group_call_per_halfhour` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '半小时时间戳',
  `in_group_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总数',
  `in_customer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入客户数',
  `in_line_up_group` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '技能组排队数',
  `in_line_up_group_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队放弃数',
  `in_seat_incall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入到达坐席数',
  `in_seat_incall_success_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席接听数',
  `in_seat_incall_rate` float NOT NULL DEFAULT '0' COMMENT '呼入接听率',
  `in_seat_miss_incall` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席未接数',
  `in_ring_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '振铃放弃数',
  `in_transfer_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入转接通话数',
  `in_ring_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入总振铃时长',
  `in_ring_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均振铃时长',
  `in_call_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均通话时长',
  `in_line_up_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队总时长',
  `in_call_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长',
  `in_incall_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入分钟数',
  `out_total_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出总数',
  `out_customer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出客户数',
  `out_intercept_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出拦截数',
  `out_total_success` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出接听数',
  `out_call_rate` float NOT NULL DEFAULT '0' COMMENT '呼出接听率',
  `out_miscall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出未接数',
  `out_average_time` float NOT NULL DEFAULT '0' COMMENT '呼出平均通话时长',
  `out_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话总时长',
  `out_call_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出分钟数',
  `all_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成功通话总数',
  `evaluate_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话评价数',
  `evaluate_count_rate` float NOT NULL DEFAULT '0' COMMENT '通话评价率',
  `evaluate_count_9` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常满意数',
  `evaluate_count_7` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '满意数',
  `evaluate_count_5` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '一般数',
  `evaluate_count_3` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '不满意数',
  `evaluate_count_1` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常不满意数',
  `good_evaluate` float NOT NULL DEFAULT '0' COMMENT '好评率',
  `bad_evaluate` float NOT NULL DEFAULT '0' COMMENT '差评率',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_gid_timestamp` (`seid`,`ccgeid`,`gid`,`timestamp`),
  KEY `gid` (`gid`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能组通话半小时统计表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics_of_group_call_per_halfhour`
--

LOCK TABLES `statistics_of_group_call_per_halfhour` WRITE;
/*!40000 ALTER TABLE `statistics_of_group_call_per_halfhour` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics_of_group_call_per_halfhour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics_of_group_call_per_month`
--

DROP TABLE IF EXISTS `statistics_of_group_call_per_month`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_group_call_per_month` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当月首日时间戳',
  `in_group_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总数',
  `in_customer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入客户数',
  `in_line_up_group` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '技能组排队数',
  `in_line_up_group_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队放弃数',
  `in_seat_incall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入到达坐席数',
  `in_seat_incall_success_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席接听数',
  `in_seat_incall_rate` float NOT NULL DEFAULT '0' COMMENT '呼入接听率',
  `in_seat_miss_incall` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席未接数',
  `in_ring_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '振铃放弃数',
  `in_transfer_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入转接通话数',
  `in_ring_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入总振铃时长',
  `in_ring_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均振铃时长',
  `in_call_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均通话时长',
  `in_line_up_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队总时长',
  `in_call_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长',
  `in_incall_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入分钟数',
  `out_total_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出总数',
  `out_customer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出客户数',
  `out_intercept_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出拦截数',
  `out_total_success` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出接听数',
  `out_call_rate` float NOT NULL DEFAULT '0' COMMENT '呼出接听率',
  `out_miscall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出未接数',
  `out_average_time` float NOT NULL DEFAULT '0' COMMENT '呼出平均通话时长',
  `out_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出通话总时长',
  `out_call_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出分钟数',
  `all_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成功通话总数',
  `evaluate_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话评价数',
  `evaluate_count_rate` float NOT NULL DEFAULT '0' COMMENT '通话评价率',
  `evaluate_count_9` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常满意数',
  `evaluate_count_7` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '满意数',
  `evaluate_count_5` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '一般数',
  `evaluate_count_3` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '不满意数',
  `evaluate_count_1` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常不满意数',
  `good_evaluate` float NOT NULL DEFAULT '0' COMMENT '好评率',
  `bad_evaluate` float NOT NULL DEFAULT '0' COMMENT '差评率',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_gid_timestamp` (`seid`,`ccgeid`,`gid`,`timestamp`),
  KEY `gid` (`gid`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='技能组通话按月统计表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics_of_group_call_per_month`
--

LOCK TABLES `statistics_of_group_call_per_month` WRITE;
/*!40000 ALTER TABLE `statistics_of_group_call_per_month` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics_of_group_call_per_month` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics_of_seat_call_per_day`
--

DROP TABLE IF EXISTS `statistics_of_seat_call_per_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_seat_call_per_day` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当天时间戳',
  `in_seat_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话数',
  `in_customer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入客户数',
  `in_seat_incall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席接听数',
  `in_seat_incall_rate` float NOT NULL DEFAULT '0' COMMENT '呼入接听率',
  `in_seat_miss_incall` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席未接数',
  `in_ring_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '振铃放弃数',
  `in_seat_tranfer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '转接通话数',
  `in_direct_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入直线呼入数',
  `in_seat_line_up` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '坐席排队数',
  `in_seat_line_up_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队放弃数',
  `in_ring_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入总振铃时长',
  `in_ring_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均振铃时长',
  `in_call_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均通话时长',
  `in_call_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长',
  `in_call_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入分钟数',
  `out_total_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出总次数',
  `out_intercept_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出拦截数',
  `out_customer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出客户数',
  `out_total_success` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出客户接听数',
  `out_call_rate` float NOT NULL DEFAULT '0' COMMENT '呼出客户接听率',
  `out_miscall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出客户振铃未接数',
  `out_average_time` float NOT NULL DEFAULT '0' COMMENT '呼出平均通话时长',
  `out_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出总通话时长',
  `out_call_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出分钟数',
  `all_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成功通话总数',
  `evaluate_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话评价数',
  `evaluate_count_rate` float NOT NULL DEFAULT '0' COMMENT '通话评价率',
  `evaluate_count_9` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常满意数',
  `evaluate_count_7` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '满意数',
  `evaluate_count_5` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '一般数',
  `evaluate_count_3` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '不满意数',
  `evaluate_count_1` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常不满意数',
  `good_evaluate` float NOT NULL DEFAULT '0' COMMENT '好评率',
  `bad_evaluate` float NOT NULL DEFAULT '0' COMMENT '差评率',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_uid_timestamp` (`seid`,`ccgeid`,`uid`,`timestamp`),
  KEY `uid` (`uid`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席通话按天统计表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics_of_seat_call_per_day`
--

LOCK TABLES `statistics_of_seat_call_per_day` WRITE;
/*!40000 ALTER TABLE `statistics_of_seat_call_per_day` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics_of_seat_call_per_day` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics_of_seat_call_per_halfhour`
--

DROP TABLE IF EXISTS `statistics_of_seat_call_per_halfhour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_seat_call_per_halfhour` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '半小时时间戳',
  `in_seat_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话数',
  `in_customer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入客户数',
  `in_seat_incall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席接听数',
  `in_seat_incall_rate` float NOT NULL DEFAULT '0' COMMENT '呼入接听率',
  `in_seat_miss_incall` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席未接数',
  `in_ring_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '振铃放弃数',
  `in_seat_tranfer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '转接通话数',
  `in_direct_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入直线呼入数',
  `in_seat_line_up` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '坐席排队数',
  `in_seat_line_up_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队放弃数',
  `in_ring_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入总振铃时长',
  `in_ring_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均振铃时长',
  `in_call_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均通话时长',
  `in_call_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长',
  `in_call_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入分钟数',
  `out_total_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出总次数',
  `out_intercept_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出拦截数',
  `out_customer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出客户数',
  `out_total_success` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出客户接听数',
  `out_call_rate` float NOT NULL DEFAULT '0' COMMENT '呼出客户接听率',
  `out_miscall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出客户振铃未接数',
  `out_average_time` float NOT NULL DEFAULT '0' COMMENT '呼出平均通话时长',
  `out_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出总通话时长',
  `out_call_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出分钟数',
  `all_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成功通话总数',
  `evaluate_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话评价数',
  `evaluate_count_rate` float NOT NULL DEFAULT '0' COMMENT '通话评价率',
  `evaluate_count_9` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常满意数',
  `evaluate_count_7` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '满意数',
  `evaluate_count_5` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '一般数',
  `evaluate_count_3` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '不满意数',
  `evaluate_count_1` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常不满意数',
  `good_evaluate` float NOT NULL DEFAULT '0' COMMENT '好评率',
  `bad_evaluate` float NOT NULL DEFAULT '0' COMMENT '差评率',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_uid_timestamp` (`seid`,`ccgeid`,`uid`,`timestamp`),
  KEY `uid` (`uid`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席通话半小时统计表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics_of_seat_call_per_halfhour`
--

LOCK TABLES `statistics_of_seat_call_per_halfhour` WRITE;
/*!40000 ALTER TABLE `statistics_of_seat_call_per_halfhour` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics_of_seat_call_per_halfhour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics_of_seat_call_per_month`
--

DROP TABLE IF EXISTS `statistics_of_seat_call_per_month`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_seat_call_per_month` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当月首日时间戳',
  `in_seat_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话数',
  `in_customer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入客户数',
  `in_seat_incall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席接听数',
  `in_seat_incall_rate` float NOT NULL DEFAULT '0' COMMENT '呼入接听率',
  `in_seat_miss_incall` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入坐席未接数',
  `in_ring_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '振铃放弃数',
  `in_seat_tranfer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '转接通话数',
  `in_direct_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入直线呼入数',
  `in_seat_line_up` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '坐席排队数',
  `in_seat_line_up_abort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排队放弃数',
  `in_ring_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入总振铃时长',
  `in_ring_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均振铃时长',
  `in_call_average_time` float NOT NULL DEFAULT '0' COMMENT '呼入平均通话时长',
  `in_call_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入通话总时长',
  `in_call_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼入分钟数',
  `out_total_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出总次数',
  `out_intercept_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出拦截数',
  `out_customer_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出客户数',
  `out_total_success` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出客户接听数',
  `out_call_rate` float NOT NULL DEFAULT '0' COMMENT '呼出客户接听率',
  `out_miscall_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出客户振铃未接数',
  `out_average_time` float NOT NULL DEFAULT '0' COMMENT '呼出平均通话时长',
  `out_total_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出总通话时长',
  `out_call_minute` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '呼出分钟数',
  `all_call_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成功通话总数',
  `evaluate_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '通话评价数',
  `evaluate_count_rate` float NOT NULL DEFAULT '0' COMMENT '通话评价率',
  `evaluate_count_9` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常满意数',
  `evaluate_count_7` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '满意数',
  `evaluate_count_5` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '一般数',
  `evaluate_count_3` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '不满意数',
  `evaluate_count_1` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '非常不满意数',
  `good_evaluate` float NOT NULL DEFAULT '0' COMMENT '好评率',
  `bad_evaluate` float NOT NULL DEFAULT '0' COMMENT '差评率',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_uid_timestamp` (`seid`,`ccgeid`,`uid`,`timestamp`),
  KEY `uid` (`uid`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席通话按月统计表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics_of_seat_call_per_month`
--

LOCK TABLES `statistics_of_seat_call_per_month` WRITE;
/*!40000 ALTER TABLE `statistics_of_seat_call_per_month` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics_of_seat_call_per_month` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics_of_seat_monitor_per_day`
--

DROP TABLE IF EXISTS `statistics_of_seat_monitor_per_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_seat_monitor_per_day` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当天时间戳',
  `online_time` int(10) DEFAULT '0' COMMENT '在线总时长',
  `wait_time` int(10) DEFAULT '0' COMMENT '空闲总时长',
  `answer_time` int(10) DEFAULT '0' COMMENT '通话总时长',
  `busy_time` int(10) DEFAULT '0' COMMENT '忙碌总时长',
  `answer_after_time` int(10) DEFAULT '0' COMMENT '话后总时长',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_uid_timestamp` (`seid`,`ccgeid`,`uid`,`timestamp`),
  KEY `uid` (`uid`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席监控按天统计表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics_of_seat_monitor_per_day`
--

LOCK TABLES `statistics_of_seat_monitor_per_day` WRITE;
/*!40000 ALTER TABLE `statistics_of_seat_monitor_per_day` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics_of_seat_monitor_per_day` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics_of_seat_monitor_per_halfhour`
--

DROP TABLE IF EXISTS `statistics_of_seat_monitor_per_halfhour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_seat_monitor_per_halfhour` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '半小时时间戳',
  `online_time` int(10) DEFAULT '0' COMMENT '在线总时长',
  `wait_time` int(10) DEFAULT '0' COMMENT '空闲总时长',
  `answer_time` int(10) DEFAULT '0' COMMENT '通话总时长',
  `busy_time` int(10) DEFAULT '0' COMMENT '忙碌总时长',
  `answer_after_time` int(10) DEFAULT '0' COMMENT '话后总时长',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_uid_timestamp` (`seid`,`ccgeid`,`uid`,`timestamp`),
  KEY `uid` (`uid`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席监控半小时统计表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics_of_seat_monitor_per_halfhour`
--

LOCK TABLES `statistics_of_seat_monitor_per_halfhour` WRITE;
/*!40000 ALTER TABLE `statistics_of_seat_monitor_per_halfhour` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics_of_seat_monitor_per_halfhour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics_of_seat_monitor_per_month`
--

DROP TABLE IF EXISTS `statistics_of_seat_monitor_per_month`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_seat_monitor_per_month` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当月首日时间戳',
  `online_time` int(10) DEFAULT '0' COMMENT '在线总时长',
  `wait_time` int(10) DEFAULT '0' COMMENT '空闲总时长',
  `answer_time` int(10) DEFAULT '0' COMMENT '通话总时长',
  `busy_time` int(10) DEFAULT '0' COMMENT '忙碌总时长',
  `answer_after_time` int(10) DEFAULT '0' COMMENT '话后总时长',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_uid_timestamp` (`seid`,`ccgeid`,`uid`,`timestamp`),
  KEY `uid` (`uid`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席监控按月统计表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics_of_seat_monitor_per_month`
--

LOCK TABLES `statistics_of_seat_monitor_per_month` WRITE;
/*!40000 ALTER TABLE `statistics_of_seat_monitor_per_month` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics_of_seat_monitor_per_month` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics_of_seat_substate_monitor_per_day`
--

DROP TABLE IF EXISTS `statistics_of_seat_substate_monitor_per_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_seat_substate_monitor_per_day` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当天时间戳',
  `sub_state_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '子状态ID',
  `sub_state_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '子状态名称',
  `sub_state_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '子状态时长',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_uid_timestamp_sub_state_id` (`seid`,`ccgeid`,`uid`,`timestamp`,`sub_state_id`),
  KEY `uid` (`uid`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席监控按天统计表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics_of_seat_substate_monitor_per_day`
--

LOCK TABLES `statistics_of_seat_substate_monitor_per_day` WRITE;
/*!40000 ALTER TABLE `statistics_of_seat_substate_monitor_per_day` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics_of_seat_substate_monitor_per_day` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics_of_seat_substate_monitor_per_halfhour`
--

DROP TABLE IF EXISTS `statistics_of_seat_substate_monitor_per_halfhour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_seat_substate_monitor_per_halfhour` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '半小时时间戳',
  `sub_state_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '子状态ID',
  `sub_state_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '子状态名称',
  `sub_state_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '子状态时长',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_uid_timestamp_sub_state_id` (`seid`,`ccgeid`,`uid`,`timestamp`,`sub_state_id`),
  KEY `uid` (`uid`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席监控半小时统计表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics_of_seat_substate_monitor_per_halfhour`
--

LOCK TABLES `statistics_of_seat_substate_monitor_per_halfhour` WRITE;
/*!40000 ALTER TABLE `statistics_of_seat_substate_monitor_per_halfhour` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics_of_seat_substate_monitor_per_halfhour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics_of_seat_substate_monitor_per_month`
--

DROP TABLE IF EXISTS `statistics_of_seat_substate_monitor_per_month`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_of_seat_substate_monitor_per_month` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '坐席UID',
  `timestamp` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '当月首日时间戳',
  `sub_state_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '子状态ID',
  `sub_state_name` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '子状态名称',
  `sub_state_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '子状态时长',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccgeid_uid_timestamp_sub_state_id` (`seid`,`ccgeid`,`uid`,`timestamp`,`sub_state_id`),
  KEY `uid` (`uid`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='坐席监控按月统计表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics_of_seat_substate_monitor_per_month`
--

LOCK TABLES `statistics_of_seat_substate_monitor_per_month` WRITE;
/*!40000 ALTER TABLE `statistics_of_seat_substate_monitor_per_month` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics_of_seat_substate_monitor_per_month` ENABLE KEYS */;
UNLOCK TABLES;

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
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain` (`domain`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='超级企业表' ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `super_enterprise`
--

LOCK TABLES `super_enterprise` WRITE;
/*!40000 ALTER TABLE `super_enterprise` DISABLE KEYS */;
INSERT INTO `super_enterprise` VALUES (1,'测试超级企业1','e1.emic.com.cn',1,0,1531727947),(2,'测试超级企业2','e2.emic.com.cn',1,0,0);
/*!40000 ALTER TABLE `super_enterprise` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='超级企业配置表' ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `super_enterprise_setting`
--

LOCK TABLES `super_enterprise_setting` WRITE;
/*!40000 ALTER TABLE `super_enterprise_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `super_enterprise_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync`
--

DROP TABLE IF EXISTS `sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `type` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据类型',
  `action` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据变更类型',
  `data` longtext COLLATE utf8mb4_unicode_ci COMMENT '数据对象序列化数据',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `seid` (`seid`),
  KEY `ccgeid` (`ccgeid`),
  KEY `action` (`action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据同步表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync`
--

LOCK TABLES `sync` WRITE;
/*!40000 ALTER TABLE `sync` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terminal_number`
--

DROP TABLE IF EXISTS `terminal_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terminal_number` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `mobile` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '终端话机号码',
  `call_type` tinyint(4) unsigned NOT NULL DEFAULT '5' COMMENT '呼叫限制 0-允许呼出 5-禁止呼出',
  `auto_answer` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '自动接听 0-否 1-是',
  `enable_headest` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '启用耳机 0-否 1-是',
  `auto_answer_tone` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '自动接听提示音 0-无 1-短促',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `seid_mobile` (`seid`,`mobile`),
  KEY `ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='终端话机号码表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terminal_number`
--

LOCK TABLES `terminal_number` WRITE;
/*!40000 ALTER TABLE `terminal_number` DISABLE KEYS */;
/*!40000 ALTER TABLE `terminal_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terminal_tel`
--

DROP TABLE IF EXISTS `terminal_tel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terminal_tel` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长ID',
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `seid_imei` (`seid`,`imei`),
  KEY `ccgeid` (`ccgeid`),
  KEY `mobile` (`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='终端话机表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terminal_tel`
--

LOCK TABLES `terminal_tel` WRITE;
/*!40000 ALTER TABLE `terminal_tel` DISABLE KEYS */;
/*!40000 ALTER TABLE `terminal_tel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业id',
  `username` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '姓名',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '头像',
  `last_login_time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最近登录时间',
  `last_login_ip` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '最近登录IP',
  `login_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '登录成功次数',
  `login_error_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '登录失败次数',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_users_username_unique` (`username`,`seid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表' dbpartition by hash(`username`) tbpartition by hash(`username`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,0,'admin','8927609862c3c764783422b148ce2c3d8eff8e8bdc2331ccee57675bc754444c','emicnet-tech@emicnet.com','','系统管理员','',0,'',0,0,0,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户配置表' ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_setting`
--

LOCK TABLES `user_setting` WRITE;
/*!40000 ALTER TABLE `user_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `week_work_time`
--

DROP TABLE IF EXISTS `week_work_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `week_work_time` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP COMMENT '自增长ID',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组ID',
  `week` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '周（1-7）',
  `work_status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '本日工作状态：0-不工作；1-工作',
  `work_time_range` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '08:00-18:00' COMMENT '工作时间段，可以允许多段工作时间',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '工作时间类型：0-企业工作时间 1-技能组工作时间',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `e_gid_week` (`seid`,`ccgeid`,`gid`,`week`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='周工作时间表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `week_work_time`
--

LOCK TABLES `week_work_time` WRITE;
/*!40000 ALTER TABLE `week_work_time` DISABLE KEYS */;
/*!40000 ALTER TABLE `week_work_time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `whitelist_of_incall`
--

DROP TABLE IF EXISTS `whitelist_of_incall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `whitelist_of_incall` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '号码',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '号码类型：0-完整号码 1-号码前缀',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`seid`,`ccgeid`,`number`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='呼入白名单表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `whitelist_of_incall`
--

LOCK TABLES `whitelist_of_incall` WRITE;
/*!40000 ALTER TABLE `whitelist_of_incall` DISABLE KEYS */;
/*!40000 ALTER TABLE `whitelist_of_incall` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `whitelist_of_outcall`
--

DROP TABLE IF EXISTS `whitelist_of_outcall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `whitelist_of_outcall` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT BY GROUP,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `number` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '号码',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '号码类型：0-完整号码 1-号码前缀',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`seid`,`ccgeid`,`number`),
  KEY `auto_shard_key_ccgeid` (`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='呼出白名单表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `whitelist_of_outcall`
--

LOCK TABLES `whitelist_of_outcall` WRITE;
/*!40000 ALTER TABLE `whitelist_of_outcall` DISABLE KEYS */;
/*!40000 ALTER TABLE `whitelist_of_outcall` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `async_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `async_task`  (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '外呼任务ID, task_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `slug` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '任务标识',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '任务状态：0-等待中 1-进行中 2-已完成',
  `type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '任务类型：0-导入 1-导出',
  `module` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所属模块',
  `condition` longtext COLLATE utf8mb4_unicode_ci COMMENT '导出查询条件',
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '存储路径',
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件原名',
  `file_extension` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '扩展名',
  `file_size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '大小,单位字节',
  `result_file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '结果文件存储路径',
  `start_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `creator_userid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建人用户ID',
  `creator_username` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建人用户名',
  `owner_userid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '归属人用户ID',
  `owner_username` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '归属人用户名',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `seid_ccgeid_slug` (`seid`,`ccgeid`,`slug`),
  KEY `slug`(`slug`),
  KEY `status`(`status`),
  KEY `type`(`type`),
  KEY `start_time`(`start_time`),
  KEY `end_time`(`end_time`),
  KEY `owner_userid`(`owner_userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT = '导入导出异步任务表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;

DROP TABLE IF EXISTS `batch_call_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_call_task`  (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '外呼任务ID, task_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0-未开始 1-进行中 2-暂停中 3-已完成',
  `preset_start_time` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '08:00' COMMENT '外呼时段开始时间',
  `preset_end_time` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '20:00' COMMENT '外呼时段结束时间',
  `preset_call_rate` float NOT NULL DEFAULT 0.8 COMMENT '外呼速率',
  `preset_connection_rate` float NOT NULL DEFAULT 0.8 COMMENT '预设接通率',
  `isset_switch_number` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否配置总机号码 0-否 1-是',
  `switch_number_mode` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '总机号码模式 0-本企业号码呼出 1-按号码归属地呼出 2-选择其他企业号码呼出',
  `switch_number_call_mode` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '总机号码呼叫模式 0-随机 1-按顺序',
  `switch_number_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '总机号码列表',
  `auto_answer` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否自动接听 0-否 1-是',
  `isset_pickup_voice` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否配置接听语音 0-否 1-是',
  `pickup_voice_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '接听语音文件ID',
  `pickup_voice_source` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '接听语音来源 0-系统生成 1-上传自制',
  `pickup_voice_content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '接听语音文本内容',
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
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `seid_ccgeid_task_name` (`seid`,`ccgeid`,`task_name`),
  KEY `status`(`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT = '批量外呼任务表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;

DROP TABLE IF EXISTS `batch_call_task_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_call_task_job`  (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '外呼批次ID, job_id',
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '外呼任务ID',
  `job_name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '批次名称',
  `customer_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户号码总数',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id_job_name` (`task_id`,`job_name`),
  KEY `seid`(`seid`),
  KEY `ccgeid`(`ccgeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT = '批量外呼任务批次表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;


DROP TABLE IF EXISTS `batch_call_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_call_customer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '任务ID',
  `job_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '批次ID',
  `cm_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '客户名称',
  `cm_mobile` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '客户号码',
  `cm_slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '客户标识',
  `is_called` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '联系结果，0-未联系，1-已联系',
  `cm_result_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '客户处理结果ID',
  `cm_result` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '客户处理结果',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id_job_id_cm_mobile`(`task_id`,`job_id`,`cm_mobile`),
  KEY `seid`(`seid`),
  KEY `ccgeid`(`ccgeid`),
  KEY `job_id`(`job_id`),
  KEY `is_called`(`is_called`),
  KEY `cm_result_id`(`cm_result_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT = '批量外呼客户号码表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;

DROP TABLE IF EXISTS `batch_call_seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_call_seat`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `seid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID',
  `ccgeid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID',
  `task_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '任务id',
  `gid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '技能组gid',
  `uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户uid',
  `created_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`seid`,`ccgeid`),
  UNIQUE KEY `task_id_gid_uid`(`task_id`,`gid`,`uid`),
  KEY `seid`(`seid`),
  KEY `ccgeid`(`ccgeid`),
  KEY `task_id`(`task_id`),
  KEY `gid`(`gid`),
  KEY `uid`(`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT = '批量外呼坐席表' dbpartition by hash(`seid`) tbpartition by hash(`ccgeid`) tbpartitions 128;

--
-- Dumping events for database 'emicall_cc_man'
--

--
-- Dumping routines for database 'emicall_cc_man'
--
/*!50003 DROP PROCEDURE IF EXISTS `nextSeqValue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`xvhbygva0`@`%`*/ /*!50003 PROCEDURE `nextSeqValue`(
    IN  seqName VARCHAR(128),
    IN  size    INT UNSIGNED,
    IN  maxVal  BIGINT UNSIGNED,
    IN  cycle   TINYINT UNSIGNED,
    OUT newVal  BIGINT UNSIGNED)
    MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE mysqlError  INT     DEFAULT 0;
    DECLARE mySqlState  INT     DEFAULT 0;
    DECLARE errorMsg    TEXT    DEFAULT 'N/A';

    DECLARE hasError    TINYINT DEFAULT 0;
    DECLARE rowsChanged TINYINT DEFAULT 0;
    DECLARE retry       TINYINT DEFAULT 1;

    DECLARE out_of_range CONDITION FOR 1690;
    DECLARE CONTINUE HANDLER FOR out_of_range
    BEGIN
        SET mysqlError = 1690;
        SET mySqlState = 22003;
        SET errorMsg   = 'Out of range: Attempting to update a value that exceeds maximum value allowed.';

        SET hasError = 1;
        IF cycle = 0 THEN
            SET retry = 0;
        END IF;
    END;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET mysqlError = -1;
        SET mySqlState = -1;
        SET errorMsg   = 'Hit some error when executing SQL statement.';

        SET hasError = 1;
        SET retry = 0;
    END;

    IF size <= 0 THEN
        SET size = 1;
    END IF;

    START TRANSACTION;

    UPDATE sequence_opt
    SET value = LAST_INSERT_ID(value + increment_by * (size - 1)) + increment_by, gmt_modified = NOW()
    WHERE name = seqName;

    error_handler: LOOP

        IF hasError = 0 THEN
            SELECT ROW_COUNT() INTO rowsChanged;

            IF rowsChanged = 0 THEN
                SET mysqlError = 0;
                SET mySqlState = 0;
                SET errorMsg   = concat('Not Changed: Sequence ', seqName, ' was not initialized or updated for some reason.');
                SET newval = 0;
                ROLLBACK;
                LEAVE error_handler;
            ELSE
                SELECT LAST_INSERT_ID() INTO newVal;

                IF newVal > maxVal THEN
                    IF cycle = 0 OR retry = 0 THEN
                        SET hasError   = 1;
                        SET mysqlError = 1690;
                        SET mySqlState = 22003;
                        SET errorMsg   = concat('Out of Range: Attempting to generate sequence value ', newVal, ' that exceeds the maximum value ', maxVal, ' allowed.');
                        SET newVal     = 0;
                        ROLLBACK;
                        LEAVE error_handler;
                    END IF;
                ELSE
                    COMMIT;
                    LEAVE error_handler;
                END IF;
            END IF;
        ELSE
            IF retry = 0 THEN
                SET newval = 0;
                ROLLBACK;
                LEAVE error_handler;
            ELSE
                SET hasError   = 0;
                SET mysqlError = 0;
                SET mySqlState = 0;
                SET errorMsg   = 'N/A';
            END IF;
        END IF;

        IF retry = 1 THEN
            UPDATE sequence_opt
            SET value = LAST_INSERT_ID(start_with + increment_by * (size - 1)) + increment_by, gmt_modified = NOW()
            WHERE name = seqName;

            SET retry = 0;

            ITERATE error_handler;
        END IF;

    END LOOP error_handler;

    SELECT mysqlError as 'MySQL Error', mySqlState as 'SQLSTATE', errorMsg as 'Error Message';
END */;;
DELIMITER ;

INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('cc_man_db_version', '1199', '数据库版本') ON DUPLICATE KEY UPDATE `value`=VALUES(`value`);

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

-- Dump completed on 2018-09-05 17:34:41
