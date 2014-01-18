package com.sicd.bugmanagement.business.addbug.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sicd.bugmanagement.business.addbug.service.AddBugService;
import com.sicd.bugmanagement.business.project.bean.ModuleBean;
import com.sicd.bugmanagement.business.register.service.SendMailService;
import com.sicd.bugmanagement.common.bean.AffectedVersion;
import com.sicd.bugmanagement.common.bean.Bug;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Department;
import com.sicd.bugmanagement.common.bean.Developer;
import com.sicd.bugmanagement.common.bean.History;
import com.sicd.bugmanagement.common.bean.Module;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.Resource;
import com.sicd.bugmanagement.common.bean.Step;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.UserCase;
import com.sicd.bugmanagement.common.bean.Version;
import com.sicd.bugmanagement.utils.ModuleUtil;


@Controller
public class AddBugController {
	
	private static Logger logger = Logger.getLogger(AddBugController.class);
	private static String path = "E:/workplace/bugmanagement/src/main/webapp";
			
	@Autowired
	private AddBugService aService;
	
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
	@RequestMapping("goAddBug.htm")
	public ModelAndView goAddBug(HttpServletRequest request){
			
		Company company=(Company) request.getSession().getAttribute("company");
		DetachedCriteria dCriteria=DetachedCriteria.forClass(Project.class);
		dCriteria.add(Restrictions.eq("company",company));		
		List<Project> projectList=aService.queryAllOfCondition(Project.class, dCriteria);
		
		DetachedCriteria dCriteria1=DetachedCriteria.forClass(Department.class);
		dCriteria1.add(Restrictions.eq("company", company));
		List<Department> deptList=aService.queryAllOfCondition(Department.class, dCriteria1);
		
		DetachedCriteria dCriteria2=DetachedCriteria.forClass(Developer.class);
		dCriteria2.createCriteria("user")
		.add(Restrictions.in("department", deptList));
		List<Developer> userList=aService.queryAllOfCondition(Developer.class, dCriteria2);
		
		
		DetachedCriteria dCriteria3=DetachedCriteria.forClass(User.class);
		dCriteria3.add(Restrictions.in("department", deptList));
		List<User> userList1=aService.queryAllOfCondition(User.class, dCriteria3);
		
		ModelMap map = new ModelMap();
		map.put("projectList", projectList);
		map.put("userList", userList);
		map.put("userList1", userList1);
		
		return new ModelAndView("/bug/addBug", map);
	}
	
