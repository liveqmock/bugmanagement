package com.sicd.bugmanagement.business.bugdisplay.service;

import java.util.List;
import com.sicd.bugmanagement.common.baseService.BaseService;
import com.sicd.bugmanagement.common.bean.Bug;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Developer;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.User;

public interface BugDisplayService extends BaseService {
	List<Developer> findUseByCompany(Company com);
}
