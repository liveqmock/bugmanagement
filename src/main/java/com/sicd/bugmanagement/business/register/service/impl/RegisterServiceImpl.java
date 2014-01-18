package com.sicd.bugmanagement.business.register.service.impl;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sicd.bugmanagement.business.register.service.RegisterService;
import com.sicd.bugmanagement.common.baseService.impl.BaseServiceImpl;
import com.sicd.bugmanagement.common.bean.User;


@Component
public class RegisterServiceImpl extends BaseServiceImpl implements RegisterService {

	
	@Override
	public int checkEmail(String userEmail) {
		// TODO Auto-generated method stub
		List<User> list=getCurrentSession().createCriteria(User.class).add(Restrictions.eq("email", userEmail)).list();
		
		
		return list.size();
	}
}
