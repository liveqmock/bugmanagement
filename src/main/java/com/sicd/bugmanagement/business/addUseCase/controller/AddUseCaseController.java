package com.sicd.bugmanagement.business.addUseCase.controller;

import java.io.File;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sicd.bugmanagement.business.addUseCase.service.AddUseCaseService;
import com.sicd.bugmanagement.business.project.bean.ModuleBean;
import com.sicd.bugmanagement.common.bean.Bug;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.History;
import com.sicd.bugmanagement.common.bean.Module;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.Resource;
import com.sicd.bugmanagement.common.bean.Step;
import com.sicd.bugmanagement.common.bean.Tester;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.UserCase;
import com.sicd.bugmanagement.utils.ModuleUtil;



@Controller
public class AddUseCaseController {

	
	@Autowired
	private AddUseCaseService aService;
	
	@Secured({"ROLE_TESTER"})
	@RequestMapping("goAddUseCase.htm")
	public ModelAndView goAddUseCase(HttpServletRequest request){
		
		Project project=(Project) request.getSession().getAttribute("curProject");
			
		Company company=(Company) request.getSession().getAttribute("company");
		DetachedCriteria dCriteria=DetachedCriteria.forClass(Project.class);
		dCriteria.add(Restrictions.eq("company",company)).add(Restrictions.ne ("projectId", project.getProjectId()));		
		List<Project> projectList=aService.queryAllOfCondition(Project.class, dCriteria);
			
			
		List<ModuleBean> modulebean = ModuleUtil.getModuleNameList(aService, project);
			
		request.setAttribute("modulebean", modulebean);
		return new ModelAndView("/usecase/addUseCase","projectList",projectList);
	}
	@Secured({"ROLE_TESTER"})
	@RequestMapping("AddUseCase.htm")
	public ModelAndView AddUseCase(HttpServletRequest request) throws Exception{
		
		User user=(User) request.getSession().getAttribute("user");
		
		String destinationDir = "E:\\workplace\\bugmanagement\\src\\main\\webapp\\source\\usercase\\";

		MultipartHttpServletRequest multipartReq = (MultipartHttpServletRequest) request;
		
		String module1=multipartReq.getParameter("module");
		String type=multipartReq.getParameter("type");
		
		String pri=multipartReq.getParameter("pri");
		String title=multipartReq.getParameter("title");
		String precondition=multipartReq.getParameter("precondition");
		String keywords=multipartReq.getParameter("keywords");
		String[] steps=(String[])multipartReq.getParameterValues("steps");
		String[] expects=(String[])multipartReq.getParameterValues("expects");
		String[] stages=(String[])multipartReq.getParameterValues("stage");
		
		
		String stage="";
		
		for(int j=0;j<stages.length;j++){
			if(j==(stages.length-1)){
				
				stage=stage+stages[j];
			}else{
				stage=stage+stages[j]+";";
			}
			
			
		}
		Module module=aService.findById(Module.class, Integer.parseInt(module1));
		Tester tester=aService.findById(Tester.class,user.getUserId());
		
		UserCase uc=new UserCase();
		uc.setCaseType(type);
		uc.setCreatedAt(new Date());
		uc.setCreator(tester);
		uc.setKeyword(keywords);
		uc.setModule(module);
		uc.setPrecondition(precondition);
		uc.setPriority(Integer.parseInt(pri));
		uc.setStage(stage);
		uc.setTitle(title);
		uc.setStatus("未开始");
		aService.save(uc);
		
		for(int i=0;i<steps.length;i++){
			if(!steps[i].isEmpty()) {
				Step step=new Step();
				step.setUserCase(uc);
				step.setExpect(expects[i]);
				step.setNum(i+1);
				step.setContent(steps[i]);
				aService.save(step);
			}
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
				
				re.setObjectId(uc.getCaseId());
				re.setObjectType("usercase");
				re.setResourceName(labels[i]);
				re.setResourceUrl("/source/usercase/" + uuid + "."
						+ filetype);
				
				aService.save(re);
				
				File destination = new File(destinationDir + uuid
						+ "." + filetype);
				
				file.transferTo(destination);
			}
		}
		History hs=new History();
		hs.setUser(user);
		hs.setObjectId(uc.getCaseId());
		hs.setObjectType("usercase");
		hs.setOperateTime(new Date());
		hs.setOperation("创建");
		aService.save(hs);
		
