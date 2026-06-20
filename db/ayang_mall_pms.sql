/*==============================================================*/
/* 创建数据库：商品服务数据库                                      */
/*==============================================================*/
CREATE DATABASE IF NOT EXISTS `ayang_mall_pms`
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci;

USE `ayang_mall_pms`;

/*==============================================================*/
/* 删除旧表，避免重复创建报错                                      */
/*==============================================================*/
DROP TABLE IF EXISTS pms_attr;

DROP TABLE IF EXISTS pms_attr_attrgroup_relation;

DROP TABLE IF EXISTS pms_attr_group;

DROP TABLE IF EXISTS pms_brand;

DROP TABLE IF EXISTS pms_category;

DROP TABLE IF EXISTS pms_category_brand_relation;

DROP TABLE IF EXISTS pms_comment_replay;

DROP TABLE IF EXISTS pms_product_attr_value;

DROP TABLE IF EXISTS pms_sku_images;

DROP TABLE IF EXISTS pms_sku_info;

DROP TABLE IF EXISTS pms_sku_sale_attr_value;

DROP TABLE IF EXISTS pms_spu_comment;

DROP TABLE IF EXISTS pms_spu_images;

DROP TABLE IF EXISTS pms_spu_info;

DROP TABLE IF EXISTS pms_spu_info_desc;


