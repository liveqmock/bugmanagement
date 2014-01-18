package com.sicd.bugmanagement.business.project.bean;

public class ModuleBean {
	private int moduleId;
	private String moduleName;
	private Boolean hasChildren;
	private Boolean last;

	public int getModuleId() {
		return moduleId;
	}

	public void setModuleId(int moduleId) {
		this.moduleId = moduleId;
	}

	public String getModuleName() {
		return moduleName;
	}

	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
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
