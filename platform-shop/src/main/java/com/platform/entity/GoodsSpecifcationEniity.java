package com.platform.entity;

import java.io.Serializable;
import java.util.List;

public class GoodsSpecifcationEniity implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    // 规格名称
    private String GoodsSpecifcationName;
    // 规格信息
    private List<GoodsSpecificationEntity> GoodsSpecifcationInfo;

    public String getGoodsSpecifcationName() {
	return GoodsSpecifcationName;
    }

    public void setGoodsSpecifcationName(String goodsSpecifcationName) {
	GoodsSpecifcationName = goodsSpecifcationName;
    }

    public List<GoodsSpecificationEntity> getGoodsSpecifcationInfo() {
	return GoodsSpecifcationInfo;
    }

    public void setGoodsSpecifcationInfo(List<GoodsSpecificationEntity> goodsSpecifcationInfo) {
	GoodsSpecifcationInfo = goodsSpecifcationInfo;
    }

}
