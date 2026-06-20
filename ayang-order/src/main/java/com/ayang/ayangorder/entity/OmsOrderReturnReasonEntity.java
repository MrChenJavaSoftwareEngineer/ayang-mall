package com.ayang.ayangorder.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 退货原因表
 * 
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:21:59
 */
@Data
@TableName("oms_order_return_reason")
public class OmsOrderReturnReasonEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 主键ID
	 */
	@TableId
	private Long id;
	/**
	 * 退货原因名称
	 */
	private String name;
	/**
	 * 排序值
	 */
	private Integer sort;
	/**
	 * 启用状态：0-禁用，1-启用
	 */
	private Integer status;
	/**
	 * 创建时间
	 */
	private Date createTime;

}
