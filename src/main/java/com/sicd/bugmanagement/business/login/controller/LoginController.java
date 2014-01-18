package com.sicd.bugmanagement.business.login.controller;

import java.security.Principal;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sicd.bugmanagement.business.admin.logrecord.annotation.SeachAnnotation;
import com.sicd.bugmanagement.business.login.service.LoginService;
import com.sicd.bugmanagement.common.bean.Bug;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Department;
import com.sicd.bugmanagement.common.bean.ExceptionRecord;
import com.sicd.bugmanagement.common.bean.History;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.Task;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.UserCase;

@Controller
public class LoginController {
	
	private static Logger logger=Logger.getLogger(LoginController.class);
	private final String[] week = {"日", "一", "二", "三", "四", "五", "六"};
	
	@Autowired
	private LoginService service;
	
	
	/**
	 * Rewrite login method.
	 *
		@RequestMapping("login.htm")
		public ModelAndView login(HttpServletRequest request,HttpServletResponse response)throws Exception{
			HttpSession hs=request.getSession();
			hs.invalidate();
			String userEmail=ServletRequestUtils.getStringParameter(request, "email");
			String userPswd=ServletRequestUtils.getStringParameter(request, "password");
			//自动登录标记
			String autoLogin=ServletRequestUtils.getStringParameter(request, "autoLogin");
			
			
			System.out.println(autoLogin);
			
			int userid=service.checkByEmailAndPswd(userEmail,userPswd);
			
			if(userid!=0){
				User userinfo=service.findById(User.class, userid);
				hs=request.getSession();
				hs.setAttribute("userId", Integer.valueOf(userid));
				hs.setAttribute("user", userinfo);
				
				Department userDept = service.findById(Department.class, userinfo
						.getDepartment().getDepartmentId());
				Company company = service.findById(Company.class, userDept
						.getCompany().getCompanyId());
				hs.setAttribute("company", company);
				
				DetachedCriteria proCriteria = DetachedCriteria.forClass(Project.class);
				proCriteria.add(Restrictions.eq("company", company)).addOrder(Order.asc("createdAt"));
				List<Project> comProjects = service.queryAllOfCondition(Project.class, proCriteria);
				hs.setAttribute("comProjects", comProjects);
				logger.info("comProjects size " + comProjects.size());
				
				if(!comProjects.isEmpty()) {
					hs.setAttribute("curProject", comProjects.get(0));
					logger.info("current project id " + comProjects.get(0).getProjectId());
				}
				
				if(autoLogin!=null){
					Cookie cookie=new Cookie("cookieEmail",userinfo.getEmail()+"&&"+userinfo.getPassword());
					
					cookie.setMaxAge(60*60*24*14);
					
					response.addCookie(cookie);
				
				}
				
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(new Date());
				hs.setAttribute("year", calendar.get(Calendar.YEAR));
				hs.setAttribute("month", calendar.get(Calendar.MONTH));
				hs.setAttribute("day", calendar.get(Calendar.DAY_OF_MONTH));
				hs.setAttribute("week", week[calendar.get(Calendar.DAY_OF_WEEK)-2]);
				
				return new ModelAndView("redirect:turnToHomePage.htm");
			}else{
				request.setAttribute("note", "邮箱或是密码不正确，请重新输入");
				return new ModelAndView("/login/login");
			}
		
		}
		//从cookie直接登陆
		@RequestMapping("checkLogin.htm")
		public ModelAndView checkLogin(HttpServletRequest request) throws Exception{
			Enumeration<?> e=request.getSession().getAttributeNames();
			
			while(e.hasMoreElements()){
				String attributeName=(String) e.nextElement();
				request.getSession().removeAttribute(attributeName);
			}
			Cookie[] cookies=request.getCookies();
			
			String[] cooks=null;
			
			String cookieEmail=null;
			String cookiePswd=null;
			
			User userinfo=new User();
			if(cookies!=null){
				boolean exist=false;
				for(Cookie coo:cookies){
					String value=coo.getValue();
					
					cooks=value.split("&&");
					if(cooks.length==2){
						cookieEmail=cooks[0];	
						cookiePswd=cooks[1];
						exist=true;
						break;
					}
				
				}
				if(exist){
					
					int userid=service.checkByEmailAndCookie(cookieEmail, cookiePswd);
					if(userid!=0){
						
						userinfo=service.findById(User.class, userid);
						HttpSession hs=request.getSession();
						hs=request.getSession();
						hs.setAttribute("userId", Integer.valueOf(userid));
						hs.setAttribute("user", userinfo);
						Calendar calendar = Calendar.getInstance();
						calendar.setTime(new Date());
						hs.setAttribute("year", calendar.get(Calendar.YEAR));
						hs.setAttribute("month", calendar.get(Calendar.MONTH));
						hs.setAttribute("day", calendar.get(Calendar.DAY_OF_MONTH));
						hs.setAttribute("week", week[calendar.get(Calendar.DAY_OF_WEEK)-2]);
						return new ModelAndView("redirect:turnToHomePage.htm");
				
					}
				
				}
			
			}
			
			return new ModelAndView("/login/login");
		}
		
		@RequestMapping("goLoginPage.htm")
		public ModelAndView goLoginPage(){
			return new ModelAndView("redirect:checkLogin.htm");
		}
		@RequestMapping("logout.htm")
		public ModelAndView logout(HttpServletRequest request,HttpServletResponse response) {
			request.getSession().invalidate();
			Cookie cookie = new Cookie("cookieEmail", null); 
			cookie.setMaxAge(0);
			response.addCookie(cookie);
			return new ModelAndView("redirect:goLoginPage.htm");
		}
		
		
		@Secured({"ROLE_DIRECTOR", "ROLE_TESTER"})
		@RequestMapping(value = "newIndex.htm", method = RequestMethod.GET)
		public String printMessage(ModelMap model, Principal principal) {
			String username = principal.getName();
			model.addAttribute("user", username);
			model.addAttribute("msg", "Spring Security Custom Login Form");
			return "/login/welcome";
		}
		
		 * following is add for test.
		 */
		
