package com.ayang.ayangorder.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ayang.ayangcommon.utils.PageUtils;
import com.ayang.ayangorder.entity.OmsOrderItemEntity;

import java.util.Map;

/**
 * 订单商品明细表
 *
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:21:59
 */
public interface OmsOrderItemService extends IService<OmsOrderItemEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

