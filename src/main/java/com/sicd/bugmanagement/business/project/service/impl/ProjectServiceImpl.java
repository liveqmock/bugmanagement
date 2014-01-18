package com.sicd.bugmanagement.business.project.service.impl;

import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.sicd.bugmanagement.business.project.service.ProjectService;
import com.sicd.bugmanagement.common.baseService.impl.BaseServiceImpl;

@Transactional
@Component
public class ProjectServiceImpl extends BaseServiceImpl implements ProjectService {

}