		@Secured({"ROLE_DEVELOPER", "ROLE_TESTER", "ROLE_ADMIN", "ROLE_ANONYMOUS"})
		@RequestMapping(value = "newLogin.htm", method = RequestMethod.GET)
		public String login(ModelMap model) {
			return "/login/newLogin";
		}
		@SeachAnnotation(name="用户登录")
		@Secured({"ROLE_DEVELOPER", "ROLE_TESTER", "ROLE_ADMIN"})
		@RequestMapping(value = "myLogin.htm", method = RequestMethod.GET)
		public String myLogin(HttpServletRequest req, Principal principal){
			String email = principal.getName();
			User user = service.queryAllOfCondition(User.class, DetachedCriteria.forClass(User.class).add(Restrictions.eq("email", email))).get(0);
			logger.info("$$$$$$$ current user id is " + user.getUserId());
			HttpSession hs = req.getSession();
			hs.setAttribute("user", user);
			hs.setAttribute("userId", user.getUserId());
			
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(new Date());
			hs.setAttribute("year", calendar.get(Calendar.YEAR));
			hs.setAttribute("month", calendar.get(Calendar.MONTH));
			hs.setAttribute("day", calendar.get(Calendar.DAY_OF_MONTH));
			hs.setAttribute("week", week[calendar.get(Calendar.DAY_OF_WEEK)-1]);
			
			if(user.getPosition().equals("管理员")) {
				return "redirect:goIndex.htm";
			} else {
				Department userDept = service.findById(Department.class, user
						.getDepartment().getDepartmentId());
				Company company = service.findById(Company.class, userDept
						.getCompany().getCompanyId());
				hs.setAttribute("company", company);
				
				DetachedCriteria proCriteria = DetachedCriteria.forClass(Project.class);
				proCriteria.add(Restrictions.eq("company", company)).addOrder(Order.asc("createdAt"));
				List<Project> comProjects = service.queryAllOfCondition(Project.class, proCriteria);
				hs.setAttribute("comProjects", comProjects);
				logger.info("comProjects size " + comProjects.size());
				
				if(!comProjects.isEmpty()) {
					hs.setAttribute("curProject", comProjects.get(0));
					logger.info("current project id " + comProjects.get(0).getProjectId());
				}
			
				return "redirect:turnToHomePage.htm";
			}
		}
		
