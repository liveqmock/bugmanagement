package com.sicd.bugmanagement.business.register.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sicd.bugmanagement.business.company.bean.DeptBean;
import com.sicd.bugmanagement.business.register.service.RegisterService;
import com.sicd.bugmanagement.business.register.service.SendMailService;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Department;
import com.sicd.bugmanagement.common.bean.Developer;
import com.sicd.bugmanagement.common.bean.Role;
import com.sicd.bugmanagement.common.bean.Tester;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.UserRole;
import com.sicd.bugmanagement.common.tag.pageTag.PageHelper;
import com.sicd.bugmanagement.utils.DateParser;


@Controller
public class RegiseterController {
	
	private static Logger logger = Logger.getLogger(RegiseterController.class);
	
	@Autowired
	private RegisterService service;
	@RequestMapping("goRegisterPage.htm")
	public ModelAndView goRegisterPage(){
		return new ModelAndView("/register/register");
	}
	@SuppressWarnings("unchecked")
	@RequestMapping("goToUserList.htm")
	public ModelAndView goToUserList(HttpServletRequest request){
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
		Company company=(Company) request.getSession().getAttribute("company");
		
		DetachedCriteria dCriteria=DetachedCriteria.forClass(Department.class);
		dCriteria.add(Restrictions.eq("company", company));
		List<Department> deptList=service.queryAllOfCondition(Department.class, dCriteria);
		
		DetachedCriteria dCriteria1=DetachedCriteria.forClass(User.class);
		dCriteria1.add(Restrictions.in("department", deptList)).add(Restrictions.eq("enabled", true));
		int totalSize = service.countTotalSize(dCriteria1);
		PageHelper.forPage(pageSize, totalSize);
		List<User> userList=(List<User>)service.getByPage(dCriteria1, pageSize);
		
		DetachedCriteria dCriteria2=DetachedCriteria.forClass(Department.class);
		dCriteria2.add(Restrictions.eq("company", company)).add(Restrictions.isNull("parent")).addOrder(Order.asc("createdAt"));
		List<Department> parents=service.queryAllOfCondition(Department.class, dCriteria2);
		List<DeptBean> all=new ArrayList<DeptBean>();
		addChildDept1(parents, all);
		
		ModelMap map=new ModelMap();
		map.put("all", all);
		map.put("userList", userList);
		
		return new ModelAndView("/register/userList",map);
	}
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping("goEditUser.htm")
	public ModelAndView goEditUser(HttpServletRequest request){
		String userId=request.getParameter("userId");
		User user1=service.findById(User.class, Integer.parseInt(userId));
		Company company=(Company) request.getSession().getAttribute("company");
		
		DetachedCriteria dCriteria2=DetachedCriteria.forClass(Department.class);
		dCriteria2.add(Restrictions.eq("company", company)).add(Restrictions.isNull("parent")).addOrder(Order.asc("createdAt"));
		List<Department> parents=service.queryAllOfCondition(Department.class, dCriteria2);
		List<DeptBean> all=new ArrayList<DeptBean>();
		addChildDept(parents, all);
		
		ModelMap map=new ModelMap();
		map.put("all", all);
		map.put("user1", user1);
		return new ModelAndView("/register/editeUser", map);
	}
	@SuppressWarnings("unchecked")
	@RequestMapping("goDeptUser.htm")
	public ModelAndView goDeptUser(HttpServletRequest request){
		
		Company company=(Company) request.getSession().getAttribute("company");
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
		String deptId=request.getParameter("deptId");
		Department dept=service.findById(Department.class, Integer.parseInt(deptId));
		
		DetachedCriteria dCriteria1=DetachedCriteria.forClass(User.class);
		dCriteria1.add(Restrictions.eq("enabled", true)).add(Restrictions.eq("department", dept));
		int totalSize = service.countTotalSize(dCriteria1);
		PageHelper.forPage(pageSize, totalSize);
		List<User> userList=(List<User>)service.getByPage(dCriteria1, pageSize);
		
		
		DetachedCriteria dCriteria2=DetachedCriteria.forClass(Department.class);
		dCriteria2.add(Restrictions.eq("company", company)).add(Restrictions.isNull("parent")).addOrder(Order.asc("createdAt"));
		List<Department> parents=service.queryAllOfCondition(Department.class, dCriteria2);
		List<DeptBean> all=new ArrayList<DeptBean>();
		addChildDept1(parents, all);
		
		ModelMap map=new ModelMap();
		map.put("all", all);
		map.put("userList", userList);
		
		
		return new ModelAndView("/register/userList" ,map);
	}
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping("editUser.htm")
	public ModelAndView editUser(HttpServletRequest request) throws Exception{
		String dept1=ServletRequestUtils.getStringParameter(request, "deptId");
		String userId=ServletRequestUtils.getStringParameter(request, "userId");
		int deptId=Integer.parseInt(dept1);
		
		Department dept=service.findById(Department.class, deptId);
		String name=ServletRequestUtils.getStringParameter(request, "name");
		String realName=ServletRequestUtils.getStringParameter(request, "realName");
		String position=ServletRequestUtils.getStringParameter(request, "position");
		String email=ServletRequestUtils.getStringParameter(request, "email");
		String joinDate=ServletRequestUtils.getStringParameter(request, "joinDate");
		
		
		
		User user1=service.findById(User.class, Integer.parseInt(userId));
		user1.setEmail(email);
		user1.setName(name);
		user1.setRealName(realName);
		user1.setPosition(position);
		user1.setDepartment(dept);
		user1.setJoinDate(DateParser.parseDate(joinDate));
		
		service.update(user1);
		return new ModelAndView("redirect:goToUserList.htm");
	}
	@RequestMapping("goRegistersuccess.htm")
	public ModelAndView goRegistersuccess(){
		return new ModelAndView("/register/registersuccess");
	}
	@RequestMapping("checkUsedEmail.htm")
	public void checkUsedEmail(HttpServletRequest request ,HttpServletResponse response)throws Exception{
		String userEmail=ServletRequestUtils.getStringParameter(request, "email");
		System.out.println(userEmail+"####################");
		PrintWriter out=null;
		String result=null;
		out=response.getWriter();
		if(service.checkEmail(userEmail)!=0){
			
			result="registed";
			System.out.println(result);
		}else{
			result="ok";
		}
		out.print(result);
		
	}
	
