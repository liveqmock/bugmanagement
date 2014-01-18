package com.sicd.bugmanagement.common.bean;

// Generated 2013-10-17 10:13:18 by Hibernate Tools 4.0.0

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Authority generated by hbm2java
 */
@Entity
@Table(name = "authority", catalog = "bugmanagement")
public class Authority implements java.io.Serializable {

	private static final long serialVersionUID = 9114258025981115040L;
	
	private Integer authorityId;
	private String authorityName;
	private String methodClass;
	private String methodSign;
	private String authorityAbstract;
	private Date updateTime;
	private Set<AuthorityRole> authorityRoles = new HashSet<AuthorityRole>(0);

	public Authority() {
	}

	public Authority(String authorityName, String methodClass,
			String methodSign, String authorityAbstract, Date updateTime,
			Set<AuthorityRole> authorityRoles) {
		this.authorityName = authorityName;
		this.methodClass = methodClass;
		this.methodSign = methodSign;
		this.authorityAbstract = authorityAbstract;
		this.updateTime = updateTime;
		this.authorityRoles = authorityRoles;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "authority_id", unique = true, nullable = false)
	public Integer getAuthorityId() {
		return this.authorityId;
	}

	public void setAuthorityId(Integer authorityId) {
		this.authorityId = authorityId;
	}

	@Column(name = "authority_name")
	public String getAuthorityName() {
		return this.authorityName;
	}

	public void setAuthorityName(String authorityName) {
		this.authorityName = authorityName;
	}

	@Column(name = "method_class")
	public String getMethodClass() {
		return this.methodClass;
	}

	public void setMethodClass(String methodClass) {
		this.methodClass = methodClass;
	}

	@Column(name = "method_sign")
	public String getMethodSign() {
		return this.methodSign;
	}

	public void setMethodSign(String methodSign) {
		this.methodSign = methodSign;
	}

	@Column(name = "authority_abstract")
	public String getAuthorityAbstract() {
		return this.authorityAbstract;
	}

	public void setAuthorityAbstract(String authorityAbstract) {
		this.authorityAbstract = authorityAbstract;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "update_time", length = 19)
	public Date getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "authority")
	public Set<AuthorityRole> getAuthorityRoles() {
		return this.authorityRoles;
	}

	public void setAuthorityRoles(Set<AuthorityRole> authorityRoles) {
		this.authorityRoles = authorityRoles;
	}

}