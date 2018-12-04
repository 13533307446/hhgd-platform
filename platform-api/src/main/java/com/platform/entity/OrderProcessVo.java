package com.platform.entity;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;


/**
 * 实体
 * 表名 nideshop_order_process
 *
 * @author lipengjun
 * @email 939961241@qq.com
 * @date 2018-07-30 13:48:56
 */
public class OrderProcessVo implements Serializable {
    private static final long serialVersionUID = 1L;

    //
    private Integer id;
    //
    private Integer orderId;
    //添加时间
    private Date addTime;
    //进度描述
    private String desc;
    //记录人
    private String sysUsername;




    /**
     * 设置：
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * 获取：
     */
    public Integer getId() {
        return id;
    }
    /**
     * 设置：
     */
    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    /**
     * 获取：
     */
    public Integer getOrderId() {
        return orderId;
    }
    /**
     * 设置：添加时间
     */
    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    /**
     * 获取：添加时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    public Date getAddTime() {
        return addTime;
    }
    /**
     * 设置：进度描述
     */
    public void setDesc(String desc) {
        this.desc = desc;
    }

    /**
     * 获取：进度描述
     */
    public String getDesc() {
        return desc;
    }
    /**
     * 设置：记录人
     */
    public void setSysUsername(String sysUsername) {
        this.sysUsername = sysUsername;
    }

    /**
     * 获取：记录人
     */
    public String getSysUsername() {
        return sysUsername;
    }
}
