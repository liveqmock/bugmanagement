package com.sicd.bugmanagement.business.admin.logrecord.aspect;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.core.Ordered;
import org.springframework.stereotype.Component;

import com.marswork.websupport.springext.utils.ServletUtil;
import com.sicd.bugmanagement.business.admin.logrecord.annotation.SeachAnnotation;
import com.sicd.bugmanagement.common.baseService.BaseService;
import com.sicd.bugmanagement.common.bean.OperateLog;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.utils.BrowseTool;


@Aspect
@Component
public class ActionLogRecord implements Ordered {

	private BaseService bservice;
	
	
	
	@Resource(name = "baseServiceImpl")
	public void setBaservice(BaseService bservice) {
		this.bservice = bservice;
	}

	@Pointcut("execution(* com.sicd.bugmanagement.business..*.*(..))")
	public void skanPackage() {

	}
	@After("skanPackage()&&@annotation(search)")
	public void doAfter(JoinPoint joinPoint, SeachAnnotation search) {
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		HttpSession session = ServletUtil.getRequest().getSession();
		HttpServletRequest request = ServletUtil.getRequest();
		User user = (User) session.getAttribute("user");
		System.out.println("userId:"+user.getUserId());
		if (user!=null) {
			System.out.println("##########################");
			OperateLog log = new OperateLog();
			
			log.setOperateTime(new Date());
			log.setUserOperate(search.name().trim());
			log.setUserIp(request.getRemoteAddr());
			log.setBrowser(BrowseTool.checkBrowse(request
					.getHeader("User-agent")));
			log.setUserId(user.getUserId());
			bservice.save(log);
         
		}
	}

	@Override
	public int getOrder() {
		// TODO Auto-generated method stub
		return 0;
	}

	

}
