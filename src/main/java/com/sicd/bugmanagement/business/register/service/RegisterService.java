package com.sicd.bugmanagement.business.register.service;

import com.sicd.bugmanagement.common.baseService.BaseService;

public interface RegisterService extends BaseService {
	int checkEmail(String userEmail);
}
