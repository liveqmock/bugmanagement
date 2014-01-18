package com.sicd.bugmanagement.business.bugdisplay.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sicd.bugmanagement.business.bugdisplay.service.BugDisplayService;
import com.sicd.bugmanagement.common.baseService.impl.BaseServiceImpl;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Department;
import com.sicd.bugmanagement.common.bean.Developer;

import com.sicd.bugmanagement.common.bean.User;

@Component
public class BugDisplayServiceImpl extends BaseServiceImpl implements BugDisplayService {
	private static Logger logger=Logger.getLogger(BugDisplayServiceImpl.class);

	@Override
	public List<Developer> findUseByCompany(Company com){
		List<Developer> developers=new ArrayList<Developer>();
		List<Department> dept=getCurrentSession().createCriteria(Department.class).add(Restrictions.eq("company", com)).list();
		List<User> userlist = new ArrayList<User>();
		List<User> user;
		Developer temp;
		for(int i=0;i<dept.size();i++){
			user=getCurrentSession().createCriteria(User.class).add(Restrictions.eq("department", dept.get(i))).list();
			if(user==null||user.isEmpty()){
				
			}else{
				userlist.addAll(user);
			}
			user=null;
		}
		for(int j=0;j<userlist.size();j++){
			temp=findById(Developer.class, userlist.get(j).getUserId());

			if(temp==null){
			}else{
				developers.add(temp);
			}
			temp=null;
		}
		return developers;
	}


}