/*==============================================================*/
/* Table: pms_attr                                               */
/* 表说明：商品属性                                                */
/*==============================================================*/
CREATE TABLE pms_attr
(
    attr_id              BIGINT NOT NULL AUTO_INCREMENT COMMENT '属性id',
    attr_name            CHAR(30) COMMENT '属性名',
    search_type          TINYINT COMMENT '是否需要检索[0-不需要，1-需要]',
    `value_type`         TINYINT(4) DEFAULT NULL COMMENT '值类型[0-为单个值，1-可以选择多个值]',
    `icon`               VARCHAR(255) DEFAULT NULL COMMENT '属性图标',
    `value_select`       CHAR(255) DEFAULT NULL COMMENT '可选值列表[用逗号分隔]',
    `attr_type`          TINYINT(4) DEFAULT NULL COMMENT '属性类型[0-销售属性，1-基本属性，2-既是销售属性又是基本属性]',
    enable               BIGINT COMMENT '启用状态[0 - 禁用，1 - 启用]',
    catelog_id           BIGINT COMMENT '所属分类',
    show_desc            TINYINT COMMENT '快速展示【是否展示在介绍上；0-否 1-是】，在sku中仍然可以调整',
    PRIMARY KEY (attr_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品属性';


/*==============================================================*/
/* Table: pms_attr_attrgroup_relation                            */
/* 表说明：属性&属性分组关联                                       */
/*==============================================================*/
CREATE TABLE pms_attr_attrgroup_relation
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
    attr_id              BIGINT COMMENT '属性id',
    attr_group_id        BIGINT COMMENT '属性分组id',
    attr_sort            INT COMMENT '属性组内排序',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='属性&属性分组关联';


/*==============================================================*/
/* Table: pms_attr_group                                         */
/* 表说明：属性分组                                                */
/*==============================================================*/
CREATE TABLE pms_attr_group
(
    attr_group_id        BIGINT NOT NULL AUTO_INCREMENT COMMENT '分组id',
    attr_group_name      CHAR(20) COMMENT '组名',
    sort                 INT COMMENT '排序',
    descript             VARCHAR(255) COMMENT '描述',
    icon                 VARCHAR(255) COMMENT '组图标',
    catelog_id           BIGINT COMMENT '所属分类id',
    PRIMARY KEY (attr_group_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='属性分组';


/*==============================================================*/
/* Table: pms_brand                                              */
/* 表说明：品牌                                                    */
/*==============================================================*/
CREATE TABLE pms_brand
(
    brand_id             BIGINT NOT NULL AUTO_INCREMENT COMMENT '品牌id',
    name                 CHAR(50) COMMENT '品牌名',
    logo                 VARCHAR(2000) COMMENT '品牌logo地址',
    descript             LONGTEXT COMMENT '介绍',
    show_status          TINYINT COMMENT '显示状态[0-不显示；1-显示]',
    first_letter         CHAR(1) COMMENT '检索首字母',
    sort                 INT COMMENT '排序',
    PRIMARY KEY (brand_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='品牌';


/*==============================================================*/
/* Table: pms_category                                           */
/* 表说明：商品三级分类                                            */
/*==============================================================*/
CREATE TABLE pms_category
(
    cat_id               BIGINT NOT NULL AUTO_INCREMENT COMMENT '分类id',
    name                 CHAR(50) COMMENT '分类名称',
    parent_cid           BIGINT COMMENT '父分类id',
    cat_level            INT COMMENT '层级',
    show_status          TINYINT COMMENT '是否显示[0-不显示，1显示]',
    sort                 INT COMMENT '排序',
    icon                 CHAR(255) COMMENT '图标地址',
    product_unit         CHAR(50) COMMENT '计量单位',
    product_count        INT COMMENT '商品数量',
    PRIMARY KEY (cat_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品三级分类';


/*==============================================================*/
/* Table: pms_category_brand_relation                            */
/* 表说明：品牌分类关联                                            */
/*==============================================================*/
CREATE TABLE pms_category_brand_relation
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
    brand_id             BIGINT COMMENT '品牌id',
    catelog_id           BIGINT COMMENT '分类id',
    brand_name           VARCHAR(255) COMMENT '品牌名称',
    catelog_name         VARCHAR(255) COMMENT '分类名称',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='品牌分类关联';


/*==============================================================*/
/* Table: pms_comment_replay                                     */
/* 表说明：商品评价回复关系                                        */
/*==============================================================*/
CREATE TABLE pms_comment_replay
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
    comment_id           BIGINT COMMENT '评论id',
    reply_id             BIGINT COMMENT '回复id',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品评价回复关系';


/*==============================================================*/
/* Table: pms_product_attr_value                                 */
/* 表说明：spu属性值                                               */
/*==============================================================*/
CREATE TABLE pms_product_attr_value
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
    spu_id               BIGINT COMMENT '商品id',
    attr_id              BIGINT COMMENT '属性id',
    attr_name            VARCHAR(200) COMMENT '属性名',
    attr_value           VARCHAR(200) COMMENT '属性值',
    attr_sort            INT COMMENT '顺序',
    quick_show           TINYINT COMMENT '快速展示【是否展示在介绍上；0-否 1-是】',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='spu属性值';


/*==============================================================*/
/* Table: pms_sku_images                                         */
/* 表说明：sku图片                                                 */
/*==============================================================*/
CREATE TABLE pms_sku_images
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
    sku_id               BIGINT COMMENT 'sku_id',
    img_url              VARCHAR(255) COMMENT '图片地址',
    img_sort             INT COMMENT '排序',
    default_img          INT COMMENT '默认图[0 - 不是默认图，1 - 是默认图]',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='sku图片';


/*==============================================================*/
/* Table: pms_sku_info                                           */
/* 表说明：sku信息                                                 */
/*==============================================================*/
CREATE TABLE pms_sku_info
(
    sku_id               BIGINT NOT NULL AUTO_INCREMENT COMMENT 'skuId',
    spu_id               BIGINT COMMENT 'spuId',
    sku_name             VARCHAR(255) COMMENT 'sku名称',
    sku_desc             VARCHAR(2000) COMMENT 'sku介绍描述',
    catalog_id           BIGINT COMMENT '所属分类id',
    brand_id             BIGINT COMMENT '品牌id',
    sku_default_img      VARCHAR(255) COMMENT '默认图片',
    sku_title            VARCHAR(255) COMMENT '标题',
    sku_subtitle         VARCHAR(2000) COMMENT '副标题',
    price                DECIMAL(18,4) COMMENT '价格',
    sale_count           BIGINT COMMENT '销量',
    PRIMARY KEY (sku_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='sku信息';


/*==============================================================*/
/* Table: pms_sku_sale_attr_value                                */
/* 表说明：sku销售属性&值                                          */
/*==============================================================*/
CREATE TABLE pms_sku_sale_attr_value
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
    sku_id               BIGINT COMMENT 'sku_id',
    attr_id              BIGINT COMMENT 'attr_id',
    attr_name            VARCHAR(200) COMMENT '销售属性名',
    attr_value           VARCHAR(200) COMMENT '销售属性值',
    attr_sort            INT COMMENT '顺序',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='sku销售属性&值';


/*==============================================================*/
/* Table: pms_spu_comment                                        */
/* 表说明：商品评价                                                */
/*==============================================================*/
CREATE TABLE pms_spu_comment
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
    sku_id               BIGINT COMMENT 'sku_id',
    spu_id               BIGINT COMMENT 'spu_id',
    spu_name             VARCHAR(255) COMMENT '商品名字',
    member_nick_name     VARCHAR(255) COMMENT '会员昵称',
    star                 TINYINT(1) COMMENT '星级',
    member_ip            VARCHAR(64) COMMENT '会员ip',
    create_time          DATETIME COMMENT '创建时间',
    show_status          TINYINT(1) COMMENT '显示状态[0-不显示，1-显示]',
    spu_attributes       VARCHAR(255) COMMENT '购买时属性组合',
    likes_count          INT COMMENT '点赞数',
    reply_count          INT COMMENT '回复数',
    resources            VARCHAR(1000) COMMENT '评论图片/视频[json数据；[{type:文件类型,url:资源路径}]]',
    content              TEXT COMMENT '内容',
    member_icon          VARCHAR(255) COMMENT '用户头像',
    comment_type         TINYINT COMMENT '评论类型[0 - 对商品的直接评论，1 - 对评论的回复]',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品评价';


/*==============================================================*/
/* Table: pms_spu_images                                         */
/* 表说明：spu图片                                                 */
/*==============================================================*/
CREATE TABLE pms_spu_images
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
    spu_id               BIGINT COMMENT 'spu_id',
    img_name             VARCHAR(200) COMMENT '图片名',
    img_url              VARCHAR(255) COMMENT '图片地址',
    img_sort             INT COMMENT '顺序',
    default_img          TINYINT COMMENT '是否默认图',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='spu图片';


/*==============================================================*/
/* Table: pms_spu_info                                           */
/* 表说明：spu信息                                                 */
/*==============================================================*/
CREATE TABLE pms_spu_info
(
    id                   BIGINT NOT NULL AUTO_INCREMENT COMMENT '商品id',
    spu_name             VARCHAR(200) COMMENT '商品名称',
    spu_description      VARCHAR(1000) COMMENT '商品描述',
    catalog_id           BIGINT COMMENT '所属分类id',
    brand_id             BIGINT COMMENT '品牌id',
    weight               DECIMAL(18,4) COMMENT '商品重量',
    publish_status       TINYINT COMMENT '上架状态[0 - 下架，1 - 上架]',
    create_time          DATETIME COMMENT '创建时间',
    update_time          DATETIME COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='spu信息';


/*==============================================================*/
/* Table: pms_spu_info_desc                                      */
/* 表说明：spu信息介绍                                             */
/*==============================================================*/
CREATE TABLE pms_spu_info_desc
(
    spu_id               BIGINT NOT NULL COMMENT '商品id',
    decript              LONGTEXT COMMENT '商品介绍',
    PRIMARY KEY (spu_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='spu信息介绍';
