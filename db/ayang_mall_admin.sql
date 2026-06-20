/*==============================================================*/
/* 创建数据库：后台管理服务数据库                                  */
/*==============================================================*/
CREATE DATABASE IF NOT EXISTS `ayang_mall_admin`
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci;

USE `ayang_mall_admin`;


/*==============================================================*/
/* 关闭外键检查，避免 Quartz 表之间存在外键导致删除失败              */
/*==============================================================*/
SET FOREIGN_KEY_CHECKS = 0;


/*==============================================================*/
/* 删除旧表，避免重复创建报错                                      */
/*==============================================================*/
DROP TABLE IF EXISTS `sys_menu`;
DROP TABLE IF EXISTS `sys_user`;
DROP TABLE IF EXISTS `sys_user_token`;
DROP TABLE IF EXISTS `sys_captcha`;
DROP TABLE IF EXISTS `sys_role`;
DROP TABLE IF EXISTS `sys_user_role`;
DROP TABLE IF EXISTS `sys_role_menu`;
DROP TABLE IF EXISTS `sys_config`;
DROP TABLE IF EXISTS `sys_log`;
DROP TABLE IF EXISTS `sys_oss`;
DROP TABLE IF EXISTS `schedule_job`;
DROP TABLE IF EXISTS `schedule_job_log`;
DROP TABLE IF EXISTS `tb_user`;

DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;


/*==============================================================*/
/* 重新开启外键检查                                                */
/*==============================================================*/
SET FOREIGN_KEY_CHECKS = 1;


