package com.platform.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.platform.dao.ApiAddressMapper;
import com.platform.entity.AddressVo;


@Service
public class ApiAddressService {
    @Autowired
    private ApiAddressMapper addressDao;


    public AddressVo queryObject(Integer id) {
        return addressDao.queryObject(id);
    }


    public List<AddressVo> queryList(Map<String, Object> map) {
        return addressDao.queryList(map);
    }


    public int queryTotal(Map<String, Object> map) {
        return addressDao.queryTotal(map);
    }


	@Transactional
    public void save(AddressVo address) {
		//如果是默认地址则更新该用户的其他地址为非默认
    	if(address.getIs_default() == 1) {
			addressDao.updateAllDefaultAddr0ByUserId(address.getUserId());
    	}
        addressDao.save(address);
    }

	@Transactional
    public void update(AddressVo address) {
		//如果是默认地址则更新该用户的其他地址为非默认
		if (address.getIs_default() == 1) {
			addressDao.updateAllDefaultAddr0ByUserId(address.getUserId());
		}
        addressDao.update(address);
    }


    public void delete(Integer id) {
        addressDao.delete(id);
    }


    public void deleteBatch(Integer[] ids) {
        addressDao.deleteBatch(ids);
    }

}
