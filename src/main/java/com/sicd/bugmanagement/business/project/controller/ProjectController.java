package com.sicd.bugmanagement.business.project.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.sicd.bugmanagement.business.project.bean.ModuleBean;
import com.sicd.bugmanagement.business.project.service.ProjectService;
import com.sicd.bugmanagement.common.bean.AffectedVersion;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.History;
import com.sicd.bugmanagement.common.bean.Module;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.Task;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.Version;
import com.sicd.bugmanagement.utils.DateParser;

@Controller
@SessionAttributes({ "user", "company", "comProjects", "curProject" })
public class ProjectController {

	private static Logger logger = Logger.getLogger(ProjectController.class);

	@Autowired
	ProjectService service;
	
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping("newProject.htm")
	public String newProject() {
		return "project/newProject";
	}

	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping("addProject.htm")
	public String addProject(@ModelAttribute("user") User user,
			@ModelAttribute("company") Company company,
			@ModelAttribute("comProjects") List<Project> comProjects,
			@RequestParam String name, @RequestParam String startDate,
			@RequestParam String endDate,
			@RequestParam(required = false) String goal,
			@RequestParam(required = false) String description, ModelMap map) {

		logger.info("user name " + user.getName());
		logger.info("company name " + company.getName());

		Project project = new Project();
		project.setCompany(company);
		project.setName(name);
		project.setStartDate(DateParser.parseDate(startDate));
		project.setEndDate(DateParser.parseDate(endDate));
		project.setGoal(goal);
		project.setDescription(description);
		project.setCreatedAt(new Date());

		service.save(project);
		
		History history = new History();
		history.setUser(user);
		history.setObjectId(project.getProjectId());
		history.setObjectType("project");
		history.setOperateTime(new Date());
		history.setOperation("创建");
		service.save(history);

		comProjects.add(project);

		map.addAttribute("comProjects", comProjects);
		map.addAttribute("curProject", project);

		return "redirect:projectList.htm";
	}
	
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
	@RequestMapping("projectList.htm")
	public String projectList() {
		return "project/projectList";
	}
	
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
	@RequestMapping("changeCurProject.htm")
	public String changeCurProject(HttpServletRequest req,
			@RequestParam int projectId, ModelMap map) {
		map.addAttribute("curProject",
				service.findById(Project.class, projectId));
		return "redirect:" + req.getHeader("Referer");
	}
	
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
	@RequestMapping("showModule.htm")
	public String showModule(@ModelAttribute("curProject") Project curProject,
			@RequestParam(required = false) Integer moduleId, ModelMap map) {

		logger.info("module id is " + moduleId);

		Module module = null;
		if (moduleId != null) {
			module = service.findById(Module.class, moduleId);
		}

		DetachedCriteria pCriteria = DetachedCriteria.forClass(Module.class);
		pCriteria.add(Restrictions.isNull("parent"))
				.add(Restrictions.eq("project", curProject))
				.addOrder(Order.asc("createdAt"));
		List<Module> parentModules = service.queryAllOfCondition(Module.class,
				pCriteria);
		for (Module module2 : parentModules) {
			logger.info("parent module " + module2.getName() + " has children "
					+ module2.getChildren());
		}
		logger.info("parent modules size " + parentModules.size());

		List<ModuleBean> moduleBeans = new ArrayList<ModuleBean>();
		addChildModule(parentModules, moduleBeans);
		logger.info("all modules size " + moduleBeans.size());

		List<ModuleBean> menuModules = new ArrayList<ModuleBean>();
		if (module != null) {
			addParentModule(module, menuModules);
		}
		logger.info("menu size si " + menuModules.size());

		List<Module> subModules = null;
		if (moduleId != null) {
			DetachedCriteria subCriteria = DetachedCriteria
					.forClass(Module.class);
			subCriteria.add(Restrictions.eq("parent", module)).addOrder(
					Order.asc("createdAt"));
			subModules = service.queryAllOfCondition(Module.class, subCriteria);
			logger.info("sub module size " + subModules.size());
		} else {
			subModules = parentModules;
		}
		if (subModules.size() < 10) {
			while (subModules.size() < 10) {
				subModules.add(new Module());
			}
		}
		logger.info("new sub modules size " + subModules.size());

		map.put("module", module);
		map.put("moduleBeans", moduleBeans);
		map.put("menuModules", menuModules);
		map.put("subModules", subModules);

		return "/project/showModule";
	}
	
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping("updateModule.htm")
	public String updateModule(
			@ModelAttribute("curProject") Project curProject,
			@RequestParam(required = false) Integer parentModuleId,
			@RequestParam String[] moduleNames) {
		logger.info("@@@@@@ current project id is " + curProject.getProjectId());
		logger.info("@@@@@@ parent module id is " + parentModuleId);

		if (parentModuleId == null) {
			logger.info("@@@@@@@@ add first level module");
			DetachedCriteria dCriteria = DetachedCriteria
					.forClass(Module.class);
			dCriteria.add(Restrictions.isNull("parent")).addOrder(
					Order.asc("createdAt"));
			List<Module> parentModules = service.queryAllOfCondition(
					Module.class, dCriteria);
			for (int i = 0; i < parentModules.size(); i++) {
				if (!moduleNames[i].trim().isEmpty()) {
					logger.info("update module ");
					Module module = parentModules.get(i);
					module.setName(moduleNames[i]);
					service.update(module);
				}
			}
			for (int i = parentModules.size(); i < 10; i++) {
				if (!moduleNames[i].trim().isEmpty()) {
					logger.info("add module ");
					Module module = new Module();
					module.setProject(curProject);
					module.setName(moduleNames[i]);
					module.setCreatedAt(new Date());
					service.save(module);
				}
			}
			return "redirect:showModule.htm";
		} else {
			logger.info("@@@@ add sub modules ");
			Module parent = service.findById(Module.class, parentModuleId);
			logger.info("parent id and name " + parent.getModuleId() + " "
					+ parent.getName());
			DetachedCriteria dCriteria = DetachedCriteria
					.forClass(Module.class);
			dCriteria.add(Restrictions.eq("parent", parent)).addOrder(
					Order.asc("createdAt"));
			List<Module> subModules = service.queryAllOfCondition(Module.class,
					dCriteria);
			for (int i = 0; i < subModules.size(); i++) {
				if (!moduleNames[i].trim().isEmpty()) {
					logger.info("update module ");
					Module module = subModules.get(i);
					module.setName(moduleNames[i]);
					service.update(module);
				}
			}
			for (int i = subModules.size(); i < 10; i++) {
				if (!moduleNames[i].trim().isEmpty()) {
					logger.info("add module ");
					Module module = new Module();
					module.setParent(parent);
					module.setProject(curProject);
					module.setName(moduleNames[i]);
					module.setCreatedAt(new Date());
					service.save(module);
				}
			}
			return "redirect:showModule.htm?moduleId=" + parentModuleId;
		}
	}

	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping("deleteModule.htm")
	public String deleteModule(@RequestParam Integer moduleId) {
		service.deleteById(Module.class, moduleId);
		return "redirect:showModule.htm";
	}
	
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping("newVersion.htm")
	public String newVersion() {
		return "/project/newVersion";
	}
	
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping("addVersion.htm")
	public String addVersion(@ModelAttribute("user") User user,
			@RequestParam int projectId,
			@RequestParam String name, @RequestParam String description) {
		Version version = new Version();
		version.setProject(service.findById(Project.class, projectId));
		version.setName(name);
		version.setDescription(description);
		version.setCreatedAt(new Date());

		service.save(version);
		
		History history = new History();
		history.setUser(user);
		history.setObjectId(version.getVersionId());
		history.setObjectType("version");
		history.setOperateTime(new Date());
		history.setOperation("创建");
		service.save(history);
		
		return "redirect:versionList.htm";
	}
	
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
	@RequestMapping("versionList.htm")
	public String versionList(@ModelAttribute("curProject") Project curProject,
			ModelMap map) {

		DetachedCriteria dCriteria = DetachedCriteria.forClass(Version.class);
		dCriteria.add(Restrictions.eq("project", curProject)).addOrder(
				Order.desc("createdAt"));
		List<Version> versions = service.queryAllOfCondition(Version.class,
				dCriteria);

		map.put("versions", versions);

		return "/project/versionList";
	}
	
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
	@RequestMapping(value = "showProject.htm", method = RequestMethod.GET)
	public String showProject(@RequestParam Integer projectId, ModelMap map){
		Project project = service.findById(Project.class, projectId);
		
		List<History> histories = service.queryAllOfCondition(History.class, 
				DetachedCriteria.forClass(History.class)
				.add(Restrictions.eq("objectId", project.getProjectId()))
				.add(Restrictions.eq("objectType", "project"))
				.addOrder(Order.asc("operateTime")));
		
		map.put("project", project);
		map.put("histories", histories);
		
		return "/project/showProject";
	}
	
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping(value = "editProject.htm", method = RequestMethod.GET)
	public String editProject(@RequestParam Integer projectId, ModelMap map) {
		Project project = service.findById(Project.class, projectId);
		map.put("project", project);
		return "/project/editProject";
	}
	
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping(value = "updateProject.htm", method = RequestMethod.POST)
	public String updateProject(@ModelAttribute("user") User user,
			@RequestParam Integer projectId, 
			@RequestParam String name, 
			@RequestParam String startDate,
			@RequestParam String endDate,
			@RequestParam(required = false) String goal,
			@RequestParam(required = false) String description, ModelMap map) {
		Project project = service.findById(Project.class, projectId);
		project.setName(name);
		project.setStartDate(DateParser.parseDate(startDate));
		project.setEndDate(DateParser.parseDate(endDate));
		project.setGoal(goal);
		project.setDescription(description);
		service.update(project);
		
		History history = new History();
		history.setUser(user);
		history.setObjectId(project.getProjectId());
		history.setObjectType("project");
		history.setOperateTime(new Date());
		history.setOperation("编辑");
		service.save(history);
		
		return "redirect:showProject.htm?projectId=" + projectId;
	}
	
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping(value = "deleteProject.htm", method = RequestMethod.GET)
	public String deleteProject(@RequestParam Integer projectId){
		Project project = service.findById(Project.class, projectId);
		
		List<Module> modules = service.queryAllOfCondition(Module.class, 
				DetachedCriteria.forClass(Module.class)
				.add(Restrictions.eq("project", project)));
		if(!modules.isEmpty()) {
			return "/project/deleteFail";
		}
		
		List<Version> versions = service.queryAllOfCondition(Version.class, 
				DetachedCriteria.forClass(Version.class)
				.add(Restrictions.eq("project", project)));
		if(!versions.isEmpty()) {
			return "/project/deleteFail";
		}
		
		service.delete(project);
		return "redirect:projectList.htm";
	}
	
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping(value = "editVersion.htm", method = RequestMethod.GET)
	public String editVersion(@RequestParam Integer versionId, ModelMap map) {
		Version version = service.findById(Version.class, versionId);
		map.put("version", version);
		return "/project/editVersion";
	}
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping(value = "updateVersion.htm", method = RequestMethod.POST)
	public String updateVersion(@ModelAttribute("user") User user,
			@RequestParam Integer versionId,
			@RequestParam String name,
			@RequestParam String description) {
		Version version = service.findById(Version.class, versionId);
		version.setName(name);
		version.setDescription(description);
		service.update(version);
		
		History history = new History();
		history.setUser(user);
		history.setObjectId(version.getVersionId());
		history.setObjectType("version");
		history.setOperateTime(new Date());
		history.setOperation("编辑");
		service.save(history);
		
		return "redirect:showVersion.htm?versionId=" + versionId;
	}
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
	@RequestMapping(value = "showVersion.htm", method = RequestMethod.GET)
	public String showVersion(@RequestParam Integer versionId, ModelMap map) {
		Version version = service.findById(Version.class, versionId);
		
		List<History> histories = service.queryAllOfCondition(History.class, 
				DetachedCriteria.forClass(History.class)
				.add(Restrictions.eq("objectId", versionId))
				.add(Restrictions.eq("objectType", "version"))
				.addOrder(Order.asc("operateTime")));
		
		map.put("version", version);
		map.put("histories", histories);
		
		return "/project/showVersion";
	}
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping(value = "deleteVersion.htm", method = RequestMethod.GET)
	public String deleteVersion(@RequestParam Integer versionId) {
		Version version = service.findById(Version.class, versionId);
		
		List<AffectedVersion> affects = service.queryAllOfCondition(AffectedVersion.class, 
				DetachedCriteria.forClass(AffectedVersion.class)
				.add(Restrictions.eq("version", version)));
		if(!affects.isEmpty()) {
			return "/project/deleteVersionFail";
		}
		
		List<Task> tasks = service.queryAllOfCondition(Task.class, 
				DetachedCriteria.forClass(Task.class)
				.add(Restrictions.eq("version", version)));
		if(!tasks.isEmpty()) {
			return "/project/deleteVersionFail";
		}
		
		service.delete(version);
		return "redirect:versionList.htm";
	}

	private void addChildModule(List<Module> parents, List<ModuleBean> all) {
		for (int i = 0; i < parents.size(); i++) {
			Module module = parents.get(i);
			ModuleBean moduleBean = new ModuleBean();
			moduleBean.setModuleId(module.getModuleId());
			moduleBean.setModuleName(module.getName());
			logger.info("#############children size is "
					+ module.getChildren().size());
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
				addChildModule(children, all);
			}
		}
	}

	private void addParentModule(Module module, List<ModuleBean> menuModules) {
		ModuleBean moduleBean = new ModuleBean();
		if (module.getParent() != null) {

			addParentModule(module.getParent(), menuModules);

			moduleBean.setModuleId(module.getModuleId());
			moduleBean.setModuleName(module.getName());
			menuModules.add(moduleBean);
		} else {
			moduleBean.setModuleId(module.getModuleId());
			moduleBean.setModuleName(module.getName());
			menuModules.add(moduleBean);
		}
	}
}
