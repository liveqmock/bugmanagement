package com.sicd.bugmanagement.common.tag.pageTag;

import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


import org.springframework.web.bind.ServletRequestUtils;

import com.sicd.bugmanagement.utils.ServletUtil;

public class PageHelper {

	public static int validateCurPage(int curPage) {
		if (curPage < 1)
			curPage = 1;
		return curPage;
	}

	public static int validateTotalPage(int totalPage) {
		if (totalPage == 0)
			totalPage = 1;
		return totalPage;
	}

	public static String generateUrl(Map<String, Object> map) {
		StringBuffer url = ServletUtil.getRequest().getRequestURL();
		Iterator<String> iterator = map.keySet().iterator();
		url.append("?");
		while (iterator.hasNext()) {
			String key = iterator.next();
			String value = String.valueOf(map.get(key));
			url.append(key + "=");
			url.append(value + "&");
		}
		//url.append("curPage={curPage}&pageSize={pageSize}");
		return url.toString();
	}

	public static String generateUrl() {
		StringBuffer url = ServletUtil.getRequest().getRequestURL();
		url.append("?");
		//url.append("?curPage={curPage}&pageSize={pageSize}");
		return url.toString();
	}

	public static int getCurPage() {
		int curPage=ServletRequestUtils.getIntParameter(ServletUtil.getRequest(), "curPage", 1);
		if(curPage<1)
			curPage=1;
		return curPage;
	}
	
	public static int getPageSize(){
		return ServletRequestUtils.getIntParameter(ServletUtil.getRequest(), "pageSize", 10);
	}

	public static void forPage(int pageSize, int totalSize) {
		HttpServletRequest request=ServletUtil.getRequest();		
		request.setAttribute("url", generateUrl());
		request.setAttribute("curPage", getCurPage());
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totalSize", totalSize);
	}
	
	public static void forPage(int pageSize,Map<String,Object> conditionMap, int totalSize) {
		HttpServletRequest request=ServletUtil.getRequest();
		request.setAttribute("url", generateUrl(conditionMap));
		request.setAttribute("curPage", getCurPage());
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totalSize", totalSize);
	}
	
	public static void forPage(int pageSize, int totalSize, String curCol, String order) {
		HttpServletRequest request=ServletUtil.getRequest();		
		request.setAttribute("url", generateUrl());
		request.setAttribute("curPage", getCurPage());
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totalSize", totalSize);
		request.setAttribute("curCol", curCol);
		request.setAttribute("order", order);
	}
	
	public static void forPage(int pageSize,Map<String,Object> conditionMap, int totalSize, String curCol, String order) {
		HttpServletRequest request=ServletUtil.getRequest();
		request.setAttribute("url", generateUrl(conditionMap));
		request.setAttribute("curPage", getCurPage());
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totalSize", totalSize);
		request.setAttribute("curCol", curCol);
		request.setAttribute("order", order);
	}

}
