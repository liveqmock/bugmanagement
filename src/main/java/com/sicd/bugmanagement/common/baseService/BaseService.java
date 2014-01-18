package com.sicd.bugmanagement.common.baseService;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;


public interface BaseService {
	
	Session getCurrentSession();
	
	void delete(Object object);
	
	<T> void deleteAll(List<T> list);

	void saveOrUpdate(Object object);
	
	void save(Object object);
	
	<T> void saveAll(List<T> list);
	
	void update(Object object);

	<T> void updateAll(List<T> objList);
	
	public<T> List<T> queryAll(Class<T> clazz);
	
	public<T> List<T> queryMaxNumOfCondition(Class<T> clazz,DetachedCriteria dCriteria,int num);
	
	<T> List<T> queryAllOfCondition(Class<T> clazz,DetachedCriteria dCriteria);

	
	<T> T findById(Class<T> clazz, int id);
	
	void deleteById(Class<?> clazz, int id);
	
    int countTotalPage(Class<?>  clazz,int pageSize);
    
    int countTotalSize(DetachedCriteria dCriteria);
	
	int countTotalPage(DetachedCriteria dCriteria,int pageSize);
	
	<T> List<T> getByPage(Class<T> clazz,int pageSize);
	
    List<?> getByPage(DetachedCriteria dCriteria,int pageSize);
}