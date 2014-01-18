package com.sicd.bugmanagement.business.usecaseDisplay.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

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

import com.sicd.bugmanagement.business.project.bean.ModuleBean;
import com.sicd.bugmanagement.business.usecaseDisplay.service.usecaseDisplayService;
import com.sicd.bugmanagement.common.bean.Module;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.Step;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.UserCase;
import com.sicd.bugmanagement.common.tag.pageTag.PageHelper;
import com.sicd.bugmanagement.utils.ModuleUtil;

@Controller
public class usecaseDisplayController {
	@Autowired
	private usecaseDisplayService ucdservice;


	

	@Secured({"ROLE_TESTER"})
	@SuppressWarnings("unchecked")
	@RequestMapping("usecase.htm")
	public ModelAndView usecase(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
		String curCol = ServletRequestUtils.getStringParameter(request, "curCol", "caseId");
		String order = ServletRequestUtils.getStringParameter(request, "order", "asc");

		String message = null;
		HttpSession hs = request.getSession();
		Project curProject = (Project) hs.getAttribute("curProject");

		List<UserCase> usercaselist = null;

		DetachedCriteria dCriteria = DetachedCriteria.forClass(UserCase.class);
		
		List<Integer> moduleIds = ModuleUtil.getModules(ucdservice, curProject);
		if(!moduleIds.isEmpty()) {
			dCriteria.add(Restrictions.in("module.moduleId", moduleIds));
		}

		int totalSize = ucdservice.countTotalSize(dCriteria);
		PageHelper.forPage(pageSize, totalSize, curCol, order);
		
		if(order.equals("asc")) {
			dCriteria.addOrder(Order.asc(curCol));
		} else {
			dCriteria.addOrder(Order.desc(curCol));
		}

		usercaselist = (List<UserCase>) ucdservice.getByPage(dCriteria,
				pageSize);

		if (usercaselist.isEmpty()) {
			message = "没有用例";
		}
		
		List<ModuleBean> moduleBeans = ModuleUtil.getModuleBean(ucdservice, curProject);
		
		ModelMap map=new ModelMap();
		map.put("message", message);
		map.put("usercaselist", usercaselist);
		map.put("moduleBeans", moduleBeans);

		return new ModelAndView("/usecase/usecase",map);

	}
	@Secured({"ROLE_TESTER"})
	@SuppressWarnings("unchecked")
	@RequestMapping("goModuleUseCase.htm")
	public ModelAndView goModuleUseCase(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize",20);
		
		String moduleId=request.getParameter("moduleId");
		Module module=ucdservice.findById(Module.class, Integer.parseInt(moduleId));
		String message = null;
		DetachedCriteria dCriteria=DetachedCriteria.forClass(UserCase.class);
		dCriteria.add(Restrictions.eq("module", module)).addOrder(Order.desc("createdAt"));
		
		int totalSize = ucdservice.countTotalSize(dCriteria);
		PageHelper.forPage(pageSize, totalSize);
		
		List<UserCase> usercaselist = (List<UserCase>) ucdservice.getByPage(dCriteria,pageSize);
		
		
		Project curProject = (Project) request.getSession().getAttribute("curProject");
		List<ModuleBean> moduleBeans = ModuleUtil.getModuleBean(ucdservice, curProject);
		
		if (usercaselist.isEmpty()) {
			message = "没有用例";
		}
		ModelMap map=new ModelMap();
		map.put("usercaselist", usercaselist);
		map.put("moduleBeans", moduleBeans);
		map.put("message", message);
		
		return new ModelAndView("/usecase/usecase",map);
	}

	@Secured({"ROLE_TESTER"})
	@RequestMapping("gocaseresult.htm")
	public ModelAndView gocaseresult(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		return new ModelAndView("/usecase/caseresult");
	}

	@Secured({"ROLE_TESTER"})
	@RequestMapping("caseresult.htm")
	public ModelAndView caseresult(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String caseId = request.getParameter("caseId");
		String nextcaseId = request.getParameter("nextcaseId");
		UserCase usercase = ucdservice.findById(UserCase.class,
				Integer.parseInt(caseId));
		DetachedCriteria dCriteria = DetachedCriteria.forClass(Step.class);
		dCriteria.add(Restrictions.eq("userCase", usercase)).addOrder(
				Order.asc("num"));
		List<Step> steps = ucdservice
				.queryAllOfCondition(Step.class, dCriteria);
		
		String result = usercase.getResult();
		if(result == null) {
			result = "n/a";
		}
		
		ModelMap map=new ModelMap();
		map.put("nextcaseId", nextcaseId);
		map.put("steps", steps);
		map.put("usercase", usercase);
		map.put("result", result);
		return new ModelAndView("/usecase/caseresults",map);
	}

