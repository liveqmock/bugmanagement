package com.sicd.bugmanagement.business.question.bean;

import com.sicd.bugmanagement.business.question.service.QuestionService;

public class VoteQuestion extends VoteChoice {

	QuestionService service;
	
	@Override
	public void voteup(VoteChoiceBeans votebeans) {
		
		if(votebeans.getObjectType().equals("question")||isvoted(votebeans)){
			savevote(votebeans);
		}
	}
	@Override
	public void votedown(VoteChoiceBeans votebeans) {
		
		if(votebeans.getObjectType().equals("question")||isvoted(votebeans)){
			savevote(votebeans);
		}
	}

}
