package com.platform.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.platform.entity.OrderEntity;
import com.platform.service.OrderService;
import com.platform.utils.DateUtils;
import com.platform.utils.PageUtils;
import com.platform.utils.Query;
import com.platform.utils.R;
import com.platform.utils.excel.ExcelExport;


/**
 * @author lipengjun
 * @email 939961241@qq.com
 * @date 2017-08-13 10:41:09
 */
@RestController
@RequestMapping("order")
public class OrderController extends AbstractController {
    @Autowired
    private OrderService orderService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("order:list")
    public R list(@RequestParam Map<String, Object> params) {
        //查询列表数据
        Query query = new Query(params);

        List<OrderEntity> orderList = orderService.queryList(query);
        int total = orderService.queryTotal(query);

        PageUtils pageUtil = new PageUtils(orderList, total, query.getLimit(), query.getPage());

        return R.ok().put("page", pageUtil);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("order:info")
    public R info(@PathVariable("id") Integer id) {
        OrderEntity order = orderService.queryObject(id);

        return R.ok().put("order", order);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("order:save")
    public R save(@RequestBody OrderEntity order) {
        orderService.save(order);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("order:update")
    public R update(@RequestBody OrderEntity order) {
        orderService.update(order);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("order:delete")
    public R delete(@RequestBody Integer[] ids) {
        orderService.deleteBatch(ids);

        return R.ok();
    }

    /**
     * 查看所有列表
     */
    @RequestMapping("/queryAll")
    public R queryAll(@RequestParam Map<String, Object> params) {

        List<OrderEntity> list = orderService.queryList(params);

        return R.ok().put("list", list);
    }

    /**
     * 总计
     */
    @RequestMapping("/queryTotal")
    public R queryTotal(@RequestParam Map<String, Object> params) {
        int sum = orderService.queryTotal(params);

        return R.ok().put("sum", sum);
    }

    /**
     * 确定收货
     *
     * @param id
     * @return
     */
    @RequestMapping("/confirm")
    @RequiresPermissions("order:confirm")
    public R confirm(@RequestBody Integer id) {
        orderService.confirm(id);

        return R.ok();
    }

    /**
     * 发货
     *
     * @param order
     * @return
     */
    @RequestMapping("/sendGoods")
    @RequiresPermissions("order:sendGoods")
    public R sendGoods(@RequestBody OrderEntity order) {
	order.setHandler(getUser().getUsername());
        orderService.sendGoods(order);

        return R.ok();
    }

    /**
     * 更新进度
     * 
     */
    @RequestMapping("/updateprogress")
    @RequiresPermissions("order:updateprogress")
    public R updateprogress(@RequestBody OrderEntity order) {
	orderService.updatepProgress(order);
	return R.ok();
    }

	/**
	 * 下载云系统录单数据
	 * 
	 */
	@RequestMapping("/downloadOrder")
	@RequiresPermissions("order:downloadOrder")
	public void downloadOrder(String ids, HttpServletResponse response)
			throws IOException {
		String[] idArray = ids.split(",");
		Integer[] idsInt = new Integer[idArray.length];

		for (int i = 0; i < idArray.length; i++) {
			idsInt[i] = Integer.parseInt(idArray[i]);
		}
		List<OrderEntity> orderList = orderService.queryDownloadList(idsInt);

		ExcelExport ee = new ExcelExport("wxOrder.xls");

		String[] header = new String[] { "订单号", "订单状态", "下单时间", "订单变更时间", "供应商", "收货时间", "收货人", "收货地址", "联系电话", "座机号",
				"邮编", "是否导出", "导出时间", "发票信息", "发票金额", "备注", "PO", "品牌", "商品名称", "数量", "尺寸", "货品", "条码", "单价", "渠道来源",
				"省", "市", "区" };

		List<Map<String, Object>> list = new ArrayList<>();
		if (CollectionUtils.isNotEmpty(orderList)) {
			for (int i = 0; i < orderList.size(); i++) {
				OrderEntity orderEntity = orderList.get(i);

				LinkedHashMap<String, Object> map = new LinkedHashMap<>();

				//按顺序
				if (orderList.size() > 1) {
					map.put("1", orderEntity.getOrderSn() + "_" + (i + 1));
				} else {
					map.put("1", orderEntity.getOrderSn());
				}

				map.put("2", orderEntity.getOrderStatusText());
				map.put("3", DateUtils.format(orderEntity.getPayTime(), DateUtils.DATE_TIME_PATTERN));
				map.put("4", DateUtils.format(orderEntity.getPayTime(), DateUtils.DATE_TIME_PATTERN));
				map.put("5", "广州酷漫居动漫科技有限公司");
				map.put("6", "");
				map.put("7", orderEntity.getConsignee());
				map.put("8", orderEntity.getAddress());
				map.put("9", orderEntity.getMobile());
				map.put("10", "-");
				map.put("11", "-");
				map.put("12", "-");
				map.put("13", "-");
				map.put("14", "-");
				map.put("15", orderEntity.getRetailPrice());
				map.put("16", orderEntity.getPostscript());
				map.put("17", "-");
				map.put("18", "酷漫居");
				map.put("19", orderEntity.getGoodsName());
				map.put("20", orderEntity.getNumber());
				map.put("21", orderEntity.getGoodsSpecifitionNameValue());
				map.put("22", orderEntity.getGoodsSn());
				map.put("23", orderEntity.getGoodsSn());
				map.put("24", orderEntity.getRetailPrice());
				map.put("25", "微信商城");
				map.put("26", orderEntity.getProvince());
				map.put("27", orderEntity.getCity());
				map.put("28", orderEntity.getDistrict());

				list.add(map);
			}
		}

		ee.addSheetByMap("wxOrder", list, header);
		ee.export(response);
	}
}
