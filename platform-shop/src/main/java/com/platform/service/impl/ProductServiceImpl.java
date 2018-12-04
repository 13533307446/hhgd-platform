package com.platform.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.platform.dao.GoodsSpecificationDao;
import com.platform.dao.ProductDao;
import com.platform.entity.GoodsSpecificationEntity;
import com.platform.entity.ProductEntity;
import com.platform.service.ProductService;
import com.platform.utils.BeanUtils;
import com.platform.utils.StringUtils;

/**
 * Service实现类
 *
 * @author lipengjun
 * @email 939961241@qq.com
 * @date 2017-08-30 14:31:21
 */
@Service("productService")
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductDao productDao;
    @Autowired
    private GoodsSpecificationDao goodsSpecificationDao;

    @Override
    public ProductEntity queryObject(Integer id) {
	ProductEntity productEntity= productDao.queryObject(id);
	if(null!=productEntity) {
	    String specificationIds = productEntity.getGoodsSpecificationIds();
		String specificationValue = "";
		if (!StringUtils.isNullOrEmpty(specificationIds)) {
		    String[] arr = specificationIds.split("_");

		    for (String goodsSpecificationId : arr) {
			GoodsSpecificationEntity entity = goodsSpecificationDao.queryObject(goodsSpecificationId);
			if (null != entity) {
			    specificationValue += entity.getValue() + "；";
			}
		    }
		productEntity.setSpecificationValue(specificationValue);
		    
	}
    }
	return productEntity;
    }

    @Override
    public List<ProductEntity> queryList(Map<String, Object> map) {
	List<ProductEntity> list = productDao.queryList(map);

	List<ProductEntity> result = new ArrayList<>();
	// 翻译产品规格
	if (null != list && list.size() > 0) {
	    for (ProductEntity item : list) {
		String specificationIds = item.getGoodsSpecificationIds();
		String specificationValue = "";
		if (!StringUtils.isNullOrEmpty(specificationIds)) {
		    String[] arr = specificationIds.split("_");

		    for (String goodsSpecificationId : arr) {
			GoodsSpecificationEntity entity = goodsSpecificationDao.queryObject(goodsSpecificationId);
			if (null != entity) {
			    specificationValue += entity.getValue() + "；";
			}
		    }
		}
		item.setSpecificationValue(item.getGoodsName() + " " + specificationValue);
		result.add(item);
	    }
	}
	return result;
    }

    @Override
    public int queryTotal(Map<String, Object> map) {
	return productDao.queryTotal(map);
    }

    @Override
    @Transactional
    public int save(ProductEntity product) {
	int result = 0;
	// 从前端传递过来的原值
	String goodsSpecificationIdsAll = product.getGoodsSpecificationIds();
	System.out.println(goodsSpecificationIdsAll);
	// 用于存放规格类型ID
	Set<String> specificationIdSet = new HashSet<>();
	// 所有产品规格的数组包含类型和具体值
	String[] goodsSpecificationIds = goodsSpecificationIdsAll.split(",");
	// 循环产品规格得数组
	for (String productSpecificationId : goodsSpecificationIds) {
	    // 分割出单个规格的类型和具体值
	    String[] kv = productSpecificationId.split(":");
	    // 0为类型
	    String key = kv[0];
	    // 将类型放入集合中
	    specificationIdSet.add(key);
	}
	Map<String, List<String>> sp_productSpList_Map = new HashMap<String, List<String>>();
	for (String spId : specificationIdSet) {
	    sp_productSpList_Map.put(spId, new ArrayList<String>());
	}

	for (String productSpecificationId : goodsSpecificationIds) {
	    String[] kv = productSpecificationId.split(":");
	    String key = kv[0];
	    String value = kv[1];
	    // 通过key获取到了当前组的集合然后直接把数据塞入相应KEY的集合中
	    sp_productSpList_Map.get(key).add(value);
	}
	    List<String> sortOrder = getSortOrder(specificationIdSet);

	    // 处理后的数据
	    List<String> resultList = new ArrayList<>();
	    // 获取排序第一的规格
	    List<String> spIds = sp_productSpList_Map.get(sortOrder.get(0));
	    for (String id : spIds) {
		resultList.add(id);
	    }
	    // 从排序第二条规格开始处理
	    for (int i = 1; i < sortOrder.size(); i++) {
		// 处理中的数据中间结果
		List<String> mResultList = new ArrayList<>();
		// 根据排序的规格，获取对应商品规格id
		List<String> subSpIds = sp_productSpList_Map.get(sortOrder.get(i));
		// 获取之前拼接的商品规格中间值
		for (String perSpIds : resultList) {
		    // 遍历当前需要拼接的商品规格id
		    for (String subSpId : subSpIds) {
			// 拼接
			mResultList.add(perSpIds + "_" + subSpId);

		    }
		    
		    }
		// 替换结果
		resultList = mResultList;

		mResultList = null;
		}
	    System.out.println(resultList);
	for (String s : resultList) {
	    ProductEntity entity = new ProductEntity();
	    BeanUtils.copyProperties(product, entity);
	    entity.setGoodsSpecificationIds(s);
	    result += productDao.save(entity);
	}
	return result;
	}

    public static List<String> getSortOrder(Set<String> sets) {
	List<String> sortOrder = new ArrayList<String>();
	   	for (String id:sets) {
	    sortOrder.add(id);
		}
	

	return sortOrder;
  }

    @Override
    public int update(ProductEntity product) {
	// if (StringUtils.isNullOrEmpty(product.getGoodsSpecificationIds())){
	// product.setGoodsSpecificationIds("");
	// }

	// 暂时不开放更新产品规格的信息
	product.setGoodsSpecificationIds(null);

	return productDao.update(product);
    }

    @Override
    public int delete(Integer id) {
	return productDao.delete(id);
    }

    @Override
    public int deleteBatch(Integer[] ids) {
	return productDao.deleteBatch(ids);
    }
}
