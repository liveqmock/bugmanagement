package com.sicd.bugmanagement.business.exception.controller;

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

import com.sicd.bugmanagement.business.exception.service.ExceptionRecordService;

import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Department;
import com.sicd.bugmanagement.common.bean.Developer;
import com.sicd.bugmanagement.common.bean.ExceptionRecord;
import com.sicd.bugmanagement.common.bean.MyException;
import com.sicd.bugmanagement.common.bean.User;

public class ExceptionRecordControllerTest {
	
	@Mock
	private ExceptionRecordService service;
	
	@InjectMocks
	private ExceptionRecordController eController;
	private List<ExceptionRecord> erlist=new ArrayList<ExceptionRecord>();
	private ExceptionRecord er=new ExceptionRecord(); 
	private Developer developer=new Developer(); 
	private Company company=new Company();
	private MyException myException=new MyException();
	private User user=new User();
	
	private List<Developer> devs = new ArrayList<Developer>();
	private List<Department> dptList = new ArrayList<Department>();

	
	private MockMvc mockMvc;
	@Before
	public void setUp() throws Exception {
		
		MockitoAnnotations.initMocks(this);
		this.mockMvc = MockMvcBuilders.standaloneSetup(eController)
				.build();

		company.setCompanyId(1);
		company.setName("test company");
		
		user.setUserId(1);
		user.setName("junit test");
		user.setEmail("test@qq.com");
		user.setPassword("111111");
		
		developer.setDeveloperId(1);
		developer.setUser(user);
		
		myException.setExceptionId(1);
		myException.setExceptionClass("this is a exception");
		
		
		er.setRecordId(1);
		er.setDeveloper(developer);
		er.setMyException(myException);
		for (int i = 1; i < 5; i++) {
			ExceptionRecord er = new ExceptionRecord();
			er.setRecordId(i);
			er.setDeveloper(developer);
			erlist.add(er);
		}
		for (int i = 1; i < 5; i++) {
			Department department = new Department();
			department.setDepartmentId(i);
			department.setName("this is a department"+i);
			dptList.add(department);
		}
		for (int i = 1; i < 5; i++) {
			Developer developer=new Developer(); 
			developer.setDeveloperId(i);
			devs.add(developer);
		}
		
	}

	@Test
	public void testGoPerExceptionRecord() throws Exception{
		
		when(service.findById(Developer.class, 1)).thenReturn(developer);
		mockMvc.perform(
				get("/goPerExceptionRecord.htm")
				.param("pageSize", "1")
				.sessionAttr("user", user))
				.andExpect(status().isOk())
				.andExpect(view().name("/exception/showPersonalRecord"))
				.andExpect(model().attributeExists("exList"));
		verify(service,times(1)).countTotalSize(Matchers.any(DetachedCriteria.class));
		verify(service,times(1)).getByPage(Matchers.any(DetachedCriteria.class),Matchers.anyInt());
		verify(service,times(1)).findById(Developer.class, 1);
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

	@Test
	public void testGoCompanyExceptionRecord() throws Exception{
		when(
				service.queryAllOfCondition(eq(Department.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
								dptList);
		when(
				service.queryAllOfCondition(eq(Developer.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
								devs);
		mockMvc.perform(
				get("/goCompanyExceptionRecord.htm")
				.param("pageSize", "1")
				.sessionAttr("company", company)
				.sessionAttr("user", user))
				.andExpect(status().isOk())
				.andExpect(view().name("/exception/showCompanyRecord"))
				.andExpect(model().attributeExists("exList"));
		verify(service, times(1)).queryAllOfCondition(eq(Department.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Developer.class),
				Matchers.any(DetachedCriteria.class));
		verify(service,times(1)).countTotalSize(Matchers.any(DetachedCriteria.class));
		verify(service,times(1)).getByPage(Matchers.any(DetachedCriteria.class),Matchers.anyInt());
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

	@Test
	public void testGoExceptionDetail()throws Exception {
		when(service.findById(Developer.class, 1)).thenReturn(developer);
		when(service.findById(ExceptionRecord.class, 1)).thenReturn(er);
		when(
				service.queryAllOfCondition(eq(Department.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
								dptList);
		when(
				service.queryAllOfCondition(eq(Developer.class),
						Matchers.any(DetachedCriteria.class))).thenReturn(
								devs);
		mockMvc.perform(
				get("/goExceptionDetail.htm")
				.param("recordId", "1")
				.sessionAttr("user", user)
				.sessionAttr("company", company))
				.andExpect(status().isOk())
				.andExpect(view().name("/exception/showExceptionDetail"))
				.andExpect(model().attributeExists("json1"))
				.andExpect(model().attributeExists("record"))
				.andExpect(model().attributeExists("json"))
				.andExpect(model().attributeExists("pieList"))
				.andExpect(model().attributeExists("pieList1"));
		verify(service, times(4)).queryAllOfCondition(eq(ExceptionRecord.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Department.class),
				Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).queryAllOfCondition(eq(Developer.class),
				Matchers.any(DetachedCriteria.class));
		verify(service,times(1)).findById(Developer.class, 1);
		verify(service,times(1)).findById(ExceptionRecord.class, 1);
		verifyNoMoreInteractions(service);
		//fail("Not yet implemented");
	}

}
