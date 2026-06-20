-- 创建数据库
CREATE DATABASE IF NOT EXISTS ayang_mall_ums
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci;

-- 使用数据库
USE ayang_mall_ums;

-- 删除旧表，避免重复创建报错
DROP TABLE IF EXISTS ums_growth_change_history;
DROP TABLE IF EXISTS ums_integration_change_history;
DROP TABLE IF EXISTS ums_member;
DROP TABLE IF EXISTS ums_member_collect_spu;
DROP TABLE IF EXISTS ums_member_collect_subject;
DROP TABLE IF EXISTS ums_member_level;
DROP TABLE IF EXISTS ums_member_login_log;
DROP TABLE IF EXISTS ums_member_receive_address;
DROP TABLE IF EXISTS ums_member_statistics_info;

-- ============================================================
-- 表名：ums_growth_change_history
-- 说明：成长值变化历史记录
-- ============================================================
CREATE TABLE ums_growth_change_history
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键id',
    member_id            BIGINT COMMENT '会员id',
    create_time          DATETIME COMMENT '创建时间',
    change_count         INT COMMENT '改变的值，正数表示增加，负数表示减少',
    note                 VARCHAR(255) COMMENT '备注',
    source_type          TINYINT COMMENT '积分来源：0-购物，1-管理员修改',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='成长值变化历史记录';

-- ============================================================
-- 表名：ums_integration_change_history
-- 说明：积分变化历史记录
-- ============================================================
CREATE TABLE ums_integration_change_history
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键id',
    member_id            BIGINT COMMENT '会员id',
    create_time          DATETIME COMMENT '创建时间',
    change_count         INT COMMENT '变化的值，正数表示增加，负数表示减少',
    note                 VARCHAR(255) COMMENT '备注',
    source_tyoe          TINYINT COMMENT '来源：0-购物，1-管理员修改，2-活动',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='积分变化历史记录';

-- ============================================================
-- 表名：ums_member
-- 说明：会员信息表
-- ============================================================
CREATE TABLE ums_member
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键id',
    level_id             BIGINT COMMENT '会员等级id',
    username             CHAR(64) COMMENT '用户名',
    password             VARCHAR(64) COMMENT '密码',
    nickname             VARCHAR(64) COMMENT '昵称',
    mobile               VARCHAR(20) COMMENT '手机号码',
    email                VARCHAR(64) COMMENT '邮箱',
    header               VARCHAR(500) COMMENT '头像',
    gender               TINYINT COMMENT '性别',
    birth                DATE COMMENT '生日',
    city                 VARCHAR(500) COMMENT '所在城市',
    job                  VARCHAR(255) COMMENT '职业',
    sign                 VARCHAR(255) COMMENT '个性签名',
    source_type          TINYINT COMMENT '用户来源',
    integration          INT COMMENT '积分',
    growth               INT COMMENT '成长值',
    status               TINYINT COMMENT '启用状态',
    create_time          DATETIME COMMENT '注册时间',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员';

-- ============================================================
-- 表名：ums_member_collect_spu
-- 说明：会员收藏的商品
-- ============================================================
CREATE TABLE ums_member_collect_spu
(
    id                   BIGINT NOT NULL COMMENT '主键id',
    member_id            BIGINT COMMENT '会员id',
    spu_id               BIGINT COMMENT '商品spu_id',
    spu_name             VARCHAR(500) COMMENT '商品名称',
    spu_img              VARCHAR(500) COMMENT '商品图片',
    create_time          DATETIME COMMENT '创建时间',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员收藏的商品';

-- ============================================================
-- 表名：ums_member_collect_subject
-- 说明：会员收藏的专题活动
-- ============================================================
CREATE TABLE ums_member_collect_subject
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键id',
    subject_id           BIGINT COMMENT '专题活动id',
    subject_name         VARCHAR(255) COMMENT '专题活动名称',
    subject_img          VARCHAR(500) COMMENT '专题活动图片',
    subject_urll         VARCHAR(500) COMMENT '活动url',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员收藏的专题活动';

-- ============================================================
-- 表名：ums_member_level
-- 说明：会员等级
-- ============================================================
CREATE TABLE ums_member_level
(
    id                         BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键id',
    name                       VARCHAR(100) COMMENT '等级名称',
    growth_point               INT COMMENT '等级需要的成长值',
    default_status             TINYINT COMMENT '是否为默认等级：0-不是，1-是',
    free_freight_point         DECIMAL(18,4) COMMENT '免运费标准',
    comment_growth_point       INT COMMENT '每次评价获取的成长值',
    priviledge_free_freight    TINYINT COMMENT '是否有免邮特权',
    priviledge_member_price    TINYINT COMMENT '是否有会员价格特权',
    priviledge_birthday        TINYINT COMMENT '是否有生日特权',
    note                       VARCHAR(255) COMMENT '备注',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员等级';

-- ============================================================
-- 表名：ums_member_login_log
-- 说明：会员登录记录
-- ============================================================
CREATE TABLE ums_member_login_log
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键id',
    member_id            BIGINT COMMENT '会员id',
    create_time          DATETIME COMMENT '创建时间',
    ip                   VARCHAR(64) COMMENT '登录ip',
    city                 VARCHAR(64) COMMENT '登录城市',
    login_type           TINYINT(1) COMMENT '登录类型：1-web，2-app',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员登录记录';

-- ============================================================
-- 表名：ums_member_receive_address
-- 说明：会员收货地址
-- ============================================================
CREATE TABLE ums_member_receive_address
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键id',
    member_id            BIGINT COMMENT '会员id',
    name                 VARCHAR(255) COMMENT '收货人姓名',
    phone                VARCHAR(64) COMMENT '电话',
    post_code            VARCHAR(64) COMMENT '邮政编码',
    province             VARCHAR(100) COMMENT '省份/直辖市',
    city                 VARCHAR(100) COMMENT '城市',
    region               VARCHAR(100) COMMENT '区',
    detail_address       VARCHAR(255) COMMENT '详细地址，街道地址',
    areacode             VARCHAR(15) COMMENT '省市区代码',
    default_status       TINYINT(1) COMMENT '是否默认：0-否，1-是',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员收货地址';

-- ============================================================
-- 表名：ums_member_statistics_info
-- 说明：会员统计信息
-- ============================================================
CREATE TABLE ums_member_statistics_info
(
    id                       BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键id',
    member_id                BIGINT COMMENT '会员id',
    consume_amount           DECIMAL(18,4) COMMENT '累计消费金额',
    coupon_amount            DECIMAL(18,4) COMMENT '累计优惠金额',
    order_count              INT COMMENT '订单数量',
    coupon_count             INT COMMENT '优惠券数量',
    comment_count            INT COMMENT '评价数',
    return_order_count       INT COMMENT '退货数量',
    login_count              INT COMMENT '登录次数',
    attend_count             INT COMMENT '关注数量',
    fans_count               INT COMMENT '粉丝数量',
    collect_product_count    INT COMMENT '收藏的商品数量',
    collect_subject_count    INT COMMENT '收藏的专题活动数量',
    collect_comment_count    INT COMMENT '收藏的评论数量',
    invite_friend_count      INT COMMENT '邀请的朋友数量',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员统计信息';
