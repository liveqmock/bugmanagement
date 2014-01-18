package com.sicd.bugmanagement.business.bugdisplay.controller;

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

import com.sicd.bugmanagement.business.bugdisplay.service.BugDisplayService;
import com.sicd.bugmanagement.common.bean.Bug;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Department;
import com.sicd.bugmanagement.common.bean.Developer;
import com.sicd.bugmanagement.common.bean.Dictionary;
import com.sicd.bugmanagement.common.bean.History;
import com.sicd.bugmanagement.common.bean.Module;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.Question;
import com.sicd.bugmanagement.common.bean.User;

public class BugDisplayControllerTest {

	@Mock
	private BugDisplayService service;
	@InjectMocks
	private BugDisplayController bugDisplayController;
	private Department department = new Department();
	private MockMvc mockMvc;
	private User user=new User();
	private Developer developer=new Developer();
	private Project curProject=new Project();
	private Company company= new Company();
	private Bug bug= new Bug();
	private History history=new History();
	private List<Module> modules = new ArrayList<Module>();
	private List<History> historylist= new ArrayList<History>();
	private List<Developer> developers=new ArrayList<Developer>();
	private List<Dictionary> resolutionlist=new ArrayList<Dictionary>();
	private List<Bug> buglist=new ArrayList<Bug>();
	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
		this.mockMvc = MockMvcBuilders.standaloneSetup(bugDisplayController).build();
		
		company.setCompanyId(1);
		company.setName("test company");

		department.setDepartmentId(1);
		department.setName("test dept");
		
		developer.setUser(user);
		developer.setDeveloperId(1);
		
		user.setUserId(1);
		user.setName("junit test");
		user.setEmail("test@qq.com");
		user.setPassword("111111");
		user.setDepartment(department);
		user.setDeveloper(developer);
		
		bug.setBugId(1);
		bug.setTitle("bug"+1);
		bug.setAssignedTo(developer);
		
		curProject.setProjectId(1);
		curProject.setCompany(company);
		
		for (int i = 1; i < 5; i++) {
			Module module = new Module();
			module.setModuleId(i);
			module.setName("test module " + i);
			modules.add(module);
		}
		
		for(int j=0;j<5;j++){
			history.setHistoryId(j);
			history.setComment("history"+j);
			history.setObjectId(1);
			historylist.add(history);
		}
		for(int k=0;k<3;k++){
			developer.setDeveloperId(k);
			developers.add(developer);
		}
		
