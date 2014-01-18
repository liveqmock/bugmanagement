package com.sicd.bugmanagement.business.usecaseDisplay.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sicd.bugmanagement.business.usecaseDisplay.service.usecaseDisplayService;
import com.sicd.bugmanagement.common.baseService.impl.BaseServiceImpl;
import com.sicd.bugmanagement.common.bean.Module;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.UserCase;


@Component
public class usecaseDisplayServiceImpl extends BaseServiceImpl implements
		usecaseDisplayService {
	@Override
	public List<UserCase> findAllUserCase(Project proj){
		List<Module> mod=getCurrentSession().createCriteria(Module.class).add(Restrictions.eq("project", proj)).list();
		List<UserCase> caselist = new ArrayList<UserCase>();
		List<UserCase> e=null;
		for(int i=0;i<mod.size();i++){
			e=getCurrentSession().createCriteria(UserCase.class).add(Restrictions.eq("module", mod.get(i))).list();
			
			
			if(e.size()>0){
				caselist.addAll(e);
			}
			e=null;
		}
		Collections.sort(caselist, new Comparator<UserCase>() {
            public int compare(UserCase arg0, UserCase arg1) {
                return arg0.getCaseId().compareTo(arg1.getCaseId());
            }
        });
		return caselist;
	}
}
