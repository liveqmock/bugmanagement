package com.sicd.bugmanagement.business.question.bean;

import com.sicd.bugmanagement.business.question.service.QuestionService;
import com.sicd.bugmanagement.common.bean.Answer;

public class VoteAnswer extends VoteChoice{

	QuestionService service;
	@Override
	public void voteup(VoteChoiceBeans votebeans) {
		
		if(votebeans.getObjectType().equals("answer")||isvoted(votebeans)){
		savevote(votebeans);
		Answer answer=service.findById(Answer.class, Integer.parseInt(votebeans.getObjectId()));
		answer.setVotes(answer.getVotes()+1);
		service.update(answer);
		}
	}
	@Override
    public void votedown(VoteChoiceBeans votebeans) {
		
		if(votebeans.getObjectType().equals("answer")||isvoted(votebeans)){
	    savevote(votebeans);
		Answer answer=service.findById(Answer.class, Integer.parseInt(votebeans.getObjectId()));
		answer.setVotes(answer.getVotes()+1);
		service.update(answer);
		}
	}

}
