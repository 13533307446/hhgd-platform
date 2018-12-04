package com.platform.service;

import com.platform.entity.OrderProcessEntity;

import java.util.List;
import java.util.Map;

/**
 * Service接口
 *
 * @author lipengjun
 * @email 939961241@qq.com
 * @date 2018-07-30 13:48:56
 */
public interface OrderProcessService {

    /**
     * 根据主键查询实体
     *
     * @param id 主键
     * @return 实体
     */
    OrderProcessEntity queryObject(Integer id);

    /**
     * 分页查询
     *
     * @param map 参数
     * @return list
     */
    List<OrderProcessEntity> queryList(Map<String, Object> map);

    /**
     * 分页统计总数
     *
     * @param map 参数
     * @return 总数
     */
    int queryTotal(Map<String, Object> map);

    /**
     * 保存实体
     *
     * @param orderProcess 实体
     * @return 保存条数
     */
    int save(OrderProcessEntity orderProcess);

    /**
     * 根据主键更新实体
     *
     * @param orderProcess 实体
     * @return 更新条数
     */
    int update(OrderProcessEntity orderProcess);

    /**
     * 根据主键删除
     *
     * @param id
     * @return 删除条数
     */
    int delete(Integer id);

    /**
     * 根据主键批量删除
     *
     * @param ids
     * @return 删除条数
     */
    int deleteBatch(Integer[]ids);
}
