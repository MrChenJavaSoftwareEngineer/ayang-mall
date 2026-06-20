package com.ayang.ayangorder.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ayang.ayangcommon.utils.PageUtils;
import com.ayang.ayangorder.entity.OmsOrderReturnReasonEntity;

import java.util.Map;

/**
 * 退货原因表
 *
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:21:59
 */
public interface OmsOrderReturnReasonService extends IService<OmsOrderReturnReasonEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

