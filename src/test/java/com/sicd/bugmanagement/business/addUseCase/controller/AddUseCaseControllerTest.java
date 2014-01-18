package com.sicd.bugmanagement.business.addUseCase.controller;

import static org.hamcrest.Matchers.hasProperty;
import static org.hamcrest.Matchers.is;
import static org.junit.Assert.fail;
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

import com.sicd.bugmanagement.business.addUseCase.service.AddUseCaseService;
import com.sicd.bugmanagement.business.project.bean.ModuleBean;
import com.sicd.bugmanagement.common.bean.Bug;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.History;
import com.sicd.bugmanagement.common.bean.Module;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.Resource;
import com.sicd.bugmanagement.common.bean.Step;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.UserCase;



public class AddUseCaseControllerTest {
	
	@Mock
	private AddUseCaseService service;
	
	@InjectMocks
	private AddUseCaseController addCaseController;
	private Company company = new Company();
	private List<Project> projectList = new ArrayList<Project>();
	private List<Module> modules = new ArrayList<Module>();
	private Project project = new Project();
	private Module module = new Module();
	private History hs = new History();
	private MockMvc mockMvc;
	private Bug bug = new Bug();
	private User user = new User();
	private List<ModuleBean> mbList=new ArrayList<ModuleBean>();
	private UserCase us=new UserCase();
	private List<History> hslist = new ArrayList<History>();
	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
		this.mockMvc = MockMvcBuilders.standaloneSetup(addCaseController)
				.build();

		company.setCompanyId(1);
		company.setName("test company");
		
		user.setUserId(1);
		user.setName("junit test");
		user.setEmail("test@qq.com");
		user.setPassword("111111");
		project.setProjectId(1);
		project.setName("test project");

		module.setModuleId(111);
		module.setName("test module");
		module.setProject(project);
		
		us.setCaseId(1);
		us.setTitle("this is a userCase");
		us.setModule(module);
		
		hs.setHistoryId(1);
		hs.setOperation("this is Test operation");
		
		bug.setBugId(1);
		bug.setTitle("this is a Test Bug");
		bug.setModule(module);

		
		for (int i = 1; i < 5; i++) {
			Project project = new Project();
			project.setProjectId(i);
			project.setName("test Project " + i);
			projectList.add(project);
		}
		for (int i = 1; i < 5; i++) {
			History h = new History();
			h.setHistoryId(i);
			h.setOperation("test history " + i);
			hslist.add(h);
		}
		for (int i = 1; i < 5; i++) {
			ModuleBean mb = new ModuleBean();
			mb.setModuleId(i);
			mb.setModuleName("test module " + i);
			mbList.add(mb);
		}

		for (int i = 1; i < 5; i++) {
			Module module = new Module();
			module.setModuleId(i);
			module.setName("test module " + i);
			modules.add(module);
		}

	}

	@Test
	public void testGoAddUseCase() throws Exception{
	
		mockMvc.perform(
				get("/goAddUseCase.htm")
				.sessionAttr("user", user)
				.sessionAttr("curProject", project)
				.sessionAttr("company", company))
				.andExpect(status().isOk())
				.andExpect(view().name("/usecase/addUseCase"))
				.andExpect(model().attributeExists("projectList"));
		verify(service, times(1)).queryAllOfCondition(eq(Project.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Module.class),
				Matchers.any(DetachedCriteria.class));
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

	@Test
	public void testGoCopyUserCase() throws Exception {
		when(service.findById(UserCase.class, 1)).thenReturn(us);
		mockMvc.perform(
				get("/goCopyUserCase.htm")
				.param("usercaseId", "1")
				.sessionAttr("user", user)
				.sessionAttr("company", company))
				.andExpect(status().isOk())
				.andExpect(view().name("/usecase/copyUseCase"))
				.andExpect(model().attributeExists("modulebean"))
				.andExpect(model().attributeExists("projectList"))
				.andExpect(model().attributeExists("stepList"))
				.andExpect(model().attribute("userCase", hasProperty("title", is("this is a userCase"))));
		verify(service, times(1)).queryAllOfCondition(eq(Project.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Module.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Step.class),
				Matchers.any(DetachedCriteria.class));
		verify(service,times(1)).findById(UserCase.class, 1);
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

	@Test
	public void testGoEditeUserCase() throws Exception{
		when(service.findById(UserCase.class, 1)).thenReturn(us);
		when(
				service.queryAllOfCondition(eq(History.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(hslist);
		mockMvc.perform(
				get("/goEditeUserCase.htm")
				.param("usercaseId", "1")
				.sessionAttr("user", user))
				.andExpect(status().isOk())
				.andExpect(view().name("/usecase/editUseCase"))
				.andExpect(model().attributeExists("modulebean"))
				.andExpect(model().attributeExists("hisList"))
				.andExpect(model().attributeExists("stepList"))
				.andExpect(model().attribute("hs",hasProperty("operation", is("test history 4"))))
				.andExpect(model().attribute("userCase", hasProperty("title", is("this is a userCase"))));
		verify(service, times(2)).queryAllOfCondition(eq(History.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Module.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Step.class),
				Matchers.any(DetachedCriteria.class));
		verify(service,times(1)).findById(UserCase.class, 1);
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}


	@Test
	public void testGoUcFromBug() throws Exception{
		when(service.findById(Bug.class, 1)).thenReturn(bug);
		mockMvc.perform(
				get("/goUcFromBug.htm")
				.param("bugId", "1")
				.sessionAttr("user", user)
				.sessionAttr("company", company))
				.andExpect(status().isOk())
				.andExpect(view().name("/usecase/bugToUc"))
				.andExpect(model().attributeExists("modulebean"))
				.andExpect(model().attributeExists("projectList"))
				.andExpect(model().attribute("bug", hasProperty("title", is("this is a Test Bug"))));
		verify(service, times(1)).queryAllOfCondition(eq(Project.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Module.class),
				Matchers.any(DetachedCriteria.class));
		verify(service,times(1)).findById(Bug.class, 1);
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}


	@Test
	public void testShowCase() throws Exception{
		when(service.findById(UserCase.class, 1)).thenReturn(us);
		mockMvc.perform(
				get("/showCase.htm")
				.param("caseId", "1"))
				.andExpect(status().isOk())
				.andExpect(view().name("/usecase/showCase"))
				.andExpect(model().attributeExists("histories"))
				.andExpect(model().attributeExists("resources"))
				.andExpect(model().attributeExists("steps"))
				.andExpect(model().attribute("userCase", hasProperty("title", is("this is a userCase"))));
		verify(service, times(1)).queryAllOfCondition(eq(History.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Resource.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Step.class),
				Matchers.any(DetachedCriteria.class));
		verify(service,times(1)).findById(UserCase.class, 1);
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

}
