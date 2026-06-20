package com.ayang.ayangware.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.math.BigDecimal;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 采购信息
 * 
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:33:17
 */
@Data
@TableName("wms_purchase")
public class WmsPurchaseEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 采购单id
	 */
	@TableId
	private Long id;
	/**
	 * 采购人id
	 */
	private Long assigneeId;
	/**
	 * 采购人姓名
	 */
	private String assigneeName;
	/**
	 * 联系方式
	 */
	private String phone;
	/**
	 * 优先级
	 */
	private Integer priority;
	/**
	 * 采购单状态
	 */
	private Integer status;
	/**
	 * 仓库id
	 */
	private Long wareId;
	/**
	 * 采购总金额
	 */
	private BigDecimal amount;
	/**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 更新时间
	 */
	private Date updateTime;

}
