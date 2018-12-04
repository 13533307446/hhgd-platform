package com.platform.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.platform.entity.OrderProcessEntity;
import com.platform.service.OrderProcessService;
import com.platform.utils.PageUtils;
import com.platform.utils.Query;
import com.platform.utils.R;

/**
 * Controller
 *
 * @author lipengjun
 * @email 939961241@qq.com
 * @date 2018-07-30 13:48:56
 */
@Controller
@RequestMapping("orderprocess")
public class OrderProcessController extends AbstractController {
    @Autowired
    private OrderProcessService orderProcessService;

    /**
     * 查看列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("orderprocess:list")
    @ResponseBody
    public R list(@RequestParam Map<String, Object> params) {
        //查询列表数据
        Query query = new Query(params);

        List<OrderProcessEntity> orderProcessList = orderProcessService.queryList(query);
        int total = orderProcessService.queryTotal(query);

        PageUtils pageUtil = new PageUtils(orderProcessList, total, query.getLimit(), query.getPage());

        return R.ok().put("page", pageUtil);
    }

    /**
     * 查看信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("orderprocess:info")
    @ResponseBody
    public R info(@PathVariable("id") Integer id) {
        OrderProcessEntity orderProcess = orderProcessService.queryObject(id);

        return R.ok().put("orderProcess", orderProcess);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("orderprocess:save")
    @ResponseBody
    public R save(@RequestBody OrderProcessEntity orderProcess) {
	orderProcess.setAddTime(new Date());
	orderProcess.setSysUsername(getUser().getUsername());
        orderProcessService.save(orderProcess);


        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("orderprocess:update")
    @ResponseBody
    public R update(@RequestBody OrderProcessEntity orderProcess) {
        orderProcessService.update(orderProcess);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("orderprocess:delete")
    @ResponseBody
    public R delete(@RequestBody Integer[]ids) {
        orderProcessService.deleteBatch(ids);

        return R.ok();
    }

    /**
     * 查看所有列表
     */
    @RequestMapping("/queryAll")
    @ResponseBody
    public R queryAll(@RequestParam Map<String, Object> params) {

        List<OrderProcessEntity> list = orderProcessService.queryList(params);

        return R.ok().put("list", list);
    }
}
