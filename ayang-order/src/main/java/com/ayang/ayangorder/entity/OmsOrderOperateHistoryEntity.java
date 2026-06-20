package com.ayang.ayangorder.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 订单操作历史记录表
 * 
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:21:59
 */
@Data
@TableName("oms_order_operate_history")
public class OmsOrderOperateHistoryEntity implements Serializable {
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
	 * 操作人：用户、系统、后台管理员
	 */
	private String operateMan;
	/**
	 * 操作时间
	 */
	private Date createTime;
	/**
	 * 订单状态：0-待付款，1-待发货，2-已发货，3-已完成，4-已关闭，5-无效订单
	 */
	private Integer orderStatus;
	/**
	 * 操作备注
	 */
	private String note;

}
