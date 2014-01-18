package com.sicd.bugmanagement.business.login.service;

import com.sicd.bugmanagement.common.baseService.BaseService;

public interface LoginService extends BaseService{
	int checkByEmailAndCookie(String cookieEmail,String cookiePswd);
	int checkByEmailAndPswd(String email,String pswd);
}
