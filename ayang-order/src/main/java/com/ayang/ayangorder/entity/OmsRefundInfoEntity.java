package com.ayang.ayangorder.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.math.BigDecimal;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 退款信息表
 * 
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:21:59
 */
@Data
@TableName("oms_refund_info")
public class OmsRefundInfoEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 主键ID
	 */
	@TableId
	private Long id;
	/**
	 * 退货申请ID
	 */
	private Long orderReturnId;
	/**
	 * 退款金额
	 */
	private BigDecimal refund;
	/**
	 * 退款交易流水号
	 */
	private String refundSn;
	/**
	 * 退款状态
	 */
	private Integer refundStatus;
	/**
	 * 退款渠道：1-支付宝，2-微信，3-银联，4-汇款
	 */
	private Integer refundChannel;
	/**
	 * 退款内容
	 */
	private String refundContent;

}
