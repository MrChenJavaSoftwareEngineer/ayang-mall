package com.ayang.ayangproduct.controller;

import java.util.Arrays;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ayang.ayangproduct.entity.PmsSpuCommentEntity;
import com.ayang.ayangproduct.service.PmsSpuCommentService;
import com.ayang.ayangcommon.utils.PageUtils;
import com.ayang.ayangcommon.utils.R;



/**
 * 商品评价
 *
 * @author ayang
 * @email 3648901811@qq.com
 * @date 2026-06-20 09:29:22
 */
@RestController
@RequestMapping("ayangproduct/pmsspucomment")
public class PmsSpuCommentController {
    @Autowired
    private PmsSpuCommentService pmsSpuCommentService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    //@RequiresPermissions("ayangproduct:pmsspucomment:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = pmsSpuCommentService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    //@RequiresPermissions("ayangproduct:pmsspucomment:info")
    public R info(@PathVariable("id") Long id){
		PmsSpuCommentEntity pmsSpuComment = pmsSpuCommentService.getById(id);

        return R.ok().put("pmsSpuComment", pmsSpuComment);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    //@RequiresPermissions("ayangproduct:pmsspucomment:save")
    public R save(@RequestBody PmsSpuCommentEntity pmsSpuComment){
		pmsSpuCommentService.save(pmsSpuComment);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    //@RequiresPermissions("ayangproduct:pmsspucomment:update")
    public R update(@RequestBody PmsSpuCommentEntity pmsSpuComment){
		pmsSpuCommentService.updateById(pmsSpuComment);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    //@RequiresPermissions("ayangproduct:pmsspucomment:delete")
    public R delete(@RequestBody Long[] ids){
		pmsSpuCommentService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
