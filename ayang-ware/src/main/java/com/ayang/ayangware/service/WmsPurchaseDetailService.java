package com.ayang.ayangware.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ayang.ayangcommon.utils.PageUtils;
import com.ayang.ayangware.entity.WmsPurchaseDetailEntity;

import java.util.Map;

/**
 * 采购需求详情
 *
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:33:17
 */
public interface WmsPurchaseDetailService extends IService<WmsPurchaseDetailEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

