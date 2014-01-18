package com.sicd.bugmanagement.business.bugdisplay.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import com.sicd.bugmanagement.business.bugdisplay.service.BugDisplayService;
import com.sicd.bugmanagement.business.project.bean.ModuleBean;
import com.sicd.bugmanagement.common.bean.AffectedVersion;
import com.sicd.bugmanagement.common.bean.Bug;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Developer;
import com.sicd.bugmanagement.common.bean.Dictionary;
import com.sicd.bugmanagement.common.bean.History;
import com.sicd.bugmanagement.common.bean.Module;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.Version;
import com.sicd.bugmanagement.common.tag.pageTag.PageHelper;
import com.sicd.bugmanagement.utils.ModuleUtil;


@Controller
public class BugDisplayController {
	@Autowired
	private BugDisplayService bdservice;
	
	@Secured({"ROLE_DEVELOPER","ROLE_TESTER"})
	@RequestMapping("gobug.htm")
	public ModelAndView gobug(HttpServletRequest req){
		
		Project curProject = (Project) req.getSession().getAttribute("curProject");
		List<ModuleBean> moduleBeans = ModuleUtil.getModuleBean(bdservice, curProject);
		
		ModelMap map=new ModelMap();
		map.put("moduleBeans", moduleBeans);
		return new ModelAndView("/bug/bug",map);
	}
	@Secured({"ROLE_DEVELOPER"})
	@RequestMapping("gobugconfirmbug.htm")
	public ModelAndView gobugconfirmbug(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String bugId=request.getParameter("bugId");
		ModelMap map = new ModelMap();
		HttpSession hs=request.getSession();
		Company com=(Company) hs.getAttribute("company");
		DetachedCriteria dCriteria=DetachedCriteria.forClass(History.class);
		dCriteria.add(Restrictions.eq("objectId",Integer.parseInt(bugId))).addOrder(Order.asc("operateTime"));
		List<History> historylist=bdservice.queryAllOfCondition(History.class, dCriteria);
		map.put("historylist", historylist);
		List<Developer> developers=bdservice.findUseByCompany(com);
		map.put("developers", developers);
		map.put("bug", (Bug)bdservice.findById(Bug.class, Integer.parseInt(bugId)));
		

		return new ModelAndView("/bug/bugconfirmbug",map);
	}
	@Secured({"ROLE_DEVELOPER"})
	@RequestMapping("bugconfirmbug.htm")
	public ModelAndView bugconfirmbug(HttpServletRequest request,HttpServletResponse response) throws Exception{

		String bugId=request.getParameter("bugId");
		String priority=request.getParameter("pri");
		HttpSession hs=request.getSession();
		User user=(User) hs.getAttribute("user");
		String comment=request.getParameter("comment");
			
			if(priority.isEmpty()){
			Bug bug=(Bug)bdservice.findById(Bug.class,Integer.parseInt(bugId));
			bug.setConfirm(true);
			bug.setPriority(Integer.parseInt(priority));
			bdservice.update(bug);
			History history=new History();
			if(!comment.isEmpty()){
				history.setComment(comment);
			}	
			history.setObjectType("bug");
			history.setObjectId(bug.getBugId());
			history.setUser(user);
			history.setOperateTime(new Date());
			history.setOperation("由"+user.getRealName()+"确认");
			bdservice.save(history);
			String data="ok";
			PrintWriter  pw = response.getWriter(); 
			pw.println(data);
			
			return new ModelAndView("forward:bug.htm");
		}
		Bug bug=(Bug)bdservice.findById(Bug.class,Integer.parseInt(bugId));
		bug.setConfirm(true);
		bug.setPriority(Integer.parseInt(priority));
		bdservice.update(bug);
		History history=new History();
		if(!comment.isEmpty()){
			history.setComment(comment);
		}		
		history.setObjectType("bug");
		history.setObjectId(bug.getBugId());
		history.setUser(user);
		history.setOperateTime(new Date());
		history.setOperation("由"+user.getRealName()+"确认");
		bdservice.save(history);
		String data="ok";
		PrintWriter  pw = response.getWriter(); 
		pw.println(data);
		return new ModelAndView("forward:bug.htm");
	}
	@Secured({"ROLE_DEVELOPER"})
	@RequestMapping("gobugresolve.htm")
	public ModelAndView gobugresolve(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String bugId=request.getParameter("bugId");
		HttpSession hs=request.getSession();
		Project project=(Project) hs.getAttribute("project");
		DetachedCriteria dCriteria = DetachedCriteria.forClass(Version.class);
		dCriteria.add(Restrictions.eq("project", project)).addOrder(Order.asc("createdAt"));
		Company com=(Company) hs.getAttribute("company");
		dCriteria = DetachedCriteria.forClass(Dictionary.class);
		dCriteria.add(Restrictions.eq("dictionaryKey", "resolution"));
		List<Dictionary> resolutionlist=bdservice.queryAllOfCondition(Dictionary.class, dCriteria);
		List<Developer> developers=bdservice.findUseByCompany(com);
		dCriteria = DetachedCriteria.forClass(History.class);
		dCriteria.add(Restrictions.eq("objectId",Integer.parseInt(bugId))).addOrder(Order.asc("operateTime"));
		List<History> historylist=bdservice.queryAllOfCondition(History.class, dCriteria);
		ModelMap map = new ModelMap();
		map.put("historylist", historylist);
		map.put("resolutionlist", resolutionlist);
		map.put("developers", developers);
		map.put("bug", (Bug)bdservice.findById(Bug.class, Integer.parseInt(bugId)));
		
		return new ModelAndView("/bug/bugresolve",map);
	}
	@Secured({"ROLE_DEVELOPER"})
	@RequestMapping("bugresolve.htm")
	public ModelAndView bugresolve(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String bugId=request.getParameter("bugId");
		String resolution=request.getParameter("resolution");
		String comment=request.getParameter("comment");
		Bug bug=(Bug)bdservice.findById(Bug.class,Integer.parseInt(bugId));
		HttpSession hs=request.getSession();
		User user=(User) hs.getAttribute("user");
		if(bug.getAssignedTo()==null){
			String data="ok";
			PrintWriter  pw = response.getWriter(); 
			pw.println(data);
			return new ModelAndView("forward:bug.htm");
		}
		if(resolution==null||resolution.isEmpty()){
			String data="ok";
			PrintWriter  pw = response.getWriter(); 
			pw.println(data);
			return new ModelAndView("forward:bug.htm");
		}
		else{
			
			bug.setStatus("已解决");
			bug.setConfirm(true);
			bug.setResolution(resolution);
			bdservice.update(bug);
			History history=new History();
			history.setComment(comment);
			history.setObjectType("bug");
			history.setObjectId(bug.getBugId());
			history.setUser(user);
			history.setOperateTime(new Date());
			history.setOperation("由"+user.getRealName()+"解决, 解决方案为"+resolution);
			bdservice.save(history);
			String data="ok";
			PrintWriter  pw = response.getWriter(); 
			pw.println(data);
			return new ModelAndView("forward:bug.htm");
		}
		
		
		
	}
	@Secured({"ROLE_TESTER"})
	@RequestMapping("gobugclose.htm")
	public ModelAndView gobugclose(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String bugId=request.getParameter("bugId");
		HttpSession hs=request.getSession();
		Company com=(Company) hs.getAttribute("company");
		DetachedCriteria dCriteria=DetachedCriteria.forClass(History.class);
		dCriteria.add(Restrictions.eq("objectId",Integer.parseInt(bugId))).addOrder(Order.asc("operateTime"));
		List<History> historylist=bdservice.queryAllOfCondition(History.class, dCriteria);
		ModelMap map = new ModelMap();
		map.put("historylist", historylist);
		List<Developer> developers=bdservice.findUseByCompany(com);
		map.put("developers", developers);
		map.put("bug", (Bug)bdservice.findById(Bug.class, Integer.parseInt(bugId)));
		
		
		return new ModelAndView("/bug/bugclose",map);
	}
	@Secured({"ROLE_TESTER"})
	@RequestMapping("bugclose.htm")
	public ModelAndView bugclose(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String bugId=request.getParameter("bugId");
		String comment=request.getParameter("comment");
		HttpSession hs=request.getSession();
		User user=(User) hs.getAttribute("user");
		Bug bug=(Bug)bdservice.findById(Bug.class, Integer.parseInt(bugId));
		if(comment.isEmpty()){
			History history=new History();
			history.setComment(comment);
			history.setObjectType("bug");
			history.setObjectId(bug.getBugId());
			history.setUser(user);
			history.setOperateTime(new Date());
			history.setOperation("由"+user.getRealName()+"关闭");
			bdservice.save(history);
			String data="ok";
			PrintWriter  pw = response.getWriter(); 
			pw.println(data);
			
			return new ModelAndView("forward:bug.htm");
		}else{
			bug=(Bug)bdservice.findById(Bug.class, Integer.parseInt(bugId));
            bug.setStatus("关闭");
			bdservice.update(bug);
			History history=new History();
			history.setComment(comment);
			history.setObjectType("bug");
			history.setObjectId(bug.getBugId());
			history.setUser(user);
			history.setOperateTime(new Date());
			history.setOperation("由"+user.getRealName()+"关闭");
			bdservice.save(history);
			String data="ok";
			PrintWriter  pw = response.getWriter(); 
			pw.println(data);
			
			return new ModelAndView("forward:bug.htm");
		}
		
	}

