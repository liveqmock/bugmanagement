package com.sicd.bugmanagement.business.question.bean;

import com.sicd.bugmanagement.common.bean.User;

public class VoteChoiceBeans {
	User user;
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getObjectId() {
		return objectId;
	}
	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}
	public String getObjectType() {
		return objectType;
	}
	public void setObjectType(String objectType) {
		this.objectType = objectType;
	}
	public String getQuestionId() {
		return questionId;
	}
	public void setQuestionId(String questionId) {
		this.questionId = questionId;
	}
	String objectId;
	String objectType;
	String questionId;

}
