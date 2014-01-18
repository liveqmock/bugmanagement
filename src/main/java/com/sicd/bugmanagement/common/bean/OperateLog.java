package com.sicd.bugmanagement.common.bean;

// Generated 2013-10-17 10:13:18 by Hibernate Tools 4.0.0

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * OperateLog generated by hbm2java
 */
@Entity
@Table(name = "operate_log", catalog = "bugmanagement")
public class OperateLog implements java.io.Serializable {

	private static final long serialVersionUID = -3187499072765551308L;
	
	private Integer operateLogId;
	private String browser;
	private String userIp;
	private String userOperate;
	private Date operateTime;
	private Integer userId;

	public OperateLog() {
	}

	public OperateLog(String browser, String userIp, String userOperate,
			Date operateTime, Integer userId) {
		this.browser = browser;
		this.userIp = userIp;
		this.userOperate = userOperate;
		this.operateTime = operateTime;
		this.userId = userId;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "operate_log_id", unique = true, nullable = false)
	public Integer getOperateLogId() {
		return this.operateLogId;
	}

	public void setOperateLogId(Integer operateLogId) {
		this.operateLogId = operateLogId;
	}

	@Column(name = "browser")
	public String getBrowser() {
		return this.browser;
	}

	public void setBrowser(String browser) {
		this.browser = browser;
	}

	@Column(name = "user_ip")
	public String getUserIp() {
		return this.userIp;
	}

	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}

	@Column(name = "user_operate")
	public String getUserOperate() {
		return this.userOperate;
	}

	public void setUserOperate(String userOperate) {
		this.userOperate = userOperate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "operate_time", length = 19)
	public Date getOperateTime() {
		return this.operateTime;
	}

	public void setOperateTime(Date operateTime) {
		this.operateTime = operateTime;
	}

	@Column(name = "user_id")
	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

}
