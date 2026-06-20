package com.ayang.ayangmember.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 会员登录记录
 * 
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:13:20
 */
@Data
@TableName("ums_member_login_log")
public class MemberLoginLogEntity implements Serializable {
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
	 * 登录ip
	 */
	private String ip;
	/**
	 * 登录城市
	 */
	private String city;
	/**
	 * 登录类型：1-web，2-app
	 */
	private Integer loginType;

}
