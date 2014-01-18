package com.sicd.bugmanagement.business.company.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sicd.bugmanagement.business.company.bean.DeptBean;
import com.sicd.bugmanagement.business.company.service.CompanyService;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Department;
import com.sicd.bugmanagement.common.bean.History;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.tag.pageTag.PageHelper;

@Controller
public class CompanyController {

	private static Logger logger = Logger.getLogger(CompanyController.class);

	@Autowired
	private CompanyService cservice;
	
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
	@RequestMapping("goCompany.htm")
	public ModelAndView goCompany() {

		return new ModelAndView("/company/company");

	}
	
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
	@RequestMapping("goDept.htm")
	public ModelAndView goDept(HttpServletRequest req) {
		User user = (User) req.getSession().getAttribute("user");

		Department userDept = cservice.findById(Department.class, user
				.getDepartment().getDepartmentId());
		Company company = cservice.findById(Company.class, userDept
				.getCompany().getCompanyId());
		String strDeptId = req.getParameter("deptId");
		Department department = null;
		if (strDeptId != null) {
			department = cservice.findById(Department.class,
					Integer.parseInt(strDeptId));
		}
		DetachedCriteria dCriteria = DetachedCriteria
				.forClass(Department.class);
		dCriteria.add(Restrictions.isNull("parent")).addOrder(
				Order.asc("createdAt"));
		List<Department> parentDepts = cservice.queryAllOfCondition(
				Department.class, dCriteria);
		logger.info("parent department size " + parentDepts.size());

		List<DeptBean> deptBeans = new ArrayList<DeptBean>();
		addChildDept(parentDepts, deptBeans);
		logger.info("all department size " + deptBeans.size());

		List<DeptBean> menuDepts = new ArrayList<DeptBean>();
		if (department != null) {
			addParentDept(department, menuDepts);
		}
		logger.info("menu length is " + menuDepts.size());

		List<Department> subDepts = null;
		if (strDeptId != null) {
			DetachedCriteria subCriteria = DetachedCriteria
					.forClass(Department.class);
			subCriteria.add(Restrictions.eq("parent", department)).addOrder(
					Order.asc("createdAt"));
			subDepts = cservice.queryAllOfCondition(Department.class,
					subCriteria);
			logger.info("origin sub depts size " + subDepts.size());
		} else {
			subDepts = parentDepts;
		}
		if (subDepts.size() < 10) {
			while (subDepts.size() < 10) {
				subDepts.add(new Department());
			}
		}
		logger.info("new sub depts size " + subDepts.size());

		ModelMap map = new ModelMap();
		map.put("deptBeans", deptBeans);
		map.put("department", department);
		map.put("parentDepts", parentDepts);
		map.put("company", company);
		map.put("menuDepts", menuDepts);
		map.put("subDepts", subDepts);

		return new ModelAndView("/company/dept", map);
	}
	
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping("updateDept.htm")
	public ModelAndView updateDept(HttpServletRequest req) {
		logger.info("enter update dept");
		User user = (User) req.getSession().getAttribute("user");

		Department userDept = cservice.findById(Department.class, user
				.getDepartment().getDepartmentId());
		Company company = cservice.findById(Company.class, userDept
				.getCompany().getCompanyId());
		
		String[] deptNames = req.getParameterValues("deptNames");
		String parentDeptId = req.getParameter("parentDeptId");
		logger.info("parent dept id is " + parentDeptId);
		
		if(parentDeptId.isEmpty()) {
			logger.info("enter update parent dept");
			DetachedCriteria dCriteria = DetachedCriteria
					.forClass(Department.class);
			dCriteria.add(Restrictions.isNull("parent")).addOrder(
					Order.asc("createdAt"));
			List<Department> parentDepts = cservice.queryAllOfCondition(
					Department.class, dCriteria);
			for (int i = 0; i < parentDepts.size(); i++) {
				if(!deptNames[i].trim().isEmpty()) {
					logger.info("update dept ");
					Department dept = parentDepts.get(i);
					dept.setName(deptNames[i]);
					cservice.update(dept);
				}
			}
			for (int i = parentDepts.size(); i < 10; i++) {
				if(!deptNames[i].trim().isEmpty()) {
					logger.info("add dept ");
					Department dept = new Department();
					dept.setCompany(company);
					dept.setName(deptNames[i]);
					dept.setCreatedAt(new Date());
					cservice.save(dept);
				}
			}
			return new ModelAndView("redirect:goDept.htm");
			
		} else {
			logger.info("enter update sub dept.");
			Department parent = cservice.findById(Department.class, Integer.parseInt(parentDeptId));
			DetachedCriteria dCriteria = DetachedCriteria
					.forClass(Department.class);
			dCriteria.add(Restrictions.eq("parent", parent)).addOrder(
					Order.asc("createdAt"));
			List<Department> subDepts = cservice.queryAllOfCondition(
					Department.class, dCriteria);
			for (int i = 0; i < subDepts.size(); i++) {
				if(!deptNames[i].trim().isEmpty()) {
					logger.info("update dept ");
					Department dept = subDepts.get(i);
					dept.setName(deptNames[i]);
					cservice.update(dept);
				}
			}
			for (int i = subDepts.size(); i < 10; i++) {
				if(!deptNames[i].trim().isEmpty()) {
					logger.info("add dept ");
					Department dept = new Department();
					dept.setParent(parent);
					dept.setCompany(company);
					dept.setName(deptNames[i]);
					dept.setCreatedAt(new Date());
					cservice.save(dept);
				}
			}
			return new ModelAndView("redirect:goDept.htm?deptId=" + parentDeptId);
			
		}
	}
	
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping("deleteDept.htm")
	public ModelAndView deleteDept(HttpServletRequest req) throws ServletRequestBindingException {
		int deptId = ServletRequestUtils.getIntParameter(req, "deptId");
		Department department = cservice.findById(Department.class, deptId);
		DetachedCriteria  dCriteria = DetachedCriteria.forClass(User.class);
		dCriteria.add(Restrictions.eq("department", department));
		List<User> users = cservice.queryAllOfCondition(User.class, dCriteria);
		for (User user : users) {
			user.setDepartment(null);
			cservice.update(user);
		}
		cservice.delete(department);
		return new ModelAndView("redirect:goDept.htm");
	}
	
