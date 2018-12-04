package com.platform.service.impl;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.platform.dao.GoodsSpecificationDao;
import com.platform.dao.SpecificationDao;
import com.platform.entity.GoodsSpecificationEntity;
import com.platform.entity.SpecificationEntity;
import com.platform.service.SpecificationService;


@Service("specificationService")
public class SpecificationServiceImpl implements SpecificationService {
	@Autowired
	private SpecificationDao specificationDao;
	
	@Autowired
	private GoodsSpecificationDao goodsSpecificationDao;

	@Override
	public SpecificationEntity queryObject(Integer id){
		return specificationDao.queryObject(id);
	}
	
	@Override
	public List<SpecificationEntity> queryList(Map<String, Object> map){
		return specificationDao.queryList(map);
	}
	
	@Override
	public List<SpecificationEntity> queryByGoodsId(Integer goodsId) {
		Map<String, Object> param = new HashMap<>();
		param.put("goodsId", goodsId);
		List<GoodsSpecificationEntity> goodsSpecificationEntityList = goodsSpecificationDao.queryList(param);

		Set<Integer> specificationIdSet = new HashSet<>();
		if(CollectionUtils.isNotEmpty(goodsSpecificationEntityList)) {
			for(GoodsSpecificationEntity goodsSpecificationEntity : goodsSpecificationEntityList) {
				specificationIdSet.add(goodsSpecificationEntity.getSpecificationId());
			}
		}

		return specificationDao.queryByIds(specificationIdSet.toArray());
	}

	@Override
	public int queryTotal(Map<String, Object> map){
		return specificationDao.queryTotal(map);
	}
	
	@Override
	public void save(SpecificationEntity specification){
		specificationDao.save(specification);
	}
	
	@Override
	public void update(SpecificationEntity specification){
		specificationDao.update(specification);
	}
	
	@Override
	public void delete(Integer id){
		specificationDao.delete(id);
	}
	
	@Override
	public void deleteBatch(Integer[] ids){
		specificationDao.deleteBatch(ids);
	}
	
}
