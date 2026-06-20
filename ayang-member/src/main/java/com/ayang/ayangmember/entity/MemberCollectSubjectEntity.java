package com.ayang.ayangmember.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 会员收藏的专题活动
 * 
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:13:20
 */
@Data
@TableName("ums_member_collect_subject")
public class MemberCollectSubjectEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 主键id
	 */
	@TableId
	private Long id;
	/**
	 * 专题活动id
	 */
	private Long subjectId;
	/**
	 * 专题活动名称
	 */
	private String subjectName;
	/**
	 * 专题活动图片
	 */
	private String subjectImg;
	/**
	 * 活动url
	 */
	private String subjectUrll;

}
