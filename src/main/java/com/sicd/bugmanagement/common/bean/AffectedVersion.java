package com.sicd.bugmanagement.common.bean;

// Generated 2013-10-17 10:13:18 by Hibernate Tools 4.0.0

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * AffectedVersion generated by hbm2java
 */
@Entity
@Table(name = "affected_version", catalog = "bugmanagement")
public class AffectedVersion implements java.io.Serializable {

	private static final long serialVersionUID = 4793554773990927646L;
	
	private Integer affectedVersionId;
	private Bug bug;
	private Version version;

	public AffectedVersion() {
	}

	public AffectedVersion(Bug bug, Version version) {
		this.bug = bug;
		this.version = version;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "affected_version_id", unique = true, nullable = false)
	public Integer getAffectedVersionId() {
		return this.affectedVersionId;
	}

	public void setAffectedVersionId(Integer affectedVersionId) {
		this.affectedVersionId = affectedVersionId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "bugID")
	public Bug getBug() {
		return this.bug;
	}

	public void setBug(Bug bug) {
		this.bug = bug;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "version_id")
	public Version getVersion() {
		return this.version;
	}

	public void setVersion(Version version) {
		this.version = version;
	}

}