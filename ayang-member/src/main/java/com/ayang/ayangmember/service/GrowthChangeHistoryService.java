package com.ayang.ayangmember.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ayang.ayangcommon.utils.PageUtils;
import com.ayang.ayangmember.entity.GrowthChangeHistoryEntity;

import java.util.Map;

/**
 * 成长值变化历史记录
 *
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:13:20
 */
public interface GrowthChangeHistoryService extends IService<GrowthChangeHistoryEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