/*==============================================================*/
/* Table: sys_menu                                                */
/* 表说明：菜单管理                                                */
/*==============================================================*/
CREATE TABLE `sys_menu` (
                            `menu_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
                            `parent_id` BIGINT COMMENT '父菜单ID，一级菜单为0',
                            `name` VARCHAR(50) COMMENT '菜单名称',
                            `url` VARCHAR(200) COMMENT '菜单URL',
                            `perms` VARCHAR(500) COMMENT '授权标识，多个用逗号分隔，如：user:list,user:create',
                            `type` INT COMMENT '类型：0-目录，1-菜单，2-按钮',
                            `icon` VARCHAR(50) COMMENT '菜单图标',
                            `order_num` INT COMMENT '排序',
                            PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='菜单管理';


/*==============================================================*/
/* Table: sys_user                                                */
/* 表说明：系统用户                                                */
/*==============================================================*/
CREATE TABLE `sys_user` (
                            `user_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '用户ID',
                            `username` VARCHAR(50) NOT NULL COMMENT '用户名',
                            `password` VARCHAR(100) COMMENT '密码',
                            `salt` VARCHAR(20) COMMENT '盐',
                            `email` VARCHAR(100) COMMENT '邮箱',
                            `mobile` VARCHAR(100) COMMENT '手机号',
                            `status` TINYINT COMMENT '状态：0-禁用，1-正常',
                            `create_user_id` BIGINT(20) COMMENT '创建者ID',
                            `create_time` DATETIME COMMENT '创建时间',
                            PRIMARY KEY (`user_id`),
                            UNIQUE INDEX `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统用户';


/*==============================================================*/
/* Table: sys_user_token                                          */
/* 表说明：系统用户Token                                           */
/*==============================================================*/
CREATE TABLE `sys_user_token` (
                                  `user_id` BIGINT(20) NOT NULL COMMENT '用户ID',
                                  `token` VARCHAR(100) NOT NULL COMMENT 'token',
                                  `expire_time` DATETIME DEFAULT NULL COMMENT '过期时间',
                                  `update_time` DATETIME DEFAULT NULL COMMENT '更新时间',
                                  PRIMARY KEY (`user_id`),
                                  UNIQUE KEY `uk_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统用户Token';


/*==============================================================*/
/* Table: sys_captcha                                             */
/* 表说明：系统验证码                                               */
/*==============================================================*/
CREATE TABLE `sys_captcha` (
                               `uuid` CHAR(36) NOT NULL COMMENT 'uuid',
                               `code` VARCHAR(6) NOT NULL COMMENT '验证码',
                               `expire_time` DATETIME DEFAULT NULL COMMENT '过期时间',
                               PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统验证码';


/*==============================================================*/
/* Table: sys_role                                                */
/* 表说明：角色                                                    */
/*==============================================================*/
CREATE TABLE `sys_role` (
                            `role_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '角色ID',
                            `role_name` VARCHAR(100) COMMENT '角色名称',
                            `remark` VARCHAR(100) COMMENT '备注',
                            `create_user_id` BIGINT(20) COMMENT '创建者ID',
                            `create_time` DATETIME COMMENT '创建时间',
                            PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色';


/*==============================================================*/
/* Table: sys_user_role                                           */
/* 表说明：用户与角色对应关系                                       */
/*==============================================================*/
CREATE TABLE `sys_user_role` (
                                 `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                                 `user_id` BIGINT COMMENT '用户ID',
                                 `role_id` BIGINT COMMENT '角色ID',
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户与角色对应关系';


/*==============================================================*/
/* Table: sys_role_menu                                           */
/* 表说明：角色与菜单对应关系                                       */
/*==============================================================*/
CREATE TABLE `sys_role_menu` (
                                 `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                                 `role_id` BIGINT COMMENT '角色ID',
                                 `menu_id` BIGINT COMMENT '菜单ID',
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色与菜单对应关系';


/*==============================================================*/
/* Table: sys_config                                              */
/* 表说明：系统配置信息表                                           */
/*==============================================================*/
CREATE TABLE `sys_config` (
                              `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '配置ID',
                              `param_key` VARCHAR(50) COMMENT '配置key',
                              `param_value` VARCHAR(2000) COMMENT '配置value',
                              `status` TINYINT DEFAULT 1 COMMENT '状态：0-隐藏，1-显示',
                              `remark` VARCHAR(500) COMMENT '备注',
                              PRIMARY KEY (`id`),
                              UNIQUE INDEX `uk_param_key` (`param_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统配置信息表';


/*==============================================================*/
/* Table: sys_log                                                 */
/* 表说明：系统日志                                                */
/*==============================================================*/
CREATE TABLE `sys_log` (
                           `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
                           `username` VARCHAR(50) COMMENT '用户名',
                           `operation` VARCHAR(50) COMMENT '用户操作',
                           `method` VARCHAR(200) COMMENT '请求方法',
                           `params` VARCHAR(5000) COMMENT '请求参数',
                           `time` BIGINT NOT NULL COMMENT '执行时长，单位：毫秒',
                           `ip` VARCHAR(64) COMMENT 'IP地址',
                           `create_date` DATETIME COMMENT '创建时间',
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统日志';


/*==============================================================*/
/* Table: sys_oss                                                 */
/* 表说明：文件上传                                                */
/*==============================================================*/
CREATE TABLE `sys_oss` (
                           `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '文件ID',
                           `url` VARCHAR(200) COMMENT 'URL地址',
                           `create_date` DATETIME COMMENT '创建时间',
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文件上传';


/*==============================================================*/
/* Table: schedule_job                                            */
/* 表说明：定时任务                                                */
/*==============================================================*/
CREATE TABLE `schedule_job` (
                                `job_id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
                                `bean_name` VARCHAR(200) DEFAULT NULL COMMENT 'spring bean名称',
                                `params` VARCHAR(2000) DEFAULT NULL COMMENT '参数',
                                `cron_expression` VARCHAR(100) DEFAULT NULL COMMENT 'cron表达式',
                                `status` TINYINT(4) DEFAULT NULL COMMENT '任务状态：0-正常，1-暂停',
                                `remark` VARCHAR(255) DEFAULT NULL COMMENT '备注',
                                `create_time` DATETIME DEFAULT NULL COMMENT '创建时间',
                                PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='定时任务';


/*==============================================================*/
/* Table: schedule_job_log                                        */
/* 表说明：定时任务日志                                             */
/*==============================================================*/
CREATE TABLE `schedule_job_log` (
                                    `log_id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
                                    `job_id` BIGINT(20) NOT NULL COMMENT '任务id',
                                    `bean_name` VARCHAR(200) DEFAULT NULL COMMENT 'spring bean名称',
                                    `params` VARCHAR(2000) DEFAULT NULL COMMENT '参数',
                                    `status` TINYINT(4) NOT NULL COMMENT '任务状态：0-成功，1-失败',
                                    `error` VARCHAR(2000) DEFAULT NULL COMMENT '失败信息',
                                    `times` INT(11) NOT NULL COMMENT '耗时，单位：毫秒',
                                    `create_time` DATETIME DEFAULT NULL COMMENT '创建时间',
                                    PRIMARY KEY (`log_id`),
                                    KEY `idx_job_id` (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='定时任务日志';


/*==============================================================*/
/* Table: tb_user                                                 */
/* 表说明：用户                                                    */
/*==============================================================*/
CREATE TABLE `tb_user` (
                           `user_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '用户ID',
                           `username` VARCHAR(50) NOT NULL COMMENT '用户名',
                           `mobile` VARCHAR(20) NOT NULL COMMENT '手机号',
                           `password` VARCHAR(64) COMMENT '密码',
                           `create_time` DATETIME COMMENT '创建时间',
                           PRIMARY KEY (`user_id`),
                           UNIQUE INDEX `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户';


/*==============================================================*/
/* 初始化数据：系统管理员                                           */
/*==============================================================*/
INSERT INTO `sys_user`
(`user_id`, `username`, `password`, `salt`, `email`, `mobile`, `status`, `create_user_id`, `create_time`)
VALUES
    (1, 'admin', '9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d', 'YzcmCZNvbXocrsz9dm8e', 'root@renren.io', '13612345678', 1, 1, '2016-11-11 11:11:11');


/*==============================================================*/
/* 初始化数据：系统菜单                                             */
/*==============================================================*/
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (1, 0, '系统管理', NULL, NULL, 0, 'system', 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (2, 1, '管理员列表', 'sys/user', NULL, 1, 'admin', 1);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (3, 1, '角色管理', 'sys/role', NULL, 1, 'role', 2);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (4, 1, '菜单管理', 'sys/menu', NULL, 1, 'menu', 3);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (5, 1, 'SQL监控', 'http://localhost:8080/renren-fast/druid/sql.html', NULL, 1, 'sql', 4);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (6, 1, '定时任务', 'job/schedule', NULL, 1, 'job', 5);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (7, 6, '查看', NULL, 'sys:schedule:list,sys:schedule:info', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (8, 6, '新增', NULL, 'sys:schedule:save', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (9, 6, '修改', NULL, 'sys:schedule:update', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (10, 6, '删除', NULL, 'sys:schedule:delete', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (11, 6, '暂停', NULL, 'sys:schedule:pause', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (12, 6, '恢复', NULL, 'sys:schedule:resume', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (13, 6, '立即执行', NULL, 'sys:schedule:run', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (14, 6, '日志列表', NULL, 'sys:schedule:log', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (15, 2, '查看', NULL, 'sys:user:list,sys:user:info', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (16, 2, '新增', NULL, 'sys:user:save,sys:role:select', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (17, 2, '修改', NULL, 'sys:user:update,sys:role:select', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (18, 2, '删除', NULL, 'sys:user:delete', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (19, 3, '查看', NULL, 'sys:role:list,sys:role:info', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (20, 3, '新增', NULL, 'sys:role:save,sys:menu:list', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (21, 3, '修改', NULL, 'sys:role:update,sys:menu:list', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (22, 3, '删除', NULL, 'sys:role:delete', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (23, 4, '查看', NULL, 'sys:menu:list,sys:menu:info', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (24, 4, '新增', NULL, 'sys:menu:save,sys:menu:select', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (25, 4, '修改', NULL, 'sys:menu:update,sys:menu:select', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (26, 4, '删除', NULL, 'sys:menu:delete', 2, NULL, 0);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (27, 1, '参数管理', 'sys/config', 'sys:config:list,sys:config:info,sys:config:save,sys:config:update,sys:config:delete', 1, 'config', 6);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (29, 1, '系统日志', 'sys/log', 'sys:log:list', 1, 'log', 7);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (30, 1, '文件上传', 'oss/oss', 'sys:oss:all', 1, 'oss', 6);


/*==============================================================*/
/* 初始化数据：系统配置                                             */
/*==============================================================*/
INSERT INTO `sys_config`
(`param_key`, `param_value`, `status`, `remark`)
VALUES
    (
        'CLOUD_STORAGE_CONFIG_KEY',
        '{"aliyunAccessKeyId":"","aliyunAccessKeySecret":"","aliyunBucketName":"","aliyunDomain":"","aliyunEndPoint":"","aliyunPrefix":"","qcloudBucketName":"","qcloudDomain":"","qcloudPrefix":"","qcloudSecretId":"","qcloudSecretKey":"","qiniuAccessKey":"","qiniuBucketName":"","qiniuDomain":"","qiniuPrefix":"","qiniuSecretKey":"","type":1}',
        0,
        '云存储配置信息'
    );


/*==============================================================*/
/* 初始化数据：定时任务                                             */
/*==============================================================*/
INSERT INTO `schedule_job`
(`bean_name`, `params`, `cron_expression`, `status`, `remark`, `create_time`)
VALUES
    ('testTask', 'renren', '0 0/30 * * * ?', 0, '参数测试', NOW());


/*==============================================================*/
/* 初始化数据：普通用户                                             */
/* 账号：13612345678                                               */
/* 密码：admin                                                      */
/*==============================================================*/
INSERT INTO `tb_user`
(`username`, `mobile`, `password`, `create_time`)
VALUES
    ('mark', '13612345678', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '2017-03-23 22:37:41');


/*==============================================================*/
/* Quartz 自带表结构                                               */
/*==============================================================*/

/*==============================================================*/
/* Table: QRTZ_JOB_DETAILS                                        */
/* 表说明：Quartz 任务详情表                                       */
/*==============================================================*/
CREATE TABLE `QRTZ_JOB_DETAILS` (
                                    `SCHED_NAME` VARCHAR(120) NOT NULL COMMENT '调度器名称',
                                    `JOB_NAME` VARCHAR(200) NOT NULL COMMENT '任务名称',
                                    `JOB_GROUP` VARCHAR(200) NOT NULL COMMENT '任务分组',
                                    `DESCRIPTION` VARCHAR(250) NULL COMMENT '任务描述',
                                    `JOB_CLASS_NAME` VARCHAR(250) NOT NULL COMMENT '任务执行类',
                                    `IS_DURABLE` VARCHAR(1) NOT NULL COMMENT '是否持久化',
                                    `IS_NONCONCURRENT` VARCHAR(1) NOT NULL COMMENT '是否禁止并发执行',
                                    `IS_UPDATE_DATA` VARCHAR(1) NOT NULL COMMENT '是否更新数据',
                                    `REQUESTS_RECOVERY` VARCHAR(1) NOT NULL COMMENT '是否请求恢复',
                                    `JOB_DATA` BLOB NULL COMMENT '任务数据',
                                    PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Quartz任务详情表';


/*==============================================================*/
/* Table: QRTZ_TRIGGERS                                           */
/* 表说明：Quartz 触发器表                                         */
/*==============================================================*/
CREATE TABLE `QRTZ_TRIGGERS` (
                                 `SCHED_NAME` VARCHAR(120) NOT NULL COMMENT '调度器名称',
                                 `TRIGGER_NAME` VARCHAR(200) NOT NULL COMMENT '触发器名称',
                                 `TRIGGER_GROUP` VARCHAR(200) NOT NULL COMMENT '触发器分组',
                                 `JOB_NAME` VARCHAR(200) NOT NULL COMMENT '任务名称',
                                 `JOB_GROUP` VARCHAR(200) NOT NULL COMMENT '任务分组',
                                 `DESCRIPTION` VARCHAR(250) NULL COMMENT '触发器描述',
                                 `NEXT_FIRE_TIME` BIGINT(13) NULL COMMENT '下次触发时间',
                                 `PREV_FIRE_TIME` BIGINT(13) NULL COMMENT '上次触发时间',
                                 `PRIORITY` INTEGER NULL COMMENT '优先级',
                                 `TRIGGER_STATE` VARCHAR(16) NOT NULL COMMENT '触发器状态',
                                 `TRIGGER_TYPE` VARCHAR(8) NOT NULL COMMENT '触发器类型',
                                 `START_TIME` BIGINT(13) NOT NULL COMMENT '开始时间',
                                 `END_TIME` BIGINT(13) NULL COMMENT '结束时间',
                                 `CALENDAR_NAME` VARCHAR(200) NULL COMMENT '日历名称',
                                 `MISFIRE_INSTR` SMALLINT(2) NULL COMMENT '错过触发策略',
                                 `JOB_DATA` BLOB NULL COMMENT '任务数据',
                                 PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`),
                                 FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
                                     REFERENCES `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Quartz触发器表';


/*==============================================================*/
/* Table: QRTZ_SIMPLE_TRIGGERS                                    */
/* 表说明：Quartz 简单触发器表                                     */
/*==============================================================*/
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
                                        `SCHED_NAME` VARCHAR(120) NOT NULL COMMENT '调度器名称',
                                        `TRIGGER_NAME` VARCHAR(200) NOT NULL COMMENT '触发器名称',
                                        `TRIGGER_GROUP` VARCHAR(200) NOT NULL COMMENT '触发器分组',
                                        `REPEAT_COUNT` BIGINT(7) NOT NULL COMMENT '重复次数',
                                        `REPEAT_INTERVAL` BIGINT(12) NOT NULL COMMENT '重复间隔',
                                        `TIMES_TRIGGERED` BIGINT(10) NOT NULL COMMENT '已触发次数',
                                        PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`),
                                        FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
                                            REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Quartz简单触发器表';


/*==============================================================*/
/* Table: QRTZ_CRON_TRIGGERS                                      */
/* 表说明：Quartz Cron触发器表                                     */
/*==============================================================*/
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
                                      `SCHED_NAME` VARCHAR(120) NOT NULL COMMENT '调度器名称',
                                      `TRIGGER_NAME` VARCHAR(200) NOT NULL COMMENT '触发器名称',
                                      `TRIGGER_GROUP` VARCHAR(200) NOT NULL COMMENT '触发器分组',
                                      `CRON_EXPRESSION` VARCHAR(120) NOT NULL COMMENT 'Cron表达式',
                                      `TIME_ZONE_ID` VARCHAR(80) COMMENT '时区ID',
                                      PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`),
                                      FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
                                          REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Quartz Cron触发器表';


/*==============================================================*/
/* Table: QRTZ_SIMPROP_TRIGGERS                                   */
/* 表说明：Quartz 属性触发器表                                      */
/*==============================================================*/
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
                                         `SCHED_NAME` VARCHAR(120) NOT NULL COMMENT '调度器名称',
                                         `TRIGGER_NAME` VARCHAR(200) NOT NULL COMMENT '触发器名称',
                                         `TRIGGER_GROUP` VARCHAR(200) NOT NULL COMMENT '触发器分组',
                                         `STR_PROP_1` VARCHAR(512) NULL COMMENT '字符串属性1',
                                         `STR_PROP_2` VARCHAR(512) NULL COMMENT '字符串属性2',
                                         `STR_PROP_3` VARCHAR(512) NULL COMMENT '字符串属性3',
                                         `INT_PROP_1` INT NULL COMMENT '整型属性1',
                                         `INT_PROP_2` INT NULL COMMENT '整型属性2',
                                         `LONG_PROP_1` BIGINT NULL COMMENT '长整型属性1',
                                         `LONG_PROP_2` BIGINT NULL COMMENT '长整型属性2',
                                         `DEC_PROP_1` NUMERIC(13,4) NULL COMMENT '数值属性1',
                                         `DEC_PROP_2` NUMERIC(13,4) NULL COMMENT '数值属性2',
                                         `BOOL_PROP_1` VARCHAR(1) NULL COMMENT '布尔属性1',
                                         `BOOL_PROP_2` VARCHAR(1) NULL COMMENT '布尔属性2',
                                         PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`),
                                         FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
                                             REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Quartz属性触发器表';


/*==============================================================*/
/* Table: QRTZ_BLOB_TRIGGERS                                      */
/* 表说明：Quartz Blob触发器表                                     */
/*==============================================================*/
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
                                      `SCHED_NAME` VARCHAR(120) NOT NULL COMMENT '调度器名称',
                                      `TRIGGER_NAME` VARCHAR(200) NOT NULL COMMENT '触发器名称',
                                      `TRIGGER_GROUP` VARCHAR(200) NOT NULL COMMENT '触发器分组',
                                      `BLOB_DATA` BLOB NULL COMMENT 'Blob数据',
                                      PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`),
                                      INDEX `idx_blob_trigger` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`),
                                      FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
                                          REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Quartz Blob触发器表';


/*==============================================================*/
/* Table: QRTZ_CALENDARS                                          */
/* 表说明：Quartz 日历表                                           */
/*==============================================================*/
CREATE TABLE `QRTZ_CALENDARS` (
                                  `SCHED_NAME` VARCHAR(120) NOT NULL COMMENT '调度器名称',
                                  `CALENDAR_NAME` VARCHAR(200) NOT NULL COMMENT '日历名称',
                                  `CALENDAR` BLOB NOT NULL COMMENT '日历数据',
                                  PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Quartz日历表';


/*==============================================================*/
/* Table: QRTZ_PAUSED_TRIGGER_GRPS                                */
/* 表说明：Quartz 暂停触发器分组表                                  */
/*==============================================================*/
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
                                            `SCHED_NAME` VARCHAR(120) NOT NULL COMMENT '调度器名称',
                                            `TRIGGER_GROUP` VARCHAR(200) NOT NULL COMMENT '触发器分组',
                                            PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Quartz暂停触发器分组表';


/*==============================================================*/
/* Table: QRTZ_FIRED_TRIGGERS                                     */
/* 表说明：Quartz 已触发触发器表                                    */
/*==============================================================*/
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
                                       `SCHED_NAME` VARCHAR(120) NOT NULL COMMENT '调度器名称',
                                       `ENTRY_ID` VARCHAR(95) NOT NULL COMMENT '实例ID',
                                       `TRIGGER_NAME` VARCHAR(200) NOT NULL COMMENT '触发器名称',
                                       `TRIGGER_GROUP` VARCHAR(200) NOT NULL COMMENT '触发器分组',
                                       `INSTANCE_NAME` VARCHAR(200) NOT NULL COMMENT '实例名称',
                                       `FIRED_TIME` BIGINT(13) NOT NULL COMMENT '触发时间',
                                       `SCHED_TIME` BIGINT(13) NOT NULL COMMENT '计划触发时间',
                                       `PRIORITY` INTEGER NOT NULL COMMENT '优先级',
                                       `STATE` VARCHAR(16) NOT NULL COMMENT '状态',
                                       `JOB_NAME` VARCHAR(200) NULL COMMENT '任务名称',
                                       `JOB_GROUP` VARCHAR(200) NULL COMMENT '任务分组',
                                       `IS_NONCONCURRENT` VARCHAR(1) NULL COMMENT '是否禁止并发执行',
                                       `REQUESTS_RECOVERY` VARCHAR(1) NULL COMMENT '是否请求恢复',
                                       PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Quartz已触发触发器表';


/*==============================================================*/
/* Table: QRTZ_SCHEDULER_STATE                                    */
/* 表说明：Quartz 调度器状态表                                      */
/*==============================================================*/
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
                                        `SCHED_NAME` VARCHAR(120) NOT NULL COMMENT '调度器名称',
                                        `INSTANCE_NAME` VARCHAR(200) NOT NULL COMMENT '实例名称',
                                        `LAST_CHECKIN_TIME` BIGINT(13) NOT NULL COMMENT '上次检查时间',
                                        `CHECKIN_INTERVAL` BIGINT(13) NOT NULL COMMENT '检查间隔',
                                        PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Quartz调度器状态表';


/*==============================================================*/
/* Table: QRTZ_LOCKS                                              */
/* 表说明：Quartz 锁表                                             */
/*==============================================================*/
CREATE TABLE `QRTZ_LOCKS` (
                              `SCHED_NAME` VARCHAR(120) NOT NULL COMMENT '调度器名称',
                              `LOCK_NAME` VARCHAR(40) NOT NULL COMMENT '锁名称',
                              PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Quartz锁表';


/*==============================================================*/
/* Quartz 索引                                                     */
/*==============================================================*/
CREATE INDEX `IDX_QRTZ_J_REQ_RECOVERY` ON `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `REQUESTS_RECOVERY`);
CREATE INDEX `IDX_QRTZ_J_GRP` ON `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_GROUP`);

CREATE INDEX `IDX_QRTZ_T_J` ON `QRTZ_TRIGGERS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`);
CREATE INDEX `IDX_QRTZ_T_JG` ON `QRTZ_TRIGGERS` (`SCHED_NAME`, `JOB_GROUP`);
CREATE INDEX `IDX_QRTZ_T_C` ON `QRTZ_TRIGGERS` (`SCHED_NAME`, `CALENDAR_NAME`);
CREATE INDEX `IDX_QRTZ_T_G` ON `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_GROUP`);
CREATE INDEX `IDX_QRTZ_T_STATE` ON `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_STATE`);
CREATE INDEX `IDX_QRTZ_T_N_STATE` ON `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`);
CREATE INDEX `IDX_QRTZ_T_N_G_STATE` ON `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`);
CREATE INDEX `IDX_QRTZ_T_NEXT_FIRE_TIME` ON `QRTZ_TRIGGERS` (`SCHED_NAME`, `NEXT_FIRE_TIME`);
CREATE INDEX `IDX_QRTZ_T_NFT_ST` ON `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_STATE`, `NEXT_FIRE_TIME`);
CREATE INDEX `IDX_QRTZ_T_NFT_MISFIRE` ON `QRTZ_TRIGGERS` (`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`);
CREATE INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE` ON `QRTZ_TRIGGERS` (`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_STATE`);
CREATE INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` ON `QRTZ_TRIGGERS` (`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_GROUP`, `TRIGGER_STATE`);

CREATE INDEX `IDX_QRTZ_FT_TRIG_INST_NAME` ON `QRTZ_FIRED_TRIGGERS` (`SCHED_NAME`, `INSTANCE_NAME`);
CREATE INDEX `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` ON `QRTZ_FIRED_TRIGGERS` (`SCHED_NAME`, `INSTANCE_NAME`, `REQUESTS_RECOVERY`);
CREATE INDEX `IDX_QRTZ_FT_J_G` ON `QRTZ_FIRED_TRIGGERS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`);
CREATE INDEX `IDX_QRTZ_FT_JG` ON `QRTZ_FIRED_TRIGGERS` (`SCHED_NAME`, `JOB_GROUP`);
CREATE INDEX `IDX_QRTZ_FT_T_G` ON `QRTZ_FIRED_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`);
CREATE INDEX `IDX_QRTZ_FT_TG` ON `QRTZ_FIRED_TRIGGERS` (`SCHED_NAME`, `TRIGGER_GROUP`);