	@Secured({"ROLE_DEVELOPER","ROLE_TESTER"})
	@RequestMapping("gobugAssignTo.htm")
	public ModelAndView gobugAssignTo(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String bugId=request.getParameter("bugId");
		HttpSession hs=request.getSession();
		Company com=(Company) hs.getAttribute("company");
		DetachedCriteria dCriteria=DetachedCriteria.forClass(History.class);
		dCriteria.add(Restrictions.eq("objectId",Integer.parseInt(bugId))).addOrder(Order.asc("operateTime"));
		List<History> historylist=bdservice.queryAllOfCondition(History.class, dCriteria);
		ModelMap map = new ModelMap();
		map.put("historylist", historylist);
		List<Developer> developers=bdservice.findUseByCompany(com);
		map.put("developers", developers);
		map.put("bug", (Bug)bdservice.findById(Bug.class, Integer.parseInt(bugId)));
		return new ModelAndView("/bug/bugAssignTo",map);
	}
	@Secured({"ROLE_DEVELOPER","ROLE_TESTER"})
	@RequestMapping("bugAssignTo.htm")
	public ModelAndView bugAssignTo(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String developeruser=request.getParameter("assignedTo");
		String bugId=request.getParameter("bugId");
		String comment=request.getParameter("comment");
		HttpSession hs=request.getSession();
		User user=(User) hs.getAttribute("user");
		if(developeruser.isEmpty()){
			return new ModelAndView("forward:bug.htm");
		}
		
		Bug bug=(Bug)bdservice.findById(Bug.class, Integer.parseInt(bugId));
		Developer developer=(Developer) bdservice.findById(Developer.class, Integer.parseInt(developeruser));
		bug.setAssignedTo(developer);
		bdservice.update(bug);
		History history2=new History();
		history2.setComment(comment);
		history2.setObjectType("bug");
		history2.setObjectId(bug.getBugId());
		history2.setUser(user);
		history2.setOperateTime(new Date());
		history2.setOperation("由"+user.getRealName()+"指派给："+developer.getUser().getRealName());
		bdservice.save(history2);
		String data="ok";
		PrintWriter  pw = response.getWriter(); 
		pw.println(data);
		return new ModelAndView("forward:bug.htm");
		
	}
	@Secured({"ROLE_DEVELOPER","ROLE_TESTER"})
	@SuppressWarnings("unchecked")
	@RequestMapping("bug.htm")
	public ModelAndView bug(HttpServletRequest request,HttpServletResponse response){
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
		String curCol = ServletRequestUtils.getStringParameter(request, "curCol", "bugId");
		String order = ServletRequestUtils.getStringParameter(request, "order", "asc");
		
		ModelMap map = new ModelMap();
		String message=null;
		HttpSession hs=request.getSession();

		Project project = (Project) hs.getAttribute("curProject");

		List<Bug> buglist = null;
		
		if(project==null){
			message="noproject";
			System.out.println("messagemessagemessagemessagemessagemessagemessagemessagemessage"+message);
			map.put("message", message);
			map.put("buglsit", buglist);
		}else{

			DetachedCriteria dCriteria = DetachedCriteria.forClass(Bug.class);
			
			List<Integer> moduleIds = ModuleUtil.getModules(bdservice, project);
			if(!moduleIds.isEmpty()) {
				dCriteria.add(Restrictions.in("module.moduleId", moduleIds));
			}
			
			int totalSize = bdservice.countTotalSize(dCriteria);
			PageHelper.forPage(pageSize, totalSize, curCol, order);
			
			if(order.equals("asc")) {
				dCriteria.addOrder(Order.asc(curCol));
			} else {
				dCriteria.addOrder(Order.desc(curCol));
			}
			
			buglist = (List<Bug>) bdservice.getByPage(dCriteria, pageSize);
			
			if(buglist.isEmpty()){
				message="该项目还未添加BUG";
			}
			
			map.put("message", message);
			map.put("buglistx", buglist);
		}
		
		return new ModelAndView("forward:gobug.htm",map);
	}
	