		@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
		@RequestMapping("turnToHomePage.htm")
		public String turnToHomePage(HttpServletRequest req, ModelMap map){
			
			User user = (User) req.getSession().getAttribute("user");
			Company company = (Company) req.getSession().getAttribute("company");
			
			logger.info("user id in session is " + user.getUserId());
			
			List<History> histories = service.queryMaxNumOfCondition(History.class, 
					DetachedCriteria.forClass(History.class)
					.createAlias("user", "u")
					.createAlias("u.department", "dept")
					.createAlias("dept.company", "com")
					.add(Restrictions.eq("com.companyId", company.getCompanyId()))
					.addOrder(Order.desc("operateTime")), 
					15);
			
			map.put("histories", histories);
			
			if(user.getPosition().equals("研发人员")) {
				
				List<ExceptionRecord> records = service.queryMaxNumOfCondition(ExceptionRecord.class,
						DetachedCriteria.forClass(ExceptionRecord.class)
						.add(Restrictions.eq("developer.developerId", user.getUserId()))
						.addOrder(Order.desc("createdAt")),
						15);
				
				List<Bug> assignBugs = service.queryMaxNumOfCondition(Bug.class, 
						DetachedCriteria.forClass(Bug.class)
						.add(Restrictions.eq("assignedTo.developerId", user.getUserId()))
						.addOrder(Order.desc("createdAt")), 
						15);
				
				List<Bug> newBugs = service.queryMaxNumOfCondition(Bug.class, 
						DetachedCriteria.forClass(Bug.class)
						.createAlias("module", "mod")
						.createAlias("mod.project", "pro")
						.createAlias("pro.company", "com")
						.add(Restrictions.eq("com.companyId", company.getCompanyId()))
						.addOrder(Order.desc("createdAt")), 
						15);
				List<Bug> unsolvedBugs = service.queryMaxNumOfCondition(Bug.class, 
						DetachedCriteria.forClass(Bug.class)
						.createAlias("module", "mod")
						.createAlias("mod.project", "pro")
						.createAlias("pro.company", "com")
						.add(Restrictions.eq("com.companyId", company.getCompanyId()))
						.add(Restrictions.eq("status", "激活"))
						.addOrder(Order.desc("createdAt")), 
						15);
				
				map.put("records", records);
				map.put("assignBugs", assignBugs);
				map.put("newBugs", newBugs);
				map.put("unsolvedBugs", unsolvedBugs);
				
			} else {
				
				List<Bug> myBugs = service.queryMaxNumOfCondition(Bug.class, 
						DetachedCriteria.forClass(Bug.class)
						.add(Restrictions.eq("creator.userId", user.getUserId()))
						.addOrder(Order.desc("createdAt")),
						15);
				
				List<Bug> unclosedBugs = service.queryMaxNumOfCondition(Bug.class, 
						DetachedCriteria.forClass(Bug.class)
						.createAlias("module", "mod")
						.createAlias("mod.project", "pro")
						.createAlias("pro.company", "com")
						.add(Restrictions.eq("com.companyId", company.getCompanyId()))
						.add(Restrictions.ne("status", "关闭"))
						.addOrder(Order.desc("createdAt")), 
						15);
				
				List<UserCase> newCases = service.queryMaxNumOfCondition(UserCase.class,
						DetachedCriteria.forClass(UserCase.class)
						.createAlias("module", "mod")
						.createAlias("mod.project", "pro")
						.createAlias("pro.company", "com")
						.add(Restrictions.eq("com.companyId", company.getCompanyId()))
						.addOrder(Order.desc("createdAt")), 
						15);
				
				List<Task> newTasks = service.queryMaxNumOfCondition(Task.class, 
						DetachedCriteria.forClass(Task.class)
						.createAlias("version", "ver")
						.createAlias("ver.project", "pro")
						.createAlias("pro.company", "com")
						.add(Restrictions.eq("com.companyId", company.getCompanyId()))
						.addOrder(Order.desc("createdAt")), 
						15);
				
				map.put("myBugs", myBugs);
				map.put("unclosedBugs", unclosedBugs);
				map.put("newCases", newCases);
				map.put("newTasks", newTasks);
			}
			
			return "/homepage/myHome";
		}
		@Secured({"ROLE_DEVELOPER", "ROLE_TESTER", "ROLE_ANONYMOUS"})
		@RequestMapping("goMyInfo.htm")
		public ModelAndView goMyInfo(HttpServletRequest request) {
			User user1=(User) request.getSession().getAttribute("user");
			return new ModelAndView("/homepage/myInfo","user1",user1);
		}
		@Secured({"ROLE_DEVELOPER", "ROLE_TESTER", "ROLE_ANONYMOUS"})
		@RequestMapping("goEditMyInfo.htm")
		public ModelAndView goEditMyInfo(HttpServletRequest request) {
			User user1=(User) request.getSession().getAttribute("user");
			return new ModelAndView("/homepage/editMyInfo","user1",user1);
		}
		@Secured({"ROLE_DEVELOPER", "ROLE_TESTER", "ROLE_ANONYMOUS"})
		@RequestMapping("editMyInfo.htm")
		public ModelAndView editMyInfo(HttpServletRequest request) {
			User user1=(User) request.getSession().getAttribute("user");
			String name=request.getParameter("name");
			String gender=request.getParameter("gender");
			String password=request.getParameter("password");
			user1.setName(name);
			user1.setGender(gender);
			user1.setPassword(password);
			service.update(user1);
			HttpSession hs=request.getSession();
			hs.setAttribute("user", user1);
			return new ModelAndView("redirect:goMyInfo.htm");
		}
}
