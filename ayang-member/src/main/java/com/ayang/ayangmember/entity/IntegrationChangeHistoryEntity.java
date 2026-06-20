package com.ayang.ayangmember.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 积分变化历史记录
 * 
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:13:20
 */
@Data
@TableName("ums_integration_change_history")
public class IntegrationChangeHistoryEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 主键id
	 */
	@TableId
	private Long id;
	/**
	 * 会员id
	 */
	private Long memberId;
	/**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 变化的值，正数表示增加，负数表示减少
	 */
	private Integer changeCount;
	/**
	 * 备注
	 */
	private String note;
	/**
	 * 来源：0-购物，1-管理员修改，2-活动
	 */
	private Integer sourceTyoe;

}
