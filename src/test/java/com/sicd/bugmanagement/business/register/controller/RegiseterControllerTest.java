package com.sicd.bugmanagement.business.register.controller;

import static org.mockito.Matchers.eq;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoMoreInteractions;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import org.hibernate.criterion.DetachedCriteria;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Matchers;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.invocation.InvocationOnMock;
import org.mockito.stubbing.Answer;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import com.sicd.bugmanagement.business.register.service.RegisterService;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Department;
import com.sicd.bugmanagement.common.bean.Role;
import com.sicd.bugmanagement.common.bean.Tester;
import com.sicd.bugmanagement.common.bean.User;

public class RegiseterControllerTest {
	
	@Mock
	private RegisterService service;
	
	@InjectMocks
	private RegiseterController rController;
	private MockMvc mockMvc;
	private Company company = new Company();
	private User user = new User();
	private Department dept= new Department();
	private Role role=new Role();
	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
		this.mockMvc=MockMvcBuilders.standaloneSetup(rController).build();
		
		company.setCompanyId(1);
		company.setName("Test company");
		
		user.setUserId(1);
		user.setName("Test name");
		
		dept.setDepartmentId(1);
		dept.setName("Test department");
		
		
		role.setRoleId(1);
		role.setRoleName("Test role");
		
	}

	@Test
	public void testGoRegisterPage() throws Exception{
		mockMvc.perform(
				get("/goRegisterPage.htm"))
				.andExpect(status().isOk())
				.andExpect(view().name("/register/register"));
		//fail("Not yet implemented");
	}

	@Test
	public void testGoRegistersuccess() throws Exception{
		mockMvc.perform(
				get("/goRegistersuccess.htm"))
				.andExpect(status().isOk())
				.andExpect(view().name("/register/registersuccess"));
		//fail("Not yet implemented");
	}

	@Test
	public void testUserRegister() throws Exception{
		doAnswer(new Answer() {
		    public Object answer(InvocationOnMock invocation) {
		        Object obj = invocation.getArguments()[0];
		        if(obj instanceof User) {
		        	User myuser = (User) obj;
		        	myuser.setUserId(111);
		        }
		        if(obj instanceof Tester) {
		        	Tester tester = (Tester) obj;
		        	tester.setTesterId(111);
		        }
		        if(obj instanceof Company) {
		        	Company company = (Company) obj;
		        	company.setCompanyId(111);
		        }
		        if(obj instanceof Department) {
		        	Department dept = (Department) obj;
		        	dept.setDepartmentId(111);
		        }
		       return null;
		    }})
		.when(service).save(Matchers.any(Object.class));
		when(service.findById(Role.class, 1)).thenReturn(role);
		mockMvc.perform(
				post("/userRegister.htm")
				.param("userName","hah")
				.param("companyname","公司已")
				.param("userPassword","111111")
				.param("userEmail","11@11.com")
				.param("userGender","男"))
				.andExpect(status().isMovedTemporarily())
				.andExpect(view().name("redirect:goRegistersuccess.htm"));
		verify(service,times(1)).findById(Role.class, 1);
		verify(service,times(7)).save(Matchers.any(Object.class));
		verify(service,times(1)).update(Matchers.any(Object.class));
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

	@Test
	public void testVerifyEmail() throws Exception{
		
		when(service.findById(User.class, 1)).thenReturn(user);
		mockMvc.perform(
				get("/verifyEmail.htm")
				.param("userid","1"))
				.andExpect(status().isOk())
				.andExpect(view().name("/register/verifysuccess"));
		verify(service,times(1)).findById(User.class, 1);
		verify(service,times(1)).update(Matchers.any(Object.class));
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

	@Test
	public void testGoaddUser() throws Exception{
		mockMvc.perform(
				get("/goaddUser.htm")
				.sessionAttr("company", company))
				.andExpect(status().isOk())
				.andExpect(view().name("/register/addUser"))
				.andExpect(model().attributeExists("deptBeans"));
		verify(service, times(1)).queryAllOfCondition(eq(Department.class),
				Matchers.any(DetachedCriteria.class));
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

	@SuppressWarnings("rawtypes")
	@Test
	public void testAddUser() throws Exception{
		User user1=new User();
		user1.setUserId(2);
		user1.setRealName("realName");
		user1.setPosition("测试人员");
		
		doAnswer(new Answer() {
		    public Object answer(InvocationOnMock invocation) {
		        Object obj = invocation.getArguments()[0];
		        if(obj instanceof User) {
		        	User myuser = (User) obj;
		        	myuser.setUserId(111);
		        }
		        if(obj instanceof Tester) {
		        	Tester tester = (Tester) obj;
		        	tester.setTesterId(111);
		        }
		       return null;
		    }})
		.when(service).save(Matchers.any(Object.class));
		when(service.findById(Department.class, 1)).thenReturn(dept);
		mockMvc.perform(
				post("/addUser.htm")
				.param("deptId","1")
				.param("name","hah")
				.param("realName","aha")
				.param("password","111111")
				.param("position","测试人员")
				.param("email","11@11.com")
				.param("gender","男"))
				.andExpect(status().isOk())
				.andExpect(view().name("/register/userHome"));
		verify(service,times(1)).findById(Department.class, 1);
		verify(service,times(2)).save(Matchers.any(Object.class));
		
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

}