	@Secured({"ROLE_DEVELOPER","ROLE_TESTER"})
	@SuppressWarnings("unchecked")
	@RequestMapping("VersionToBug.htm")
	public ModelAndView VersionToBug(HttpServletRequest request,HttpServletResponse response){
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
		String curCol = ServletRequestUtils.getStringParameter(request, "curCol", "bugId");
		String order = ServletRequestUtils.getStringParameter(request, "order", "asc");
		
		String versionId=request.getParameter("versionId");
		Version version=bdservice.findById(Version.class, Integer.parseInt(versionId));
		
		DetachedCriteria dCriteria=DetachedCriteria.forClass(AffectedVersion.class);
		dCriteria.add(Restrictions.eq("version", version));
		
		int totalSize = bdservice.countTotalSize(dCriteria);
		Map<String, Object> urlmap = new HashMap<String, Object>();
		urlmap.put("versionId", versionId);
		PageHelper.forPage(pageSize, urlmap, totalSize, curCol, order);
		
		if(order.equals("asc")) {
			dCriteria.addOrder(Order.asc(curCol));
		} else {
			dCriteria.addOrder(Order.desc(curCol));
		}
		List<AffectedVersion> afversionList = (List<AffectedVersion>) bdservice.getByPage(dCriteria, pageSize);
		
		List<Bug> buglist = new ArrayList<Bug>();
		for (AffectedVersion aversion : afversionList) {
			buglist.add(aversion.getBug());
		}
		
		return new ModelAndView("forward:gobug.htm","buglistx", buglist);
	}
	@Secured({"ROLE_DEVELOPER","ROLE_TESTER"})
	@SuppressWarnings("unchecked")
	@RequestMapping("goModuleBug.htm")
	public ModelAndView goModuleBug(HttpServletRequest request,HttpServletResponse response){
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
		String curCol = ServletRequestUtils.getStringParameter(request, "curCol", "bugId");
		String order = ServletRequestUtils.getStringParameter(request, "order", "asc");
		
		String message=null;
		String ModuleId=request.getParameter("moduleId");
		Module module=bdservice.findById(Module.class, Integer.parseInt(ModuleId));
		List<Bug> buglist = null;
		ModelMap map = new ModelMap();
		DetachedCriteria countCriteria = DetachedCriteria.forClass(Bug.class);
		countCriteria.add(Restrictions.eq("module", module)).addOrder(Order.desc("createdAt"));
		int totalSize = bdservice.countTotalSize(countCriteria);
		PageHelper.forPage(pageSize, totalSize, curCol, order);
		
		if(order.equals("asc")) {
			countCriteria.addOrder(Order.asc(curCol));
		} else {
			countCriteria.addOrder(Order.desc(curCol));
		}
		buglist = (List<Bug>) bdservice.getByPage(countCriteria, pageSize);
			
		if(buglist.isEmpty()){
			message="未添加BUG";
		}
			
		List<Project> projlist = (List<Project>) request.getAttribute("projects");
			
		map.put("projlist", projlist);
		map.put("message", message);
		map.put("buglistx", buglist);
		return new ModelAndView("forward:gobug.htm",map);
	}
	@Secured({"ROLE_DEVELOPER"})
	@SuppressWarnings("unchecked")
	@RequestMapping("bugassigntome.htm")
	public ModelAndView bugassigntome(HttpServletRequest request,HttpServletResponse response){
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
		String curCol = ServletRequestUtils.getStringParameter(request, "curCol", "bugId");
		String order = ServletRequestUtils.getStringParameter(request, "order", "asc");
		
		ModelMap map=new ModelMap();
		String message=null;
		HttpSession hs=request.getSession();
		
		Integer userId = (Integer) hs.getAttribute("userId");
		Project project = (Project) hs.getAttribute("curProject");

		List<Bug> buglist = null;
		
		if(project==null){
			message="noproject";
			System.out.println("messagemessagemessagemessagemessagemessagemessagemessagemessage"+message);
			map.put("message", message);
			map.put("buglsit", buglist);
		}else{

			DetachedCriteria dCriteria = DetachedCriteria.forClass(Bug.class)
					.add(Restrictions.eq("assignedTo.developerId", userId));
			
			List<Integer> moduleIds = ModuleUtil.getModules(bdservice, project);
			if(!moduleIds.isEmpty()) {
				dCriteria.add(Restrictions.in("module.moduleId", moduleIds));
			}
			
			int totalSize = bdservice.countTotalSize(dCriteria);
			PageHelper.forPage(pageSize, totalSize, curCol, order);
			
			if(order.equals("asc")) {
				dCriteria.addOrder(Order.asc(curCol));
			} else {
				dCriteria.addOrder(Order.desc(curCol));
			}
			buglist = (List<Bug>) bdservice.getByPage(dCriteria, pageSize);
			
			if(buglist.isEmpty()){
				message="没有BUG";
			}
			
			map.put("message", message);
			map.put("buglistx", buglist);
		}
		return new ModelAndView("forward:gobug.htm",map);
	}
	
