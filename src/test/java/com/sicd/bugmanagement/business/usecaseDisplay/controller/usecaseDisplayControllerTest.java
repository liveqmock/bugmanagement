package com.sicd.bugmanagement.business.usecaseDisplay.controller;

import static org.junit.Assert.*;
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

import com.sicd.bugmanagement.business.usecaseDisplay.service.usecaseDisplayService;
import com.sicd.bugmanagement.common.bean.Answer;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.Question;
import com.sicd.bugmanagement.common.bean.Step;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.UserCase;

public class usecaseDisplayControllerTest {

	@Mock
	private usecaseDisplayService service;

	@InjectMocks
	private usecaseDisplayController userControler;

	private MockMvc mockMvc;
	private Project curProject=new Project();
	private Project project=new Project();
	private List<UserCase> usercaselist=new ArrayList<>();
	private UserCase usercase=new UserCase();
	private List<Step> steps=new ArrayList<>();
	private Step step=new Step();
	private User user=new User();
	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
		this.mockMvc = MockMvcBuilders.standaloneSetup(userControler).build();
		
		

		user.setUserId(1);
		user.setName("junit test");
		user.setEmail("test@qq.com");
		user.setPassword("111111");
		
		
		usercase.setCaseId(1);
		usercase.setTitle("usercase"+1);
		
		
		curProject.setProjectId(1);
		curProject.setName("curProject");
		
		step.setStepId(1);
		step.setResult("pass");
		step.setUserCase(usercase);
		step.setNum(1);
		step.setReality("pass");
		
		for(int j=0;j<5;j++){
			step.setStepId(j);
			step.setResult("pass");
			step.setUserCase(usercase);
			step.setNum(j+1);
			steps.add(step);
		}
		
		for(int i=0;i<20;i++){
			usercase.setCaseId(i);
			usercase.setTitle("usercase"+i);
			usercaselist.add(usercase);
		}
	}

	

	@Test
	public void testUsecase() throws Exception {
		
		when(service.countTotalSize(Matchers.any(DetachedCriteria.class))).thenReturn(20);
		when((List<UserCase>)service.getByPage(Matchers.any(DetachedCriteria.class),eq(10))).thenReturn(usercaselist);
		
		mockMvc.perform(post("/usecase.htm").param("pageSize", "10").sessionAttr("curProject", curProject))
	       .andExpect(status().isOk())
	       .andExpect(view().name("/usecase/usecase"));
		verify(service, times(1)).countTotalSize(Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).getByPage(Matchers.any(DetachedCriteria.class), eq(10));
		
	}



	@Test
	public void testGocaseresult() throws Exception {
		mockMvc.perform(post("/gocaseresult.htm"))
	       .andExpect(status().isOk())
	       .andExpect(view().name("/usecase/caseresult"));
	}

	@Test
	public void testCaseresult() throws Exception {
		when(service.findById(UserCase.class,1)).thenReturn(usercase);
		when(service.queryAllOfCondition(eq(Step.class),Matchers.any(DetachedCriteria.class))).thenReturn(steps);
		mockMvc.perform(post("/caseresult.htm").param("caseId", "1").param("result", "pass").param("nextcaseId", "1"))
	       .andExpect(status().isOk())
	       .andExpect(view().name("/usecase/caseresults"))
	       .andExpect(model().attribute("steps", hasSize(5)))
	       .andExpect(model().attributeExists("usercase"))
	       .andExpect(model().attributeExists("result"))
	       .andExpect(model().attributeExists("nextcaseId"));
		verify(service,times(1)).findById(UserCase.class,1);
		verify(service, times(1)).queryAllOfCondition(eq(Step.class),Matchers.any(DetachedCriteria.class));
	}

	@Test
	public void testGoruncase() throws Exception {
		when(service.findById(UserCase.class,1)).thenReturn(usercase);
		when(service.queryAllOfCondition(eq(Step.class),Matchers.any(DetachedCriteria.class))).thenReturn(steps);
		mockMvc.perform(post("/goruncase.htm").param("caseId", "1").param("result", "pass"))
	       .andExpect(status().isOk())
	       .andExpect(view().name("/usecase/runcase"))
	       .andExpect(model().attribute("steps", hasSize(5)))
	       .andExpect(model().attributeExists("usercase"))
	       .andExpect(model().attributeExists("result"));
		verify(service,times(1)).findById(UserCase.class,1);
		verify(service, times(1)).queryAllOfCondition(eq(Step.class),Matchers.any(DetachedCriteria.class));
	}

	@Test
	public void testRuncase() throws Exception {
		when(service.findById(UserCase.class,1)).thenReturn(usercase);
		when(service.findById(eq(Step.class),Matchers.anyInt())).thenReturn(step);
		mockMvc.perform(get("/runcase.htm")
				.param("stepId[1]", "0").param("stepId[2]", "1").param("stepId[3]", "2").param("stepId[4]", "3").param("stepId[5]", "4")
				.param("reals[1]", "block").param("reals[2]", "block").param("reals[3]", "block").param("reals[4]", "block").param("reals[5]", "block")
				.param("steps[1]", "pass").param("steps[2]", "pass").param("steps[3]", "pass").param("steps[4]", "pass").param("steps[5]", "pass")
				
				.param("stepslength", "5")
				.param("caseId", "1").sessionAttr("user", user))
	       .andExpect(status().isOk())
	       .andExpect(view().name("/usecase/usecase"));
		verify(service,times(1)).findById(UserCase.class,1);
		verify(service,times(1)).update(Matchers.any(UserCase.class));
	}

	@Test
	public void testRuncase2() throws Exception {
		when(service.findById(UserCase.class,1)).thenReturn(usercase);
		when(service.findById(eq(Step.class),Matchers.anyInt())).thenReturn(step);
		mockMvc.perform(get("/runcase.htm")
				.param("stepId[1]", "0").param("stepId[2]", "1").param("stepId[3]", "2").param("stepId[4]", "3").param("stepId[5]", "4")
				.param("reals[1]", "block").param("reals[2]", "block").param("reals[3]", "block").param("reals[4]", "block").param("reals[5]", "block")
				.param("steps[1]", "pass").param("steps[2]", "pass").param("steps[3]", "pass").param("steps[4]", "pass").param("steps[5]", "pass")
				
				.param("stepslength", "5")
				.param("caseId", "1").sessionAttr("user", user))
	       .andExpect(status().isOk())
	       .andExpect(view().name("/usecase/usecase"));
		verify(service,times(1)).findById(UserCase.class,1);
		verify(service,times(1)).update(Matchers.any(UserCase.class));
	}

}
