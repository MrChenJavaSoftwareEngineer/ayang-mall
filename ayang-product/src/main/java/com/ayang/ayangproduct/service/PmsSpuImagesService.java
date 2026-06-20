package com.ayang.ayangproduct.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ayang.ayangcommon.utils.PageUtils;
import com.ayang.ayangproduct.entity.PmsSpuImagesEntity;

import java.util.Map;

/**
 * spu图片
 *
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:29:22
 */
public interface PmsSpuImagesService extends IService<PmsSpuImagesEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

