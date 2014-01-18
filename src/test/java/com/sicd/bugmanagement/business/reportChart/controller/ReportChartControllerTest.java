package com.sicd.bugmanagement.business.reportChart.controller;

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

import com.sicd.bugmanagement.business.reportChart.service.ReportChartService;
import com.sicd.bugmanagement.common.bean.AffectedVersion;
import com.sicd.bugmanagement.common.bean.Bug;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Department;
import com.sicd.bugmanagement.common.bean.Developer;
import com.sicd.bugmanagement.common.bean.Module;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.Version;

public class ReportChartControllerTest {
	
	@Mock
	private ReportChartService service;
	
	@InjectMocks
	private ReportChartController rChartController;
	private MockMvc mockMvc;
	private User user = new User();
	private Company company = new Company();
	private Project project = new Project();
	private List<Department> deptList=new ArrayList<Department>();
	private List<Version> verList=new ArrayList<Version>();
	private List<Module> modules = new ArrayList<Module>();
	private List<Developer> devs = new ArrayList<Developer>();
	private List<User> userList = new ArrayList<User>();
	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
		this.mockMvc = MockMvcBuilders.standaloneSetup(rChartController)
				.build();
		
		user.setUserId(1);
		user.setName("junit test");
		user.setEmail("test@qq.com");
		user.setPassword("111111");
		user.setRealName("realName");
		project.setProjectId(1);
		project.setName("this is a Test project");
		
		
		company.setCompanyId(1);
		company.setName("this is a Test Company");
		
		for (int i = 1; i < 5; i++) {
			Department department = new Department();
			department.setDepartmentId(i);
			department.setName("this is a department"+i);
			deptList.add(department);
		}
		for (int i = 1; i < 5; i++) {
			Version ver = new Version();
			ver.setVersionId(i);
			ver.setName("this is a version"+i);
			verList.add(ver);
		}
		for (int i = 1; i < 5; i++) {
			Module module = new Module();
			module.setModuleId(i);
			module.setName("test module " + i);
			modules.add(module);
		}
		for (int i = 1; i < 5; i++) {
			Developer dev = new Developer();
			dev.setDeveloperId(i);
			dev.setUser(user);
			devs.add(dev);
		}
		for (int i = 1; i < 5; i++) {
			User user = new User();
			user.setUserId(i);
			user.setName("this is a Test name");

			userList.add(user);
		}
		
		
	}
	@Test
	public void testTestChart() throws Exception{
		when(
				service.queryAllOfCondition(eq(Department.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
								deptList);
		when(
				service.queryAllOfCondition(eq(Module.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
								modules);
		when(
				service.queryAllOfCondition(eq(Version.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
								verList);
		when(
				service.queryAllOfCondition(eq(Developer.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
								devs);
		when(
				service.queryAllOfCondition(eq(User.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
								userList);
		mockMvc.perform(
				get("/TestChart.htm")
				.sessionAttr("curProject", project)
				.sessionAttr("company", company))
				.andExpect(status().isOk())
				.andExpect(view().name("/reportChart/reportChart"))
				.andExpect(model().attributeExists("json"))
				.andExpect(model().attributeExists("js"))
				.andExpect(model().attributeExists("js1"))
				.andExpect(model().attributeExists("js2"))
				.andExpect(model().attributeExists("js3"))
				.andExpect(model().attributeExists("js4"))
				.andExpect(model().attributeExists("js5"))
				.andExpect(model().attributeExists("js6"))
				.andExpect(model().attributeExists("js7"))
				.andExpect(model().attributeExists("js8"))
				.andExpect(model().attributeExists("js9"))
				.andExpect(model().attributeExists("js10"))
				.andExpect(model().attributeExists("pieList"))
				.andExpect(model().attributeExists("pieList1"))
				.andExpect(model().attributeExists("pieList2"))
				.andExpect(model().attributeExists("pieList3"))
				.andExpect(model().attributeExists("pieList4"))
				.andExpect(model().attributeExists("pieList5"))
				.andExpect(model().attributeExists("pieList6"))
				.andExpect(model().attributeExists("pieList7"))
				.andExpect(model().attributeExists("pieList9"));
		verify(service, times(1)).queryAllOfCondition(eq(Module.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(31)).queryAllOfCondition(eq(Bug.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Department.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Version.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(4)).queryAllOfCondition(eq(AffectedVersion.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Developer.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(User.class),
				Matchers.any(DetachedCriteria.class));
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

}
