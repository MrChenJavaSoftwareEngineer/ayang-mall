package com.ayang.ayangware.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ayang.ayangcommon.utils.PageUtils;
import com.ayang.ayangware.entity.WmsWareOrderTaskDetailEntity;

import java.util.Map;

/**
 * 库存工作单详情
 *
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:33:18
 */
public interface WmsWareOrderTaskDetailService extends IService<WmsWareOrderTaskDetailEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

