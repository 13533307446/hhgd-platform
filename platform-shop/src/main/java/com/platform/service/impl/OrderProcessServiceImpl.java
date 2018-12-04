package com.platform.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.platform.dao.OrderProcessDao;
import com.platform.entity.OrderProcessEntity;
import com.platform.service.OrderProcessService;

/**
 * Service实现类
 *
 * @author lipengjun
 * @email 939961241@qq.com
 * @date 2018-07-30 13:48:56
 */
@Service("orderProcessService")
public class OrderProcessServiceImpl implements OrderProcessService {
    @Autowired
    private OrderProcessDao orderProcessDao;

    @Override
    public OrderProcessEntity queryObject(Integer id) {
        return orderProcessDao.queryObject(id);
    }

    @Override
    public List<OrderProcessEntity> queryList(Map<String, Object> map) {
        return orderProcessDao.queryList(map);
    }

    @Override
    public int queryTotal(Map<String, Object> map) {
        return orderProcessDao.queryTotal(map);
    }

    @Override
    public int save(OrderProcessEntity orderProcess) {
        return orderProcessDao.save(orderProcess);
    }

    @Override
    public int update(OrderProcessEntity orderProcess) {
        return orderProcessDao.update(orderProcess);
    }

    @Override
    public int delete(Integer id) {
        return orderProcessDao.delete(id);
    }

    @Override
    public int deleteBatch(Integer[]ids) {
        return orderProcessDao.deleteBatch(ids);
    }
}