	@RequestMapping("userRegister.htm")
	public  ModelAndView userRegister(HttpServletRequest request ,HttpServletResponse response) throws Exception{
		/*System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");*/
		String userEmail=ServletRequestUtils.getStringParameter(request, "userEmail");
		String userPassword=ServletRequestUtils.getStringParameter(request, "userPassword");
		String userName=ServletRequestUtils.getStringParameter(request, "userName");
		String userGender=ServletRequestUtils.getStringParameter(request, "userGender");
		String companyname=ServletRequestUtils.getStringParameter(request, "companyname");
		
		
		Tester tester=new Tester();
		
		//注册用户信息
		User user=new User();
		user.setEmail(userEmail);
		user.setName(userName);		
		user.setPassword(userPassword);	
		user.setGender(userGender);
		user.setJoinDate(new Date());
		user.setPosition("测试经理");
		user.setEnabled(false);
		service.save(user);
		
		tester.setUser(user);
		tester.setTesterId(user.getUserId());
		
		service.save(tester);
		
		//注册的时候创建公司
		Company compony=new Company();
		
		compony.setCreatedAt(new Date());
		compony.setName(companyname);
		compony.setUser(user);
		
		service.save(compony);
		
		
		//默认添加3个部门
		Department department=new Department();
		
		department.setCompany(compony);
		department.setCreatedAt(new Date());
		department.setName("测试主管部门");
		
		service.save(department);
		
		Department department1=new Department();
		
		department1.setCompany(compony);
		department1.setCreatedAt(new Date());
		department1.setName("测试部门");
		
		service.save(department1);
		
		Department department2=new Department();
		
		department2.setCompany(compony);
		department2.setCreatedAt(new Date());
		department2.setName("研发部门");
		service.save(department2);
		
		//给注册者添加部门
		user.setDepartment(department);
		service.update(user);
		
		
		//插入角色用户表
		Role role=service.findById(Role.class, 1);
		
		UserRole userRole=new UserRole();
		userRole.setUser(user);
		userRole.setRole(role);
		service.save(userRole);
		
		SendMailService email = new SendMailService("smtp.qq.com", 25, 0, true, "2424208347","1136822939",true);
		String url="尊敬的"+user.getName()+"您好，点击链接激活您的BUGManagement账号<br><a href='http://localhost:8888/bugmanagement/verifyEmail.htm?userid="+user.getUserId()+"'>激活</a><br>";
		try {
			email.sendEmail(
					"2424208347@qq.com",
					"BUG管理系统",
					userEmail,
					"激活邮件",url
					);
			request.setAttribute("note", "尊敬的用户,您已经成功注册，请前往注册邮箱激活账号。");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("send fail");
			request.setAttribute("note", "尊敬的用户,很不幸的消息，由于网络故障，注册激活邮件发送失败。");
		}
		return new ModelAndView("redirect:goRegistersuccess.htm");
		
	}
	//激活 
	
