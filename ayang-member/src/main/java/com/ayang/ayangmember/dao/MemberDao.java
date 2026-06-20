package com.ayang.ayangmember.dao;

import com.ayang.ayangmember.entity.MemberEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 会员
 * 
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:13:20
 */
@Mapper
public interface MemberDao extends BaseMapper<MemberEntity> {
	
}
