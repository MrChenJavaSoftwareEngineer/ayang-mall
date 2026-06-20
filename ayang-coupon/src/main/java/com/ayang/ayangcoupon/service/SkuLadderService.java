package com.ayang.ayangcoupon.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ayang.ayangcommon.utils.PageUtils;
import com.ayang.ayangcoupon.entity.SkuLadderEntity;

import java.util.Map;

/**
 * 商品阶梯价格
 *
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-18 22:10:26
 */
public interface SkuLadderService extends IService<SkuLadderEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