	@Secured({"ROLE_DEVELOPER","ROLE_TESTER"})
	@SuppressWarnings("unchecked")
	@RequestMapping("bugopenedbyme.htm")
	public ModelAndView bugopenedbyme(HttpServletRequest request,HttpServletResponse response){
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
		String curCol = ServletRequestUtils.getStringParameter(request, "curCol", "bugId");
		String order = ServletRequestUtils.getStringParameter(request, "order", "asc");
		
		String message=null;
		HttpSession hs=request.getSession();
		ModelMap map=new ModelMap();
		Integer userId = (Integer) hs.getAttribute("userId");
		Project project = (Project) hs.getAttribute("curProject");
		
		List<Bug> buglist = null;
		
		if(project==null){
			message="noproject";
			System.out.println("messagemessagemessagemessagemessagemessagemessagemessagemessage"+message);
			map.put("message", message);
			map.put("buglsit", buglist);
		}else{
			
			DetachedCriteria dCriteria = DetachedCriteria.forClass(Bug.class)
					.add(Restrictions.eq("creator.userId", userId));
			
			List<Integer> moduleIds = ModuleUtil.getModules(bdservice, project);
			if(!moduleIds.isEmpty()) {
				dCriteria.add(Restrictions.in("module.moduleId", moduleIds));
			}
			
			int totalSize = bdservice.countTotalSize(dCriteria);
			PageHelper.forPage(pageSize, totalSize, curCol, order);
			
			if(order.equals("asc")) {
				dCriteria.addOrder(Order.asc(curCol));
			} else {
				dCriteria.addOrder(Order.desc(curCol));
			}
			buglist = (List<Bug>) bdservice.getByPage(dCriteria, pageSize);
			
			if(buglist.isEmpty()){
				message="该项目还未添加BUG";
			}
			
			map.put("message", message);
			map.put("buglistx", buglist);
		}
		return new ModelAndView("forward:gobug.htm",map);
	
	}
	
