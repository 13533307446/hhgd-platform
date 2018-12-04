package com.platform.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.platform.dao.OrderDao;
import com.platform.dao.ShippingDao;
import com.platform.entity.OrderEntity;
import com.platform.entity.ShippingEntity;
import com.platform.service.OrderService;
import com.platform.utils.RRException;


@Service("orderService")
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderDao orderDao;
    @Autowired
    private ShippingDao shippingDao;

    @Override
    public OrderEntity queryObject(Integer id) {
        return orderDao.queryObject(id);
    }

    @Override
    public List<OrderEntity> queryList(Map<String, Object> map) {
        return orderDao.queryList(map);
    }

	@Override
	public List<OrderEntity> queryDownloadList(Integer[] ids) {
		return orderDao.queryDownloadList(ids);
	}

    @Override
    public int queryTotal(Map<String, Object> map) {
        return orderDao.queryTotal(map);
    }

    @Override
    public int save(OrderEntity order) {
        return orderDao.save(order);
    }

    @Override
    public int update(OrderEntity order) {
        return orderDao.update(order);
    }

    @Override
    public int delete(Integer id) {
        return orderDao.delete(id);
    }

    @Override
    public int deleteBatch(Integer[] ids) {
        return orderDao.deleteBatch(ids);
    }

    @Override
    public int confirm(Integer id) {
        OrderEntity orderEntity = queryObject(id);
        Integer shippingStatus = orderEntity.getShippingStatus();//发货状态
        Integer payStatus = orderEntity.getPayStatus();//付款状态
		Integer orderStatus = orderEntity.getOrderStatus(); //订单状态
        if (2 != payStatus) {
            throw new RRException("此订单未付款，不能确认收货！");
        }
        if (4 == shippingStatus) {
            throw new RRException("此订单处于退货状态，不能确认收货！");
        }
        if (0 == shippingStatus) {
            throw new RRException("此订单未发货，不能确认收货！");
        }

		if (301 == orderStatus) {
			throw new RRException("订单已经确认收货！");
		}

        orderEntity.setShippingStatus(2);
		orderEntity.setOrderStatus(301);
		orderEntity.setConfirmTime(new Date());
		orderDao.update(orderEntity);

        return 0;
    }

    @Override
    public int sendGoods(OrderEntity order) {
	Integer orderStatus = order.getOrderStatus();// 订单状态
	if (201 != orderStatus) {
	    throw new RRException("此订单当前状态不可发货！");
        }


        ShippingEntity shippingEntity = shippingDao.queryObject(order.getShippingId());
        if (null != shippingEntity) {
            order.setShippingName(shippingEntity.getName());
        }
        order.setOrderStatus(300);//订单已发货
        order.setShippingStatus(1);//已发货
	order.setShippingTime(new Date());
        return orderDao.update(order);
    }

    @Override
    public int updatepProgress(OrderEntity order) {
	Integer orderStatus = order.getOrderStatus();// 付款状态

	if (201 != orderStatus) {
	    throw new RRException("该订单非待发货状态，不可编辑进度！");
	}

	
	return orderDao.update(order);
    }
}
