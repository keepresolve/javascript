USE `emicall_cc_running`;

/*1*/
#CM_CR_Version_v1.0-RC3 

call emicall_cc_running.func_handle_column('emicall_cc_running','cc_talk_batch_call_task','add','task_duration','int(10) unsigned NOT NULL DEFAULT \'0\'','COMMENT \'任务执行时长\' after last_end_time');
/*3256*/

call emicall_cc_running.func_handle_index('emicall_cc_running','cc_talk_api_push_data','add','index','api_push_status','api_push_status');

alter table cc_talk_called_statistics remove partitioning; call emicall_cc_running.func_handle_change('emicall_cc_running','cc_talk_called_statistics','id','id','bigint(20) unsigned','default 0'); alter table cc_talk_called_statistics drop primary key; alter table cc_talk_called_statistics add PRIMARY KEY (id,seid,ccgeid); call emicall_cc_running.func_handle_change('emicall_cc_running','cc_talk_called_statistics','id','id','bigint(20) unsigned NOT NULL','AUTO_INCREMENT COMMENT \'\''); alter table cc_talk_called_statistics  partition BY KEY (seid,ccgeid) PARTITIONS 128;
/*3491*/

call emicall_cc_running.func_handle_column('emicall_cc_running','cc_talk_terminal_number','add','is_bind_seat','tinyint(4) unsigned NOT NULL DEFAULT \'0\'','COMMENT \'是否绑定坐席 0-否 1-是\'');
call emicall_cc_running.func_handle_column('emicall_cc_running','cc_talk_terminal_number','add','is_bind_imei','tinyint(4) unsigned NOT NULL DEFAULT \'0\'','COMMENT \'是否绑定IMEI 0-否 1-是\'');
call emicall_cc_running.func_handle_column('emicall_cc_running','cc_talk_sip_number','add','is_bind_seat','tinyint(4) unsigned NOT NULL DEFAULT \'0\'','COMMENT \'是否绑定坐席 0-否 1-是\'');
/*3871*/

call emicall_cc_running.func_handle_column('emicall_cc_running','cc_talk_call_detail','add','gid_name','varchar(50) NOT NULL DEFAULT \'\'','COMMENT \'技能组名称\' after gid');
call emicall_cc_running.func_handle_column('emicall_cc_running','cc_talk_call_detail','add','work_number','varchar(63) NOT NULL DEFAULT \'\'','COMMENT \'工号\' after number');
call emicall_cc_running.func_handle_column('emicall_cc_running','cc_talk_call_detail','add','display_name','varchar(127) NOT NULL DEFAULT \'\'','COMMENT \'坐席名称\' after number');
call emicall_cc_running.func_handle_index('emicall_cc_running','cc_talk_enterprise_user_c_state_record','add','index','status_update','upload_status,update_time');
call emicall_cc_running.func_handle_index('emicall_cc_running','cc_talk_call_record','drop','index','duration','duration');
call emicall_cc_running.func_handle_index('emicall_cc_running','cc_talk_call_record','drop','index','stop_reason','stop_reason');
call emicall_cc_running.func_handle_index('emicall_cc_running','cc_talk_call_record','add','index','upload_status','upload_status');
/*4064*/

call emicall_cc_running.func_handle_index('emicall_cc_running','cc_talk_concurrent_statistics','add','index','upload_status','upload_status');
call emicall_cc_running.func_handle_column('emicall_cc_running','cc_talk_ivr_flow_variable','add','ivr_version','int(11) NOT NULL DEFAULT 0','COMMENT \'ivr版本号\' after default_value');
call emicall_cc_running.func_handle_column('emicall_cc_running','cc_talk_ivr_node_set_variable','add','ivr_version','int(11) NOT NULL DEFAULT 0','COMMENT \'ivr版本号\' after value');

DELIMITER //
DROP TABLE IF EXISTS cc_talk_enterprise_ivr_node_change// CREATE TABLE IF NOT EXISTS cc_talk_enterprise_ivr_node_change ( id bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增长Id', seid bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '超级企业ID', ccgeid bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '企业ID', ivr_flow_id bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr流程Id', ivr_node_id bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr节点Id', ivr_version int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ivr版本号', ivr_node_name varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ivr节点名称', ivr_node_slug varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ivr节点唯一标识', ivr_node_type smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '节点类型', create_time timestamp NULL DEFAULT NULL COMMENT '创建时间', update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间', PRIMARY KEY (id,ccgeid), UNIQUE KEY ivr_flow_node(seid, ccgeid, ivr_flow_id, ivr_node_name, ivr_version), UNIQUE KEY ivr_flow_node_slug(seid, ccgeid, ivr_flow_id, ivr_node_slug, ivr_version), KEY ivr_version (ivr_version)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='IVR节点表' PARTITION BY HASH (ccgeid)PARTITIONS 128// insert ignore into cc_talk_enterprise_ivr_node_change(id,seid,ccgeid,ivr_flow_id,ivr_node_id,ivr_version,ivr_node_name,ivr_node_slug,ivr_node_type,create_time,update_time) select id,seid,ccgeid,ivr_flow_id,ivr_node_id,ivr_version,ivr_node_name,ivr_node_slug,ivr_node_type,create_time,update_time from cc_talk_enterprise_ivr_node order by id// alter table cc_talk_enterprise_ivr_node rename cc_talk_enterprise_ivr_node_change1// alter table cc_talk_enterprise_ivr_node_change rename cc_talk_enterprise_ivr_node// DROP TABLE IF EXISTS cc_talk_enterprise_ivr_node_change1// 
DELIMITER ;
/*4577*/

DELIMITER //
call emicall_cc_running.func_handle_column('emicall_cc_running','cc_talk_call_detail','drop','gid_name','varchar(50)','');
call emicall_cc_running.func_handle_column('emicall_cc_running','cc_talk_call_detail','drop','work_number','varchar(63)','');
call emicall_cc_running.func_handle_column('emicall_cc_running','cc_talk_call_detail','drop','display_name','varchar(127)','');
DELIMITER ;
/*4678*/
