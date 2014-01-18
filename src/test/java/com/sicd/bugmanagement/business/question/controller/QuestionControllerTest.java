package com.sicd.bugmanagement.business.question.controller;

import static org.junit.Assert.*;
import static org.hamcrest.Matchers.*;
import static org.mockito.Matchers.eq;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.ui.ModelMap;

import com.sicd.bugmanagement.business.question.service.QuestionService;
import com.sicd.bugmanagement.common.bean.Answer;
import com.sicd.bugmanagement.common.bean.Department;
import com.sicd.bugmanagement.common.bean.Developer;
import com.sicd.bugmanagement.common.bean.Module;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.Question;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.Vote;

public class QuestionControllerTest {

	@Mock
	private QuestionService service;
	@InjectMocks
	private QuestionController questionController;
	private Department department = new Department();
	private MockMvc mockMvc;
	private Answer answer=new Answer();
	private User user=new User();
	private Developer developer=new Developer();
	private Question question=new Question();
	private List<Question> questionlist =new ArrayList<Question>() ;
	private List<Answer>  answerList= new ArrayList<Answer>();
	
	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
		this.mockMvc = MockMvcBuilders.standaloneSetup(questionController).build();
		
		user.setUserId(1);
		user.setName("junit test");
		user.setEmail("test@qq.com");
		user.setPassword("111111");
		user.setDepartment(department);
		user.setDeveloper(developer);
		
		question.setQuestionId(1);
		question.setTitle("question"+1);
		
		answer.setAnswerId(1);
		answer.setVotes(0);
		answer.setContent("answer"+1);
		answer.setCreatedAt(new Date());
		answer.setDeveloper(developer);
		answer.setQuestion(question);
		
		
		
		for(int i=0;i<20;i++){
			question.setQuestionId(i);
			question.setTitle("question"+i);
			questionlist.add(question);
		}
		
		for(int j=0;j<10;j++){
			Answer answer=new Answer();
			answer.setAnswerId(j);
			answer.setContent("answer"+j);
			answer.setVotes(j);
			answerList.add(answer);
		} 
		
	}

	@Test
	public void testQuestion() throws Exception {
		when(service.countTotalSize(Matchers.any(DetachedCriteria.class))).thenReturn(20);
		when((List<Question>)service.getByPage(Matchers.any(DetachedCriteria.class),eq(10))).thenReturn(questionlist);
		
		mockMvc.perform(post("/question.htm").param("pageSize", "10"))
		      .andExpect(status().isOk())
		       .andExpect(view().name("forward:goquestion.htm"))
				.andExpect(model().attributeExists("questionlist"));
		verify(service, times(1)).countTotalSize(Matchers.any(DetachedCriteria.class));
		verify(service, times(1)).getByPage(Matchers.any(DetachedCriteria.class), eq(10));
		verifyNoMoreInteractions(service);
	}

	@Test
	public void testGoquestion() throws Exception {
		mockMvc.perform(post("/goquestion.htm"))
		       .andExpect(status().isOk())
		       .andExpect(view().name("/question/newQuestionList"));
	}

	@Test
	public void testGoanswers() throws Exception {
		mockMvc.perform(post("/goanswers.htm"))
	       .andExpect(status().isOk())
	       .andExpect(view().name("/question/answers"));
	}

	@Test
	public void testAnswers() throws Exception {
		
		
		when(service.findById(Question.class,1)).thenReturn(question);
		when(service.queryAllOfCondition(eq(Answer.class),Matchers.any(DetachedCriteria.class))).thenReturn(answerList);
		mockMvc.perform(post("/answers.htm").param("questionId", "1"))
	      .andExpect(status().isOk())
	       .andExpect(view().name("forward:goanswers.htm"))
			.andExpect(model().attribute("answerlist",hasSize(10)))
			.andExpect(model().attributeExists("question"));
		verify(service, times(1)).findById(Question.class,1);
		verify(service, times(1)).queryAllOfCondition(eq(Answer.class),Matchers.any(DetachedCriteria.class));
       
	}

	@Test
	public void testAnswer() throws Exception {
		
		when(service.findById(Question.class,1)).thenReturn(question);
		when(service.queryAllOfCondition(eq(Answer.class),Matchers.any(DetachedCriteria.class))).thenReturn(answerList);
		
		mockMvc.perform(post("/answer.htm")
				.param("post-text", "haha").param("questionId", "1")
				.sessionAttr("user",user))
	        .andExpect(status().isFound())
	        .andExpect(view().name("redirect:answers.htm?questionId="+question.getQuestionId()))
			.andExpect(model().attributeExists("answerlist"))
			.andExpect(model().attributeExists("question"));
		
		verify(service, times(1)).findById(Question.class,1);
		verify(service, times(1)).queryAllOfCondition(eq(Answer.class),Matchers.any(DetachedCriteria.class));

	}

	@Test
	public void testVoteup() throws Exception {
		when(service.findById(Question.class,1)).thenReturn(question);
		when(service.queryAllOfCondition(eq(Answer.class),Matchers.any(DetachedCriteria.class))).thenReturn(answerList);
		when(service.queryAllOfCondition(eq(Vote.class),Matchers.any(DetachedCriteria.class))).thenReturn(new ArrayList<Vote>(0));
		when(service.findById(Answer.class, 1)).thenReturn(answer);
		 mockMvc.perform(post("/voteup.htm").param("questionId", "1")
				.param("objectType", "answer").param("objectId", "1")
				.sessionAttr("user",user))
	        .andExpect(status().isOk())
	        .andExpect(view().name("forward:goanswers.htm"))
			.andExpect(model().attributeExists("answerlist"))
			.andExpect(model().attributeExists("question"));
		 
		 verify(service, times(1)).findById(Question.class,1);
		 verify(service, times(1)).findById(Answer.class,1);
		 verify(service, times(1)).queryAllOfCondition(eq(Answer.class),Matchers.any(DetachedCriteria.class));
		 verify(service, times(1)).queryAllOfCondition(eq(Vote.class),Matchers.any(DetachedCriteria.class));
		 verify(service, times(1)).save(Matchers.any(Vote.class));
		 verify(service, times(1)).save(Matchers.any(Answer.class));
		
	}

	@Test
	public void testVotedown() throws Exception {
		
		
		when(service.findById(Question.class,1)).thenReturn(question);
		when(service.queryAllOfCondition(eq(Answer.class),Matchers.any(DetachedCriteria.class))).thenReturn(answerList);
		when(service.queryAllOfCondition(eq(Vote.class),Matchers.any(DetachedCriteria.class))).thenReturn(new ArrayList<Vote>(0));
		when(service.findById(Answer.class, 1)).thenReturn(answer);
		 mockMvc.perform(post("/votedown.htm")
				.param("objectType", "answer").param("questionId", "1").param("objectId", "1")
				.sessionAttr("user",user))
	        .andExpect(status().isOk())
	        .andExpect(view().name("forward:goanswers.htm"))
			.andExpect(model().attributeExists("answerlist"))
			.andExpect(model().attributeExists("question"));
		 
		 verify(service, times(1)).findById(Question.class,1);
		 verify(service, times(1)).findById(Answer.class,1);
		 verify(service, times(1)).queryAllOfCondition(eq(Answer.class),Matchers.any(DetachedCriteria.class));
		 verify(service, times(1)).queryAllOfCondition(eq(Vote.class),Matchers.any(DetachedCriteria.class));
		 verify(service, times(1)).save(Matchers.any(Vote.class));
		 verify(service, times(1)).save(Matchers.any(Answer.class));
		
	}

}
