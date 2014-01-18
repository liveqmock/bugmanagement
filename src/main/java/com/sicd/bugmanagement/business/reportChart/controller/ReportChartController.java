package com.sicd.bugmanagement.business.reportChart.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sicd.bugmanagement.business.reportChart.bean.PieBean;
import com.sicd.bugmanagement.business.reportChart.service.ReportChartService;
import com.sicd.bugmanagement.common.bean.AffectedVersion;
import com.sicd.bugmanagement.common.bean.Bug;
import com.sicd.bugmanagement.common.bean.Company;
import com.sicd.bugmanagement.common.bean.Department;
import com.sicd.bugmanagement.common.bean.Developer;
import com.sicd.bugmanagement.common.bean.Module;
import com.sicd.bugmanagement.common.bean.Project;
import com.sicd.bugmanagement.common.bean.User;
import com.sicd.bugmanagement.common.bean.Version;


@Controller
public class ReportChartController {
	
	@Autowired
	private ReportChartService rService;
	
	private String[] colors = {"AFD8F8", "F6BD0F", "8BBA00", "FF8E46", "008E8E",  
            "D64646", "8E468E", "588526", "B3AA00", "008ED6", "9D080D", "A186BE"};
	@Secured({"ROLE_DEVELOPER", "ROLE_TESTER"})
	@RequestMapping("TestChart.htm")
	public ModelAndView TestChart(HttpServletRequest request){
		Company company=(Company) request.getSession().getAttribute("company");

		String nameSize="18";
		String nameColor="blank";
		Project project= (Project) request.getSession().getAttribute("curProject");
		
		DetachedCriteria dCriteria3=DetachedCriteria.forClass(Module.class);
		dCriteria3.add(Restrictions.eq("project", project));
		List<Module> moduleList=rService.queryAllOfCondition(Module.class, dCriteria3);
		
		DetachedCriteria dCriteria2=DetachedCriteria.forClass(Bug.class);
		dCriteria2.add(Restrictions.in("module", moduleList));
		List<Bug> bugList=  rService.queryAllOfCondition(Bug.class, dCriteria2);
		int sumBug=bugList.size();
		
		DetachedCriteria dCriteria=DetachedCriteria.forClass(Version.class);
		dCriteria.add(Restrictions.eq("project", project));
		List<Version> verList=rService.queryAllOfCondition(Version.class, dCriteria);
		
		List<PieBean> pieList=new ArrayList<PieBean>();
		for(int i=0;i<verList.size();i++){
			PieBean pb=new PieBean();
			Version version=verList.get(i);
			
			DetachedCriteria dCriteria1=DetachedCriteria.forClass(AffectedVersion.class);
			dCriteria1.add(Restrictions.eq("version", version));
			List<AffectedVersion> afList=rService.queryAllOfCondition(AffectedVersion.class, dCriteria1);
			
			int sum=afList.size();
			String color=colors[i%12];
			String name=version.getName();
			
			String baifenbi=getBaifenBi(sum, sumBug);
			pb.setLabel(name);
			pb.setColor(color);
			pb.setLabelColor(nameColor);
			pb.setValue(sum);
			pb.setLabelFontSize(nameSize);
			pb.setBfb(baifenbi);
			pieList.add(pb);
		
		}
		JSONArray json= JSONArray.fromObject(pieList); 
		//柱状图  bug类型  
		JSONArray js=new JSONArray();
		String[] types={"代码错误","界面优化","设计缺陷","配置相关","安装部署","安全相关","性能问题","标准规范","测试脚本"};
		List<PieBean> pieList1=new ArrayList<PieBean>();
		for(int j=0;j<types.length;j++){
			PieBean pb1=new PieBean();
			String type=types[j];
			DetachedCriteria dCriteria4=DetachedCriteria.forClass(Bug.class);
			dCriteria4.add(Restrictions.in("module", moduleList)).add(Restrictions.eq("type", type));
			List<Bug> bug1=  rService.queryAllOfCondition(Bug.class, dCriteria4);
			
			int num=bug1.size();
			
			String baifenbi1=getBaifenBi(num, sumBug);
			js.add(j,num);
			pb1.setValue(num);
			pb1.setLabel(type);
			pb1.setBfb(baifenbi1);
			pieList1.add(pb1);
			
		}
		//Bug状态 
		String[] status={"激活","已关闭","已解决"};
		List<PieBean> pieList2=new ArrayList<PieBean>();
		for(int x=0;x<status.length;x++){
			PieBean pb2=new PieBean();
			String statu=status[x];
			
			DetachedCriteria dCriteria5=DetachedCriteria.forClass(Bug.class);
			dCriteria5.add(Restrictions.in("module", moduleList)).add(Restrictions.eq("status", statu));
			List<Bug> bug2=  rService.queryAllOfCondition(Bug.class, dCriteria5);
			
			int num1=bug2.size();
			
			String baifenbi2=getBaifenBi(num1, sumBug);
			
			pb2.setLabel(statu);
			pb2.setColor(colors[x%12]);
			pb2.setValue(num1);
			pb2.setLabelColor(nameColor);
			pb2.setLabelFontSize(nameSize);
			pb2.setBfb(baifenbi2);
			pieList2.add(pb2);
			
		}
		JSONArray js1= JSONArray.fromObject(pieList2); 
		//Bug严重程度 
		
		String[] severitys={"1","2","3","4"};
		List<PieBean> pieList3=new ArrayList<PieBean>();
		for(int y=0;y<severitys.length;y++){
			PieBean pb3=new PieBean();
			String severity=severitys[y];
			
			DetachedCriteria dCriteria6=DetachedCriteria.forClass(Bug.class);
			dCriteria6.add(Restrictions.in("module", moduleList)).add(Restrictions.eq("severity", Integer.parseInt(severity)));
			List<Bug> bug3=  rService.queryAllOfCondition(Bug.class, dCriteria6);
			int num2=bug3.size();
			String baifenbi3=getBaifenBi(num2, sumBug);
			
			pb3.setLabel(severity);
			pb3.setColor(colors[y%12]);
			pb3.setValue(num2);
			pb3.setLabelColor(nameColor);
			pb3.setLabelFontSize(nameSize);
			pb3.setBfb(baifenbi3);
			pieList3.add(pb3);
			
		}
		JSONArray js2= JSONArray.fromObject(pieList3); 
		
		//Bug模块统计
		List<PieBean> pieList4=new ArrayList<PieBean>();
		for(int z=0;z<moduleList.size();z++){
			PieBean pb4=new PieBean();
			Module module=moduleList.get(z);
			DetachedCriteria dCriteria7=DetachedCriteria.forClass(Bug.class);
			dCriteria7.add(Restrictions.in("module", moduleList)).add(Restrictions.eq("module", module));
			List<Bug> bug4=  rService.queryAllOfCondition(Bug.class, dCriteria7);
			int num3=bug4.size();
			
			String baifenbi4=getBaifenBi(num3, sumBug);
			pb4.setLabel(module.getName());
			pb4.setColor(colors[z%12]);
			pb4.setValue(num3);
			pb4.setLabelColor(nameColor);
			pb4.setLabelFontSize(nameSize);
			pb4.setBfb(baifenbi4);
			pieList4.add(pb4);
		}
		JSONArray js3= JSONArray.fromObject(pieList4);
		
		//是否确认
		List<PieBean> pieList5=new ArrayList<PieBean>();
		for(int c=0;c<2;c++){
			PieBean pb5=new PieBean();
			
			Boolean a=false;
			String na="";
			if(c==0){
				a=false;
				 na="未确认";
			}else{
				 na="确认";
				 a=true;
			}
			DetachedCriteria dCriteria8=DetachedCriteria.forClass(Bug.class);
			dCriteria8.add(Restrictions.in("module", moduleList)).add(Restrictions.eq("confirm", a));
			List<Bug> bug5=  rService.queryAllOfCondition(Bug.class, dCriteria8);
			int num4=bug5.size();
			String baifenbi5=getBaifenBi(num4, sumBug);
		
			pb5.setLabel(na);
			pb5.setColor(colors[c%12]);
			pb5.setValue(num4);
			pb5.setLabelColor(nameColor);
			pb5.setLabelFontSize(nameSize);
			pb5.setBfb(baifenbi5);
			pieList5.add(pb5);
		}
		JSONArray js4= JSONArray.fromObject(pieList5);
		
		//指派给统计
		DetachedCriteria dCriteria9=DetachedCriteria.forClass(Department.class);
		dCriteria9.add(Restrictions.eq("company", company));
		List<Department> deptList=rService.queryAllOfCondition(Department.class, dCriteria9);
		
		DetachedCriteria dCriteria12=DetachedCriteria.forClass(Developer.class);
		dCriteria12.createCriteria("user").add(Restrictions.in("department", deptList));
		List<Developer> userList=rService.queryAllOfCondition(Developer.class, dCriteria12);
		
		List<PieBean> pieList6=new ArrayList<PieBean>();
		JSONArray js5=new JSONArray();
		JSONArray js6=new JSONArray();
		for(int v=0;v<userList.size();v++){
			PieBean pb6=new PieBean();
			Developer develop=userList.get(v);
			String realname=develop.getUser().getRealName();
			js5.add(v,realname);
			
			DetachedCriteria dCriteria11=DetachedCriteria.forClass(Bug.class);
			dCriteria11.add(Restrictions.in("module", moduleList)).add(Restrictions.eq("assignedTo", develop));
			List<Bug> bug6=  rService.queryAllOfCondition(Bug.class, dCriteria11);
			
			js6.add(v,bug6.size());
			String baifenbi6=getBaifenBi(bug6.size(), sumBug);
			pb6.setValue(bug6.size());
			pb6.setLabel(realname);
			pb6.setBfb(baifenbi6);
			pieList6.add(pb6);
			
		}
	// 每天提交的bug  曲线图
		JSONArray js7=getDateString(10);
		String[] str=getDate(10);
	
		int[] value={0,0,0,0,0,0,0,0,0,0};
		for(int b=0;b<bugList.size();b++){
			Bug bug0=bugList.get(b);
			Date dd1=bug0.getCreatedAt();
			
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			String dd = df.format(dd1);
		
			for(int n = 0;n<str.length;n++){
				
				if(dd.equals(str[n])){
					value[n]=value[n]+1;
					break;
				}
				
			}
		}
		List<PieBean> pieList7=new ArrayList<PieBean>();
		for(int k=0;k<value.length;k++){
			
			PieBean pb7=new PieBean();
			pb7.setLabel(str[k]);
			pb7.setValue(value[k]);
			String baifenbi7=getBaifenBi(value[k], sumBug);
			pb7.setBfb(baifenbi7);
			pieList7.add(pb7);
		}
		JSONArray js8= JSONArray.fromObject(value);
		//提交Bug最多的10人
		
		DetachedCriteria dCriteria13=DetachedCriteria.forClass(User.class);
		dCriteria13.add(Restrictions.in("department", deptList));
		List<User> userList1=rService.queryAllOfCondition(User.class, dCriteria13);
		List<PieBean> pieList8=new ArrayList<PieBean>();
		for(int p=0;p<userList1.size();p++){
			PieBean pb8=new PieBean();
			User user=userList1.get(p);
			DetachedCriteria dCriteria11=DetachedCriteria.forClass(Bug.class);
			dCriteria11.add(Restrictions.in("module", moduleList)).add(Restrictions.eq("creator", user));
			List<Bug> bug7=  rService.queryAllOfCondition(Bug.class, dCriteria11);
			int intsum=bug7.size();
			pb8.setLabel(user.getRealName());
			pb8.setValue(intsum);
			String baifenbi8=getBaifenBi(intsum, sumBug);
			pb8.setBfb(baifenbi8);
			pieList8.add(pb8);
		}
		Comparator<PieBean> cc= new Comparator<PieBean>() {
			public int compare(PieBean o1, PieBean o2) {
				return o2.getValue()-o1.getValue();
			}
		};
		JSONArray js9=new JSONArray();
		JSONArray js10=new JSONArray();
		Collections.sort(pieList8, cc);
		List<PieBean> pieList9=new ArrayList<PieBean>();
		int size=0;
		if(pieList8.size()>10){
			size=10;
		}else{
			size=pieList8.size();
		}
		for(int s=0;s<size;s++){
			PieBean pb9=pieList8.get(s);
			js9.add(s, pb9.getLabel());
			js10.add(s, pb9.getValue());
			pieList9.add(pb9);
		}
		ModelMap map=new ModelMap();
		map.put("json", json);
		map.put("js", js);
		map.put("js1", js1);
		map.put("js2", js2);
		map.put("js3", js3);
		map.put("js4", js4);
		map.put("js5", js5);
		map.put("js6", js6);
		map.put("js7", js7);
		map.put("js8", js8);
		map.put("js9", js9);
		map.put("js10", js10);
		
		map.put("pieList", pieList);
		map.put("pieList1", pieList1);
		map.put("pieList2", pieList2);
		map.put("pieList3", pieList3);
		map.put("pieList4", pieList4);
		map.put("pieList5", pieList5);
		map.put("pieList6", pieList6);
		map.put("pieList7", pieList7);
		map.put("pieList9", pieList9);
		return new ModelAndView("/reportChart/reportChart" ,map);
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
