package com.platform.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.platform.dao.ApiOrderProcessMapper;
import com.platform.entity.OrderProcessVo;

@Service
public class ApiOrderProcessService {
    @Autowired
    private ApiOrderProcessMapper orderProcessDao;

    public List<OrderProcessVo> getOrderProcessList(Map<String, Object> map) {
	return orderProcessDao.queryList(map);

    }
}