	@RequestMapping("loadModel.htm")
	public void loadModel(HttpServletRequest request,HttpServletResponse response)throws Exception{
		String projectId=request.getParameter("projectId");
		
		Project project=aService.findById(Project.class, Integer.parseInt(projectId));
		
		List<ModuleBean> moduleBean = ModuleUtil.getModuleNameList(aService, project);
		
		JSONArray json= JSONArray.fromObject(moduleBean); 
		PrintWriter pt=response.getWriter();
		pt.write(json.toString());
		System.out.println(json.toString());
		pt.close();
		
	}
	@RequestMapping("loadVersion.htm")
	public void loadVersion(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String projectId=request.getParameter("projectId");
		Project project=aService.findById(Project.class, Integer.parseInt(projectId));
		DetachedCriteria dCriteria=DetachedCriteria.forClass(Version.class);
		dCriteria.add(Restrictions.eq("project", project));
		List<Version> list=new ArrayList<Version>();
		list=aService.queryAllOfCondition(Version.class, dCriteria);
		System.out.println("version list size " + list.size());
		JsonConfig config1 = new JsonConfig(); 
		config1.setExcludes(new String[]{"project", "tasks", "affectedVersions"}); 
		JSONArray json= JSONArray.fromObject(list,config1); 
		PrintWriter pt=response.getWriter();
		pt.write(json.toString());
		pt.close();
		
	}
	
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
	@RequestMapping("addBug.htm")
	public ModelAndView addBug(HttpServletRequest request) throws Exception{
		
		User user=(User) request.getSession().getAttribute("user");

		String destinationDir = "E:\\workplace\\bugmanagement\\src\\main\\webapp\\source\\bug\\";

		MultipartHttpServletRequest multipartReq = (MultipartHttpServletRequest) request;
		String module1=multipartReq.getParameter("module");
		String assignedTo=multipartReq.getParameter("assignedTo");
		String title=multipartReq.getParameter("title");
		String chongxian=multipartReq.getParameter("chongxian");
		String os=multipartReq.getParameter("os");
		String browser=multipartReq.getParameter("browser");
		String type=multipartReq.getParameter("type");
		String severity=multipartReq.getParameter("severity");
		String keywords=multipartReq.getParameter("keywords");
		String[] version=multipartReq.getParameterValues("version");
		String[] mailto=(String[])multipartReq.getParameterValues("mailto");
		
		int size=mailto.length;
		String mail="";
		String mail1="";
		String email="";
		String email1="";
		System.out.println(keywords);
		System.out.println(size);
		for(int j=0;j<size;j++){
			
			System.out.println(" mail to " + mailto[j]);
			
			User user1=aService.findById(User.class, Integer.parseInt(mailto[j]));
			
			if(j==(mailto.length-1)){
				email=user1.getEmail();
			}else{
				email=user1.getEmail()+";";
			}
			email1=email1+email;
			
			if(j==(mailto.length-1)){
				mail=user1.getRealName();
			}else{
				mail=user1.getRealName()+";";
			}
			mail1=mail1+mail;
			
		}
		
		Module module=aService.findById(Module.class, Integer.parseInt(module1));
		
		Developer develop=aService.findById(Developer.class,Integer.parseInt(assignedTo));
		
		Bug bug=new Bug();
		bug.setAssignedTo(develop);
		bug.setBrowser(browser);
		bug.setConfirm(false);
		bug.setKeyword(keywords);
		bug.setModule(module);
		bug.setCreatedAt(new Date());
		bug.setCreator(user);
		bug.setMailto(mail1);
		bug.setOs(os);
		bug.setSeverity(Integer.parseInt(severity));
		bug.setTitle(title);
		bug.setType(type);
		bug.setSteps(chongxian);
		bug.setStatus("激活");
		
		aService.save(bug);
		
		History hs=new History();
		hs.setUser(user);
		hs.setObjectId(bug.getBugId());
		hs.setObjectType("bug");
		hs.setOperateTime(new Date());
		hs.setOperation("创建");
		aService.save(hs);
		
		for(int x=0;x<version.length;x++){
			
		Version ver=aService.findById(Version.class,Integer.parseInt(version[x]));	
			
		AffectedVersion av=new AffectedVersion();
			av.setBug(bug);
			av.setVersion(ver);
			aService.save(av);
		}
		
		
		List<MultipartFile> files = multipartReq.getFiles("files");
		System.out.println("files size ====="+files.size());
		for (int i = 0; i < files.size(); i++) {
			String[] labels=multipartReq.getParameterValues("labels");
			MultipartFile file = files.get(i);
			
			String fileName = file.getOriginalFilename();
			
			if(!fileName.isEmpty()) {
				String filetype=fileName.substring(fileName.lastIndexOf(".") + 1);
				
				Resource re=new Resource();
				String uuid = UUID.randomUUID().toString();
				re.setObjectId(bug.getBugId());
				re.setObjectType("bug");
				re.setResourceName(labels[i]);
				re.setResourceUrl("/source/bug/" + uuid + "."
						+ filetype);
				
				aService.save(re);
				
				File destination = new File(destinationDir + uuid
						+ "." + filetype);
				
				file.transferTo(destination);
			}
		}
		SendMailService email2 = new SendMailService("smtp.qq.com", 25, 0, true, "2424208347","1136822939",true);
		String url="尊敬的用户您好，"+user.getName()+"创建了新BUG，并抄送给了你请注意查收，点击<a href='http://localhost:8888/goDetailBug.htm?bugId="+bug.getBugId()+"'>这里</a>查看BuG详细信息<br>";
		try {
			email2.sendEmail(
					"2424208347@qq.com",
					"BUG管理系统",
						email1,
					"通知",url
					);
			request.setAttribute("note", "尊敬的用户您好，"+user.getName()+"创建了新BUG，并抄送给了你请注意查收");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("send fail");
			request.setAttribute("note", "尊敬的用户,很不幸的消息，由于网络故障，邮件发送失败。");
		}
		return new ModelAndView("redirect:bug.htm");
	}
	
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})	
	@RequestMapping("gocopyBug.htm")
	public ModelAndView gocopyBug(HttpServletRequest request){
		
		String bugId=request.getParameter("bugId");
		
		
		Bug bug=aService.findById(Bug.class, Integer.parseInt(bugId));
		Project project=bug.getModule().getProject();
		List<ModuleBean> moduleBean = ModuleUtil.getModuleNameList(aService, project);
		
		Company company=(Company) request.getSession().getAttribute("company");
		DetachedCriteria dCriteria1=DetachedCriteria.forClass(Project.class);
		dCriteria1.add(Restrictions.eq("company",company)).add(Restrictions.ne ("projectId", project.getProjectId()));		
		List<Project> projectList=aService.queryAllOfCondition(Project.class, dCriteria1);
		
		
		DetachedCriteria dCriteria2=DetachedCriteria.forClass(Version.class);
		dCriteria2.add(Restrictions.eq("project", project));
		List<Version> versionList=aService.queryAllOfCondition(Version.class, dCriteria2);
		
		
		DetachedCriteria dCriteria3=DetachedCriteria.forClass(AffectedVersion.class);
		dCriteria3.add(Restrictions.eq("bug", bug));
		List<AffectedVersion> avList=aService.queryAllOfCondition(AffectedVersion.class, dCriteria3);
		
		List<Version> aList = new ArrayList<Version>();
		for (AffectedVersion aversion : avList) {
			aList.add(aversion.getVersion());
		}

		DetachedCriteria dCriteria5=DetachedCriteria.forClass(Department.class);
		dCriteria5.add(Restrictions.eq("company", company));
		List<Department> deptList=aService.queryAllOfCondition(Department.class, dCriteria5);
		
		DetachedCriteria dCriteria4=DetachedCriteria.forClass(Developer.class).add(Restrictions.ne("developerId", bug.getAssignedTo().getDeveloperId()));
		dCriteria4.createCriteria("user")
		.add(Restrictions.in("department", deptList));
		List<Developer> userList=aService.queryAllOfCondition(Developer.class, dCriteria4);
		
		
		DetachedCriteria dCriteria6=DetachedCriteria.forClass(User.class);
		dCriteria6.add(Restrictions.in("department", deptList));
		List<User> userList1=aService.queryAllOfCondition(User.class, dCriteria6);
		String mailto=bug.getMailto();
		
		String[] name=mailto.split(";");
		List<User> userlist=new ArrayList<User>();
		for(int i=0;i<name.length;i++){
			User user1=new User();
			user1.setRealName(name[i]);
			userlist.add(user1);
		}
		ModelMap map=new ModelMap();
		map.put("bug", bug);
		map.put("modulebean", moduleBean);
		map.put("projectList", projectList);
		map.put("versionList", versionList);
		map.put("userlist", userlist);
		map.put("userList", userList);
		map.put("userList1", userList1);
		map.put("aList", aList);
			
		
		return new ModelAndView("/bug/copyBug",map);
	}
	
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
	@RequestMapping("goeditBug.htm")
	public ModelAndView goeditBug(HttpServletRequest request){
		String bugId=request.getParameter("bugId");
		
		
		Bug bug=aService.findById(Bug.class, Integer.parseInt(bugId));
		Project project=bug.getModule().getProject();
		List<ModuleBean> modulebean = ModuleUtil.getModuleNameList(aService, project);
		
		Company company=(Company) request.getSession().getAttribute("company");
		DetachedCriteria dCriteria1=DetachedCriteria.forClass(Project.class);
		dCriteria1.add(Restrictions.eq("company",company)).add(Restrictions.ne ("projectId", project.getProjectId()));		
		List<Project> projectList=aService.queryAllOfCondition(Project.class, dCriteria1);
		
		
		DetachedCriteria dCriteria2=DetachedCriteria.forClass(Version.class);
		dCriteria2.add(Restrictions.eq("project", project));
		List<Version> versionList=aService.queryAllOfCondition(Version.class, dCriteria2);
		
		
		DetachedCriteria dCriteria3=DetachedCriteria.forClass(AffectedVersion.class);
		dCriteria3.add(Restrictions.eq("bug", bug));
		List<AffectedVersion> avList=aService.queryAllOfCondition(AffectedVersion.class, dCriteria3);
		
		List<Version> aList = new ArrayList<Version>();
		for (AffectedVersion aversion : avList) {
			aList.add(aversion.getVersion());
		}

		DetachedCriteria dCriteria5=DetachedCriteria.forClass(Department.class);
		dCriteria5.add(Restrictions.eq("company", company));
		List<Department> deptList=aService.queryAllOfCondition(Department.class, dCriteria5);
		
		DetachedCriteria dCriteria4=DetachedCriteria.forClass(Developer.class).add(Restrictions.ne("developerId", bug.getAssignedTo().getDeveloperId()));
		dCriteria4.createCriteria("user")
		.add(Restrictions.in("department", deptList));
		List<Developer> userList=aService.queryAllOfCondition(Developer.class, dCriteria4);
		
		DetachedCriteria dCriteria7=DetachedCriteria.forClass(History.class);
		dCriteria7.add(Restrictions.eq("objectId", bug.getBugId())).add(Restrictions.eq("objectType", "bug")).addOrder(Order.asc("operateTime"));
		List<History> hisList=aService.queryAllOfCondition(History.class, dCriteria7);
		
		DetachedCriteria dCriteria6=DetachedCriteria.forClass(User.class);
		dCriteria6.add(Restrictions.in("department", deptList));
		List<User> userList1=aService.queryAllOfCondition(User.class, dCriteria6);
		String mailto=bug.getMailto();
		
		String[] name=mailto.split(";");
		List<User> userlist=new ArrayList<User>();
		for(int i=0;i<name.length;i++){
			User user1=new User();
			user1.setRealName(name[i]);
			userlist.add(user1);
		}
		ModelMap map=new ModelMap();
		map.put("bug", bug);
		map.put("modulebean", modulebean);
		map.put("projectList", projectList);
		map.put("versionList", versionList);
		map.put("userlist", userlist);
		map.put("userList", userList);
		map.put("userList1", userList1);
		map.put("aList", aList);
		map.put("hisList", hisList);
		
		return new ModelAndView("/bug/editBug" , map);
	}
	
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
	@RequestMapping("editBug.htm")
	public ModelAndView editBug(HttpServletRequest request) throws Exception{
		
		User user=(User) request.getSession().getAttribute("user");
		String destinationDir = "E:\\workplace\\bugmanagement\\src\\main\\webapp\\source\\bug\\";

		MultipartHttpServletRequest multipartReq = (MultipartHttpServletRequest) request;
		String bugId=multipartReq.getParameter("bugId");
		String module1=multipartReq.getParameter("module");
		String assignedTo=multipartReq.getParameter("assignedTo");
		String title=multipartReq.getParameter("title");
		String chongxian=multipartReq.getParameter("chongxian");
		String os=multipartReq.getParameter("os");
		String browser=multipartReq.getParameter("browser");
		String type=multipartReq.getParameter("type");
		String severity=multipartReq.getParameter("severity");
		String keywords=multipartReq.getParameter("keywords");
		String beizhu=multipartReq.getParameter("beizhu");
		String pri=multipartReq.getParameter("pri");
		String status=multipartReq.getParameter("status");
		String relateBug=multipartReq.getParameter("relateBug");
		
		String[] mailto=(String[])multipartReq.getParameterValues("mailto");
		
		int size=mailto.length;
		String mail="";
		String mail1="";
		String email="";
		String email1="";
		
		for(int j=0;j<size;j++){
			
			System.out.println(" mail to " + mailto[j]);
			
			User user1=aService.findById(User.class, Integer.parseInt(mailto[j]));
			
			if(j==(mailto.length-1)){
				email=user1.getEmail();
			}else{
				email=user1.getEmail()+";";
			}
			email1=email1+email;
			
			if(j==(mailto.length-1)){
				mail=user1.getRealName();
			}else{
				mail=user1.getRealName()+";";
			}
			mail1=mail1+mail;
			
		}
		
		Module module=aService.findById(Module.class, Integer.parseInt(module1));
		
		Developer develop=aService.findById(Developer.class,Integer.parseInt(assignedTo));
		
		Bug bug=aService.findById(Bug.class, Integer.parseInt(bugId));
		bug.setAssignedTo(develop);
		bug.setBrowser(browser);
		
		bug.setKeyword(keywords);
		bug.setModule(module);
		
		if(!pri.isEmpty()) {
			bug.setPriority(Integer.parseInt(pri));
		}
		
		if(!relateBug.isEmpty()) {
			bug.setRelatedBug(aService.findById(Bug.class,Integer.parseInt(relateBug)));
		}
		
		
		bug.setMailto(mail1);
		bug.setOs(os);
		bug.setSeverity(Integer.parseInt(severity));
		bug.setTitle(title);
		bug.setType(type);
		bug.setSteps(chongxian);
		bug.setStatus(status);
		
		aService.update(bug);
		
		List<MultipartFile> files = multipartReq.getFiles("files");
		System.out.println("files size ====="+files.size());
		for (int i = 0; i < files.size(); i++) {
			String[] labels=multipartReq.getParameterValues("labels");
			MultipartFile file = files.get(i);
			
			String fileName = file.getOriginalFilename();
			
			if(!fileName.isEmpty()) {
				String filetype=fileName.substring(fileName.lastIndexOf(".") + 1);
				
				Resource re=new Resource();
				
				re.setObjectId(bug.getBugId());
				re.setObjectType("bug");
				re.setResourceName(labels[i]);
				re.setResourceUrl("/source/bug/" + UUID.randomUUID() + "."
						+ filetype);
				
				aService.save(re);
				
				File destination = new File(destinationDir + UUID.randomUUID()
						+ "." + filetype);
				
				file.transferTo(destination);
			}
		}
		History hs=new History();
		hs.setUser(user);
		hs.setComment(beizhu);
		hs.setObjectId(bug.getBugId());
		hs.setObjectType("bug");
		hs.setOperateTime(new Date());
		hs.setOperation("编辑");
		aService.save(hs);
		
		SendMailService email2 = new SendMailService("smtp.qq.com", 25, 0, true, "2424208347","1136822939",true);
		String url="尊敬的用户您好，"+user.getName()+"编辑BUG，并抄送给了你请注意查收，点击<a href='http://localhost:8888/goDetailBug.htm?bugId="+bug.getBugId()+"'>这里</a>查看BuG详细信息<br>";
		try {
			email2.sendEmail(
					"2424208347@qq.com",
					"BUG管理系统",
						email1,
					"通知",url
					);
			request.setAttribute("note", "尊敬的用户您好，"+user.getName()+"编辑BUG，并抄送给了你请注意查收");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("send fail");
			request.setAttribute("note", "尊敬的用户,很不幸的消息，由于网络故障，邮件发送失败。");
		}
		return new ModelAndView("redirect:bug.htm");
	}
	
	@Secured({"ROLE_TESTER"})
	@RequestMapping("goBugFromUc.htm")
	public ModelAndView goBugFromUc(HttpServletRequest request){

		String ucId=request.getParameter("usercaseId");
		UserCase uc=aService.findById(UserCase.class, Integer.parseInt(ucId));
		
		Company company=(Company) request.getSession().getAttribute("company");
		DetachedCriteria dCriteria=DetachedCriteria.forClass(Project.class);
		dCriteria.add(Restrictions.eq("company",company));		
		List<Project> projectList=aService.queryAllOfCondition(Project.class, dCriteria);	
			
		DetachedCriteria dCriteria1=DetachedCriteria.forClass(Department.class);
		dCriteria1.add(Restrictions.eq("company", company));
		List<Department> deptList=aService.queryAllOfCondition(Department.class, dCriteria1);
		
		DetachedCriteria dCriteria2=DetachedCriteria.forClass(Developer.class);
		dCriteria2.createCriteria("user")
		.add(Restrictions.in("department", deptList));
		List<Developer> userList=aService.queryAllOfCondition(Developer.class, dCriteria2);
		
		
		DetachedCriteria dCriteria3=DetachedCriteria.forClass(User.class);
		dCriteria3.add(Restrictions.in("department", deptList));
		List<User> userList1=aService.queryAllOfCondition(User.class, dCriteria3);
		
		
		DetachedCriteria dCriteria4=DetachedCriteria.forClass(Step.class);
		dCriteria4.add(Restrictions.eq("userCase", uc));
		List<Step> stepList=aService.queryAllOfCondition(Step.class, dCriteria4);
		
		
		ModelMap map=new ModelMap();
		
		map.put("projectList", projectList);
		map.put("userList", userList);
		map.put("userList1", userList1);
		map.put("uc", uc);
		map.put("stepList", stepList);
		
		return new ModelAndView("/usecase/ucToBug",map);
		
	}
	@Secured({"ROLE_TESTER"})
	@RequestMapping("addBugFromUC.htm")
	public ModelAndView addBugFromUC(HttpServletRequest request) throws Exception{
		User user=(User) request.getSession().getAttribute("user");

		String destinationDir = "E:\\workplace\\bugmanagement\\src\\main\\webapp\\source\\bug\\";

		MultipartHttpServletRequest multipartReq = (MultipartHttpServletRequest) request;
		
		String usercaseId=multipartReq.getParameter("usercaseId");
		String module1=multipartReq.getParameter("module");
		String assignedTo=multipartReq.getParameter("assignedTo");
		String title=multipartReq.getParameter("title");
		String chongxian=multipartReq.getParameter("chongxian");
		String os=multipartReq.getParameter("os");
		String browser=multipartReq.getParameter("browser");
		String type=multipartReq.getParameter("type");
		String severity=multipartReq.getParameter("severity");
		String keywords=multipartReq.getParameter("keywords");
		String[] version=multipartReq.getParameterValues("version");
		String[] mailto=(String[])multipartReq.getParameterValues("mailto");
		
		int size=mailto.length;
		String mail="";
		String mail1="";
		String email="";
		String email1="";
		System.out.println(keywords);
		System.out.println(size);
		for(int j=0;j<size;j++){
			
			System.out.println(" mail to " + mailto[j]);
			
			User user1=aService.findById(User.class, Integer.parseInt(mailto[j]));
			
			if(j==(mailto.length-1)){
				email=user1.getEmail();
			}else{
				email=user1.getEmail()+";";
			}
			email1=email1+email;
			
			if(j==(mailto.length-1)){
				mail=user1.getRealName();
			}else{
				mail=user1.getRealName()+";";
			}
			mail1=mail1+mail;
			
		}
		
		Module module=aService.findById(Module.class, Integer.parseInt(module1));
		
		Developer develop=aService.findById(Developer.class,Integer.parseInt(assignedTo));
		
		UserCase userCase=aService.findById(UserCase.class, Integer.parseInt(usercaseId));
		
		Bug bug=new Bug();
		bug.setAssignedTo(develop);
		bug.setBrowser(browser);
		bug.setConfirm(false);
		bug.setKeyword(keywords);
		bug.setModule(module);
		bug.setCreatedAt(new Date());
		bug.setCreator(user);
		bug.setMailto(mail1);
		bug.setOs(os);
		bug.setSeverity(Integer.parseInt(severity));
		bug.setTitle(title);
		bug.setType(type);
		bug.setSteps(chongxian);
		bug.setStatus("激活");
		bug.setFromCase(userCase);
		aService.save(bug);
		
		
		userCase.setToBug(bug);
		aService.update(userCase);
		
		History hs=new History();
		hs.setUser(user);
		hs.setObjectId(bug.getBugId());
		hs.setObjectType("bug");
		hs.setOperateTime(new Date());
		hs.setOperation("创建");
		aService.save(hs);
		
		History hs1=new History();
		hs1.setUser(user);
		hs1.setObjectId(userCase.getCaseId());
		hs1.setObjectType("usercase");
		hs1.setOperateTime(new Date());
		hs1.setOperation("编辑");
		hs1.setComment("生成BUG");
		aService.save(hs1);
		
		for(int x=0;x<version.length;x++){
			
		Version ver=aService.findById(Version.class,Integer.parseInt(version[x]));	
			
		AffectedVersion av=new AffectedVersion();
			av.setBug(bug);
			av.setVersion(ver);
			aService.save(av);
		}
		
		
		List<MultipartFile> files = multipartReq.getFiles("files");
		System.out.println("files size ====="+files.size());
		for (int i = 0; i < files.size(); i++) {
			String[] labels=multipartReq.getParameterValues("labels");
			MultipartFile file = files.get(i);
			
			String fileName = file.getOriginalFilename();
			
			if(!fileName.isEmpty()) {
				String filetype=fileName.substring(fileName.lastIndexOf(".") + 1);
				
				Resource re=new Resource();
				
				re.setObjectId(bug.getBugId());
				re.setObjectType("bug");
				re.setResourceName(labels[i]);
				re.setResourceUrl("/source/bug/" + UUID.randomUUID() + "."
						+ filetype);
				
				aService.save(re);
				
				File destination = new File(destinationDir + UUID.randomUUID()
						+ "." + filetype);
				
				file.transferTo(destination);
			}
		}
		SendMailService email2 = new SendMailService("smtp.qq.com", 25, 0, true, "2424208347","1136822939",true);
		String url="尊敬的用户您好，"+user.getName()+"创建了新BUG，并抄送给了你请注意查收，点击<a href='http://localhost:8888/goDetailBug.htm?bugId="+bug.getBugId()+"'>这里</a>查看BuG详细信息<br>";
		try {
			email2.sendEmail(
					"2424208347@qq.com",
					"BUG管理系统",
						email1,
					"通知",url
					);
			request.setAttribute("note", "尊敬的用户您好，"+user.getName()+"创建了新BUG，并抄送给了你请注意查收");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("send fail");
			request.setAttribute("note", "尊敬的用户,很不幸的消息，由于网络故障，邮件发送失败。");
		}
		return new ModelAndView("redirect:bug.htm");
	}
	
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
	@RequestMapping(value = "showBug/{bugId}.htm", method = RequestMethod.GET)
	public String showBug(@PathVariable Integer bugId, ModelMap map) {
		
		Bug bug = aService.findById(Bug.class, bugId);
		
		List<History> histories = aService.queryAllOfCondition(History.class, 
				DetachedCriteria.forClass(History.class)
				.add(Restrictions.eq("objectType", "bug"))
				.add(Restrictions.eq("objectId", bug.getBugId()))
				.addOrder(Order.asc("operateTime")));
		List<Resource> resources = aService.queryAllOfCondition(Resource.class, 
				DetachedCriteria.forClass(Resource.class)
				.add(Restrictions.eq("objectType", "bug"))
				.add(Restrictions.eq("objectId", bug.getBugId()))
				.addOrder(Order.asc("resourceId")));
		
		map.put("bug", bug);
		map.put("histories", histories);
		map.put("resources", resources);
		
		return "bug/showBug";
	}
	
	@RequestMapping(value = "downloadResource.htm", method = RequestMethod.GET)
	public void downloadResource(HttpServletResponse response, @RequestParam Integer resourceId) throws IOException{
		
		Resource resource = aService.findById(Resource.class, resourceId);
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		String fileName = resource.getResourceUrl();
		response.setHeader("Content-Disposition", "attachment;fileName="
				+ fileName.substring(fileName.lastIndexOf("/") + 1));
		logger.info("download file name " + fileName.substring(fileName.lastIndexOf("/") + 1));
		InputStream inputStream = new FileInputStream(
				path + resource.getResourceUrl());
		OutputStream os = response.getOutputStream();
		byte[] b = new byte[1024];
		int length;
		while ((length = inputStream.read(b)) > 0) {
			os.write(b, 0, length);
		}
		inputStream.close();
	}
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
	@RequestMapping(value = "deleteResource.htm", method = RequestMethod.GET)
	public String deleteResource(@RequestParam Integer resourceId) {
		Resource resource = aService.findById(Resource.class, resourceId);
		Integer bugId = resource.getObjectId();
		File file = new File(path + resource.getResourceUrl());
		file.delete();
		aService.delete(resource);
		return "redirect:showBug.htm?bugId=" + bugId;
	}
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
	@RequestMapping(value = "addComment.htm", method = RequestMethod.POST)
	public void addBugComment(@RequestParam Integer objectId,
			@RequestParam String objectType, 
			@RequestParam String comment, 
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		History history = new History();
		Integer userId = (Integer) request.getSession().getAttribute("userId");
		logger.info("user id in session " + userId);
		history.setUser(aService.findById(User.class, userId));
		history.setObjectId(objectId);
		history.setObjectType(objectType);
		history.setOperateTime(new Date());
		history.setOperation("添加了备注");
		history.setComment(comment);
		aService.save(history);
		response.getWriter().write("success");
	}
	
	@Secured({"ROLE_TESTER"})
	@RequestMapping(value = "openBug.htm", method = RequestMethod.GET)
	public String openBug(HttpServletRequest request, @RequestParam Integer bugId){
		Bug bug = aService.findById(Bug.class, bugId);
		bug.setStatus("激活");
		bug.setResolution(null);
		aService.update(bug);
		
		History history = new History();
		Integer userId = (Integer) request.getSession().getAttribute("userId");
		logger.info("user id in session " + userId);
		history.setUser(aService.findById(User.class, userId));
		history.setObjectId(bug.getBugId());
		history.setObjectType("bug");
		history.setOperateTime(new Date());
		history.setOperation("激活");
		aService.save(history);
		
		return "redirect:showBug.htm?bugId=" + bugId;
	}
}
