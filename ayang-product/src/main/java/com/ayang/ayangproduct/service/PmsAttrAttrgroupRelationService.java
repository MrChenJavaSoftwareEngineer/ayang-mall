package com.ayang.ayangproduct.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ayang.ayangcommon.utils.PageUtils;
import com.ayang.ayangproduct.entity.PmsAttrAttrgroupRelationEntity;

import java.util.Map;

/**
 * 属性&属性分组关联
 *
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:29:22
 */
public interface PmsAttrAttrgroupRelationService extends IService<PmsAttrAttrgroupRelationEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

