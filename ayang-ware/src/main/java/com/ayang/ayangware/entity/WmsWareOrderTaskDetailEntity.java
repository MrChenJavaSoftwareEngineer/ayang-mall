package com.ayang.ayangware.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 库存工作单详情
 * 
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:33:18
 */
@Data
@TableName("wms_ware_order_task_detail")
public class WmsWareOrderTaskDetailEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 主键id
	 */
	@TableId
	private Long id;
	/**
	 * 商品sku_id
	 */
	private Long skuId;
	/**
	 * 商品名称
	 */
	private String skuName;
	/**
	 * 购买数量
	 */
	private Integer skuNum;
	/**
	 * 工作单id
	 */
	private Long taskId;

}
