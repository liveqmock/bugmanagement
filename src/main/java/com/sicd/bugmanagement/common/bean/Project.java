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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Type;

/**
 * Project generated by hbm2java
 */
@Entity
@Table(name = "project", catalog = "bugmanagement")
public class Project implements java.io.Serializable {

	private static final long serialVersionUID = 308708876172016441L;
	
	private Integer projectId;
	private Company company;
	private String name;
	private Date createdAt;
	private Date startDate;
	private Date endDate;
	private String description;
	private String goal;
	private Set<Module> modules = new HashSet<Module>(0);
	private Set<BugTemplate> bugTemplates = new HashSet<BugTemplate>(0);
	private Set<Version> versions = new HashSet<Version>(0);

	public Project() {
	}

	public Project(Company company, String name, Date createdAt,
			Set<Module> modules, Set<BugTemplate> bugTemplates,
			Set<Version> versions) {
		this.company = company;
		this.name = name;
		this.createdAt = createdAt;
		this.modules = modules;
		this.bugTemplates = bugTemplates;
		this.versions = versions;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "project_id", unique = true, nullable = false)
	public Integer getProjectId() {
		return this.projectId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "company_id")
	public Company getCompany() {
		return this.company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	@Column(name = "name")
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "created_at", length = 19)
	public Date getCreatedAt() {
		return this.createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "start_date", length = 19)
	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "end_date", length = 19)
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	@Column(name = "description")
	@Type(type="text")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Column(name = "goal")
	@Type(type="text")
	public String getGoal() {
		return goal;
	}

	public void setGoal(String goal) {
		this.goal = goal;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "project")
	public Set<Module> getModules() {
		return this.modules;
	}

	public void setModules(Set<Module> modules) {
		this.modules = modules;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "project")
	public Set<BugTemplate> getBugTemplates() {
		return this.bugTemplates;
	}

	public void setBugTemplates(Set<BugTemplate> bugTemplates) {
		this.bugTemplates = bugTemplates;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "project")
	public Set<Version> getVersions() {
		return this.versions;
	}

	public void setVersions(Set<Version> versions) {
		this.versions = versions;
	}

}
