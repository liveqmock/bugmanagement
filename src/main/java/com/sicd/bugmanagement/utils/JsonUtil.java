package com.sicd.bugmanagement.utils;

import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Iterator;

public class JsonUtil {
	
	/**
	 * @param object
	 *            任意对象
	 * @return java.lang.String
	 */
	public static String objectToJson(Object object){
		StringBuffer json = new StringBuffer();
		if(object == null){
			json.append("\"\"");
		} else if(object instanceof String || object instanceof Integer){
			json.append("\"").append((String) object).append("\"");
		} else if(object instanceof Map){
			json.append(mapToJson((Map<String, Object>)object));
		} else {
			json.append(beanToJson(object));
		}
		return json.toString();		
	}
	
	/**
	 * 功能描述:传入任意一个 javabean 对象生成一个指定规格的字符串
	 * 
	 * @param bean
	 *            bean对象
	 * @return String
	 */
	public static String beanToJson(Object bean){
		StringBuilder json = new StringBuilder();
		json.append("{");
		PropertyDescriptor[] props = null;
		try{
			props = Introspector.getBeanInfo(bean.getClass(), Object.class).getPropertyDescriptors();
		} catch (IntrospectionException e) {
			
		}
		
		if(props != null){
			
			for(int i = 0; i < props.length; i++){
				try{
					String name = objectToJson(props[i].getName());
					String value = objectToJson(props[i].getReadMethod().invoke(bean));
					json.append(name);
					json.append(":");
					json.append(value);
					json.append(",");
				} catch ( Exception e) {
					
				}
			}			
			json.setCharAt(json.length() - 1, '}');
			
		} else {
			json.append("}");
		}
		
		return json.toString();
	}
	
	
	/**
	 * 功能描述:传入Map<String,Object> 对象生成一个指定规格的字符串
	 * 
	 * @param map
	 *            map对象
	 * @return String
	 */
	public static String mapToJson(Map<String,Object> map){
		StringBuffer json = new StringBuffer();
		json.append("{");
		Set<String> keySet = map.keySet();
		Iterator<String> iter = keySet.iterator();
		if(iter.hasNext()){
			int tag = 0;
			while(iter.hasNext()){
				String key = iter.next();
				String value = String.valueOf(map.get(key));
				json.append(key);
				json.append(":");
//				if(tag==0){
					json.append("\"");
//				}
				json.append(value);
//				if(tag==0){
					json.append("\"");
//				}
				json.append(",");
				tag++;
			}
			json.setCharAt(json.length() - 1, '}');
		} else {
			json.append("}");
		}
		return json.toString();
	}
	
	public static String mapToJson1(Map<String,Object> map){
		StringBuffer json = new StringBuffer();
		json.append("{");
		Set<String> keySet = map.keySet();
		Iterator<String> iter = keySet.iterator();
		if(iter.hasNext()){
			int tag = 0;
			while(iter.hasNext()){
				String key = iter.next();
				String value = String.valueOf(map.get(key));
				json.append(key);
				json.append(":");
				json.append(value);
				json.append(",");
				tag++;
			}
			json.setCharAt(json.length() - 1, '}');
		} else {
			json.append("}");
		}
		return json.toString();
	}
	/**
	 * 功能描述:通过传入一个列表对象,调用指定方法将列表中的数据生成一个JSON规格指定字符串
	 * 
	 * @param list
	 *            列表对象
	 * @return java.lang.String
	 */
	public static String listToJson(List<?> list){
		StringBuilder json = new StringBuilder();
		json.append("[");
		if(list != null && list.size() > 0) {
			for( Object obj : list) {
				json.append(objectToJson(obj));
				json.append(",");
			}
			json.setCharAt(json.length() - 1, ']');
		} else {
			json.append("]"); 
		}
		return json.toString();
	}
	
}
