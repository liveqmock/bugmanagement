package com.sicd.bugmanagement.business.project.controller;

import static org.hamcrest.Matchers.*;
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

import com.sicd.bugmanagement.business.project.controller.ProjectController;
import com.sicd.bugmanagement.business.project.service.ProjectService;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Department;
import com.sicd.bugmanagement.common.bean.Module;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.Version;

import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.RequestPostProcessor;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

public class ProjectControllerTest {

	@Mock
	private ProjectService service;

	@InjectMocks
	private ProjectController proControler;

	private MockMvc mockMvc;

	private User user = new User();
	private Company company = new Company();
	private Department department = new Department();
	private List<Project> projects = new ArrayList<Project>();
	private List<Module> modules = new ArrayList<Module>();
	private List<Version> versions = new ArrayList<Version>();

	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
		this.mockMvc = MockMvcBuilders.standaloneSetup(proControler).build();

		company.setCompanyId(1);
		company.setName("test company");

		department.setDepartmentId(1);
		department.setName("test dept");

		user.setUserId(1);
		user.setName("junit test");
		user.setEmail("test@qq.com");
		user.setPassword("111111");
		user.setDepartment(department);

		for (int i = 1; i < 5; i++) {
			Project project = new Project();
			project.setProjectId(i);
			project.setName("test Project " + i);
			projects.add(project);
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
			versions.add(version);
		}
	}

	@Test
	public void testNewProject() throws Exception {
		mockMvc.perform(get("/newProject.htm")).andExpect(status().isOk())
				.andExpect(view().name("project/newProject"));
	}

	@Test
	public void testAddProject() throws Exception {

		mockMvc.perform(
				post("/addProject.htm").param("name", "a test project")
						.param("startDate", "2013-10-20")
						.param("endDate", "2013-10-30")
						.sessionAttr("user", user)
						.sessionAttr("company", company)
						.sessionAttr("comProjects", projects))
				.andExpect(status().isMovedTemporarily())
				.andExpect(view().name("redirect:projectList.htm"))
				.andExpect(model().attribute("comProjects", hasSize(4 + 1)))
				.andExpect(
						model().attribute("curProject",
								hasProperty("name", is("a test project"))));

		verify(service, times(2)).save(Matchers.any(Project.class));
		verifyNoMoreInteractions(service);
	}

	@Test
	public void testProjectList() throws Exception {
		mockMvc.perform(get("/projectList.htm")).andExpect(status().isOk())
				.andExpect(view().name("project/projectList"));
	}

	@Test
	public void testChangeCurProject() throws Exception {

		Project project = new Project();
		project.setProjectId(111);
		project.setName("changed project");

		when(service.findById(Project.class, 111)).thenReturn(project);

		mockMvc.perform(
				get("/changeCurProject.htm").param("projectId", "111").with(
						new RequestPostProcessor() {
							public MockHttpServletRequest postProcessRequest(
									MockHttpServletRequest request) {
								request.addHeader("Referer", "originUrl.htm");
								return request;
							}
						}))
				.andExpect(status().isMovedTemporarily())
				.andExpect(view().name("redirect:originUrl.htm"))
				.andExpect(
						model().attribute("curProject",
								hasProperty("projectId", is(111))))
				.andExpect(
						model().attribute("curProject",
								hasProperty("name", is("changed project"))));

		verify(service, times(1)).findById(Project.class, 111);
		verifyNoMoreInteractions(service);
	}

	// Only tested when moduleId is not null.
	@Test
	public void testShowModule() throws Exception {
		Module module = new Module();
		module.setModuleId(111);
		module.setName("test module");

		when(service.findById(Module.class, 111)).thenReturn(module);

		when(
				service.queryAllOfCondition(eq(Module.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
				modules);

		mockMvc.perform(
				get("/showModule.htm").param("moduleId", "111").sessionAttr(
						"curProject", projects.get(0)))
				.andExpect(status().isOk())
				.andExpect(view().name("/project/showModule"))
				.andExpect(
						model().attribute("module",
								hasProperty("moduleId", is(111))))
				.andExpect(model().attribute("moduleBeans", hasSize(4)))
				.andExpect(model().attributeExists("menuModules"))
				.andExpect(model().attribute("subModules", hasSize(10)));

		verify(service, times(1)).findById(Module.class, 111);
		verify(service, times(2)).queryAllOfCondition(eq(Module.class),
				Matchers.any(DetachedCriteria.class));
		verifyNoMoreInteractions(service);
	}

	@Test
	public void testUpdateModule() throws Exception {

		Module module = new Module();
		module.setModuleId(111);
		module.setName("a test module");

		when(service.findById(Module.class, 111)).thenReturn(module);
		when(
				service.queryAllOfCondition(eq(Module.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
				modules);

		mockMvc.perform(
				post("/updateModule.htm")
						.param("parentModuleId", "111")
						.param("moduleNames", "name1", "name2", "name3",
								"name4", "name5", "", "", "", "", "")
						.sessionAttr("curProject", projects.get(0)))
				.andExpect(status().isMovedTemporarily())
				.andExpect(view().name("redirect:showModule.htm?moduleId=111"));

		verify(service, times(1)).findById(Module.class, 111);
		verify(service, times(1)).queryAllOfCondition(eq(Module.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(4)).update(Matchers.any(Object.class));
		verify(service, times(1)).save(Matchers.any(Object.class));
		verifyNoMoreInteractions(service);
	}

	@Test
	public void testDeleteModule() throws Exception {
		mockMvc.perform(get("/deleteModule.htm").param("moduleId", "111"))
				.andExpect(status().isMovedTemporarily())
				.andExpect(view().name("redirect:showModule.htm"));

		verify(service, times(1)).deleteById(Module.class, 111);
	}

	@Test
	public void testNewVersion() throws Exception {
		mockMvc.perform(get("/newVersion.htm")).andExpect(status().isOk())
				.andExpect(view().name("/project/newVersion"));
	}

	@Test
	public void testAddVersion() throws Exception {
		mockMvc.perform(
				post("/addVersion.htm").param("projectId", "111")
						.param("name", "a new version")
						.param("description", "a short description.")
						.sessionAttr("user", user))
				.andExpect(status().isMovedTemporarily())
				.andExpect(view().name("redirect:versionList.htm"));

		verify(service, times(2)).save(Matchers.any(Object.class));
	}

	@Test
	public void testVersionList() throws Exception {

		when(
				service.queryAllOfCondition(eq(Version.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
				versions);

		mockMvc.perform(
				get("/versionList.htm").sessionAttr("curProject",
						projects.get(0))).andExpect(status().isOk())
				.andExpect(view().name("/project/versionList"))
				.andExpect(model().attribute("versions", hasSize(4)));

		verify(service, times(1)).queryAllOfCondition(eq(Version.class),
				Matchers.any(DetachedCriteria.class));
	}

}
