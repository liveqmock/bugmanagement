package com.sicd.bugmanagement.business.task.controller;

import static org.hamcrest.Matchers.*;
import static org.mockito.Matchers.eq;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Matchers;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import com.sicd.bugmanagement.business.task.service.TaskService;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.Task;
import com.sicd.bugmanagement.common.bean.Tester;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.UserCase;
import com.sicd.bugmanagement.common.bean.Version;

public class TaskControllerTest {

	@Mock
	private TaskService service;

	@InjectMocks
	private TaskController taskControler;

	private MockMvc mockMvc;

	private Company company = new Company();
	private List<Project> projects = new ArrayList<Project>();
	private List<Version> versions = new ArrayList<Version>();
	private List<User> users = new ArrayList<User>();
	private List<Tester> testers = new ArrayList<Tester>();
	private List<Task> tasks = new ArrayList<Task>();
	private List<UserCase> usercases = new ArrayList<UserCase>();

	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
		this.mockMvc = MockMvcBuilders.standaloneSetup(taskControler).build();

		company.setCompanyId(1);
		company.setName("test company");

		for (int i = 1; i < 5; i++) {
			Project project = new Project();
			project.setProjectId(i);
			project.setName("test Project " + i);
			projects.add(project);
		}

		for (int i = 1; i < 5; i++) {
			Version version = new Version();
			version.setVersionId(i);
			version.setName("test version " + i);
			versions.add(version);
		}

		for (int i = 1; i < 5; i++) {
			User user = new User();
			user.setUserId(i);
			users.add(user);
		}

		for (int i = 1; i < 5; i++) {
			Tester tester = new Tester();
			tester.setUser(users.get(i - 1));
			tester.setTesterId(i);
			testers.add(tester);
		}

		for (int i = 1; i < 5; i++) {
			Task task = new Task();
			task.setTaskId(i);
			tasks.add(task);
		}

		for (int i = 1; i < 5; i++) {
			UserCase userCase = new UserCase();
			userCase.setCaseId(i);
			usercases.add(userCase);
		}
	}

	@Test
	public void testNewTask() throws Exception {
		when(
				service.queryAllOfCondition(eq(User.class),
						Matchers.any(DetachedCriteria.class)))
				.thenReturn(users);
		when(
				service.queryAllOfCondition(eq(Version.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
				versions);

		mockMvc.perform(
				get("/newTask.htm").sessionAttr("company", company)
						.sessionAttr("curProject", projects.get(0)))
				.andExpect(status().isOk())
				.andExpect(view().name("/task/newTask"))
				.andExpect(model().attribute("users", hasSize(4)))
				.andExpect(model().attribute("versions", hasSize(4)));

		verify(service, times(1)).queryAllOfCondition(eq(User.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Version.class),
				Matchers.any(DetachedCriteria.class));
		verifyNoMoreInteractions(service);
	}

	@Test
	public void testAddTask() throws Exception {
		when(service.findById(Tester.class, 1)).thenReturn(testers.get(0));

		mockMvc.perform(
				post("/addTask.htm").param("versionId", "1")
						.param("ownerId", "1").param("priority", "1")
						.param("startDate", "2013-11-15")
						.param("endDate", "2013-11-15").param("status", "进行中")
						.param("name", "a test task")
						.param("description", "a short description")
						.sessionAttr("userId", 1))
				.andExpect(status().isMovedTemporarily())
				.andExpect(view().name("redirect:taskList.htm"));

		verify(service, times(2)).findById(eq(Tester.class), anyInt());
		verify(service, times(1)).findById(eq(Version.class), anyInt());
		verify(service, times(1)).findById(eq(User.class), anyInt());

		verify(service, times(2)).save(Matchers.any(Object.class));
		verifyNoMoreInteractions(service);
	}

	@SuppressWarnings("unchecked")
	@Test
	public void testTaskList() throws Exception {
		when(
				(List<Task>) service.getByPage(
						Matchers.any(DetachedCriteria.class), anyInt()))
				.thenReturn(tasks);

		mockMvc.perform(
				get("/taskList.htm").sessionAttr("curProject", projects.get(0)))
				.andExpect(status().isOk())
				.andExpect(view().name("/task/taskList"))
				.andExpect(model().attribute("tasks", hasSize(4)));

		verify(service, times(1)).countTotalSize(
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).getByPage(
				Matchers.any(DetachedCriteria.class), anyInt());
		verifyNoMoreInteractions(service);
	}

	@SuppressWarnings("unchecked")
	@Test
	public void testLinkCases() throws Exception {
		when(service.findById(Task.class, 1)).thenReturn(tasks.get(0));
		when(
				(List<UserCase>) service.getByPage(
						Matchers.any(DetachedCriteria.class), anyInt()))
				.thenReturn(usercases);

		mockMvc.perform(
				get("/linkCases.htm").param("taskId", "1").sessionAttr(
						"curProject", projects.get(0)))
				.andExpect(status().isOk())
				.andExpect(view().name("/task/linkCases"))
				.andExpect(
						model().attribute("task", hasProperty("taskId", is(1))))
				.andExpect(model().attribute("usercases", hasSize(4)));

		verify(service, times(1)).findById(Task.class, 1);
		verify(service, times(1)).queryAllOfCondition(eq(UserCase.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).countTotalSize(
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).getByPage(
				Matchers.any(DetachedCriteria.class), anyInt());
		verifyNoMoreInteractions(service);
	}

	@SuppressWarnings("unchecked")
	@Test
	public void testAddLinks() throws Exception {

		mockMvc.perform(
				post("/addLinks.htm").param("taskId", "1").param("cases", "1",
						"2", "3")).andExpect(status().isMovedTemporarily())
				.andExpect(view().name("redirect:taskList.htm"));

		verify(service, times(1)).findById(Task.class, 1);
		verify(service, times(3)).findById(eq(UserCase.class), anyInt());
		verify(service, times(1)).saveAll(anyList());
	}

	@Test
	public void testEditTask() throws Exception {
		when(service.findById(Task.class, 1)).thenReturn(tasks.get(0));
		when(service.queryAllOfCondition(eq(User.class), Matchers.any(DetachedCriteria.class))).thenReturn(users);
		when(service.queryAllOfCondition(eq(Version.class), Matchers.any(DetachedCriteria.class))).thenReturn(versions);
		
		mockMvc.perform(
				get("/editTask.htm").param("taskId", "1")
						.sessionAttr("company", company)
						.sessionAttr("curProject", projects.get(0)))
				.andExpect(status().isOk())
				.andExpect(view().name("/task/editTask"));
		
		verify(service, times(1)).findById(Task.class, 1);
		verify(service, times(1)).queryAllOfCondition(eq(User.class), Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Version.class), Matchers.any(DetachedCriteria.class));
	}

}
