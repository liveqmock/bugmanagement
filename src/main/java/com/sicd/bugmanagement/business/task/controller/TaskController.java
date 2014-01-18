package com.sicd.bugmanagement.business.task.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.sicd.bugmanagement.business.task.service.TaskService;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.History;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.Task;
import com.sicd.bugmanagement.common.bean.TestCase;
import com.sicd.bugmanagement.common.bean.Tester;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.UserCase;
import com.sicd.bugmanagement.common.bean.Version;
import com.sicd.bugmanagement.common.tag.pageTag.PageHelper;
import com.sicd.bugmanagement.utils.DateParser;
import com.sicd.bugmanagement.utils.ModuleUtil;

@Controller
@SessionAttributes({ "userId", "user", "company", "comProjects", "curProject" })
public class TaskController {

	private static Logger logger = Logger.getLogger(TaskController.class);

	@Autowired
	TaskService service;

	@Secured("ROLE_TESTER")
	@RequestMapping(value = "newTask.htm", method = RequestMethod.GET)
	public String newTask(@ModelAttribute("company") Company company,
			@ModelAttribute("curProject") Project curProject,
			ModelMap map) {

		List<Version> versions = service.queryAllOfCondition(
				Version.class,
				DetachedCriteria.forClass(Version.class)
						.add(Restrictions.eq("project", curProject))
						.addOrder(Order.desc("createdAt")));
		logger.info("versions size " + versions.size());

		List<User> users = service.queryAllOfCondition(
				User.class,
				DetachedCriteria
						.forClass(User.class)
						.createAlias("department", "dept")
						.createAlias("dept.company", "com")
						.add(Restrictions.eq("com.companyId", company.getCompanyId()))
						.add(Restrictions.or(
								Restrictions.eq("position", "测试人员"),
								Restrictions.eq("position", "测试经理")))
						.addOrder(Order.asc("joinDate")));
		logger.info("users size " + users.size());

		map.put("versions", versions);
		map.put("users", users);

		return "/task/newTask";
	}

	@Secured("ROLE_TESTER")
	@RequestMapping(value = "addTask.htm", method = RequestMethod.POST)
	public String addTask(@ModelAttribute("userId") Integer userId,
			@RequestParam Integer versionId, @RequestParam Integer ownerId,
			@RequestParam Integer priority, @RequestParam String startDate,
			@RequestParam String endDate, @RequestParam String status,
			@RequestParam String name,
			@RequestParam(required = false) String description) {

		Task task = new Task();
		task.setCreator(service.findById(Tester.class, userId));
		task.setVersion(service.findById(Version.class, versionId));

		Tester tester = service.findById(Tester.class, ownerId);
		logger.info("owner Id  is " + tester.getTesterId());
		task.setOwner(tester);
		logger.info("user Id is " + task.getOwner().getUser().getUserId());
		task.setPriority(priority);
		task.setStartDate(DateParser.parseDate(startDate));
		task.setEndDate(DateParser.parseDate(endDate));
		task.setName(name);
		task.setStatus(status);
		task.setDescription(description);
		task.setCreatedAt(new Date());
		service.save(task);

		History history = new History();
		history.setUser(service.findById(User.class, userId));
		history.setObjectId(task.getTaskId());
		history.setObjectType("task");
		history.setOperateTime(new Date());
		history.setOperation("创建。");
		service.save(history);

		return "redirect:taskList.htm";
	}

	@SuppressWarnings("unchecked")
	@Secured({ "ROLE_DEVELOPER", "ROLE_TESTER" })
	@RequestMapping(value = "taskList.htm", method = RequestMethod.GET)
	public String taskList(
			@ModelAttribute("curProject") Project curProject,
			@RequestParam(required = false, defaultValue = "20") Integer pageSize,
			ModelMap map) {
		logger.info("pageSize is " + pageSize);
		
		DetachedCriteria countCriteria = DetachedCriteria
				.forClass(Task.class, "task")
				.createAlias("task.version", "version")
				.createAlias("version.project", "project")
				.add(Restrictions.eq("project.projectId",
						curProject.getProjectId()));
	
		int totalSize = service.countTotalSize(countCriteria);
		PageHelper.forPage(pageSize, totalSize);

		DetachedCriteria dCriteria = DetachedCriteria
				.forClass(Task.class, "task")
				.createAlias("task.version", "version")
				.createAlias("version.project", "project")
				.add(Restrictions.eq("project.projectId",
						curProject.getProjectId()))
				.addOrder(Order.desc("task.createdAt"));

		List<Task> tasks = (List<Task>) service.getByPage(dCriteria, pageSize);
		
		map.put("tasks", tasks);
		return "/task/taskList";
	}

