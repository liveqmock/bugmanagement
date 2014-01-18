package com.sicd.bugmanagement.business.exception.controller;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sicd.bugmanagement.business.exception.service.ExceptionRecordService;
import com.sicd.bugmanagement.business.reportChart.bean.PieBean;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Department;
import com.sicd.bugmanagement.common.bean.Developer;
import com.sicd.bugmanagement.common.bean.ExceptionRecord;
import com.sicd.bugmanagement.common.bean.MyException;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.tag.pageTag.PageHelper;

@Controller
public class ExceptionRecordController {

	@Autowired
	private ExceptionRecordService erService;

	private String[] colors = { "AFD8F8", "F6BD0F", "8BBA00", "FF8E46",
			"008E8E", "D64646", "8E468E", "588526", "B3AA00", "008ED6",
			"9D080D", "A186BE" };

	@SuppressWarnings("unchecked")
	@Secured({ "ROLE_DEVELOPER" })
	@RequestMapping("goPerExceptionRecord.htm")
	public ModelAndView goPerExceptionRecord(HttpServletRequest request) {
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize",
				20);
		User user = (User) request.getSession().getAttribute("user");

		Developer developer = erService.findById(Developer.class,
				user.getUserId());
		DetachedCriteria dCriteria = DetachedCriteria
				.forClass(ExceptionRecord.class);
		dCriteria.add(Restrictions.eq("developer", developer)).addOrder(
				Order.desc("createdAt"));

		int totalSize = erService.countTotalSize(dCriteria);
		PageHelper.forPage(pageSize, totalSize);

