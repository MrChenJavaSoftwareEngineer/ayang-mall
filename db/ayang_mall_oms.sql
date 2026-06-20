-- ============================================================
-- 创建订单服务数据库
-- ============================================================
CREATE DATABASE IF NOT EXISTS `ayang_mall_oms`
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE `ayang_mall_oms`;

-- ============================================================
-- 删除旧表，避免重复创建时报错
-- 注意：如果表中已有数据，执行 DROP TABLE 会删除数据
-- ============================================================
DROP TABLE IF EXISTS `oms_order`;
DROP TABLE IF EXISTS `oms_order_item`;
DROP TABLE IF EXISTS `oms_order_operate_history`;
DROP TABLE IF EXISTS `oms_order_return_apply`;
DROP TABLE IF EXISTS `oms_order_return_reason`;
DROP TABLE IF EXISTS `oms_order_setting`;
DROP TABLE IF EXISTS `oms_payment_info`;
DROP TABLE IF EXISTS `oms_refund_info`;

-- ============================================================
-- 表名：oms_order
-- 说明：订单主表
-- ============================================================
CREATE TABLE `oms_order`
(
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `member_id` bigint COMMENT '会员ID',
    `order_sn` char(32) COMMENT '订单号',
    `coupon_id` bigint COMMENT '使用的优惠券ID',
    `create_time` datetime COMMENT '创建时间',
    `member_username` varchar(200) COMMENT '会员用户名',
    `total_amount` decimal(18,4) COMMENT '订单总金额',
    `pay_amount` decimal(18,4) COMMENT '应付总金额',
    `freight_amount` decimal(18,4) COMMENT '运费金额',
    `promotion_amount` decimal(18,4) COMMENT '促销优惠金额，如促销价、满减、阶梯价',
    `integration_amount` decimal(18,4) COMMENT '积分抵扣金额',
    `coupon_amount` decimal(18,4) COMMENT '优惠券抵扣金额',
    `discount_amount` decimal(18,4) COMMENT '后台调整订单使用的折扣金额',
    `pay_type` tinyint COMMENT '支付方式：1-支付宝，2-微信，3-银联，4-货到付款',
    `source_type` tinyint COMMENT '订单来源：0-PC订单，1-APP订单',
    `status` tinyint COMMENT '订单状态：0-待付款，1-待发货，2-已发货，3-已完成，4-已关闭，5-无效订单',
    `delivery_company` varchar(64) COMMENT '物流公司或配送方式',
    `delivery_sn` varchar(64) COMMENT '物流单号',
    `auto_confirm_day` int COMMENT '自动确认收货时间，单位：天',
    `integration` int COMMENT '可获得的积分',
    `growth` int COMMENT '可获得的成长值',
    `bill_type` tinyint COMMENT '发票类型：0-不开发票，1-电子发票，2-纸质发票',
    `bill_header` varchar(255) COMMENT '发票抬头',
    `bill_content` varchar(255) COMMENT '发票内容',
    `bill_receiver_phone` varchar(32) COMMENT '收票人电话',
    `bill_receiver_email` varchar(64) COMMENT '收票人邮箱',
    `receiver_name` varchar(100) COMMENT '收货人姓名',
    `receiver_phone` varchar(32) COMMENT '收货人电话',
    `receiver_post_code` varchar(32) COMMENT '收货人邮编',
    `receiver_province` varchar(32) COMMENT '收货地址-省份/直辖市',
    `receiver_city` varchar(32) COMMENT '收货地址-城市',
    `receiver_region` varchar(32) COMMENT '收货地址-区/县',
    `receiver_detail_address` varchar(200) COMMENT '收货详细地址',
    `note` varchar(500) COMMENT '订单备注',
    `confirm_status` tinyint COMMENT '确认收货状态：0-未确认，1-已确认',
    `delete_status` tinyint COMMENT '删除状态：0-未删除，1-已删除',
    `use_integration` int COMMENT '下单时使用的积分',
    `payment_time` datetime COMMENT '支付时间',
    `delivery_time` datetime COMMENT '发货时间',
    `receive_time` datetime COMMENT '确认收货时间',
    `comment_time` datetime COMMENT '评价时间',
    `modify_time` datetime COMMENT '修改时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单主表';

-- ============================================================
-- 表名：oms_order_item
-- 说明：订单商品明细表
-- ============================================================
CREATE TABLE `oms_order_item`
(
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `order_id` bigint COMMENT '订单ID',
    `order_sn` char(32) COMMENT '订单号',
    `spu_id` bigint COMMENT 'SPU ID',
    `spu_name` varchar(255) COMMENT 'SPU名称',
    `spu_pic` varchar(500) COMMENT 'SPU图片',
    `spu_brand` varchar(200) COMMENT '商品品牌',
    `category_id` bigint COMMENT '商品分类ID',
    `sku_id` bigint COMMENT 'SKU ID',
    `sku_name` varchar(255) COMMENT 'SKU名称',
    `sku_pic` varchar(500) COMMENT 'SKU图片',
    `sku_price` decimal(18,4) COMMENT 'SKU价格',
    `sku_quantity` int COMMENT '购买数量',
    `sku_attrs_vals` varchar(500) COMMENT '商品销售属性组合，JSON格式',
    `promotion_amount` decimal(18,4) COMMENT '商品促销分摊金额',
    `coupon_amount` decimal(18,4) COMMENT '优惠券分摊金额',
    `integration_amount` decimal(18,4) COMMENT '积分优惠分摊金额',
    `real_amount` decimal(18,4) COMMENT '该商品优惠后的实际金额',
    `gift_integration` int COMMENT '赠送积分',
    `gift_growth` int COMMENT '赠送成长值',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单商品明细表';

-- ============================================================
-- 表名：oms_order_operate_history
-- 说明：订单操作历史记录表
-- ============================================================
CREATE TABLE `oms_order_operate_history`
(
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `order_id` bigint COMMENT '订单ID',
    `operate_man` varchar(100) COMMENT '操作人：用户、系统、后台管理员',
    `create_time` datetime COMMENT '操作时间',
    `order_status` tinyint COMMENT '订单状态：0-待付款，1-待发货，2-已发货，3-已完成，4-已关闭，5-无效订单',
    `note` varchar(500) COMMENT '操作备注',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单操作历史记录表';

-- ============================================================
-- 表名：oms_order_return_apply
-- 说明：订单退货申请表
-- ============================================================
CREATE TABLE `oms_order_return_apply`
(
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `order_id` bigint COMMENT '订单ID',
    `sku_id` bigint COMMENT '退货商品SKU ID',
    `order_sn` char(32) COMMENT '订单编号',
    `create_time` datetime COMMENT '申请时间',
    `member_username` varchar(64) COMMENT '会员用户名',
    `return_amount` decimal(18,4) COMMENT '退款金额',
    `return_name` varchar(100) COMMENT '退货人姓名',
    `return_phone` varchar(20) COMMENT '退货人电话',
    `status` tinyint(1) COMMENT '申请状态：0-待处理，1-退货中，2-已完成，3-已拒绝',
    `handle_time` datetime COMMENT '处理时间',
    `sku_img` varchar(500) COMMENT '商品图片',
    `sku_name` varchar(200) COMMENT '商品名称',
    `sku_brand` varchar(200) COMMENT '商品品牌',
    `sku_attrs_vals` varchar(500) COMMENT '商品销售属性，JSON格式',
    `sku_count` int COMMENT '退货数量',
    `sku_price` decimal(18,4) COMMENT '商品单价',
    `sku_real_price` decimal(18,4) COMMENT '商品实际支付单价',
    `reason` varchar(200) COMMENT '退货原因',
    `description` varchar(500) COMMENT '退货描述',
    `desc_pics` varchar(2000) COMMENT '凭证图片，多个图片以逗号分隔',
    `handle_note` varchar(500) COMMENT '处理备注',
    `handle_man` varchar(200) COMMENT '处理人员',
    `receive_man` varchar(100) COMMENT '收货人',
    `receive_time` datetime COMMENT '收货时间',
    `receive_note` varchar(500) COMMENT '收货备注',
    `receive_phone` varchar(20) COMMENT '收货电话',
    `company_address` varchar(500) COMMENT '公司收货地址',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单退货申请表';

-- ============================================================
-- 表名：oms_order_return_reason
-- 说明：退货原因表
-- ============================================================
CREATE TABLE `oms_order_return_reason`
(
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `name` varchar(200) COMMENT '退货原因名称',
    `sort` int COMMENT '排序值',
    `status` tinyint(1) COMMENT '启用状态：0-禁用，1-启用',
    `create_time` datetime COMMENT '创建时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='退货原因表';

-- ============================================================
-- 表名：oms_order_setting
-- 说明：订单配置信息表
-- ============================================================
CREATE TABLE `oms_order_setting`
(
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `flash_order_overtime` int COMMENT '秒杀订单超时关闭时间，单位：分钟',
    `normal_order_overtime` int COMMENT '正常订单超时时间，单位：分钟',
    `confirm_overtime` int COMMENT '发货后自动确认收货时间，单位：天',
    `finish_overtime` int COMMENT '自动完成交易时间，过期后不能申请退货，单位：天',
    `comment_overtime` int COMMENT '订单完成后自动好评时间，单位：天',
    `member_level` tinyint(2) COMMENT '会员等级：0-不限会员等级，其他-对应会员等级',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单配置信息表';

-- ============================================================
-- 表名：oms_payment_info
-- 说明：支付信息表
-- ============================================================
CREATE TABLE `oms_payment_info`
(
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `order_sn` char(32) COMMENT '订单号，对外业务号',
    `order_id` bigint COMMENT '订单ID',
    `alipay_trade_no` varchar(50) COMMENT '支付宝交易流水号',
    `total_amount` decimal(18,4) COMMENT '支付总金额',
    `subject` varchar(200) COMMENT '交易内容',
    `payment_status` varchar(20) COMMENT '支付状态',
    `create_time` datetime COMMENT '创建时间',
    `confirm_time` datetime COMMENT '确认时间',
    `callback_content` varchar(4000) COMMENT '支付回调内容',
    `callback_time` datetime COMMENT '支付回调时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付信息表';

-- ============================================================
-- 表名：oms_refund_info
-- 说明：退款信息表
-- ============================================================
CREATE TABLE `oms_refund_info`
(
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `order_return_id` bigint COMMENT '退货申请ID',
    `refund` decimal(18,4) COMMENT '退款金额',
    `refund_sn` varchar(64) COMMENT '退款交易流水号',
    `refund_status` tinyint(1) COMMENT '退款状态',
    `refund_channel` tinyint COMMENT '退款渠道：1-支付宝，2-微信，3-银联，4-汇款',
    `refund_content` varchar(5000) COMMENT '退款内容',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='退款信息表';