	@SuppressWarnings("unchecked")
	@Secured("ROLE_TESTER")
	@RequestMapping(value = "linkCases.htm", method = RequestMethod.GET)
	public String linkCases(
			@ModelAttribute("curProject") Project curProject,
			@RequestParam Integer taskId,
			@RequestParam(required = false, defaultValue = "20") Integer pageSize,
			ModelMap map) {
		Task task = service.findById(Task.class, taskId);

		List<UserCase> myCases = service.queryAllOfCondition(
				UserCase.class,
				DetachedCriteria.forClass(UserCase.class)
						.createAlias("testCases", "tc")
						.add(Restrictions.eq("tc.task", task)));
		
		DetachedCriteria dCriteria = DetachedCriteria
				.forClass(UserCase.class, "usercase")
				.createAlias("usercase.module", "module")
				.createAlias("module.project", "project")
				.add(Restrictions.eq("project.projectId",
						curProject.getProjectId()));

		if (!myCases.isEmpty()) {
			List<Integer> ids = new ArrayList<Integer>();
			for (UserCase userCase : myCases) {
				ids.add(userCase.getCaseId());
			}
			dCriteria.add(Restrictions.not(Restrictions.in("usercase.caseId", ids)));
			logger.info("this task already has linked cases size : " + ids.size());
		}
		
		int totalSize = service.countTotalSize(dCriteria);
		logger.info("total record size is " + totalSize);
		
		Map<String, Object> urlmap = new HashMap<String, Object>();
		urlmap.put("taskId", taskId);
		PageHelper.forPage(pageSize, urlmap, totalSize);

		DetachedCriteria caseCriteria = DetachedCriteria
				.forClass(UserCase.class, "usercase")
				.createAlias("usercase.module", "module")
				.createAlias("module.project", "project")
				.add(Restrictions.eq("project.projectId",
						curProject.getProjectId()));

		if (!myCases.isEmpty()) {
			List<Integer> ids = new ArrayList<Integer>();
			for (UserCase userCase : myCases) {
				ids.add(userCase.getCaseId());
			}
			caseCriteria.add(Restrictions.not(Restrictions.in("usercase.caseId", ids)));
			logger.info("this task already has linked cases size : " + ids.size());
		}
		
		List<UserCase> usercases = (List<UserCase>) service.getByPage(caseCriteria, pageSize);
		logger.info("usercases size is " + usercases.size());

		map.put("usercases", usercases);
		map.put("task", task);
		logger.info("leave task controller");

		return "/task/linkCases";
	}
	
	@Secured("ROLE_TESTER")
	@RequestMapping(value = "unlinkCases.htm", method = RequestMethod.GET)
	public String unlinkCases(@RequestParam Integer taskId, @RequestParam Integer caseId){
		List<TestCase> testCases = service.queryAllOfCondition(TestCase.class, 
				DetachedCriteria.forClass(TestCase.class)
				.add(Restrictions.eq("userCase.caseId", caseId))
				.add(Restrictions.eq("task.taskId", taskId)));
		service.deleteAll(testCases);
		return "redirect:showCases.htm?taskId=" + taskId;
	}

	@Secured("ROLE_TESTER")
	@RequestMapping(value = "addLinks.htm", method = RequestMethod.POST)
	public String addLinks(@RequestParam Integer taskId,
			@RequestParam List<Integer> cases) {
		Task task = service.findById(Task.class, taskId);
		List<TestCase> testCases = new ArrayList<TestCase>();
		for (Integer i : cases) {
			TestCase testCase = new TestCase();
			testCase.setTask(task);
			testCase.setUserCase(service.findById(UserCase.class, i));
			testCases.add(testCase);
		}
		service.saveAll(testCases);
		return "redirect:taskList.htm";
	}

	@SuppressWarnings("unchecked")
	@Secured({ "ROLE_DEVELOPER", "ROLE_TESTER" })
	@RequestMapping(value = "showCases.htm", method = RequestMethod.GET)
	public String showCases(
			@ModelAttribute("curProject") Project curProject,
			@RequestParam Integer taskId,
			@RequestParam(required = false, defaultValue = "20") Integer pageSize,
			ModelMap map) {
		logger.info("pageSize is " + pageSize);
		
		Task task = service.findById(Task.class, taskId);
		
		DetachedCriteria dCriteria = DetachedCriteria.forClass(UserCase.class)
				.createAlias("testCases", "tc")
				.add(Restrictions.eq("tc.task", task));
		
		List<UserCase> usercases = (List<UserCase>) service.getByPage(dCriteria, pageSize);
		logger.info("@@@@usercases size is " + usercases.size());
		
		DetachedCriteria countCriteria = DetachedCriteria.forClass(UserCase.class)
				.createAlias("testCases", "tc")
				.add(Restrictions.eq("tc.task", task));
		
		int totalSize = service.countTotalSize(countCriteria);
		
		Map<String, Object> urlmap = new HashMap<String, Object>();
		urlmap.put("taskId", taskId);
		PageHelper.forPage(pageSize, urlmap, totalSize);
		
		List<ModuleBean> moduleBeans = ModuleUtil.getModuleBean(service, curProject);

		map.put("task", task);
		map.put("usercases", usercases);
		map.put("moduleBeans", moduleBeans);

		return "/task/showCases";
	}

