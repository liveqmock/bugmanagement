package com.sicd.bugmanagement.business.login.controller;

import static org.mockito.Matchers.eq;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoMoreInteractions;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.security.Principal;
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

import com.sicd.bugmanagement.business.login.service.LoginService;
import com.sicd.bugmanagement.common.bean.Bug;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Department;
import com.sicd.bugmanagement.common.bean.History;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.Task;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.UserCase;

public class LoginControllerTest {
	@Mock
	private LoginService service;
	
	@InjectMocks
	private LoginController lController;
	private MockMvc mockMvc;
	private Company company = new Company();
	private User user = new User();
	private Department dept= new Department();
	private List<Project> comProjects=new ArrayList<Project>();
	private List<User> userList=new ArrayList<User>();
	@Before
	public void setUp() throws Exception {
		
		MockitoAnnotations.initMocks(this);
		this.mockMvc=MockMvcBuilders.standaloneSetup(lController).build();
		
		company.setCompanyId(1);
		company.setName("Test company");
		
		dept.setDepartmentId(1);
		dept.setName("Test department");
		dept.setCompany(company);
		
		user.setUserId(1);
		user.setName("Test name");
		user.setDepartment(dept);
		user.setPosition("开发人员");
		
		for(int i=1;i<5;i++){
			Project project=new Project();
			project.setProjectId(i);
			project.setName("Test project"+i);
			comProjects.add(project);
		}
		for(int i=1;i<5;i++){
			User user=new User();
			user.setUserId(i);
			user.setName("Test User"+i);
			user.setPosition("测试人员");
			user.setDepartment(dept);
			userList.add(user);
		}
		
	}

	@Test
	public void testLogin() throws Exception{
		mockMvc.perform(
				get("/newLogin.htm"))
				.andExpect(status().isOk())
				.andExpect(view().name("/login/newLogin"));
		//fail("Not yet implemented");
	}

	@Test
	public void testMyLogin() throws Exception{
		Principal principal=new Principal() {
			public String getName() {
				// TODO Auto-generated method stub
				return "email";
			}
		};
		when(service.findById(Department.class, 1)).thenReturn(dept);
		when(service.findById(Company.class, 1)).thenReturn(company);
		when(
				service.queryAllOfCondition(eq(Project.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
								comProjects);
		when(
				service.queryAllOfCondition(eq(User.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
								userList);
		mockMvc.perform(
				get("/myLogin.htm")
				.principal(principal))
				.andExpect(status().isMovedTemporarily())
				.andExpect(view().name("redirect:turnToHomePage.htm"));
		verify(service,times(1)).findById(Department.class, 1);
		verify(service,times(1)).findById(Company.class, 1);
		verify(service, times(1)).queryAllOfCondition(eq(User.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Project.class),
				Matchers.any(DetachedCriteria.class));
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

	@Test
	public void testTurnToHomePage() throws Exception{
		mockMvc.perform(
				get("/turnToHomePage.htm")
				.sessionAttr("user", user)
				.sessionAttr("company", company))
				.andExpect(status().isOk())
				.andExpect(view().name("/homepage/myHome"))
				.andExpect(model().attributeExists("histories"))
				.andExpect(model().attributeExists("myBugs"))
				.andExpect(model().attributeExists("unclosedBugs"))
				.andExpect(model().attributeExists("newCases"))
				.andExpect(model().attributeExists("newTasks"));
		verify(service, times(1)).queryMaxNumOfCondition(eq(History.class), Matchers.any(DetachedCriteria.class), Matchers.anyInt());
		verify(service, times(2)).queryMaxNumOfCondition(eq(Bug.class), Matchers.any(DetachedCriteria.class), Matchers.anyInt());
		verify(service, times(1)).queryMaxNumOfCondition(eq(UserCase.class), Matchers.any(DetachedCriteria.class), Matchers.anyInt());
		verify(service, times(1)).queryMaxNumOfCondition(eq(Task.class), Matchers.any(DetachedCriteria.class), Matchers.anyInt());
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

}