		for(int l=0;l<10;l++){
			bug.setBugId(l);
			bug.setTitle("bug"+l);
			buglist.add(bug);
		}
	}

	@Test
	public void testGobug() throws Exception {
		when(service.queryAllOfCondition(eq(Module.class),Matchers.any(DetachedCriteria.class))).thenReturn(modules);

		mockMvc.perform(post("/gobug.htm").sessionAttr("curProject", curProject))
		      .andExpect(status().isOk())
		       .andExpect(view().name("/bug/bug"))
				.andExpect(model().attributeExists("moduleBeans"));
		verify(service, times(1)).queryAllOfCondition(eq(Module.class),Matchers.any(DetachedCriteria.class));
		verifyNoMoreInteractions(service);
	}

	@Test
	public void testGobugconfirmbug() throws Exception {
		when(service.findById(Bug.class,1)).thenReturn(bug);
		when(service.queryAllOfCondition(eq(History.class),Matchers.any(DetachedCriteria.class))).thenReturn(historylist);
		when(service.findUseByCompany(Matchers.any(Company.class))).thenReturn(developers);
		mockMvc.perform(
				get("/gobugconfirmbug.htm")
				.param("bugId", "1") 
				.sessionAttr("company", company)
				)
		      .andExpect(status().isOk())
	        .andExpect(view().name("/bug/bugconfirmbug"))
			.andExpect(model().attributeExists("developers"))
			.andExpect(model().attributeExists("historylist"))
			.andExpect(model().attributeExists("bug"));
		verify(service, times(1)).queryAllOfCondition(eq(History.class),Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).findUseByCompany(Matchers.any(Company.class));
		verify(service, times(1)).findById(Bug.class,1);
		
	}

	@Test
	public void testBugconfirmbug() throws Exception {
		when(service.findUseByCompany(Matchers.any(Company.class))).thenReturn(developers);
		when(service.findById(Bug.class,1)).thenReturn(bug);
		when(service.queryAllOfCondition(eq(History.class),Matchers.any(DetachedCriteria.class))).thenReturn(historylist);
		when(service.queryAllOfCondition(eq(Dictionary.class),Matchers.any(DetachedCriteria.class))).thenReturn(resolutionlist);
		mockMvc.perform(
				get("/bugconfirmbug.htm")
				.param("bugId", "1") .param("pri", "1").param("comment", "comment")
				.sessionAttr("user", user)
				)
		      .andExpect(status().isOk())
	        .andExpect(view().name("forward:bug.htm"));
			
		verify(service, times(1)).findById(Bug.class,1);
		verify(service, times(1)).update(Matchers.any(Bug.class));
		verify(service, times(1)).save(Matchers.any(History.class));
	}

	@Test
	public void testGobugresolve() throws Exception {
		when(service.queryAllOfCondition(eq(Dictionary.class),Matchers.any(DetachedCriteria.class))).thenReturn(resolutionlist);
		when(service.queryAllOfCondition(eq(History.class),Matchers.any(DetachedCriteria.class))).thenReturn(historylist);
		when(service.findUseByCompany(Matchers.any(Company.class))).thenReturn(developers);
		when(service.findById(Bug.class,1)).thenReturn(bug);
		mockMvc.perform(
				post("/gobugresolve.htm")
				.param("bugId", "1").sessionAttr("project", curProject)
				.sessionAttr("company", company)
				)
		      .andExpect(status().isOk())
	        .andExpect(view().name("/bug/bugresolve"))
	        .andExpect(model().attributeExists("developers"))
			.andExpect(model().attributeExists("resolutionlist"))
			.andExpect(model().attributeExists("historylist"))
			.andExpect(model().attributeExists("bug"));;
			verify(service, times(1)).queryAllOfCondition(eq(Dictionary.class),Matchers.any(DetachedCriteria.class));
			verify(service, times(1)).queryAllOfCondition(eq(History.class),Matchers.any(DetachedCriteria.class));
			verify(service, times(1)).findById(Bug.class,1);
			verify(service, times(1)).findUseByCompany(Matchers.any(Company.class));
		
	}

	@Test
	public void testBugresolve() throws Exception {
		when(service.findById(Bug.class,1)).thenReturn(bug);
		mockMvc.perform(
				get("/bugresolve.htm")
				.param("bugId", "1") .param("resolution", "resolution").param("comment", "comment")
				.sessionAttr("company", company).sessionAttr("user", user)
				)
		      .andExpect(status().isOk())
	        .andExpect(view().name("forward:bug.htm"));			
		verify(service, times(1)).update(Matchers.any(Bug.class));
		verify(service, times(1)).save(Matchers.any(History.class));
	}

	@Test
	public void testGobugclose() throws Exception {
		when(service.queryAllOfCondition(eq(History.class),Matchers.any(DetachedCriteria.class))).thenReturn(historylist);
		when(service.findUseByCompany(Matchers.any(Company.class))).thenReturn(developers);
		when(service.findById(Bug.class,1)).thenReturn(bug);
		mockMvc.perform(
				post("/gobugclose.htm")
				.param("bugId", "1")
				.sessionAttr("company", company)
				)
		      .andExpect(status().isOk())
	        .andExpect(view().name("/bug/bugclose"))
	        .andExpect(model().attributeExists("developers"))
			.andExpect(model().attributeExists("historylist"))
			.andExpect(model().attributeExists("bug"));;
			verify(service, times(1)).queryAllOfCondition(eq(History.class),Matchers.any(DetachedCriteria.class));
			verify(service, times(1)).findById(Bug.class,1);
			verify(service, times(1)).findUseByCompany(Matchers.any(Company.class));
	}

	@Test
	public void testBugclose() throws Exception {
		when(service.findById(Bug.class,1)).thenReturn(bug);
		mockMvc.perform(
				get("/bugclose.htm")
				.param("bugId", "1").param("comment", "comment")
				.sessionAttr("user", user)
				)
		      .andExpect(status().isOk())
	        .andExpect(view().name("forward:bug.htm"));			
		verify(service, times(1)).update(Matchers.any(Bug.class));
		verify(service, times(1)).save(Matchers.any(History.class));
		verify(service, times(2)).findById(Bug.class,1);
	}

	@Test
	public void testGobugAssignTo() throws Exception {
		when(service.queryAllOfCondition(eq(History.class),Matchers.any(DetachedCriteria.class))).thenReturn(historylist);
		when(service.findUseByCompany(Matchers.any(Company.class))).thenReturn(developers);
		when(service.findById(Bug.class,1)).thenReturn(bug);
		mockMvc.perform(
				post("/gobugAssignTo.htm")
				.param("bugId", "1")
				.sessionAttr("company", company)
				)
		      .andExpect(status().isOk())
	        .andExpect(view().name("/bug/bugAssignTo"))
	        .andExpect(model().attributeExists("developers"))
			.andExpect(model().attributeExists("historylist"))
			.andExpect(model().attributeExists("bug"));;
			verify(service, times(1)).queryAllOfCondition(eq(History.class),Matchers.any(DetachedCriteria.class));
			verify(service, times(1)).findById(Bug.class,1);
			verify(service, times(1)).findUseByCompany(Matchers.any(Company.class));
	}

	@Test
	public void testBugAssignTo() throws Exception {
		when(service.findById(Bug.class,1)).thenReturn(bug);
		when(service.findById(Developer.class, 1)).thenReturn(developer);
		mockMvc.perform(
				get("/bugAssignTo.htm")
				.param("bugId", "1").param("assignedTo", "1").param("comment", "comment")
				.sessionAttr("user", user)
				)
		      .andExpect(status().isOk())
	        .andExpect(view().name("forward:bug.htm"));			
		verify(service, times(1)).update(Matchers.any(Bug.class));
		verify(service, times(1)).save(Matchers.any(History.class));
	}

	@Test
	public void testBug() throws Exception {
		when(service.countTotalSize(Matchers.any(DetachedCriteria.class))).thenReturn(20);
		when((List<Bug>)service.getByPage(Matchers.any(DetachedCriteria.class),Matchers.anyInt())).thenReturn(buglist);
		
		mockMvc.perform(post("/bug.htm").param("pageSize", "10").sessionAttr("curProject", curProject))
		      .andExpect(status().isOk())
		      .andExpect(view().name("forward:gobug.htm"))
			  .andExpect(model().attribute("buglistx",hasSize(10)))
		      .andExpect(model().attribute("message",isEmptyOrNullString()));
		      
		verify(service, times(1)).countTotalSize(Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).getByPage(Matchers.any(DetachedCriteria.class), eq(10));
		verifyNoMoreInteractions(service);
	}

	@Test
	public void testBugassigntome() throws Exception {
		when(service.countTotalSize(Matchers.any(DetachedCriteria.class))).thenReturn(20);
		when((List<Bug>)service.getByPage(Matchers.any(DetachedCriteria.class),Matchers.anyInt())).thenReturn(buglist);
		
		mockMvc.perform(post("/bugassigntome.htm").sessionAttr("userId", 1).param("pageSize", "10").sessionAttr("curProject", curProject))
		      .andExpect(status().isOk())
		      .andExpect(view().name("forward:gobug.htm"))
			  .andExpect(model().attribute("buglistx",hasSize(10)))
		      .andExpect(model().attribute("message",isEmptyOrNullString()));
		      
		verify(service, times(1)).countTotalSize(Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).getByPage(Matchers.any(DetachedCriteria.class), eq(10));
		verifyNoMoreInteractions(service);
	}

	@Test
	public void testBugopenedbyme() throws Exception {
		when(service.countTotalSize(Matchers.any(DetachedCriteria.class))).thenReturn(20);
		when((List<Bug>)service.getByPage(Matchers.any(DetachedCriteria.class),Matchers.anyInt())).thenReturn(buglist);
		
		mockMvc.perform(post("/bugopenedbyme.htm").sessionAttr("userId", 1).param("pageSize", "10").sessionAttr("curProject", curProject))
		      .andExpect(status().isOk())
		      .andExpect(view().name("forward:gobug.htm"))
			  .andExpect(model().attribute("buglistx",hasSize(10)))
		      .andExpect(model().attribute("message",isEmptyOrNullString()));
		      
		verify(service, times(1)).countTotalSize(Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).getByPage(Matchers.any(DetachedCriteria.class), eq(10));
		verifyNoMoreInteractions(service);
	}

	@Test
	public void testBugresolvedbyme() throws Exception {
		when(service.countTotalSize(Matchers.any(DetachedCriteria.class))).thenReturn(20);
		when((List<Bug>)service.getByPage(Matchers.any(DetachedCriteria.class),Matchers.anyInt())).thenReturn(buglist);
		
		mockMvc.perform(post("/bugresolvedbyme.htm").sessionAttr("userId", 1).param("pageSize", "10").sessionAttr("curProject", curProject))
		      .andExpect(status().isOk())
		      .andExpect(view().name("forward:gobug.htm"))
			  .andExpect(model().attribute("buglistx",hasSize(10)))
		      .andExpect(model().attribute("message",isEmptyOrNullString()));
		      
		verify(service, times(1)).countTotalSize(Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).getByPage(Matchers.any(DetachedCriteria.class), eq(10));
		verifyNoMoreInteractions(service);
	}

	@Test
	public void testBugassigntonull() throws Exception {
		when(service.countTotalSize(Matchers.any(DetachedCriteria.class))).thenReturn(20);
		when((List<Bug>)service.getByPage(Matchers.any(DetachedCriteria.class),Matchers.anyInt())).thenReturn(buglist);
		
		mockMvc.perform(post("/bugassigntonull.htm").sessionAttr("userId", 1).param("pageSize", "10").sessionAttr("curProject", curProject))
		      .andExpect(status().isOk())
		      .andExpect(view().name("forward:gobug.htm"))
			  .andExpect(model().attribute("buglistx",hasSize(10)))
		      .andExpect(model().attribute("message",isEmptyOrNullString()));
		      
		verify(service, times(1)).countTotalSize(Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).getByPage(Matchers.any(DetachedCriteria.class), eq(10));
		verifyNoMoreInteractions(service);
	}

	@Test
	public void testBugunresolved() throws Exception {
		when(service.countTotalSize(Matchers.any(DetachedCriteria.class))).thenReturn(20);
		when((List<Bug>)service.getByPage(Matchers.any(DetachedCriteria.class),Matchers.anyInt())).thenReturn(buglist);
		
		mockMvc.perform(post("/bugunresolved.htm").sessionAttr("userId", 1).param("pageSize", "10").sessionAttr("curProject", curProject))
		      .andExpect(status().isOk())
		      .andExpect(view().name("forward:gobug.htm"))
			  .andExpect(model().attribute("buglistx",hasSize(10)))
		      .andExpect(model().attribute("message",isEmptyOrNullString()));
		      
		verify(service, times(1)).countTotalSize(Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).getByPage(Matchers.any(DetachedCriteria.class), eq(10));
		verifyNoMoreInteractions(service);
	}

	@Test
	public void testBugunclosed() throws Exception {
		when(service.countTotalSize(Matchers.any(DetachedCriteria.class))).thenReturn(20);
		when((List<Bug>)service.getByPage(Matchers.any(DetachedCriteria.class),Matchers.anyInt())).thenReturn(buglist);
		
		mockMvc.perform(post("/bugunclosed.htm").sessionAttr("userId", 1).param("pageSize", "10").sessionAttr("curProject", curProject))
		      .andExpect(status().isOk())
		      .andExpect(view().name("forward:gobug.htm"))
			  .andExpect(model().attribute("buglistx",hasSize(10)))
		      .andExpect(model().attribute("message",isEmptyOrNullString()));
		      
		verify(service, times(1)).countTotalSize(Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).getByPage(Matchers.any(DetachedCriteria.class), eq(10));
		verifyNoMoreInteractions(service);
	}

	@Test
	public void testBuglonglifebugs() throws Exception {
		when(service.countTotalSize(Matchers.any(DetachedCriteria.class))).thenReturn(20);
		when((List<Bug>)service.getByPage(Matchers.any(DetachedCriteria.class),Matchers.anyInt())).thenReturn(buglist);
		
		mockMvc.perform(post("/buglonglifebugs.htm").sessionAttr("userId", 1).param("pageSize", "10").sessionAttr("curProject", curProject))
		      .andExpect(status().isOk())
		      .andExpect(view().name("forward:gobug.htm"))
			  .andExpect(model().attribute("buglistx",hasSize(10)))
		      .andExpect(model().attribute("message",isEmptyOrNullString()));
		      
		verify(service, times(1)).countTotalSize(Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).getByPage(Matchers.any(DetachedCriteria.class), eq(10));
		verifyNoMoreInteractions(service);
	}

}
