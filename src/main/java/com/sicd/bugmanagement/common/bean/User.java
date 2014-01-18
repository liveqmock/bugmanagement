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
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * User generated by hbm2java
 */
@Entity
@Table(name = "user", catalog = "bugmanagement")
public class User implements java.io.Serializable {

	private static final long serialVersionUID = 729356949273972123L;

	private Integer userId;
	private Department department;
	private String position;
	private String name;
	private String realName;
	private String gender;
	private String email;
	private String password;
	private Boolean enabled;
	private Date joinDate;
	private Developer developer;
	private Set<Company> companies = new HashSet<Company>(0);
	private Set<UserRole> userRoles = new HashSet<UserRole>(0);
	private Set<Bug> bugs = new HashSet<Bug>(0);
	private Tester tester;
	private Set<History> histories = new HashSet<History>(0);

	public User() {
	}

	public User(Department department, String position, String name,
			String gender, String email, String password, Date joinDate,
			Developer developer, Set<Company> companies,
			Set<UserRole> userRoles, Set<Bug> bugs, Tester tester,
			Set<History> histories) {
		this.department = department;
		this.position = position;
		this.name = name;
		this.gender = gender;
		this.email = email;
		this.password = password;
		this.joinDate = joinDate;
		this.developer = developer;
		this.companies = companies;
		this.userRoles = userRoles;
		this.bugs = bugs;
		this.tester = tester;
		this.histories = histories;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "user_id", unique = true, nullable = false)
	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "department")
	public Department getDepartment() {
		return this.department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	@Column(name = "position")
	public String getPosition() {
		return this.position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	@Column(name = "name")
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "real_name")
	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	@Column(name = "gender", length = 4)
	public String getGender() {
		return this.gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	@Column(name = "email")
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "password")
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "enabled")
	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "join_date", length = 19)
	public Date getJoinDate() {
		return this.joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "user")
	public Developer getDeveloper() {
		return this.developer;
	}

	public void setDeveloper(Developer developer) {
		this.developer = developer;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
	public Set<Company> getCompanies() {
		return this.companies;
	}

	public void setCompanies(Set<Company> companies) {
		this.companies = companies;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
	public Set<UserRole> getUserRoles() {
		return this.userRoles;
	}

	public void setUserRoles(Set<UserRole> userRoles) {
		this.userRoles = userRoles;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "creator")
	public Set<Bug> getBugs() {
		return this.bugs;
	}

	public void setBugs(Set<Bug> bugs) {
		this.bugs = bugs;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "user")
	public Tester getTester() {
		return this.tester;
	}

	public void setTester(Tester tester) {
		this.tester = tester;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
	public Set<History> getHistories() {
		return this.histories;
	}

	public void setHistories(Set<History> histories) {
		this.histories = histories;
	}

	@Override
	public int hashCode() {
		int result = 31;
		result += realName.hashCode();
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (!(obj instanceof User))
			return false;
		else
			return this.realName.equals(((User) obj).getRealName());
	}

}
