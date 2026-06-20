package com.ayang.ayangmember.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 会员收藏的商品
 * 
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:13:20
 */
@Data
@TableName("ums_member_collect_spu")
public class MemberCollectSpuEntity implements Serializable {
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
	 * 商品spu_id
	 */
	private Long spuId;
	/**
	 * 商品名称
	 */
	private String spuName;
	/**
	 * 商品图片
	 */
	private String spuImg;
	/**
	 * 创建时间
	 */
	private Date createTime;

}