	@Secured("ROLE_TESTER")
	@RequestMapping(value = "editTask.htm", method = RequestMethod.GET)
	public String editTask(@ModelAttribute("company") Company company,
			@ModelAttribute("curProject") Project curProject,
			@RequestParam Integer taskId, ModelMap map) {

		Task task = service.findById(Task.class, taskId);

		List<Version> versions = service.queryAllOfCondition(
				Version.class,
				DetachedCriteria.forClass(Version.class)
						.add(Restrictions.eq("project", curProject))
						.addOrder(Order.desc("createdAt")));
		logger.info("versions size " + versions.size());

		List<User> users = service.queryAllOfCondition(
				User.class,
				DetachedCriteria
						.forClass(User.class)
						.createAlias("department", "dept")
						.createAlias("dept.company", "com")
						.add(Restrictions.eq("com.companyId", company.getCompanyId()))
						.add(Restrictions.or(
								Restrictions.eq("position", "测试人员"),
								Restrictions.eq("position", "测试经理")))
						.addOrder(Order.asc("joinDate")));
		
		logger.info("users size " + users.size());

		map.put("task", task);
		map.put("versions", versions);
		map.put("users", users);

		return "/task/editTask";
	}

	@Secured("ROLE_TESTER")
	@RequestMapping(value = "updateTask.htm", method = RequestMethod.POST)
	public String updateTask(@ModelAttribute("userId") Integer userId,
			@RequestParam Integer taskId, @RequestParam Integer versionId,
			@RequestParam Integer ownerId, @RequestParam Integer priority,
			@RequestParam String startDate, @RequestParam String endDate,
			@RequestParam String status, @RequestParam String name,
			@RequestParam(required = false) String description,
			@RequestParam(required = false) String summary) {

		Task task = service.findById(Task.class, taskId);
		task.setVersion(service.findById(Version.class, versionId));
		logger.info("owner Id  is " + ownerId);
		task.setOwner(service.findById(Tester.class, ownerId));
		logger.info("user Id is " + task.getOwner().getUser().getUserId());
		task.setPriority(priority);
		task.setStartDate(DateParser.parseDate(startDate));
		task.setEndDate(DateParser.parseDate(endDate));
		task.setName(name);
		task.setStatus(status);
		task.setDescription(description);
		task.setSummary(summary);
		service.update(task);

		History history = new History();
		history.setUser(service.findById(User.class, userId));
		history.setObjectId(taskId);
		history.setObjectType("task");
		history.setOperateTime(new Date());
		history.setOperation("更新");
		service.save(history);

		return "redirect:showTask.htm?taskId=" + taskId;
	}

	@Secured({ "ROLE_DEVELOPER", "ROLE_TESTER" })
	@RequestMapping(value = "showTask.htm", method = RequestMethod.GET)
	public String showTask(@RequestParam Integer taskId, ModelMap map) {

		Task task = service.findById(Task.class, taskId);
		List<History> histories = service.queryAllOfCondition(
				History.class,
				DetachedCriteria.forClass(History.class)
						.add(Restrictions.eq("objectId", taskId))
						.add(Restrictions.eq("objectType", "task"))
						.addOrder(Order.asc("operateTime")));

		map.put("task", task);
		map.put("histories", histories);

		return "/task/showTask";
	}

	@Secured("ROLE_TESTER")
	@RequestMapping(value = "deleteTask.htm", method = RequestMethod.GET)
	public String deleteTask(@RequestParam Integer taskId) {
		Task task = service.findById(Task.class, taskId);
		List<TestCase> testCases = service.queryAllOfCondition(
				TestCase.class,
				DetachedCriteria.forClass(TestCase.class).add(
						Restrictions.eq("task", task)));
		service.deleteAll(testCases);
		service.delete(task);
		return "redirect:taskList.htm";
	}

	@Secured("ROLE_TESTER")
	@RequestMapping(value = "closeTask.htm", method = RequestMethod.GET)
	public String closeTask(@ModelAttribute("userId") Integer userId,
			@RequestParam Integer taskId) {
		Task task = service.findById(Task.class, taskId);
		task.setStatus("已完成");
		service.update(task);

		History history = new History();
		history.setUser(service.findById(User.class, userId));
		history.setObjectId(taskId);
		history.setObjectType("task");
		history.setOperateTime(new Date());
		history.setOperation("关闭");
		service.save(history);

		return "redirect:showTask.htm?taskId=" + taskId;
	}

}
