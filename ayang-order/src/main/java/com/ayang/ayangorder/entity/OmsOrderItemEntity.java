package com.ayang.ayangorder.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.math.BigDecimal;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 订单商品明细表
 * 
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:21:59
 */
@Data
@TableName("oms_order_item")
public class OmsOrderItemEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 主键ID
	 */
	@TableId
	private Long id;
	/**
	 * 订单ID
	 */
	private Long orderId;
	/**
	 * 订单号
	 */
	private String orderSn;
	/**
	 * SPU ID
	 */
	private Long spuId;
	/**
	 * SPU名称
	 */
	private String spuName;
	/**
	 * SPU图片
	 */
	private String spuPic;
	/**
	 * 商品品牌
	 */
	private String spuBrand;
	/**
	 * 商品分类ID
	 */
	private Long categoryId;
	/**
	 * SKU ID
	 */
	private Long skuId;
	/**
	 * SKU名称
	 */
	private String skuName;
	/**
	 * SKU图片
	 */
	private String skuPic;
	/**
	 * SKU价格
	 */
	private BigDecimal skuPrice;
	/**
	 * 购买数量
	 */
	private Integer skuQuantity;
	/**
	 * 商品销售属性组合，JSON格式
	 */
	private String skuAttrsVals;
	/**
	 * 商品促销分摊金额
	 */
	private BigDecimal promotionAmount;
	/**
	 * 优惠券分摊金额
	 */
	private BigDecimal couponAmount;
	/**
	 * 积分优惠分摊金额
	 */
	private BigDecimal integrationAmount;
	/**
	 * 该商品优惠后的实际金额
	 */
	private BigDecimal realAmount;
	/**
	 * 赠送积分
	 */
	private Integer giftIntegration;
	/**
	 * 赠送成长值
	 */
	private Integer giftGrowth;

}
