package com.sicd.bugmanagement.utils;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.sicd.bugmanagement.business.project.bean.ModuleBean;
import com.sicd.bugmanagement.common.baseService.BaseService;
import com.sicd.bugmanagement.common.bean.Module;
import com.sicd.bugmanagement.common.bean.Project;

public class ModuleUtil {
	
	public static List<ModuleBean> getModuleBean(BaseService service, Project curProject) {
		List<Module> parents = service.queryAllOfCondition(
				Module.class,
				DetachedCriteria.forClass(Module.class)
						.add(Restrictions.eq("project", curProject))
						.add(Restrictions.isNull("parent"))
						.addOrder(Order.asc("createdAt")));
		
		List<ModuleBean> moduleBeans = new ArrayList<ModuleBean>();
		
		addChildModule(service, parents, moduleBeans);
		
		return moduleBeans;
	}
	
	public static List<ModuleBean> getModuleNameList(BaseService service, Project curProject) {
		DetachedCriteria dCriteria=DetachedCriteria.forClass(Module.class);
		dCriteria.add(Restrictions.eq("project", curProject)).add(Restrictions.isNull("parent"));
		List<Module> module=service.queryAllOfCondition(Module.class, dCriteria);
		List<ModuleBean> moduleBean=new ArrayList<ModuleBean>();
		addModuleName(service, module, moduleBean);
		return moduleBean;
	}
	
	public static List<ModuleBean> getModuleNameList(BaseService service, DetachedCriteria dCriteria) {
		List<Module> module=service.queryAllOfCondition(Module.class, dCriteria);
		List<ModuleBean> moduleBean=new ArrayList<ModuleBean>();
		addModuleName(service, module, moduleBean);
		return moduleBean;
	}
	
	private static void addChildModule(BaseService service, List<Module> parents, List<ModuleBean> all) {
		for (int i = 0; i < parents.size(); i++) {
			Module module = parents.get(i);
			ModuleBean moduleBean = new ModuleBean();
			moduleBean.setModuleId(module.getModuleId());
			moduleBean.setModuleName(module.getName());

			moduleBean.setHasChildren(!module.getChildren().isEmpty());
			if (i == parents.size() - 1) {
				moduleBean.setLast(true);
			} else {
				moduleBean.setLast(false);
			}

			all.add(moduleBean);
			if (!module.getChildren().isEmpty()) {
				DetachedCriteria dCriteria = DetachedCriteria
						.forClass(Module.class);
				dCriteria.add(Restrictions.eq("parent", module)).addOrder(
						Order.asc("createdAt"));
				List<Module> children = service.queryAllOfCondition(
						Module.class, dCriteria);
				addChildModule(service, children, all);
			}
		}
	}
	
	private static void addModuleName(BaseService service, List<Module> parents, List<ModuleBean> all){
		for (int i = 0; i < parents.size(); i++) {
			Module module = parents.get(i);
			ModuleBean moduleBean = new ModuleBean();
			moduleBean.setModuleId(module.getModuleId());
			moduleBean.setModuleName(getFullName(service, module));
			all.add(moduleBean);
			if (!module.getChildren().isEmpty()) {
				DetachedCriteria dCriteria = DetachedCriteria
						.forClass(Module.class);
				dCriteria.add(Restrictions.eq("parent", module)).addOrder(
						Order.asc("createdAt"));
				List<Module> children = service.queryAllOfCondition(
						Module.class, dCriteria);
				addModuleName(service, children, all);
			}
		}
	}
	
	private static String getFullName(BaseService service, Module module) {
		
		String name = module.getName();
		while((module.getParent()) != null) {
			module = service.findById(Module.class, module.getParent().getModuleId());
			name = module.getName() + "/" + name;
		}
		
		return name;
	}
	
	public static List<Integer> getModules(BaseService service, Project project) {
		List<Module> modules =  service.queryAllOfCondition(Module.class, 
				DetachedCriteria.forClass(Module.class)
				.add(Restrictions.eq("project.projectId", project.getProjectId())));
		
		List<Integer> ids = new ArrayList<Integer>();
		for (Module module : modules) {
			ids.add(module.getModuleId());
		}
		return ids;
	}

}
