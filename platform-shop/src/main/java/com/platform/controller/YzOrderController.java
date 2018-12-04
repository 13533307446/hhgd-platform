package com.platform.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.platform.utils.DateUtils;
import com.platform.utils.ResourceUtil;
import com.platform.utils.excel.ExcelExport;
import com.youzan.open.sdk.client.auth.Token;
import com.youzan.open.sdk.client.core.DefaultYZClient;
import com.youzan.open.sdk.client.core.YZClient;
import com.youzan.open.sdk.client.oauth.OAuth;
import com.youzan.open.sdk.client.oauth.OAuthContext;
import com.youzan.open.sdk.client.oauth.OAuthFactory;
import com.youzan.open.sdk.client.oauth.OAuthType;
import com.youzan.open.sdk.gen.v3_0_0.api.YouzanTradesSoldGet;
import com.youzan.open.sdk.gen.v3_0_0.model.YouzanTradesSoldGetParams;
import com.youzan.open.sdk.gen.v3_0_0.model.YouzanTradesSoldGetResult;
import com.youzan.open.sdk.gen.v3_0_0.model.YouzanTradesSoldGetResult.TradeDetailV2;
import com.youzan.open.sdk.gen.v3_0_0.model.YouzanTradesSoldGetResult.TradeOrderV2;

@RestController
@RequestMapping("/yzorder")
public class YzOrderController {
	@RequestMapping("/downloadOrder")
	@RequiresPermissions("order:downloadOrder")
	public void downloadOrder(@RequestParam Map<String, Object> params, HttpServletResponse response) {
		// 获取自有的Token
		OAuth oauth = OAuthFactory.create(OAuthType.SELF,
				new OAuthContext(ResourceUtil.getConfigByName("yz.clientId"),
						ResourceUtil.getConfigByName("yz.clientSecret"),
						Long.valueOf(ResourceUtil.getConfigByName("yz.shopid"))));
		YZClient yzClient = new DefaultYZClient(new Token(oauth.getToken().getAccessToken()));
		YouzanTradesSoldGetParams youzanTradesSoldOuterGetParams = new YouzanTradesSoldGetParams();

		if (null != params && params.size() != 0) {
			// 如果有选择参数就对参数进行格式化并放入请求参数中

			if (params.containsKey("orderStatus")) {
				youzanTradesSoldOuterGetParams.setStatus(params.get("orderStatus").toString());
			}
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			try {
				youzanTradesSoldOuterGetParams.setStartCreated(sdf.parse(params.get("starttime").toString()));
				youzanTradesSoldOuterGetParams.setEndCreated(sdf.parse(params.get("endtime").toString()));
			} catch (ParseException e) {

			}
		}

		YouzanTradesSoldGet YouzanTradesSoldGet = new YouzanTradesSoldGet();

		YouzanTradesSoldGet.setAPIParams(youzanTradesSoldOuterGetParams);

		YouzanTradesSoldGetResult result = yzClient.invoke(YouzanTradesSoldGet);
		// 外层循环可循环出有多少订单
		List<Map<String, Object>> list = new ArrayList<>();
		ExcelExport ee = new ExcelExport("wxOrder.xls");

		String[] header = new String[] { "订单号", "订单状态", "下单时间", "订单变更时间", "供应商", "收货时间", "收货人", "收货地址", "联系电话", "座机号",
				"邮编", "是否导出", "导出时间", "发票信息", "发票金额", "备注", "PO", "品牌", "商品名称", "数量", "尺寸", "货品", "条码", "单价", "渠道来源",
				"省", "市", "区" };

		for (TradeDetailV2 order : result.getTrades()) {

			TradeOrderV2[] d = order.getOrders();
			// 每个订单号有多少商品和其具体的商品信息
			for (int i = 0; i < d.length; i++) {
				LinkedHashMap<String, Object> map = new LinkedHashMap<>();
				// 如果数组长度大于1 表示有多个商品
				if (d.length > 1) {
					map.put("1", order.getTid() + "_" + (i + 1));

				} else {
					map.put("1", order.getTid());
				}
				map.put("2", order.getStatusStr());
				map.put("3", DateUtils.format(order.getCreated(), DateUtils.DATE_TIME_PATTERN));
				map.put("4", DateUtils.format(order.getUpdateTime(), DateUtils.DATE_TIME_PATTERN));
				map.put("5", "广州酷漫居动漫科技有限公司");
				map.put("6", "");
				map.put("7", order.getReceiverName());
				map.put("8", order.getReceiverAddress());
				map.put("9", order.getReceiverMobile());
				map.put("10", "-");
				map.put("11", order.getReceiverZip());
				map.put("12", "-");
				map.put("13", "-");
				map.put("14", "-");

				//订单金额统一到第一个单
				if (i == 0) {
					map.put("15", order.getPayment());
				} else {
					map.put("15", 0);
				}

				map.put("16", order.getTradeMemo());
				map.put("17", "-");
				map.put("18", "酷漫居");
				map.put("19", d[i].getTitle());
				map.put("20", d[i].getNum());
				map.put("21", d[i].getSkuPropertiesName());
				map.put("22", d[i].getOuterSkuId());
				map.put("23", d[i].getOuterSkuId());

				if (i == 0) {
					map.put("24", order.getPayment());
				} else {
					map.put("24", 0);
				}

				map.put("25", "微信商城");
				map.put("26", order.getReceiverState());
				map.put("27", order.getReceiverCity());
				map.put("28", order.getReceiverDistrict());
				list.add(map);
			}

		}
		ee.addSheetByMap("wxOrder", list, header);
		ee.export(response);
	}

}