		return new ModelAndView("redirect:usecase.htm");
	}
	
	@Secured({"ROLE_TESTER"})
	@RequestMapping("goCopyUserCase.htm")
	public ModelAndView goCopyUserCase(HttpServletRequest request){
		String userCaseId=request.getParameter("usercaseId");
		UserCase userCase=aService.findById(UserCase.class, Integer.parseInt(userCaseId));
		
		
		Company company=(Company) request.getSession().getAttribute("company");
		DetachedCriteria dCriteria=DetachedCriteria.forClass(Project.class);
		dCriteria.add(Restrictions.eq("company",company)).add(Restrictions.ne ("projectId", userCase.getModule().getProject().getProjectId()));		
		List<Project> projectList=aService.queryAllOfCondition(Project.class, dCriteria);
		
			
		DetachedCriteria dCriteria1=DetachedCriteria.forClass(Module.class);
		dCriteria1.add(Restrictions.eq("project", userCase.getModule().getProject())).add(Restrictions.isNull("parent")).add(Restrictions.ne("moduleId", userCase.getModule().getModuleId()));
		
		List<ModuleBean> modulebean = ModuleUtil.getModuleNameList(aService, dCriteria1);
			
		
		DetachedCriteria dCriteria2=DetachedCriteria.forClass(Step.class);
		dCriteria2.add(Restrictions.eq("userCase", userCase));
		List<Step> stepList=aService.queryAllOfCondition(Step.class, dCriteria2);
		
		
		ModelMap map=new ModelMap();
		map.put("userCase", userCase);
		map.put("projectList", projectList);
		map.put("modulebean", modulebean);
		map.put("stepList", stepList);
		
		return new ModelAndView("/usecase/copyUseCase",map);
	}
	@Secured({"ROLE_TESTER"})
	@RequestMapping("goEditeUserCase.htm")
	public ModelAndView goEditeUserCase(HttpServletRequest request){
		
		String userCaseId=request.getParameter("usercaseId");
		UserCase userCase=aService.findById(UserCase.class, Integer.parseInt(userCaseId));
		DetachedCriteria dCriteria1=DetachedCriteria.forClass(Module.class);
		dCriteria1.add(Restrictions.eq("project", userCase.getModule().getProject())).add(Restrictions.isNull("parent")).add(Restrictions.ne("moduleId", userCase.getModule().getModuleId()));
		List<ModuleBean> modulebean = ModuleUtil.getModuleNameList(aService, dCriteria1);
			
		DetachedCriteria dCriteria2=DetachedCriteria.forClass(Step.class);
		dCriteria2.add(Restrictions.eq("userCase", userCase));
		List<Step> stepList=aService.queryAllOfCondition(Step.class, dCriteria2);
	
		DetachedCriteria dCriteria7=DetachedCriteria.forClass(History.class);
		dCriteria7.add(Restrictions.eq("objectId", userCase.getCaseId())).add(Restrictions.eq("objectType", "usercase")).addOrder(Order.asc("operateTime"));
		List<History> hisList=aService.queryAllOfCondition(History.class, dCriteria7);
		
		DetachedCriteria dCriteria5=DetachedCriteria.forClass(History.class);
		dCriteria5.add(Restrictions.eq("objectId", userCase.getCaseId())).add(Restrictions.eq("objectType", "usercase")).addOrder(Order.asc("operateTime")).add(Restrictions.eq("operation", "编辑"));
		List<History> hisList1=aService.queryAllOfCondition(History.class, dCriteria5);
		
		int size=hisList1.size();
		History hs=null;
		if(size!=0){
			hs=hisList1.get(size-1);
		}
		
		ModelMap map=new ModelMap();
		map.put("userCase", userCase);
		map.put("modulebean", modulebean);
		map.put("hisList", hisList);
		map.put("stepList", stepList);
		map.put("hs", hs);
			
		return new ModelAndView("/usecase/editUseCase", map);
		
	}
	//@Secured({"ROLE_TESTER"})
	@RequestMapping("EditUserCase.htm")
	public ModelAndView EditUserCase(HttpServletRequest request) throws Exception{
		
		User user=(User) request.getSession().getAttribute("user");
		
		String userCaseId=request.getParameter("usercaseId");
		String destinationDir = "E:\\workplace\\bugmanagement\\src\\main\\webapp\\source\\usercase\\";

		MultipartHttpServletRequest multipartReq = (MultipartHttpServletRequest) request;
			
		String module1=multipartReq.getParameter("module");
		String type=multipartReq.getParameter("type");
			
		String pri=multipartReq.getParameter("pri");
		String title=multipartReq.getParameter("title");
		String precondition=multipartReq.getParameter("precondition");
		String keywords=multipartReq.getParameter("keywords");
		String status=multipartReq.getParameter("status");
		String linkCase=multipartReq.getParameter("linkCase");
		String beizhu=multipartReq.getParameter("beizhu");
		String[] steps= multipartReq.getParameterValues("steps");
		String[] expects= multipartReq.getParameterValues("expects");
		String[] stages= multipartReq.getParameterValues("stage");
			
		System.out.println("#####stages is " + Arrays.toString(stages));
		String stage="";
			
		for(int j=0;j<stages.length;j++){
			if(j==(stages.length-1)){	
				stage=stage+stages[j];
			}else{
				stage=stage+stages[j]+";";
			}
		}
		
		Module module=aService.findById(Module.class, Integer.parseInt(module1));
			
		UserCase uc=aService.findById(UserCase.class, Integer.parseInt(userCaseId));
		
		if(!linkCase.isEmpty()) {
			UserCase uc1=aService.findById(UserCase.class, Integer.parseInt(linkCase));
			uc.setRelatedCase(uc1);
		}
		uc.setCaseType(type);

		uc.setKeyword(keywords);
		uc.setModule(module);
		uc.setPrecondition(precondition);
		
		if(!pri.isEmpty()) {
			uc.setPriority(Integer.parseInt(pri));
		}
		
		uc.setStage(stage);
		uc.setTitle(title);
		uc.setStatus(status);
		
		aService.update(uc);
			
		DetachedCriteria dCriteria=DetachedCriteria.forClass(Step.class);
		dCriteria.add(Restrictions.eq("userCase", uc));
		List<Step> stList=aService.queryAllOfCondition(Step.class, dCriteria);
			
		for(int j=0;j<stList.size();j++){
			Step step=stList.get(j);
			aService.delete(step);
		}
			
		for(int i=0;i<steps.length;i++){
			if(!steps[i].isEmpty()) {
				Step step=new Step();
				step.setUserCase(uc);
				step.setExpect(expects[i]);
				step.setNum(i+1);
				step.setContent(steps[i]);
				aService.save(step);
			}
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
					
				re.setObjectId(uc.getCaseId());
				re.setObjectType("usercase");
				re.setResourceName(labels[i]);
				re.setResourceUrl("/source/usercase/" + UUID.randomUUID() + "."
						+ filetype);
					
				aService.save(re);
					
				File destination = new File(destinationDir + UUID.randomUUID()
						+ "." + filetype);
					
				file.transferTo(destination);
			}
		}
		History hs=new History();
		hs.setUser(user);
		hs.setObjectId(uc.getCaseId());
		hs.setObjectType("usercase");
		hs.setOperateTime(new Date());
		hs.setOperation("编辑");
		hs.setComment(beizhu);
		aService.save(hs);
			
		return new ModelAndView("redirect:usecase.htm");
	}
	
	@Secured({"ROLE_TESTER"})
	@RequestMapping("goUcFromBug.htm")
	public ModelAndView goUcFromBug(HttpServletRequest request){
		String bugId=request.getParameter("bugId");
		
		Bug bug=aService.findById(Bug.class, Integer.parseInt(bugId));
		
		Project project=bug.getModule().getProject();
		
		Company company=(Company) request.getSession().getAttribute("company");
		DetachedCriteria dCriteria=DetachedCriteria.forClass(Project.class);
		dCriteria.add(Restrictions.eq("company",company)).add(Restrictions.ne ("projectId", project.getProjectId()));		
		List<Project> projectList=aService.queryAllOfCondition(Project.class, dCriteria);
		
		
		List<ModuleBean> modulebean = ModuleUtil.getModuleNameList(aService, project);
		
		ModelMap map=new ModelMap();
		map.put("projectList", projectList);
		map.put("modulebean", modulebean);
		map.put("bug", bug);
		return new ModelAndView("/usecase/bugToUc" , map );
	}
	
	@Secured({"ROLE_TESTER"})
	@RequestMapping("addUCFromBug.htm")
	public ModelAndView addUCFromBug(HttpServletRequest request) throws Exception{
		User user=(User) request.getSession().getAttribute("user");

		String destinationDir = "E:\\workplace\\bugmanagement\\src\\main\\webapp\\source\\usercase\\";

		MultipartHttpServletRequest multipartReq = (MultipartHttpServletRequest) request;
		
		
		String bugId=multipartReq.getParameter("bugId");
		String module1=multipartReq.getParameter("module");
		String type=multipartReq.getParameter("type");
		
		String pri=multipartReq.getParameter("pri");
		String title=multipartReq.getParameter("title");
		String precondition=multipartReq.getParameter("precondition");
		String keywords=multipartReq.getParameter("keywords");
		String[] steps=(String[])multipartReq.getParameterValues("steps");
		String[] expects=(String[])multipartReq.getParameterValues("expects");
		String[] stages=(String[])multipartReq.getParameterValues("stage");
		
		
		String stage="";
		
		for(int j=0;j<stages.length;j++){
			if(j==(stages.length-1)){
				
				stage=stage+stages[j];
			}else{
				stage=stage+stages[j]+";";
			}
			
			
		}
		
		Bug bug=aService.findById(Bug.class, Integer.parseInt(bugId));
		Module module=aService.findById(Module.class, Integer.parseInt(module1));
		Tester tester=aService.findById(Tester.class,user.getUserId());
		
		UserCase uc=new UserCase();
		uc.setCaseType(type);
		uc.setCreatedAt(new Date());
		uc.setCreator(tester);
		uc.setKeyword(keywords);
		uc.setModule(module);
		uc.setPrecondition(precondition);
		uc.setPriority(Integer.parseInt(pri));
		uc.setStage(stage);
		uc.setTitle(title);
		uc.setFromBug(bug);
		uc.setStatus("未开始");
		aService.save(uc);
		
		
		bug.setToCase(uc);
		aService.update(bug);
		
		for(int i=0;i<steps.length;i++){
			if(!steps[i].isEmpty()) {
				Step step=new Step();
				step.setUserCase(uc);
				step.setExpect(expects[i]);
				step.setNum(i+1);
				step.setContent(steps[i]);
				aService.save(step);
			}
			
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
				
				re.setObjectId(uc.getCaseId());
				re.setObjectType("usercase");
				re.setResourceName(labels[i]);
				re.setResourceUrl("/source/usercase/" + UUID.randomUUID() + "."
						+ filetype);
				
				aService.save(re);
				
				File destination = new File(destinationDir + UUID.randomUUID()
						+ "." + filetype);
				
				file.transferTo(destination);
			}
		}
		History hs=new History();
		hs.setUser(user);
		hs.setObjectId(uc.getCaseId());
		hs.setObjectType("usercase");
		hs.setOperateTime(new Date());
		hs.setOperation("创建");
		aService.save(hs);
		
		History hs1=new History();
		hs1.setUser(user);
		hs1.setObjectId(bug.getBugId());
		hs1.setObjectType("bug");
		hs1.setOperateTime(new Date());
		hs1.setOperation("编辑");
		hs1.setComment("生成用例");
		aService.save(hs1);
		
		return new ModelAndView("redirect:bug.htm");
		
	}
	
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
	@RequestMapping(value = "showCase/{caseId}.htm", method = RequestMethod.GET)
	public String showCase(@PathVariable Integer caseId, ModelMap map){
		UserCase userCase = aService.findById(UserCase.class, caseId);
		
		List<History> histories = aService.queryAllOfCondition(History.class, 
				DetachedCriteria.forClass(History.class)
				.add(Restrictions.eq("objectType", "usercase"))
				.add(Restrictions.eq("objectId", userCase.getCaseId()))
				.addOrder(Order.asc("operateTime")));
		
		List<Resource> resources = aService.queryAllOfCondition(Resource.class, 
				DetachedCriteria.forClass(Resource.class)
				.add(Restrictions.eq("objectType", "usercase"))
				.add(Restrictions.eq("objectId", userCase.getCaseId()))
				.addOrder(Order.asc("resourceId")));
		
		List<Step> steps = aService.queryAllOfCondition(Step.class,
				DetachedCriteria.forClass(Step.class)
				.add(Restrictions.eq("userCase", userCase))
				.addOrder(Order.asc("num")));
		
		map.put("userCase", userCase);
		map.put("histories", histories);
		map.put("resources", resources);
		map.put("steps", steps);
		
		return "/usecase/showCase";
	}
	
}
