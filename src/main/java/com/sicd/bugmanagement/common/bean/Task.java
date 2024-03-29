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

/**
 * Task generated by hbm2java
 */
@Entity
@Table(name = "task", catalog = "bugmanagement")
public class Task implements java.io.Serializable {

	private static final long serialVersionUID = 3098019191323446509L;
	
	private Integer taskId;
	private Tester owner;
	private Tester creator;
	private Version version;
	private Integer priority;
	private Date startDate;
	private Date endDate;
	private String status;
	private String name;
	private String description;
	private String summary;
	private Date createdAt;
	private Set<TestCase> testCases = new HashSet<TestCase>(0);

	public Task() {
	}

	public Task(Tester testerByOwner, Tester testerByCreator, Version version,
			Integer priority, Date startDate, Date endDate, String status,
			String name, String description, String summary, Date createdAt,
			Set<TestCase> testCases) {
		this.owner = testerByOwner;
		this.creator = testerByCreator;
		this.version = version;
		this.priority = priority;
		this.startDate = startDate;
		this.endDate = endDate;
		this.status = status;
		this.name = name;
		this.description = description;
		this.summary = summary;
		this.createdAt = createdAt;
		this.testCases = testCases;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "task_id", unique = true, nullable = false)
	public Integer getTaskId() {
		return this.taskId;
	}

	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "owner")
	public Tester getOwner() {
		return this.owner;
	}

	public void setOwner(Tester owner) {
		this.owner = owner;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "creator")
	public Tester getCreator() {
		return this.creator;
	}

	public void setCreator(Tester creator) {
		this.creator = creator;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "version_id")
	public Version getVersion() {
		return this.version;
	}

	public void setVersion(Version version) {
		this.version = version;
	}

	@Column(name = "priority")
	public Integer getPriority() {
		return this.priority;
	}

	public void setPriority(Integer priority) {
		this.priority = priority;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "start_date", length = 19)
	public Date getStartDate() {
		return this.startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "end_date", length = 19)
	public Date getEndDate() {
		return this.endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	@Column(name = "status", length = 30)
	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "name")
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "description", length = 65535)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "summary", length = 65535)
	public String getSummary() {
		return this.summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "created_at", length = 19)
	public Date getCreatedAt() {
		return this.createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "task")
	public Set<TestCase> getTestCases() {
		return this.testCases;
	}

	public void setTestCases(Set<TestCase> testCases) {
		this.testCases = testCases;
	}

}
