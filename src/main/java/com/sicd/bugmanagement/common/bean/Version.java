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
 * Version generated by hbm2java
 */
@Entity
@Table(name = "version", catalog = "bugmanagement")
public class Version implements java.io.Serializable {

	private static final long serialVersionUID = 25364168702811809L;

	private Integer versionId;
	private Project project;
	private String name;
	private Date createdAt;
	private String description;
	private Set<Task> tasks = new HashSet<Task>(0);
	private Set<AffectedVersion> affectedVersions = new HashSet<AffectedVersion>(
			0);

	public Version() {
	}

	public Version(Project project, String name, Date createdAt,
			Set<Task> tasks, Set<AffectedVersion> affectedVersions) {
		this.project = project;
		this.name = name;
		this.createdAt = createdAt;
		this.tasks = tasks;
		this.affectedVersions = affectedVersions;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "version_id", unique = true, nullable = false)
	public Integer getVersionId() {
		return this.versionId;
	}

	public void setVersionId(Integer versionId) {
		this.versionId = versionId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "project_id")
	public Project getProject() {
		return this.project;
	}

	public void setProject(Project project) {
		this.project = project;
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

	@Column(name = "description")
	@Type(type = "text")
	public void setDescription(String description) {
		this.description = description;
	}

	public void setTasks(Set<Task> tasks) {
		this.tasks = tasks;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "version")
	public Set<Task> getTasks() {
		return this.tasks;
	}

	public String getDescription() {
		return description;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "version")
	public Set<AffectedVersion> getAffectedVersions() {
		return this.affectedVersions;
	}

	public void setAffectedVersions(Set<AffectedVersion> affectedVersions) {
		this.affectedVersions = affectedVersions;
	}
	
	@Override
	public int hashCode(){
		int result = 31;
		result += versionId.hashCode();
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (!(obj instanceof Version))
			return false;
		else
			return this.versionId.equals(((Version) obj).getVersionId());
	}

}
