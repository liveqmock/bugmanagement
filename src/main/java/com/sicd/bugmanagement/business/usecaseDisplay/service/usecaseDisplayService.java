package com.sicd.bugmanagement.business.usecaseDisplay.service;

import java.util.List;

import com.sicd.bugmanagement.common.baseService.BaseService;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.UserCase;

public interface usecaseDisplayService extends BaseService {
	List<UserCase> findAllUserCase(Project proj);

}