	@RequestMapping("Dept.htm")
	public ModelAndView Dept(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		User user = (User) request.getSession().getAttribute("user");
		Company com = user.getDepartment().getCompany();
		List list1 = cservice
				.getCurrentSession()
				.createCriteria(Department.class)
				.add(Restrictions.and(Restrictions.eq("company", com), Property
						.forName("parent").isNull())).list();
		String message = null;
		if (list1.size() == 0) {
			message = "还没有创建任何部门";
		} else {
			// int size=list1.size();
			// for(int i=0;i<size;i++){

			// }

		}
		request.setAttribute("list", list1);
		return new ModelAndView("redirect:goDept.htm", "message", message);

	}
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping("addDept.htm")
	public ModelAndView addDept(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		return new ModelAndView("Dept.htm");

	}
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER", "ROLE_ANONYMOUS"})
	@RequestMapping("goCompanyInfo.htm")
	public ModelAndView goCompanyInfo(HttpServletRequest request) {
		Company company=(Company) request.getSession().getAttribute("company");
		Company company1=cservice.findById(Company.class, company.getCompanyId());
		return new ModelAndView("/company/companyInfo","company1",company1);
	}
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping("goEditCompanyInfo.htm")
	public ModelAndView goEditCompanyInfo(HttpServletRequest request) {
		Company company=(Company) request.getSession().getAttribute("company");
		Company company1=cservice.findById(Company.class, company.getCompanyId());
		return new ModelAndView("/company/editCompany","company1",company1);
	}
	@Secured({"ROLE_DIRECTOR"})
	@RequestMapping("editCompanyInfo.htm")
	public ModelAndView editCompanyInfo(HttpServletRequest request) {
		Company company1=(Company) request.getSession().getAttribute("company");
		String phone=request.getParameter("phone");
		String zipcode=request.getParameter("zipcode");
		String address=request.getParameter("adress");
		String name=request.getParameter("name");
		
		company1.setName(name);
		company1.setAddress(address);
		company1.setPhone(phone);
		company1.setZipcode(zipcode);
		cservice.update(company1);
		HttpSession hs = request.getSession();
		hs.setAttribute("company", company1);
		
		return new ModelAndView("redirect:goCompanyInfo.htm");
	}
	@SuppressWarnings("unchecked")
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER", "ROLE_ANONYMOUS"})
	@RequestMapping("goDynamic.htm")
	public ModelAndView goDynamic(HttpServletRequest request) {
		Company company1=(Company) request.getSession().getAttribute("company");
		
		DetachedCriteria dCriteria=DetachedCriteria.forClass(History.class);
		dCriteria.createCriteria("user").createCriteria("department").add(Restrictions.eqOrIsNull("company", company1));
		dCriteria.addOrder(Order.desc("operateTime"));
		
		int pageSize = ServletRequestUtils.getIntParameter(request, "pageSize", 20);
		int totalSize = cservice.countTotalSize(dCriteria);
		PageHelper.forPage(pageSize, totalSize);
		List<History> histories=(List<History>) cservice.getByPage(dCriteria, pageSize);
		
		return new ModelAndView("/company/dynamic","histories",histories);
	}
	private void addChildDept(List<Department> parents, List<DeptBean> all) {
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
				List<Department> children = cservice.queryAllOfCondition(
						Department.class, dCriteria);
				addChildDept(children, all);
			}
		}
	}

	private void addParentDept(Department department, List<DeptBean> menuDepts) {
		DeptBean deptBean = new DeptBean();
		if (department.getParent() != null) {

			addParentDept(department.getParent(), menuDepts);

			deptBean.setDeptId(department.getDepartmentId());
			deptBean.setDeptName(department.getName());
			menuDepts.add(deptBean);
		} else {
			deptBean.setDeptId(department.getDepartmentId());
			deptBean.setDeptName(department.getName());
			menuDepts.add(deptBean);
		}
	}

}
