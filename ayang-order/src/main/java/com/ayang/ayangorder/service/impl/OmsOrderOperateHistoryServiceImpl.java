package com.ayang.ayangorder.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ayang.ayangcommon.utils.PageUtils;
import com.ayang.ayangcommon.utils.Query;

import com.ayang.ayangorder.dao.OmsOrderOperateHistoryDao;
import com.ayang.ayangorder.entity.OmsOrderOperateHistoryEntity;
import com.ayang.ayangorder.service.OmsOrderOperateHistoryService;


@Service("omsOrderOperateHistoryService")
public class OmsOrderOperateHistoryServiceImpl extends ServiceImpl<OmsOrderOperateHistoryDao, OmsOrderOperateHistoryEntity> implements OmsOrderOperateHistoryService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<OmsOrderOperateHistoryEntity> page = this.page(
                new Query<OmsOrderOperateHistoryEntity>().getPage(params),
                new QueryWrapper<OmsOrderOperateHistoryEntity>()
        );

        return new PageUtils(page);
    }

}
