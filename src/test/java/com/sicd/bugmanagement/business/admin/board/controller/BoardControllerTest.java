package com.sicd.bugmanagement.business.admin.board.controller;


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

import com.sicd.bugmanagement.business.admin.board.service.BoardService;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Department;
import com.sicd.bugmanagement.common.bean.Module;
import com.sicd.bugmanagement.common.bean.OperateLog;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.Version;

public class BoardControllerTest {
	
	@Mock
	private BoardService service;
	
	@InjectMocks
	private BoardController bController;
	private MockMvc mockMvc;
	private User user = new User();
	private Company company = new Company();
	private Project project = new Project();
	private List<Department> deptList=new ArrayList<Department>();
	
	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
		this.mockMvc = MockMvcBuilders.standaloneSetup(bController)
				.build();
		
		user.setUserId(1);
		user.setName("junit test");
		user.setEmail("test@qq.com");
		user.setPassword("111111");
		
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
		
	}

	@Test
	public void testGoToTest() throws Exception{
		mockMvc.perform(
				get("/goToTest.htm"))
				.andExpect(status().isOk())
				.andExpect(view().name("/admin/test"));
		//fail("Not yet implemented");
	}

	@Test
	public void testGoIndex() throws Exception{
		mockMvc.perform(
				get("/goIndex.htm"))
				.andExpect(status().isOk())
				.andExpect(view().name("/admin/index"))
				.andExpect(model().attributeExists("userList"))
				.andExpect(model().attributeExists("userSum"))
				.andExpect(model().attributeExists("companySum"))
				.andExpect(model().attributeExists("companyList"))
				.andExpect(model().attributeExists("projectSum"))
				.andExpect(model().attributeExists("projectList"))
				.andExpect(model().attributeExists("logList"));
		verify(service, times(1)).queryAllOfCondition(eq(User.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Company.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Project.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryMaxNumOfCondition(eq(User.class), Matchers.any(DetachedCriteria.class), Matchers.anyInt());
		verify(service, times(1)).queryMaxNumOfCondition(eq(OperateLog.class), Matchers.any(DetachedCriteria.class), Matchers.anyInt());
		verify(service, times(1)).queryMaxNumOfCondition(eq(Company.class), Matchers.any(DetachedCriteria.class), Matchers.anyInt());
		verify(service, times(1)).queryMaxNumOfCondition(eq(Project.class), Matchers.any(DetachedCriteria.class), Matchers.anyInt());
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

	@Test
	public void testGoCompanyList() throws Exception{
		
		mockMvc.perform(
				get("/goCompanyList.htm")
				.param("pageSize", "1")
				.sessionAttr("user", user))
				.andExpect(status().isOk())
				.andExpect(view().name("/admin/companyList"))
				.andExpect(model().attributeExists("companyList"));
		verify(service,times(1)).countTotalSize(Matchers.any(DetachedCriteria.class));
		verify(service,times(1)).getByPage(Matchers.any(DetachedCriteria.class),Matchers.anyInt());
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

	@Test
	public void testCompanyDetail() throws Exception{
		when(service.findById(Company.class, 1)).thenReturn(company);
		when(
				service.queryAllOfCondition(eq(Department.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
								deptList);
		mockMvc.perform(
				get("/companyDetail.htm")
				.param("companyId", "1")
				.sessionAttr("user", user))
				.andExpect(status().isOk())
				.andExpect(view().name("/admin/companyDetail"))
				.andExpect(model().attributeExists("proSum"))
				.andExpect(model().attributeExists("departSum"))
				.andExpect(model().attributeExists("userSum"))
				.andExpect(model().attributeExists("company"))
				.andExpect(model().attributeExists("projectList"))
				.andExpect(model().attributeExists("departList"))
				.andExpect(model().attributeExists("pieList2"))
				.andExpect(model().attributeExists("js5"));
		verify(service, times(1)).queryAllOfCondition(eq(Project.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Department.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(3)).queryAllOfCondition(eq(User.class),
				Matchers.any(DetachedCriteria.class));
		verify(service,times(1)).findById(Company.class, 1);
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

	@Test
	public void testGoProjectList() throws Exception{
		
		mockMvc.perform(
				get("/goProjectList.htm")
				.param("pageSize", "1")
				.sessionAttr("user", user))
				.andExpect(status().isOk())
				.andExpect(view().name("/admin/projectList"))
				.andExpect(model().attributeExists("projectList"));
		verify(service,times(1)).countTotalSize(Matchers.any(DetachedCriteria.class));
		verify(service,times(1)).getByPage(Matchers.any(DetachedCriteria.class),Matchers.anyInt());
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

	@Test
	public void testProjectDetail() throws Exception {
		when(service.findById(Project.class, 1)).thenReturn(project);
		when(
				service.queryAllOfCondition(eq(Department.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
								deptList);
		mockMvc.perform(
				get("/projectDetail.htm")
				.param("projectId", "1")
				.sessionAttr("user", user))
				.andExpect(status().isOk())
				.andExpect(view().name("/admin/projectDetail"))
				.andExpect(model().attributeExists("userSum"))
				.andExpect(model().attributeExists("verSum"))
				.andExpect(model().attributeExists("modSum"))
				.andExpect(model().attributeExists("userList"))
				.andExpect(model().attributeExists("versionList"))
				.andExpect(model().attributeExists("moduleList"))
				.andExpect(model().attributeExists("project"));
		verify(service, times(1)).queryAllOfCondition(eq(Version.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Module.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Department.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(User.class),
				Matchers.any(DetachedCriteria.class));
		verify(service,times(1)).findById(Project.class, 1);
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

	@Test
	public void testGoUserList() throws Exception{
		
		mockMvc.perform(
				get("/goUserList.htm")
				.param("pageSize", "1")
				.sessionAttr("user", user))
				.andExpect(status().isOk())
				.andExpect(view().name("/admin/userList"))
				.andExpect(model().attributeExists("js2"))
				.andExpect(model().attributeExists("js3"))
				.andExpect(model().attributeExists("js4"))
				.andExpect(model().attributeExists("js5"))
				.andExpect(model().attributeExists("userList"))
				.andExpect(model().attributeExists("pieList"))
				.andExpect(model().attributeExists("pieList1"))
				.andExpect(model().attributeExists("pieList2"));
		verify(service,times(1)).countTotalSize(Matchers.any(DetachedCriteria.class));
		verify(service,times(1)).getByPage(Matchers.any(DetachedCriteria.class),Matchers.anyInt());
		verify(service, times(5)).queryAllOfCondition(eq(User.class),
				Matchers.any(DetachedCriteria.class));
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

	@Test
	public void testGoLogList() throws Exception{
		mockMvc.perform(
				get("/goLogList.htm")
				.param("pageSize", "1")
				.sessionAttr("user", user))
				.andExpect(status().isOk())
				.andExpect(view().name("/admin/logList"))
				.andExpect(model().attributeExists("logList"));
		verify(service,times(1)).countTotalSize(Matchers.any(DetachedCriteria.class));
		verify(service,times(1)).getByPage(Matchers.any(DetachedCriteria.class),Matchers.anyInt());
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

}
