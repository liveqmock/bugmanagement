package com.sicd.bugmanagement.business.addbug.controller;

import static org.hamcrest.Matchers.hasProperty;
import static org.hamcrest.Matchers.hasSize;
import static org.hamcrest.Matchers.is;
import static org.mockito.Matchers.eq;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoMoreInteractions;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

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

import com.sicd.bugmanagement.business.addbug.controller.AddBugController;
import com.sicd.bugmanagement.business.addbug.service.AddBugService;
import com.sicd.bugmanagement.common.bean.AffectedVersion;
import com.sicd.bugmanagement.common.bean.Bug;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Department;
import com.sicd.bugmanagement.common.bean.Developer;
import com.sicd.bugmanagement.common.bean.History;
import com.sicd.bugmanagement.common.bean.Module;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.Resource;
import com.sicd.bugmanagement.common.bean.Step;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.UserCase;
import com.sicd.bugmanagement.common.bean.Version;

public class AddBugControllerTest {

	@Mock
	private AddBugService service;

	@InjectMocks
	private AddBugController addBugController;
	private User user = new User();
	private Company company = new Company();
	private Version ver = new Version();
	private Project project = new Project();
	private Module module = new Module();
	private Developer develop = new Developer();
	private Bug bug = new Bug();
	private Department department = new Department();
	private List<Project> projectList = new ArrayList<Project>();
	private List<Module> modules = new ArrayList<Module>();
	private List<Version> versionList = new ArrayList<Version>();
	private List<Bug> bugs = new ArrayList<Bug>();
	private List<History> hs = new ArrayList<History>();
	private List<Developer> devs = new ArrayList<Developer>();
	private List<AffectedVersion> avs = new ArrayList<AffectedVersion>();

	private MockMvc mockMvc;

	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
		this.mockMvc = MockMvcBuilders.standaloneSetup(addBugController)
				.build();

		company.setCompanyId(1);
		company.setName("test company");

		ver.setVersionId(1);
		ver.setName("test version");

		department.setDepartmentId(1);
		department.setName("test dept");

		user.setUserId(1);
		user.setName("junit test");
		user.setEmail("test@qq.com");
		user.setPassword("111111");
		user.setDepartment(department);

		develop.setDeveloperId(1);
		develop.setUser(user);

		project.setProjectId(1);
		project.setName("test project");

		module.setModuleId(111);
		module.setName("test module");
		module.setProject(project);

		bug.setBugId(1);
		bug.setTitle("test bug");
		bug.setMailto("hh;yy");
		bug.setModule(module);
		bug.setAssignedTo(develop);
		for (int i = 1; i < 5; i++) {
			History h = new History();
			h.setHistoryId(i);
			h.setOperation("test Project " + i);
			hs.add(h);
		}
		for (int i = 1; i < 5; i++) {
			Developer dev = new Developer();
			dev.setDeveloperId(i);

			devs.add(dev);
		}
		for (int i = 1; i < 5; i++) {
			AffectedVersion av = new AffectedVersion();
			av.setAffectedVersionId(i);

			avs.add(av);
		}
		for (int i = 1; i < 5; i++) {
			Project project = new Project();
			project.setProjectId(i);
			project.setName("test Project " + i);
			projectList.add(project);
		}
		for (int i = 1; i < 5; i++) {
			Bug bug = new Bug();
			bug.setBugId(i);
			bug.setTitle("test Project " + i);
			bugs.add(bug);
		}

		for (int i = 1; i < 5; i++) {
			Module module = new Module();
			module.setModuleId(i);
			module.setName("test module " + i);
			modules.add(module);
		}