	@Secured({"ROLE_TESTER"})
	@RequestMapping("goruncase.htm")
	public ModelAndView goruncase(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String caseId = request.getParameter("caseId");
		UserCase usercase = ucdservice.findById(UserCase.class,
				Integer.parseInt(caseId));
		DetachedCriteria dCriteria = DetachedCriteria.forClass(Step.class);
		dCriteria.add(Restrictions.eq("userCase", usercase)).addOrder(
				Order.asc("num"));
		List<Step> steps = ucdservice
				.queryAllOfCondition(Step.class, dCriteria);
		
		String result = usercase.getResult();
		if(result == null) {
			result = "n/a";
		}
		ModelMap map=new ModelMap();
		map.put("steps", steps);
		map.put("usercase", usercase);
		map.put("result", result);
		return new ModelAndView("/usecase/runcase",map);
	}

	@Secured({"ROLE_TESTER"})
	@RequestMapping("runcase.htm")
	public ModelAndView runcase(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String submit = request.getParameter("submit1");
		HttpSession hs = request.getSession();
		User user = (User) hs.getAttribute("user");
		String caseId = request.getParameter("caseId");
		int stepslength = Integer.parseInt(request.getParameter("stepslength"));
		Step step;
		List<Step> steps = new ArrayList<Step>();
		
		System.out.println("submit" + submit);
		int pass = 0, fail = 0, blocked = 0;
		for (int i = 0; i < stepslength; i++) {
			step = ucdservice.findById(
					Step.class,
					Integer.parseInt(request.getParameter("stepId[" + (i + 1)
							+ "]")));
			step.setReality(request.getParameter("reals[" + (i + 1) + "]"));
			step.setResult(request.getParameter("steps[" + (i + 1) + "]"));
			steps.add(step);
			switch (request.getParameter("steps[" + (i + 1) + "]")) {
			case "通过":
				pass++;
				break;
			case "失败":
				fail++;
				break;
			case "阻塞":
				blocked++;
				break;
			default:

				break;
			}
			System.out.println("stepstepstepstepstepstepstepstep" + step);
			step = null;
		}
		String result = null;
		if (blocked > 0) {
			result = "阻塞";
		} else if (fail > 0) {
			result = "失败";
		} else if (pass > 0) {
			result = "通过";
		} else {

		}
		ucdservice.updateAll(steps);
		UserCase usercase = ucdservice.findById(UserCase.class,
				Integer.parseInt(caseId));
		if (result != null) {
			usercase.setResult(result);
		}
		usercase.setRunner(user.getTester());
		usercase.setStatus("正常");
		ucdservice.update(usercase);
		String data = "ok";
		PrintWriter pw = response.getWriter();
		pw.println(data);
		return new ModelAndView("/usecase/usecase");

	}

	@Secured({"ROLE_TESTER"})
	@RequestMapping("runcase2.htm")
	public ModelAndView runcase2(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		HttpSession hs = request.getSession();
		User user = (User) hs.getAttribute("user");
		String caseId = request.getParameter("caseId");
		int stepslength = Integer.parseInt(request.getParameter("stepslength"));
		Step step;
		List<Step> steps = new ArrayList<Step>();
		
		
		for (int i = 0; i < stepslength; i++) {
			step = ucdservice.findById(
					Step.class,
					Integer.parseInt(request.getParameter("stepId[" + (i + 1)
							+ "]")));
			step.setReality(request.getParameter("reals[" + (i + 1) + "]"));
			step.setResult("通过");
			steps.add(step);
			step = null;

		}

		String result = "通过";
		ucdservice.updateAll(steps);
		UserCase usercase = ucdservice.findById(UserCase.class,
				Integer.parseInt(caseId));

		usercase.setResult(result);

		usercase.setRunner(user.getTester());
		ucdservice.update(usercase);
		String data = "ok";
		PrintWriter pw = response.getWriter();
		pw.println(data);
		return new ModelAndView("/usecase/usecase");

	}

}
