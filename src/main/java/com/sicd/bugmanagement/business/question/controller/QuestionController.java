package com.sicd.bugmanagement.business.question.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.sicd.bugmanagement.business.question.bean.VoteAnswer;
import com.sicd.bugmanagement.business.question.bean.VoteChoice;
import com.sicd.bugmanagement.business.question.bean.VoteChoiceBeans;
import com.sicd.bugmanagement.business.question.bean.VoteQuestion;
import com.sicd.bugmanagement.business.question.service.QuestionService;
import com.sicd.bugmanagement.common.bean.Answer;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Developer;
import com.sicd.bugmanagement.common.bean.ExceptionRecord;
import com.sicd.bugmanagement.common.bean.MyException;
import com.sicd.bugmanagement.common.bean.Question;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.tag.pageTag.PageHelper;

@Controller
@SessionAttributes({ "userId", "user", "company", "comProjects", "curProject" })

public class QuestionController {
	
	private static Logger logger = Logger.getLogger(Question.class);
	
	@Autowired
	QuestionService service;
	
//  Don't remove this method.
//	@RequestMapping(value = "newQuestion.htm", method = RequestMethod.GET)
//	public String newQuestion() throws InterruptedException{
//		List<ExceptionRecord> records = service.queryAll(ExceptionRecord.class);
//		
//		for (ExceptionRecord record : records) {
//			ExecutorService pool = Executors.newSingleThreadExecutor();
//			pool.execute(new QuestionCrawler(service, record));
//		}
//		
//		return "/question/newQuestion";
//	}
	
	void voteup(VoteChoiceBeans votechoicebean){
        VoteChoice votechoice;
		
		switch (votechoicebean.getObjectType()) {
		case "answer":
			 votechoice=new VoteAnswer();
			 votechoice.voteup(votechoicebean);
		case "question":
			 votechoice=new VoteQuestion();
			 votechoice.voteup(votechoicebean);
		default:
			logger.info("vote not success 101");
			break;
		}
	}
	
	void votedown(VoteChoiceBeans votechoicebean){
        VoteChoice votechoice;
		
		switch (votechoicebean.getObjectType()) {
		case "answer":
			 votechoice=new VoteAnswer();
			 votechoice.votedown(votechoicebean);
		case "question":
			 votechoice=new VoteQuestion();
			 votechoice.votedown(votechoicebean);
		default:
			logger.info("vote not success 101");
			break;
		}
	}
	
	@Secured({"ROLE_DEVELOPER"})
	@SuppressWarnings("unchecked")
	@RequestMapping(value="question.htm")
	public String question(
			@RequestParam(required = false, defaultValue = "20") Integer pageSize,
			ModelMap map){
		
		
		DetachedCriteria dCriteria = DetachedCriteria.forClass(Question.class);
		dCriteria.add(Restrictions.eq("isOpen", true)).addOrder(Order.desc("votes"));
		
		int totalSize = service.countTotalSize(DetachedCriteria.forClass(Question.class));
		PageHelper.forPage(pageSize, totalSize);
		
		List<Question> questionlist=(List<Question>) service.getByPage(dCriteria, pageSize);
		logger.info("questionlist"+questionlist.size());
		
		map.put("questionlist",questionlist);
		
		
		return "/question/newQuestionList";
	}
	
	@Secured({"ROLE_DEVELOPER"})
	@RequestMapping("goquestion.htm")
	public ModelAndView goquestion(){
		return new ModelAndView("/question/newQuestionList");
	}
	
	@Secured({"ROLE_DEVELOPER"})
	@RequestMapping("goanswers.htm")
	public ModelAndView goanswers(){
		return new ModelAndView("/question/answers");
	}
	
	@Secured({"ROLE_DEVELOPER"})
	@RequestMapping(value="answers.htm")
	public String answers(@RequestParam("questionId") String questionId,
			              ModelMap map) {
		
		DetachedCriteria dCriteria ;
		Question question=service.findById(Question.class, Integer.parseInt(questionId));
				
		dCriteria = DetachedCriteria.forClass(Answer.class);
		dCriteria.add(Restrictions.eq("question", question)).addOrder(Order.desc("votes"));
		List<Answer> answerList=service.queryAllOfCondition(Answer.class, dCriteria);
		
		map.put("answerlist",answerList); 
		map.put("question", question);
		return "/question/answers";
	}
	
	@Secured({"ROLE_DEVELOPER"})
	@RequestMapping(value="answer.htm")
	public String answer(
			@ModelAttribute("user") User user,
			@RequestParam("questionId") String questionId,
			@RequestParam("post-text") String content,
			ModelMap map){
		
		DetachedCriteria dCriteria ;
		Question question=service.findById(Question.class, Integer.parseInt(questionId));
		
		Answer answer=new Answer();
		answer.setContent(content);
		answer.setCreatedAt(new Date());
		answer.setDeveloper(user.getDeveloper());
		answer.setQuestion(question);
		answer.setVotes(0);
		service.save(answer);
		
		dCriteria = DetachedCriteria.forClass(Answer.class);
		dCriteria.add(Restrictions.eq("question", question)).addOrder(Order.desc("votes"));
		List<Answer> answerList=service.queryAllOfCondition(Answer.class, dCriteria);
		map.put("answerlist",answerList); 
		map.put("question", question);
		map.put("questionId", question.getQuestionId());
		return "redirect:answers.htm";
	}
	
	
	
