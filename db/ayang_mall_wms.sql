-- 创建数据库
CREATE DATABASE IF NOT EXISTS ayang_mall_wms
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci;

-- 使用数据库
USE ayang_mall_wms;

-- 删除旧表，避免重复创建报错
DROP TABLE IF EXISTS wms_purchase;
DROP TABLE IF EXISTS wms_purchase_detail;
DROP TABLE IF EXISTS wms_ware_info;
DROP TABLE IF EXISTS wms_ware_order_task;
DROP TABLE IF EXISTS wms_ware_order_task_detail;
DROP TABLE IF EXISTS wms_ware_sku;

-- ============================================================
-- 表名：wms_purchase
-- 说明：采购信息表
-- ============================================================
CREATE TABLE wms_purchase
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT '采购单id',
    assignee_id          BIGINT COMMENT '采购人id',
    assignee_name        VARCHAR(255) COMMENT '采购人姓名',
    phone                CHAR(13) COMMENT '联系方式',
    priority             INT(4) COMMENT '优先级',
    status               INT(4) COMMENT '采购单状态',
    ware_id              BIGINT COMMENT '仓库id',
    amount               DECIMAL(18,4) COMMENT '采购总金额',
    create_time          DATETIME COMMENT '创建时间',
    update_time          DATETIME COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='采购信息';

-- ============================================================
-- 表名：wms_purchase_detail
-- 说明：采购需求详情表
-- ============================================================
CREATE TABLE wms_purchase_detail
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键id',
    purchase_id          BIGINT COMMENT '采购单id',
    sku_id               BIGINT COMMENT '采购商品id',
    sku_num              INT COMMENT '采购数量',
    sku_price            DECIMAL(18,4) COMMENT '采购金额',
    ware_id              BIGINT COMMENT '仓库id',
    status               INT COMMENT '状态：0-新建，1-已分配，2-正在采购，3-已完成，4-采购失败',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='采购需求详情';

-- ============================================================
-- 表名：wms_ware_info
-- 说明：仓库信息表
-- ============================================================
CREATE TABLE wms_ware_info
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键id',
    name                 VARCHAR(255) COMMENT '仓库名称',
    address              VARCHAR(255) COMMENT '仓库地址',
    areacode             VARCHAR(20) COMMENT '区域编码',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='仓库信息';

-- ============================================================
-- 表名：wms_ware_order_task
-- 说明：库存工作单表
-- ============================================================
CREATE TABLE wms_ware_order_task
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键id',
    order_id             BIGINT COMMENT '订单id',
    order_sn             VARCHAR(255) COMMENT '订单编号',
    consignee            VARCHAR(100) COMMENT '收货人',
    consignee_tel        CHAR(15) COMMENT '收货人电话',
    delivery_address     VARCHAR(500) COMMENT '配送地址',
    order_comment        VARCHAR(200) COMMENT '订单备注',
    payment_way          TINYINT(1) COMMENT '付款方式：1-在线付款，2-货到付款',
    task_status          TINYINT(2) COMMENT '任务状态',
    order_body           VARCHAR(255) COMMENT '订单描述',
    tracking_no          CHAR(30) COMMENT '物流单号',
    create_time          DATETIME COMMENT '创建时间',
    ware_id              BIGINT COMMENT '仓库id',
    task_comment         VARCHAR(500) COMMENT '工作单备注',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='库存工作单';

-- ============================================================
-- 表名：wms_ware_order_task_detail
-- 说明：库存工作单详情表
-- ============================================================
CREATE TABLE wms_ware_order_task_detail
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键id',
    sku_id               BIGINT COMMENT '商品sku_id',
    sku_name             VARCHAR(255) COMMENT '商品名称',
    sku_num              INT COMMENT '购买数量',
    task_id              BIGINT COMMENT '工作单id',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='库存工作单详情';

-- ============================================================
-- 表名：wms_ware_sku
-- 说明：商品库存表
-- ============================================================
CREATE TABLE wms_ware_sku
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键id',
    sku_id               BIGINT COMMENT '商品sku_id',
    ware_id              BIGINT COMMENT '仓库id',
    stock                INT COMMENT '库存数量',
    sku_name             VARCHAR(200) COMMENT '商品名称',
    stock_locked         INT COMMENT '锁定库存',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品库存';