		List<ExceptionRecord> exList = (List<ExceptionRecord>) erService
				.getByPage(dCriteria, pageSize);
		//request.setAttribute("exList", exList);
		return new ModelAndView("/exception/showPersonalRecord","exList", exList);

	}
	@Secured({ "ROLE_DEVELOPER" })
	@RequestMapping("goExceptionToBug.htm")
	public ModelAndView goExceptionToBug(HttpServletRequest request) {
		String recordId=request.getParameter("recordId");
		ExceptionRecord record=erService.findById(ExceptionRecord.class, Integer.parseInt(recordId));
		Company company=(Company) request.getSession().getAttribute("company");
		DetachedCriteria dCriteria=DetachedCriteria.forClass(Project.class);
		dCriteria.add(Restrictions.eq("company",company));		
		List<Project> projectList=erService.queryAllOfCondition(Project.class, dCriteria);
		
		DetachedCriteria dCriteria1=DetachedCriteria.forClass(Department.class);
		dCriteria1.add(Restrictions.eq("company", company));
		List<Department> deptList=erService.queryAllOfCondition(Department.class, dCriteria1);
		
		DetachedCriteria dCriteria2=DetachedCriteria.forClass(Developer.class);
		dCriteria2.createCriteria("user")
		.add(Restrictions.in("department", deptList));
		List<Developer> userList=erService.queryAllOfCondition(Developer.class, dCriteria2);
		
		
		DetachedCriteria dCriteria3=DetachedCriteria.forClass(User.class);
		dCriteria3.add(Restrictions.in("department", deptList));
		List<User> userList1=erService.queryAllOfCondition(User.class, dCriteria3);
		
		ModelMap map = new ModelMap();
		map.put("projectList", projectList);
		map.put("userList", userList);
		map.put("userList1", userList1);
		map.put("record", record);
		
		
		return new ModelAndView("/exception/excrptionToBug",map);

	}

	@Secured({ "ROLE_DEVELOPER" })
	@SuppressWarnings("unchecked")
	@RequestMapping("goCompanyExceptionRecord.htm")
	public ModelAndView goCompanyExceptionRecord(HttpServletRequest request) {
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize",20);

		Company company = (Company) request.getSession()
				.getAttribute("company");

		DetachedCriteria dCriteria1 = DetachedCriteria
				.forClass(Department.class);
		dCriteria1.add(Restrictions.eq("company", company));
		List<Department> deptList = erService.queryAllOfCondition(
				Department.class, dCriteria1);

		DetachedCriteria dCriteria2 = DetachedCriteria
				.forClass(Developer.class);
		dCriteria2.createCriteria("user").add(
				Restrictions.in("department", deptList));
		List<Developer> userList = erService.queryAllOfCondition(
				Developer.class, dCriteria2);

		DetachedCriteria dCriteria = DetachedCriteria
				.forClass(ExceptionRecord.class);
		dCriteria.add(Restrictions.in("developer", userList)).addOrder(
				Order.desc("createdAt"));

		int totalSize = erService.countTotalSize(dCriteria);
		PageHelper.forPage(pageSize, totalSize);

		List<ExceptionRecord> exList = (List<ExceptionRecord>) erService
				.getByPage(dCriteria, pageSize);

		//request.setAttribute("exList", exList);
		return new ModelAndView("/exception/showCompanyRecord","exList", exList);
	}

	@Secured({ "ROLE_DEVELOPER" })
	@RequestMapping("goExceptionDetail.htm")
	public ModelAndView goExceptionDetail(HttpServletRequest request) {
		String nameSize = "18";
		String nameColor = "blank";
		User user = (User) request.getSession().getAttribute("user");

		String recordId = request.getParameter("recordId");
		ExceptionRecord record = erService.findById(ExceptionRecord.class,
				Integer.parseInt(recordId));
		Developer developer = erService.findById(Developer.class,
				user.getUserId());

		DetachedCriteria dCriteria = DetachedCriteria
				.forClass(ExceptionRecord.class);
		dCriteria.add(Restrictions.eq("developer", developer)).addOrder(
				Order.desc("createdAt"));
		List<ExceptionRecord> exList = erService.queryAllOfCondition(
				ExceptionRecord.class, dCriteria);

		DetachedCriteria dCriteria4 = DetachedCriteria
				.forClass(ExceptionRecord.class);
		dCriteria4.add(Restrictions.eq("developer", developer))
				.addOrder(Order.desc("createdAt"))
				.add(Restrictions.eq("myException", record.getMyException()));
		List<ExceptionRecord> thisexception = erService.queryAllOfCondition(
				ExceptionRecord.class, dCriteria4);

		Company company = (Company) request.getSession()
				.getAttribute("company");
		DetachedCriteria dCriteria1 = DetachedCriteria
				.forClass(Department.class);
		dCriteria1.add(Restrictions.eq("company", company));
		List<Department> deptList = erService.queryAllOfCondition(
				Department.class, dCriteria1);

		DetachedCriteria dCriteria2 = DetachedCriteria
				.forClass(Developer.class);
		dCriteria2.createCriteria("user").add(
				Restrictions.in("department", deptList));
		List<Developer> userList = erService.queryAllOfCondition(
				Developer.class, dCriteria2);

		DetachedCriteria dCriteria3 = DetachedCriteria
				.forClass(ExceptionRecord.class);
		dCriteria3.add(Restrictions.in("developer", userList)).addOrder(
				Order.desc("createdAt"));
		List<ExceptionRecord> exList1 = erService.queryAllOfCondition(
				ExceptionRecord.class, dCriteria3);

		DetachedCriteria dCriteria5 = DetachedCriteria
				.forClass(ExceptionRecord.class);
		dCriteria5.add(Restrictions.in("developer", userList))
				.addOrder(Order.desc("createdAt"))
				.add(Restrictions.eq("myException", record.getMyException()));
		List<ExceptionRecord> thisexception1 = erService.queryAllOfCondition(
				ExceptionRecord.class, dCriteria5);
		// 饼图1 此异常在我的所有异常中的比例
		int thisNum = thisexception.size();
		int myall = exList.size();

		List<PieBean> pieList = new ArrayList<PieBean>();
		String[] str = { "此异常", "其他异常" };
		int[] num = { thisNum, (myall - thisNum) };
		for (int i = 0; i < str.length; i++) {
			PieBean pb = new PieBean();
			String color = colors[i % 12];
			String baifenbi = getBaifenBi(num[i], myall);
			pb.setLabel(str[i]);
			pb.setColor(color);
			pb.setLabelColor(nameColor);
			pb.setValue(num[i]);
			pb.setLabelFontSize(nameSize);
			pb.setBfb(baifenbi);
			pieList.add(pb);

		}
		JSONArray json = JSONArray.fromObject(pieList);

		// 饼图2 此异常在所有的异常中的比例
		int thisNum2 = thisexception1.size();
		int all = exList1.size();
		List<PieBean> pieList1 = new ArrayList<PieBean>();
		int[] num1 = { thisNum2, (all - thisNum2) };
		for (int i = 0; i < str.length; i++) {
			PieBean pb1 = new PieBean();
			String color1 = colors[i % 12];
			String baifenbi1 = getBaifenBi(num1[i], all);
			pb1.setLabel(str[i]);
			pb1.setColor(color1);
			pb1.setLabelColor(nameColor);
			pb1.setValue(num1[i]);
			pb1.setLabelFontSize(nameSize);
			pb1.setBfb(baifenbi1);
			pieList1.add(pb1);
		}
		JSONArray json1 = JSONArray.fromObject(pieList1);
		ModelMap map=new ModelMap();
		map.put("json1", json1);
		map.put("record", record);
		map.put("json", json);
		map.put("pieList", pieList);
		map.put("pieList1", pieList1);

		return new ModelAndView("/exception/showExceptionDetail" ,map);
	}
	
	@Secured({ "ROLE_DEVELOPER" })
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "recordsByException.htm", method = RequestMethod.GET)
	public String recordsByException(HttpServletRequest req,
			@RequestParam Integer myExceptionId, 
			@RequestParam(required = false, defaultValue = "20") Integer pageSize,
			ModelMap map){
		Integer userId = (Integer) req.getSession().getAttribute("userId");
		DetachedCriteria dCriteria = DetachedCriteria.forClass(ExceptionRecord.class)
				.add(Restrictions.eq("developer.developerId", userId))
				.add(Restrictions.eq("myException.exceptionId", myExceptionId))
				.addOrder(Order.desc("createdAt"));
		
		int totalSize = erService.countTotalSize(dCriteria);
		Map<String, Object> urlmap = new HashMap<String, Object>();
		urlmap.put("myExceptionId", myExceptionId);
		PageHelper.forPage(pageSize, urlmap, totalSize);
		
		List<ExceptionRecord> exList = (List<ExceptionRecord>) erService.getByPage(dCriteria, pageSize);
		MyException myException = erService.findById(MyException.class, myExceptionId);
		
		map.put("myException", myException);
		map.put("exList", exList);
		
		return "/exception/showPersonalRecord";
	}

	private String getBaifenBi(int x, int y) {
		String baifenbi = "";
		double baiy = x * 1.0;
		double baiz = y * 1.0;
		double fen = baiy / baiz;
		DecimalFormat df1 = new DecimalFormat("##.00%");
		baifenbi = df1.format(fen);

		return baifenbi;
	}
}
