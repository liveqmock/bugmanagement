package com.sicd.bugmanagement.business.question.bean;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.sicd.bugmanagement.business.question.service.QuestionService;
import com.sicd.bugmanagement.common.bean.Vote;

public abstract class VoteChoice {
	
	QuestionService service;
	
	public abstract void voteup(VoteChoiceBeans votebeans);
	public abstract void votedown(VoteChoiceBeans votebeans);
	
	public boolean isvoted(VoteChoiceBeans votebeans){
		DetachedCriteria dCriteria = DetachedCriteria.forClass(Vote.class);
		dCriteria.add(Restrictions.eq("objectId", Integer.parseInt(votebeans.getObjectId()))).add(Restrictions.eq("developer", votebeans.getUser().getDeveloper()))
		.add(Restrictions.eq("objectType", votebeans.getObjectType()));
		if(service.queryAllOfCondition(Vote.class, dCriteria).size()>0){
			return true;
		}else{
			return false;
			}
		
	}
	
	public void savevote(VoteChoiceBeans votebeans){
		Vote vote=new Vote();
		vote.setDeveloper(votebeans.getUser().getDeveloper());
		vote.setObjectType(votebeans.getObjectType());
		vote.setObjectId(Integer.parseInt(votebeans.getObjectId()));
		service.save(vote);
	}

}