	@Secured({"ROLE_DEVELOPER"})
	@RequestMapping(value="voteup.htm")
	public String voteup(
			@ModelAttribute("user") User user,
			@RequestParam("objectId") String objectId,
			@RequestParam("objectType") String objectType,
			@RequestParam("questionId") String questionId,
			ModelMap map){
		
		DetachedCriteria dCriteria;
		Question question=service.findById(Question.class, Integer.parseInt(questionId));
		
		VoteChoiceBeans votechoicebean=new VoteChoiceBeans();
		votechoicebean.setObjectId(objectId);
		votechoicebean.setObjectType(objectType);
		votechoicebean.setUser(user);
		votechoicebean.setQuestionId(questionId);
		
		voteup(votechoicebean);
		
		dCriteria = DetachedCriteria.forClass(Answer.class);
		dCriteria.add(Restrictions.eq("question", question)).addOrder(Order.desc("votes"));
		List<Answer> answerList=service.queryAllOfCondition(Answer.class, dCriteria);
		
		map.put("answerlist",answerList); 
		map.put("question", question);
		
		return "/question/answers";
	}
	
	@Secured({"ROLE_DEVELOPER"})
	@RequestMapping(value="votedown.htm")
	public String votedown(
			@ModelAttribute("user") User user,
			@RequestParam("objectId") String objectId,
			@RequestParam("objectType") String objectType,
			@RequestParam("questionId") String questionId,
			ModelMap map){
		
		DetachedCriteria dCriteria;
		Question question=service.findById(Question.class, Integer.parseInt(questionId));
		
		VoteChoiceBeans votechoicebean=new VoteChoiceBeans();
		votechoicebean.setObjectId(objectId);
		votechoicebean.setObjectType(objectType);
		votechoicebean.setUser(user);
		votechoicebean.setQuestionId(questionId);
		
		votedown(votechoicebean);
		
		dCriteria = DetachedCriteria.forClass(Answer.class);
		dCriteria.add(Restrictions.eq("question", question)).addOrder(Order.desc("votes"));
		List<Answer> answerList=service.queryAllOfCondition(Answer.class, dCriteria);
		
		map.put("answerlist",answerList); 
		map.put("question", question);
		
		return "/question/answers";
	}

	@Secured({"ROLE_DEVELOPER"})
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "questionsByException.htm", method = RequestMethod.GET)
	public String myExceptionList(HttpServletRequest req,
			@RequestParam Integer myExceptionId, 
			@RequestParam(required = false, defaultValue = "20") Integer pageSize,
			ModelMap map){
		MyException myException = service.findById(MyException.class, myExceptionId);
		DetachedCriteria dCriteria = DetachedCriteria.forClass(Question.class)
				.add(Restrictions.eq("myException.exceptionId", myExceptionId))
				.add(Restrictions.eq("isOpen", true))
				.addOrder(Order.desc("votes"));
		
		int totalSize = service.countTotalSize(dCriteria);
		Map<String, Object> urlmap = new HashMap<String, Object>();
		urlmap.put("myExceptionId", myExceptionId);
		PageHelper.forPage(pageSize, urlmap, totalSize);
		
		List<Question> questionlist = (List<Question>) service.getByPage(dCriteria, pageSize);
		map.put("questionlist", questionlist);
		map.put("myException", myException);
		
		return "/question/newQuestionList";
	}
	
	@Secured({"ROLE_DEVELOPER"})
	@RequestMapping(value = "newQuestion.htm", method = RequestMethod.GET)
	public String newQuestion(@RequestParam Integer recordId, ModelMap map){
		ExceptionRecord record = service.findById(ExceptionRecord.class, recordId);
		map.put("record", record);
		return "/question/newQuestion";
	}
	
	@Secured({"ROLE_DEVELOPER"})
	@RequestMapping(value = "addQuestion.htm", method = RequestMethod.POST)
	public String addQuestion(HttpServletRequest req,
			@RequestParam Integer myExceptionId,
			@RequestParam String title,
			@RequestParam String content) {
		
		Integer userId = (Integer) req.getSession().getAttribute("userId");
		Question question = new Question();
		question.setMyException(service.findById(MyException.class, myExceptionId));
		question.setDeveloper(service.findById(Developer.class, userId));
		question.setTitle(title);
		question.setContent(content);
		question.setVotes(0);
		question.setCreatedAt(new Date());
		question.setIsOpen(false);
		service.save(question);
		
		return "redirect:answers.htm?questionId=" + question.getQuestionId();
	}
	
	@Secured({"ROLE_DEVELOPER"})
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "comQuestions.htm", method = RequestMethod.GET)
	public String comQuestions(HttpServletRequest req, 
			@RequestParam(required = false, defaultValue = "20") Integer pageSize,
			ModelMap map){
		
		Company company = (Company) req.getSession().getAttribute("company");
		List<Developer> developers = service.queryAllOfCondition(Developer.class, 
				DetachedCriteria.forClass(Developer.class)
				.createAlias("user", "u")
				.createAlias("u.department", "dept")
				.createAlias("dept.company", "com")
				.add(Restrictions.eq("com.companyId", company.getCompanyId())));
		
		List<Question> questionlist = new ArrayList<Question>();
		if(!developers.isEmpty()) {
			DetachedCriteria dCriteria = DetachedCriteria.forClass(Question.class)
					.add(Restrictions.eq("isOpen", false))
					.add(Restrictions.in("developer", developers))
					.addOrder(Order.desc("createdAt"));
			int totalSize = service.countTotalSize(dCriteria);
			PageHelper.forPage(pageSize, totalSize);
			questionlist = (List<Question>) service.getByPage(dCriteria, pageSize);
		}
		
		map.put("questionlist", questionlist);
		return "/question/comQuestions";
	}

}