	@Secured({"ROLE_DEVELOPER"})
	@SuppressWarnings("unchecked")
	@RequestMapping("bugresolvedbyme.htm")
	public ModelAndView bugresolvedbyme(HttpServletRequest request,HttpServletResponse response){
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
		String curCol = ServletRequestUtils.getStringParameter(request, "curCol", "bugId");
		String order = ServletRequestUtils.getStringParameter(request, "order", "asc");
		
		ModelMap map=new ModelMap();
		String message=null;
		HttpSession hs=request.getSession();
		
		Integer userId = (Integer) hs.getAttribute("userId");
		Project project = (Project) hs.getAttribute("curProject");
		
		List<Bug> buglist = null;
		
		if(project==null){
			message="noproject";
			System.out.println("messagemessagemessagemessagemessagemessagemessagemessagemessage"+message);
			map.put("message", message);
			map.put("buglsit", buglist);
		}else{
			
			DetachedCriteria dCriteria = DetachedCriteria.forClass(Bug.class)
					.add(Restrictions.eq("assignedTo.developerId", userId))
					.add(Restrictions.eq("status", "已解决"));
			
			List<Integer> moduleIds = ModuleUtil.getModules(bdservice, project);
			if(!moduleIds.isEmpty()) {
				dCriteria.add(Restrictions.in("module.moduleId", moduleIds));
			}
			
			int totalSize = bdservice.countTotalSize(dCriteria);
			PageHelper.forPage(pageSize, totalSize, curCol, order);
			
			if(order.equals("asc")) {
				dCriteria.addOrder(Order.asc(curCol));
			} else {
				dCriteria.addOrder(Order.desc(curCol));
			}
			buglist = (List<Bug>) bdservice.getByPage(dCriteria, pageSize);
			
			if(buglist.isEmpty()){
				message="该项目还未添加BUG";
			}
			
			map.put("message", message);
			map.put("buglistx", buglist);
			
		}
		return new ModelAndView("forward:gobug.htm",map);
	}