		for (int i = 1; i < 5; i++) {
			Version version = new Version();
			version.setVersionId(i);
			version.setName("test version " + i);
			versionList.add(version);
		}
	}

	@Test
	public void testGoAddBug() throws Exception {
		mockMvc.perform(
				get("/goAddBug.htm").sessionAttr("user", user).sessionAttr(
						"company", company)).andExpect(status().isOk())
				.andExpect(view().name("/bug/addBug"))
				.andExpect(model().attributeExists("projectList"))
				.andExpect(model().attributeExists("userList"))
				.andExpect(model().attributeExists("userList1"));
		verify(service, times(1)).queryAllOfCondition(eq(User.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Department.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Project.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Developer.class),
				Matchers.any(DetachedCriteria.class));
		verifyNoMoreInteractions(service);
	}

	/*
	 * @Test public void testAddBug() throws Exception {
	 * 
	 * Module module = new Module(); module.setModuleId(111);
	 * module.setName("test module"); when(service.findById(Version.class,
	 * 1)).thenReturn(ver); when(service.findById(Module.class,
	 * 111)).thenReturn(module); when(service.findById(Developer.class,
	 * 1)).thenReturn(develop);
	 * 
	 * 
	 * mockMvc.perform( post("/addBug.htm") .param("browser",
	 * "IE").param("keywords", "关键词") .param("mail1", "科科").param("os", "win7")
	 * .param("severity", "1").param("title", "this is first bug")
	 * .param("type", "代码错误").param("chongxian", "fjfd") .param("chongxian",
	 * "fjfd") .param("version", "ve1","ve2") .sessionAttr("user", user)
	 * .sessionAttr("company", company) )
	 * .andExpect(status().isMovedTemporarily())
	 * .andExpect(view().name("redirect:bug.htm")); verify(service,
	 * times(1)).save(Bug.class); verify(service, times(1)).save(History.class);
	 * verify(service, times(2)).save(AffectedVersion.class); }
	 */
	@Test
	public void testGoCopyBug() throws Exception {

		when(service.findById(Bug.class, 1)).thenReturn(bug);
		when(
				service.queryAllOfCondition(eq(Version.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
				versionList);
		when(
				service.queryAllOfCondition(eq(Project.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
				projectList);
		mockMvc.perform(
				get("/gocopyBug.htm").param("bugId", "1")
						.sessionAttr("user", user)
						.sessionAttr("company", company))
				.andExpect(status().isOk())
				.andExpect(view().name("/bug/copyBug"))
				.andExpect(model().attributeExists("bug"))
				.andExpect(model().attributeExists("modulebean"))
				.andExpect(model().attribute("projectList", hasSize(4)))
				.andExpect(model().attribute("versionList", hasSize(4)))
				.andExpect(model().attribute("userlist", hasSize(2)))
				.andExpect(model().attributeExists("userList"))
				.andExpect(model().attributeExists("userList1"))
				.andExpect(model().attributeExists("aList"));
		verify(service, times(1)).queryAllOfCondition(eq(Module.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).findById(Bug.class, 1);
		verify(service, times(1)).queryAllOfCondition(eq(Project.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Version.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1))
				.queryAllOfCondition(eq(AffectedVersion.class),
						Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Department.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Developer.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(User.class),
				Matchers.any(DetachedCriteria.class));
		verifyNoMoreInteractions(service);

	}

	@Test
	public void testGoBugFromUc() throws Exception {

		UserCase us = new UserCase();
		us.setCaseId(1);
		us.setTitle("test Uc");
		when(service.findById(UserCase.class, 1)).thenReturn(us);
		mockMvc.perform(
				get("/goBugFromUc.htm").param("usercaseId", "1")
						.sessionAttr("user", user)
						.sessionAttr("company", company)

		).andExpect(status().isOk()).andExpect(view().name("/usecase/ucToBug"))
				.andExpect(model().attributeExists("projectList"))
				.andExpect(model().attributeExists("userList"))
				.andExpect(model().attributeExists("userList1"))
				.andExpect(model().attributeExists("uc"))
				.andExpect(model().attributeExists("stepList"));
		verify(service, times(1)).findById(UserCase.class, 1);
		verify(service, times(1)).queryAllOfCondition(eq(Step.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Project.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(User.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Developer.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Department.class),
				Matchers.any(DetachedCriteria.class));
		verifyNoMoreInteractions(service);
	}

	/*
	 * @Test public void testEditBug() throws Exception {
	 * mockMvc.perform(get("/newVersion.htm")).andExpect(status().isOk())
	 * .andExpect(view().name("/project/newVersion")); }
	 */

	@Test
	public void testGoEditBug() throws Exception {
		when(service.findById(Bug.class, 1)).thenReturn(bug);
		when(
				service.queryAllOfCondition(eq(AffectedVersion.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(avs);
		mockMvc.perform(
				get("/goeditBug.htm").param("bugId", "1")
						.sessionAttr("user", user)
						.sessionAttr("company", company))
				.andExpect(status().isOk())
				.andExpect(view().name("/bug/editBug"))
				.andExpect(
						model().attribute("bug",
								hasProperty("title", is("test bug"))))
				.andExpect(model().attributeExists("modulebean"))
				.andExpect(model().attributeExists("projectList"))
				.andExpect(model().attributeExists("versionList"))
				.andExpect(model().attribute("userlist", hasSize(2)))
				.andExpect(model().attributeExists("userList"))
				.andExpect(model().attributeExists("userList1"))
				.andExpect(model().attribute("aList", hasSize(4)))
				.andExpect(model().attributeExists("hisList"));
		verify(service, times(1)).queryAllOfCondition(eq(Module.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).findById(Bug.class, 1);
		verify(service, times(1)).queryAllOfCondition(eq(Project.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Version.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1))
				.queryAllOfCondition(eq(AffectedVersion.class),
						Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Department.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Developer.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(User.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1))
				.queryAllOfCondition(eq(AffectedVersion.class),
						Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(History.class),
				Matchers.any(DetachedCriteria.class));
		verifyNoMoreInteractions(service);
	}

	/*
	 * @Test public void testAddBugFromUc() throws Exception {
	 * mockMvc.perform(get("/newVersion.htm")).andExpect(status().isOk())
	 * .andExpect(view().name("/project/newVersion")); }
	 */
	@Test
	public void testShowBug() throws Exception {
		when(service.findById(Bug.class, 1)).thenReturn(bug);
		mockMvc.perform(get("/showBug.htm")
				.param("bugId", "1")
				)
				.andExpect(status().isOk())
				.andExpect(view().name("bug/showBug"))
				.andExpect(model().attribute("bug", hasProperty("title",is("test bug"))))
				.andExpect(model().attributeExists("histories"))
				.andExpect(model().attributeExists("resources"));
		verify(service,times(1)).findById(Bug.class, 1);
		verify(service,times(1)).queryAllOfCondition(eq(History.class), Matchers.any(DetachedCriteria.class));
		verify(service,times(1)).queryAllOfCondition(eq(Resource.class), Matchers.any(DetachedCriteria.class));		
		verifyNoMoreInteractions(service);
	}

}
