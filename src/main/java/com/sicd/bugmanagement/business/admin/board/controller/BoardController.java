package com.sicd.bugmanagement.business.admin.board.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

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

import com.sicd.bugmanagement.business.admin.board.service.BoardService;
import com.sicd.bugmanagement.business.reportChart.bean.PieBean;

import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Department;
import com.sicd.bugmanagement.common.bean.Module;
import com.sicd.bugmanagement.common.bean.OperateLog;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.Version;
import com.sicd.bugmanagement.common.tag.pageTag.PageHelper;


@Controller
public class BoardController {
	@Autowired
	private BoardService bservice;
	private String[] colors = {"AFD8F8", "F6BD0F", "8BBA00", "FF8E46", "008E8E",  
            "D64646", "8E468E", "588526", "B3AA00", "008ED6", "9D080D", "A186BE"};
	private String nameSize="18";
	private String nameColor="blank";
	
	@RequestMapping("goToTest.htm")
	public ModelAndView goToTest(HttpServletRequest request){
		
		return new ModelAndView("/admin/test");
	}
	
	@Secured({"ROLE_ADMIN"})
	@RequestMapping("goIndex.htm")
	public ModelAndView goIndex(HttpServletRequest request){
		
		DetachedCriteria dCriteria=DetachedCriteria.forClass(User.class);
		dCriteria.add(Restrictions.eq("enabled", true)).addOrder(Order.desc("joinDate")).add(Restrictions.ne("position", "管理员"));
		List<User> userList1=bservice.queryAllOfCondition(User.class, dCriteria);
		List<User> userList=bservice.queryMaxNumOfCondition(User.class, dCriteria, 6);
		
		int userSum=userList1.size();
		
		DetachedCriteria dCriteria1=DetachedCriteria.forClass(Company.class);
		dCriteria1.addOrder(Order.desc("createdAt"));
		List<Company> companyList1=bservice.queryAllOfCondition(Company.class, dCriteria1);
		List<Company> companyList=bservice.queryMaxNumOfCondition(Company.class, dCriteria1, 6);
		
		int companySum=companyList1.size();
		
		DetachedCriteria dCriteria2=DetachedCriteria.forClass(Project.class);
		dCriteria2.addOrder(Order.desc("createdAt"));
		List<Project> projectList1=bservice.queryAllOfCondition(Project.class, dCriteria2);
		List<Project> projectList=bservice.queryMaxNumOfCondition(Project.class, dCriteria2, 6);
		
		int projectSum=projectList1.size();
		
		
		DetachedCriteria dCriteria3=DetachedCriteria.forClass(OperateLog.class);
		dCriteria3.addOrder(Order.desc("operateTime"));
		List<OperateLog> logList=bservice.queryMaxNumOfCondition(OperateLog.class, dCriteria3, 6);
		
		
		ModelMap map=new ModelMap();
		
		map.put("userList", userList);
		map.put("userSum", userSum);
		map.put("companySum", companySum);
		map.put("companyList", companyList);
		map.put("projectSum", projectSum);
		map.put("projectList", projectList);
		map.put("logList", logList);
		
		
		return new ModelAndView("/admin/index",map);
	}
	@SuppressWarnings("unchecked")
	@Secured({"ROLE_ADMIN"})
	@RequestMapping("goCompanyList.htm")
	public ModelAndView goCompanyList(HttpServletRequest request){
		User user=(User) request.getSession().getAttribute("user");
		
		if(user==null){
			return new ModelAndView("/login/newLogin");
		}else{
			int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
			DetachedCriteria dCriteria1=DetachedCriteria.forClass(Company.class);
			dCriteria1.addOrder(Order.desc("createdAt"));
			int totalSize = bservice.countTotalSize(dCriteria1);
			PageHelper.forPage(pageSize, totalSize);
			
			DetachedCriteria dCriteria0=DetachedCriteria.forClass(Company.class);
			dCriteria0.addOrder(Order.desc("createdAt"));
			List<Company> companyList =  (List<Company>) bservice.getByPage(dCriteria0, pageSize);
	
		
		//request.setAttribute("companyList", companyList);
		return new ModelAndView("/admin/companyList", "companyList", companyList);
		}
	}
	@Secured({"ROLE_ADMIN"})
	@RequestMapping("companyDetail.htm")
	public ModelAndView companyDetail(HttpServletRequest request){
		User user=(User) request.getSession().getAttribute("user");
		
		if(user==null){
			return new ModelAndView("/login/newLogin");
		}else{
		String companyId=request.getParameter("companyId");
		Company company=bservice.findById(Company.class, Integer.parseInt(companyId));
		DetachedCriteria dCriteria=DetachedCriteria.forClass(Project.class);
		dCriteria.add(Restrictions.eq("company", company));
		List<Project> projectList=bservice.queryAllOfCondition(Project.class, dCriteria);
		int proSum=projectList.size();
		
		DetachedCriteria dCriteria1=DetachedCriteria.forClass(Department.class);
		dCriteria1.add(Restrictions.eq("company", company));
		List<Department> departList=bservice.queryAllOfCondition(Department.class, dCriteria1);
		int departSum=departList.size();
		
		DetachedCriteria dCriteria2=DetachedCriteria.forClass(User.class);
		dCriteria2.add(Restrictions.in("department", departList)).add(Restrictions.eq("enabled", true));
		List<User> userList=bservice.queryAllOfCondition(User.class, dCriteria2);
		int userSum=userList.size();
		
		String[] ge={"男","女"};
		List<PieBean> pieList2=new ArrayList<PieBean>();
		for(int i=0;i<ge.length;i++){
			PieBean pp=new PieBean();
			String gender=ge[i];
			
			DetachedCriteria dCriteria3=DetachedCriteria.forClass(User.class);
			dCriteria3.add(Restrictions.eq("enabled", true)).addOrder(Order.desc("joinDate"))
			.add(Restrictions.eq("gender", gender)).add(Restrictions.in("department", departList));
			List<User> userList2=bservice.queryAllOfCondition(User.class, dCriteria3);
			
			pp.setColor(colors[i%12]);
			pp.setLabel(gender);
			pp.setLabelFontSize(nameSize);
			pp.setLabelColor(nameColor);
			pp.setValue(userList2.size());
			String baifenbi4=getBaifenBi(userList2.size(), userSum);
			pp.setBfb(baifenbi4);
			pieList2.add(pp);
			
		}
		JSONArray js5= JSONArray.fromObject(pieList2); 	
		
		
		ModelMap map=new ModelMap();
		map.put("proSum", proSum);	
		map.put("departSum", departSum);	
		map.put("userSum", userSum);	
		map.put("company", company);	
		map.put("projectList",projectList );
		map.put("departList",departList );	
		map.put("pieList2",pieList2);	
		map.put("js5",js5);
		return new ModelAndView("/admin/companyDetail" , map);
		}
	}
	@SuppressWarnings("unchecked")
	@Secured({"ROLE_ADMIN"})
	@RequestMapping("goProjectList.htm")
	public ModelAndView goProjectList(HttpServletRequest request){
		User user=(User) request.getSession().getAttribute("user");
		
		if(user==null){
			return new ModelAndView("/login/newLogin");
		}else{
			int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
			DetachedCriteria dCriteria1=DetachedCriteria.forClass(Project.class);
			dCriteria1.addOrder(Order.desc("createdAt"));
			int totalSize = bservice.countTotalSize(dCriteria1);
			PageHelper.forPage(pageSize, totalSize);
			
			DetachedCriteria dCriteria0=DetachedCriteria.forClass(Project.class);
			dCriteria0.addOrder(Order.desc("createdAt"));
			List<Project> projectList =  (List<Project>) bservice.getByPage(dCriteria0, pageSize);
	
		
		//request.setAttribute("projectList", projectList);
		return new ModelAndView("/admin/projectList" , "projectList", projectList);
		}
	}
	@Secured({"ROLE_ADMIN"})
	@RequestMapping("projectDetail.htm")
	public ModelAndView projectDetail(HttpServletRequest request){
	User user=(User) request.getSession().getAttribute("user");
		
		if(user==null){
			return new ModelAndView("/login/newLogin");
		}else{
		String projectId=request.getParameter("projectId");
		Project project=bservice.findById(Project.class, Integer.parseInt(projectId));
		
		DetachedCriteria dCriteria=DetachedCriteria.forClass(Module.class);
		dCriteria.addOrder(Order.desc("createdAt")).add(Restrictions.eq("project", project));
		List<Module> moduleList=bservice.queryAllOfCondition(Module.class, dCriteria);
		int modSum=moduleList.size();
		
		DetachedCriteria dCriteria1=DetachedCriteria.forClass(Version.class);
		dCriteria1.addOrder(Order.desc("createdAt")).add(Restrictions.eq("project", project));
		List<Version> versionList=bservice.queryAllOfCondition(Version.class, dCriteria1);
		int verSum=versionList.size();
		
		DetachedCriteria dCriteria2=DetachedCriteria.forClass(Department.class);
		dCriteria2.add(Restrictions.eq("company", project.getCompany()));
		List<Department> departList=bservice.queryAllOfCondition(Department.class, dCriteria2);
		
		DetachedCriteria dCriteria3=DetachedCriteria.forClass(User.class);
		dCriteria3.add(Restrictions.in("department", departList)).add(Restrictions.eq("enabled", true));
		List<User> userList=bservice.queryAllOfCondition(User.class, dCriteria3);
		int userSum=userList.size();
		
		ModelMap map=new ModelMap();
		map.put("userSum", userSum);
		map.put("verSum", verSum);
		map.put("modSum", modSum);
		map.put("userList", userList);
		map.put("versionList", versionList);
		map.put("moduleList", moduleList);
		map.put("project", project);
		
		return new ModelAndView("/admin/projectDetail" ,map);
		}
	}
	@SuppressWarnings("unchecked")
	@Secured({"ROLE_ADMIN"})
	@RequestMapping("goUserList.htm")
	public ModelAndView goUserList(HttpServletRequest request){
		User user=(User) request.getSession().getAttribute("user");
		
		if(user==null){
			return new ModelAndView("/login/newLogin");
		}else{
			int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
		DetachedCriteria dCriteria=DetachedCriteria.forClass(User.class);
		dCriteria.add(Restrictions.eq("enabled", true)).addOrder(Order.desc("joinDate")).add(Restrictions.ne("position", "管理员"));
		
		
		int totalSize = bservice.countTotalSize(dCriteria);
		PageHelper.forPage(pageSize, totalSize);
		
		DetachedCriteria dCriteria0=DetachedCriteria.forClass(User.class);
		dCriteria0.add(Restrictions.eq("enabled", true)).addOrder(Order.desc("joinDate")).add(Restrictions.ne("position", "管理员"));
		
		List<User> userList =  (List<User>) bservice.getByPage(dCriteria0, pageSize);
		
		int userSum=userList.size();
		
		
		//曲线
		JSONArray js2=getDateString(10);
		String[] str=getDate(10);
	
		int[] value={0,0,0,0,0,0,0,0,0,0};
		for(int b=0;b<userList.size();b++){
			User user1=userList.get(b);
			Date dd1=user1.getJoinDate();
			
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			String dd = df.format(dd1);
		
			for(int n = 0;n<str.length;n++){
				
				if(dd.equals(str[n])){
					value[n]=value[n]+1;
					break;
				}
				
			}
		}
		List<PieBean> pieList=new ArrayList<PieBean>();
		for(int k=0;k<value.length;k++){
			
			PieBean pb7=new PieBean();
			pb7.setLabel(str[k]);
			pb7.setValue(value[k]);
			String baifenbi7=getBaifenBi(value[k], userSum);
			pb7.setBfb(baifenbi7);
			pieList.add(pb7);
		}
		JSONArray js3= JSONArray.fromObject(value);	
		//饼图1
		String[] pos={"测试经理","测试人员","研发人员"};
		List<PieBean> pieList1=new ArrayList<PieBean>();
		for(int i=0;i<pos.length;i++){
			PieBean p=new PieBean();
			String position=pos[i];
			
			DetachedCriteria dCriteria1=DetachedCriteria.forClass(User.class);
			dCriteria1.add(Restrictions.eq("enabled", true)).addOrder(Order.desc("joinDate"))
			.add(Restrictions.eq("position", position));
			List<User> userList1=bservice.queryAllOfCondition(User.class, dCriteria1);
			
			p.setColor(colors[i%12]);
			p.setLabel(position);
			p.setLabelFontSize(nameSize);
			p.setLabelColor(nameColor);
			p.setValue(userList1.size());
			String baifenbi3=getBaifenBi(userList1.size(), userSum);
			p.setBfb(baifenbi3);
			pieList1.add(p);
			
		}
		JSONArray js4= JSONArray.fromObject(pieList1); 	
		//饼图2
		String[] ge={"男","女"};
		List<PieBean> pieList2=new ArrayList<PieBean>();
		for(int i=0;i<ge.length;i++){
			PieBean pp=new PieBean();
			String gender=ge[i];
			
			DetachedCriteria dCriteria2=DetachedCriteria.forClass(User.class);
			dCriteria2.add(Restrictions.eq("enabled", true)).addOrder(Order.desc("joinDate"))
			.add(Restrictions.eq("gender", gender)).add(Restrictions.ne("position", "管理员"));
			List<User> userList2=bservice.queryAllOfCondition(User.class, dCriteria2);
			
			pp.setColor(colors[i%12]);
			pp.setLabel(gender);
			pp.setLabelFontSize(nameSize);
			pp.setLabelColor(nameColor);
			pp.setValue(userList2.size());
			String baifenbi4=getBaifenBi(userList2.size(), userSum);
			pp.setBfb(baifenbi4);
			pieList2.add(pp);
			
		}
		JSONArray js5= JSONArray.fromObject(pieList2); 	
			
		
		ModelMap map=new ModelMap();
		map.put("js2", js2);
		map.put("js3", js3);
		map.put("js4", js4);
		map.put("js5", js5);
		map.put("userList", userList);
		map.put("pieList", pieList);
		map.put("pieList1", pieList1);
		map.put("pieList2",pieList2);
		
			
			return new ModelAndView("/admin/userList" ,map);
		}

	}
	@SuppressWarnings("unchecked")
	@Secured({"ROLE_ADMIN"})
	@RequestMapping("goLogList.htm")
	public ModelAndView goLogList(HttpServletRequest request){
		User user=(User) request.getSession().getAttribute("user");
		
		if(user==null){
			return new ModelAndView("/login/newLogin");
		}else{
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
		DetachedCriteria dCriteria3=DetachedCriteria.forClass(OperateLog.class);
		dCriteria3.addOrder(Order.desc("operateTime"));
		
		int totalSize = bservice.countTotalSize(dCriteria3);
		PageHelper.forPage(pageSize, totalSize);
		DetachedCriteria dCriteria2=DetachedCriteria.forClass(OperateLog.class);
		dCriteria2.addOrder(Order.desc("operateTime"));
		
		List<OperateLog> logList =  (List<OperateLog>) bservice.getByPage(dCriteria2, pageSize);
		
		//request.setAttribute("logList", logList);
		
		return new ModelAndView("/admin/logList", "logList", logList);
		}
	}
private String getBaifenBi(int x,int y){
		
		String baifenbi="";
		double baiy=x*1.0;
		double baiz=y*1.0;
		double fen=baiy/baiz;
		DecimalFormat df1 = new DecimalFormat("##.00%");   
		baifenbi= df1.format(fen);  
		
		return baifenbi;
	}
	private  JSONArray getDateString(int j){
		JSONArray js=new JSONArray();
		long date1,date2;
		date1=new Date().getTime();
		for(int i=0;i<j;i++){
			date2=date1-24*60*60*1000*(j-(i+1));
			
			Date date3=new Date(date2);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			String dd = df.format(date3);
			js.add(i, dd);
		}
		return js;
	}
	private  String[] getDate(int j){
		 String str="",str1="";
		long date1,date2;
		date1=new Date().getTime();
		for(int i=0;i<j;i++){
			date2=date1-24*60*60*1000*(j-(i+1));
			
			Date date3=new Date(date2);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			String dd = df.format(date3);
			
			if(i==j-1) {str1=dd;}else{
				str1=dd+";";
			}
			str=str+str1;
		}
		String[] js=str.split(";");
		return js;
	}
}
