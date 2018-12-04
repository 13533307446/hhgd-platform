package com.platform.dao;

import java.util.List;

import com.platform.entity.OrderEntity;

/**
 * 
 * 
 * @author lipengjun
 * @email 939961241@qq.com
 * @date 2017-08-13 10:41:09
 */
public interface OrderDao extends BaseDao<OrderEntity> {
	List<OrderEntity> queryDownloadList(Integer[] ids);
}
