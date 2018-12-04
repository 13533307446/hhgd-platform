package com.platform.api;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


import com.platform.service.ApiOrderProcessService;
import com.platform.util.ApiBaseAction;

/**
 * Controller
 *
 * @author lipengjun
 * @email 939961241@qq.com
 * @date 2018-07-30 13:48:56
 */
@RestController
@RequestMapping("/api/orderProcess")
public class ApiOrderProcessControlle extends ApiBaseAction {
    @Autowired
    private ApiOrderProcessService apiOrderProcessService;


    /**
     * 查看列表
     */
  
    @RequestMapping("/querylist")
    public Object list(@RequestParam Integer orderId) {
	Map resultObj = new HashMap();
	Map<String, Object> params = new HashMap<String, Object>();
	params.put("orderId", orderId);
	resultObj.put("orderProcess", apiOrderProcessService.getOrderProcessList(params));
	return toResponsSuccess(resultObj);

    }
    
    }

