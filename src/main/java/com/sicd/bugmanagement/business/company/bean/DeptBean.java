package com.sicd.bugmanagement.business.company.bean;

public class DeptBean {
	private Integer deptId;
	private String deptName;
	private Boolean hasChildren;
	private Boolean last;

	public Integer getDeptId() {
		return deptId;
	}

	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public Boolean getHasChildren() {
		return hasChildren;
	}

	public void setHasChildren(Boolean hasChildren) {
		this.hasChildren = hasChildren;
	}

	public Boolean getLast() {
		return last;
	}

	public void setLast(Boolean last) {
		this.last = last;
	}

}
