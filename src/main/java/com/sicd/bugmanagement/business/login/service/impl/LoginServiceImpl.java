package com.sicd.bugmanagement.business.login.service.impl;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sicd.bugmanagement.business.login.service.LoginService;
import com.sicd.bugmanagement.common.baseService.impl.BaseServiceImpl;
import com.sicd.bugmanagement.common.bean.User;

@Component
public class LoginServiceImpl extends BaseServiceImpl implements LoginService{

	@Override
	public int checkByEmailAndCookie(String cookieEmail, String cookiePswd) {
		
		List<User> userinfo=(List<User>) getCurrentSession().createCriteria(User.class).add(Restrictions.eq("email", cookieEmail)).add(Restrictions.eqOrIsNull("password", cookiePswd)).add(Restrictions.eq("enabled", true)).list();
		if(userinfo.size()!=0){
			return userinfo.get(0).getUserId();
		}else{
			return 0;	
		}
	
	}

	@Override
	public int checkByEmailAndPswd(String email, String pswd) {
	
		System.out.println("#################");
		List<User> userinfo=(List<User>) getCurrentSession().createCriteria(User.class).add(Restrictions.eq("email",email)).add(Restrictions.eq("password", pswd)).add(Restrictions.eq("enabled", true)).list();
 		
		if(userinfo.size()!=0){
			return userinfo.get(0).getUserId();
		}else{
			
			return 0;
		}
	
	}

}
