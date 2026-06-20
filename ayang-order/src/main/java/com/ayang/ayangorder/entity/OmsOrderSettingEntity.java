package com.ayang.ayangorder.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 订单配置信息表
 * 
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:21:59
 */
@Data
@TableName("oms_order_setting")
public class OmsOrderSettingEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 主键ID
	 */
	@TableId
	private Long id;
	/**
	 * 秒杀订单超时关闭时间，单位：分钟
	 */
	private Integer flashOrderOvertime;
	/**
	 * 正常订单超时时间，单位：分钟
	 */
	private Integer normalOrderOvertime;
	/**
	 * 发货后自动确认收货时间，单位：天
	 */
	private Integer confirmOvertime;
	/**
	 * 自动完成交易时间，过期后不能申请退货，单位：天
	 */
	private Integer finishOvertime;
	/**
	 * 订单完成后自动好评时间，单位：天
	 */
	private Integer commentOvertime;
	/**
	 * 会员等级：0-不限会员等级，其他-对应会员等级
	 */
	private Integer memberLevel;

}