	@RequestMapping("verifyEmail.htm")
	public ModelAndView verifyEmail(HttpServletRequest request ,HttpServletResponse response) throws Exception{
		
		String userid1=request.getParameter("userid");
		int userid=Integer.parseInt(userid1);
		System.out.println(userid);
		User user=service.findById(User.class, userid);
		
		if(user.getUserId()!=0){
			
			user.setEnabled(true);
			service.update(user);
			request.setAttribute("verify", "激活成功,马上可以登陆了....");
			return new ModelAndView("/register/verifysuccess");
		}else {
			request.setAttribute("verify","激活失败,重新注册");
			return new ModelAndView("/register/register");
		}
		
	}
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping("goaddUser.htm")
	public ModelAndView goaddUser(HttpServletRequest request) throws Exception{
			Company company=(Company) request.getSession().getAttribute("company");
			
			DetachedCriteria dCriteria=DetachedCriteria.forClass(Department.class);
			dCriteria.add(Restrictions.isNull("parent")).add(Restrictions.eq("company", company));
		
			List<Department> parents = service.queryAllOfCondition(Department.class, dCriteria);
			
			logger.info("##### parent department size " + parents.size());
			List<DeptBean> deptBeans = new ArrayList<DeptBean>();
			addChildDept(parents, deptBeans);
			logger.info("#### all deptBeans size " + deptBeans.size());
		
			return new ModelAndView("/register/addUser", "deptBeans", deptBeans);
	
		
	}
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping("addUser.htm")
	public ModelAndView addUser(HttpServletRequest request) throws Exception{
		
		
		String dept1=ServletRequestUtils.getStringParameter(request, "deptId");
		
		int deptId=Integer.parseInt(dept1);
		
		Department dept=service.findById(Department.class, deptId);
		String name=ServletRequestUtils.getStringParameter(request, "name");
		String realName=ServletRequestUtils.getStringParameter(request, "realName");
		String password=ServletRequestUtils.getStringParameter(request, "password");
		String position=ServletRequestUtils.getStringParameter(request, "position");
		String email=ServletRequestUtils.getStringParameter(request, "email");
		String gender=ServletRequestUtils.getStringParameter(request, "gender");
		
		User user1=new User();
		user1.setEmail(email);
		user1.setName(name);
		user1.setRealName(realName);
		user1.setPosition(position);
		user1.setPassword(password);
		user1.setGender(gender);
		user1.setJoinDate(new Date());
		user1.setDepartment(dept);
		user1.setEnabled(false);
		
		service.save(user1);
		
		
		if(position.equals("测试人员")){
			Tester tester=new Tester();
			tester.setUser(user1);
			tester.setTesterId(user1.getUserId());
			service.save(tester);
			
		}
		if(position.equals("开发人员")){
			Developer develop=new Developer();
			develop.setUser(user1);
			develop.setDeveloperId(user1.getUserId());
			service.save(develop);
		}
		
		
		SendMailService email1 = new SendMailService("smtp.qq.com", 25, 0, true, "2424208347","1136822939",true);
		String url="尊敬的"+user1.getRealName()+"您好,点击链接激活您的BUGManagement账号<br><a href='http://localhost:8888/bugmanagement/verifyEmail.htm?userid="+user1.getUserId()+"'>激活</a><br>";
		try {
			email1.sendEmail(
					"2424208347@qq.com",
					"BUG管理系统",
					email,
					"激活邮件",url
					);
			request.setAttribute("note", "尊敬的用户,您已经成功注册，请前往注册邮箱激活账号。");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("send fail");
			request.setAttribute("note", "尊敬的用户,很不幸的消息，由于网络故障，注册激活邮件发送失败。");
		}
		
			return new ModelAndView("/register/userHome");
		
		
	}
	
	
	private void addChildDept1(List<Department> parents, List<DeptBean> all) {
		for (int i = 0; i < parents.size(); i++) {
			Department department = parents.get(i);
			DeptBean deptBean = new DeptBean();
			deptBean.setDeptId(department.getDepartmentId());
			deptBean.setDeptName(department.getName());
			deptBean.setHasChildren(!department.getChildren().isEmpty());
			if (i == parents.size() - 1) {
				deptBean.setLast(true);
			} else {
				deptBean.setLast(false);
			}

			all.add(deptBean);
			if (!department.getChildren().isEmpty()) {
				DetachedCriteria dCriteria = DetachedCriteria
						.forClass(Department.class);
				dCriteria.add(Restrictions.eq("parent", department)).addOrder(
						Order.asc("createdAt"));
				List<Department> children = service.queryAllOfCondition(
						Department.class, dCriteria);
				addChildDept1(children, all);
			}
		}
	}
	private void addChildDept(List<Department> parents, List<DeptBean> all) {
		logger.info("#### e nter add child dept");
		for (int i = 0; i < parents.size(); i++) {
			Department department = parents.get(i);
			DeptBean deptBean = new DeptBean();
			deptBean.setDeptId(department.getDepartmentId());
			deptBean.setDeptName(getFullName(department));
			all.add(deptBean);
			if (!department.getChildren().isEmpty()) {
				DetachedCriteria dCriteria = DetachedCriteria
						.forClass(Department.class);
				dCriteria.add(Restrictions.eq("parent", department)).addOrder(
						Order.asc("createdAt"));
				List<Department> children = service.queryAllOfCondition(
						Department.class, dCriteria);
				addChildDept(children, all);
			}
		}
		logger.info("#### out add child dept");
	}
	
	private String getFullName(Department department) {
		logger.info("#### enter get full name");
		String name = department.getName();
		while((department.getParent()) != null) {
			department = service.findById(Department.class, department.getParent().getDepartmentId());
			name = department.getName() + "/" + name;
		}
		logger.info("#### out get full name");
		return name;
	}

}
