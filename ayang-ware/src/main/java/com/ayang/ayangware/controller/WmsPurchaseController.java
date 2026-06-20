package com.ayang.ayangware.controller;

import java.util.Arrays;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ayang.ayangware.entity.WmsPurchaseEntity;
import com.ayang.ayangware.service.WmsPurchaseService;
import com.ayang.ayangcommon.utils.PageUtils;
import com.ayang.ayangcommon.utils.R;



/**
 * 采购信息
 *
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:33:17
 */
@RestController
@RequestMapping("ayangware/wmspurchase")
public class WmsPurchaseController {
    @Autowired
    private WmsPurchaseService wmsPurchaseService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    //@RequiresPermissions("ayangware:wmspurchase:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = wmsPurchaseService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    //@RequiresPermissions("ayangware:wmspurchase:info")
    public R info(@PathVariable("id") Long id){
		WmsPurchaseEntity wmsPurchase = wmsPurchaseService.getById(id);

        return R.ok().put("wmsPurchase", wmsPurchase);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    //@RequiresPermissions("ayangware:wmspurchase:save")
    public R save(@RequestBody WmsPurchaseEntity wmsPurchase){
		wmsPurchaseService.save(wmsPurchase);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    //@RequiresPermissions("ayangware:wmspurchase:update")
    public R update(@RequestBody WmsPurchaseEntity wmsPurchase){
		wmsPurchaseService.updateById(wmsPurchase);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    //@RequiresPermissions("ayangware:wmspurchase:delete")
    public R delete(@RequestBody Long[] ids){
		wmsPurchaseService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