	@Secured({"ROLE_DEVELOPER","ROLE_TESTER"})
	@SuppressWarnings("unchecked")
	@RequestMapping("bugassigntonull.htm")
	public ModelAndView bugassigntonull(HttpServletRequest request,HttpServletResponse response){
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
		String curCol = ServletRequestUtils.getStringParameter(request, "curCol", "bugId");
		String order = ServletRequestUtils.getStringParameter(request, "order", "asc");
		
		ModelMap map=new ModelMap();
		String message=null;
		HttpSession hs=request.getSession();

		Project project = (Project) hs.getAttribute("curProject");
		List<Bug> buglist = null;
		
		if(project==null){
			message="noproject";
			System.out.println("messagemessagemessagemessagemessagemessagemessagemessagemessage"+message);
			map.put("message", message);
			map.put("buglsit", buglist);
		}else{
			
			DetachedCriteria dCriteria = DetachedCriteria.forClass(Bug.class)
					.add(Restrictions.isNull("assignedTo"));
			
			List<Integer> moduleIds = ModuleUtil.getModules(bdservice, project);
			if(!moduleIds.isEmpty()) {
				dCriteria.add(Restrictions.in("module.moduleId", moduleIds));
			}
			
			int totalSize = bdservice.countTotalSize(dCriteria);
			PageHelper.forPage(pageSize, totalSize, curCol, order);
			
			if(order.equals("asc")) {
				dCriteria.addOrder(Order.asc(curCol));
			} else {
				dCriteria.addOrder(Order.desc(curCol));
			}
			buglist = (List<Bug>) bdservice.getByPage(dCriteria, pageSize);
			
			if(buglist.isEmpty()){
				message="该项目还未添加BUG";
			}
			
			map.put("message", message);
			map.put("buglistx", buglist);
		}
		
		return new ModelAndView("forward:gobug.htm",map);
	}
	@Secured({"ROLE_DEVELOPER","ROLE_TESTER"})
	@SuppressWarnings("unchecked")
	@RequestMapping("bugunresolved.htm")
	public ModelAndView bugunresolved(HttpServletRequest request,HttpServletResponse response){
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
		String curCol = ServletRequestUtils.getStringParameter(request, "curCol", "bugId");
		String order = ServletRequestUtils.getStringParameter(request, "order", "asc");
		
		ModelMap map=new ModelMap();
		String message=null;
		HttpSession hs=request.getSession();

		Project project = (Project) hs.getAttribute("curProject");
		List<Bug> buglist = null;
		
		if(project==null){
			message="noproject";
			System.out.println("messagemessagemessagemessagemessagemessagemessagemessagemessage"+message);
			map.put("message", message);
			map.put("buglsit", buglist);
		}else{
			
			DetachedCriteria dCriteria = DetachedCriteria.forClass(Bug.class)
					.add(Restrictions.eq("status", "激活"));
			
			List<Integer> moduleIds = ModuleUtil.getModules(bdservice, project);
			if(!moduleIds.isEmpty()) {
				dCriteria.add(Restrictions.in("module.moduleId", moduleIds));
			}
			
			int totalSize = bdservice.countTotalSize(dCriteria);
			PageHelper.forPage(pageSize, totalSize, curCol, order);
			
			if(order.equals("asc")) {
				dCriteria.addOrder(Order.asc(curCol));
			} else {
				dCriteria.addOrder(Order.desc(curCol));
			}
			buglist = (List<Bug>) bdservice.getByPage(dCriteria, pageSize);
			
			if(buglist.isEmpty()){
				message="该项目还未添加BUG";
			}

			map.put("message", message);
			map.put("buglistx", buglist);
		}
		return new ModelAndView("forward:gobug.htm",map);
	}
	@Secured({"ROLE_DEVELOPER","ROLE_TESTER"})
	@SuppressWarnings("unchecked")
	@RequestMapping("bugunclosed.htm")
	public ModelAndView bugunclosed(HttpServletRequest request,HttpServletResponse response){
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
		String curCol = ServletRequestUtils.getStringParameter(request, "curCol", "bugId");
		String order = ServletRequestUtils.getStringParameter(request, "order", "asc");
		
		ModelMap map=new ModelMap();
		String message=null;
		HttpSession hs=request.getSession();

		Project project = (Project) hs.getAttribute("curProject");
		List<Bug> buglist = null;
		
		if(project==null){
			message="noproject";
			System.out.println("messagemessagemessagemessagemessagemessagemessagemessagemessage"+message);
			map.put("message", message);
			map.put("buglsit", buglist);
		}else{
			
			DetachedCriteria dCriteria = DetachedCriteria.forClass(Bug.class)
					.add(Restrictions.ne("status", "关闭"));
			
			List<Integer> moduleIds = ModuleUtil.getModules(bdservice, project);
			if(!moduleIds.isEmpty()) {
				dCriteria.add(Restrictions.in("module.moduleId", moduleIds));
			}
			
			int totalSize = bdservice.countTotalSize(dCriteria);
			PageHelper.forPage(pageSize, totalSize, curCol, order);
			
			if(order.equals("asc")) {
				dCriteria.addOrder(Order.asc(curCol));
			} else {
				dCriteria.addOrder(Order.desc(curCol));
			}
			buglist = (List<Bug>) bdservice.getByPage(dCriteria, pageSize);
			
			if(buglist.isEmpty()){
				message="该项目还未添加BUG";
			}

			map.put("message", message);
			map.put("buglistx", buglist);
		}
		return new ModelAndView("forward:gobug.htm",map);
	}
	@Secured({"ROLE_DEVELOPER","ROLE_TESTER"})
	@SuppressWarnings("unchecked")
	@RequestMapping("buglonglifebugs.htm")
	public ModelAndView buglonglifebugs(HttpServletRequest request,HttpServletResponse response){
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
		String curCol = ServletRequestUtils.getStringParameter(request, "curCol", "bugId");
		String order = ServletRequestUtils.getStringParameter(request, "order", "asc");
		
		ModelMap map=new ModelMap();
		String message=null;
		HttpSession hs=request.getSession();

		Project project = (Project) hs.getAttribute("curProject");
		List<Bug> buglist = null;
		
		if(project==null){
			message="noproject";
			System.out.println("messagemessagemessagemessagemessagemessagemessagemessagemessage"+message);
			map.put("message", message);
			map.put("buglsit", buglist);
		}else{
			long DAY_IN_MS = 1000 * 60 * 60 * 24;
			DetachedCriteria dCriteria = DetachedCriteria.forClass(Bug.class)
					.add(Restrictions.lt("createdAt", new Date(System.currentTimeMillis() - (5 * DAY_IN_MS))));
			
			List<Integer> moduleIds = ModuleUtil.getModules(bdservice, project);
			if(!moduleIds.isEmpty()) {
				dCriteria.add(Restrictions.in("module.moduleId", moduleIds));
			}
			
			int totalSize = bdservice.countTotalSize(dCriteria);
			PageHelper.forPage(pageSize, totalSize, curCol, order);
			
			if(order.equals("asc")) {
				dCriteria.addOrder(Order.asc(curCol));
			} else {
				dCriteria.addOrder(Order.desc(curCol));
			}
			buglist = (List<Bug>) bdservice.getByPage(dCriteria, pageSize);
			
			if(buglist.isEmpty()){
				message="该项目还未添加BUG";
			}

			map.put("message", message);
			map.put("buglistx", buglist);
		}
		return new ModelAndView("forward:gobug.htm",map);
	}
	

}
