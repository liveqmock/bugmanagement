<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加用户-BUG管理</title>
<script language='Javascript'>var config={"webRoot":"\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/theme\/","currentModule":"testtask","currentMethod":"create","clientLang":"zh-cn","requiredFields":"project,build,begin,end,name","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/index.php\/testtask-create-12.html"}
</script>
<link rel="stylesheet" href="<c:url value="/css/theme/fontawesome/min.css"/>" type="text/css" media="screen">
<script src="<c:url value="/js/all.js"/>" type="text/javascript"></script>

<link rel="stylesheet" href="<c:url value="/css/theme/default/zh-cn.default.css"/>" type="text/css" media="screen">
<link rel="icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon">
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon">
<link type="text/css" rel="stylesheet" href="<c:url value="/css/theme/browser/safari.css"/>">
<script src='<c:url value="/js/js/misc/date.js" />' type='text/javascript'></script>
</head>
<script type="text/javascript">
Date.firstDayOfWeek = 1;
Date.format = 'yyyy-mm-dd';
$.dpText = {"TEXT_OR":"\u6216 ","TEXT_PREV_YEAR":"\u53bb\u5e74","TEXT_PREV_MONTH":"\u4e0a\u6708","TEXT_PREV_WEEK":"\u4e0a\u5468","TEXT_YESTERDAY":"\u6628\u5929","TEXT_THIS_MONTH":"\u672c\u6708","TEXT_THIS_WEEK":"\u672c\u5468","TEXT_TODAY":"\u4eca\u5929","TEXT_NEXT_YEAR":"\u660e\u5e74","TEXT_NEXT_MONTH":"\u4e0b\u6708","TEXT_CLOSE":"\u5173\u95ed","TEXT_DATE":"\u9009\u62e9\u65f6\u95f4\u6bb5","TEXT_CHOOSE_DATE":"\u9009\u62e9\u65e5\u671f"}
Date.dayNames     = ["\u65e5","\u4e00","\u4e8c","\u4e09","\u56db","\u4e94","\u516d"];
Date.abbrDayNames = ["\u65e5","\u4e00","\u4e8c","\u4e09","\u56db","\u4e94","\u516d"];
Date.monthNames   = ["\u4e00\u6708","\u4e8c\u6708","\u4e09\u6708","\u56db\u6708","\u4e94\u6708","\u516d\u6708","\u4e03\u6708","\u516b\u6708","\u4e5d\u6708","\u5341\u6708","\u5341\u4e00\u6708","\u5341\u4e8c\u6708"]; 

$(function() {
    $('.date').each(function(){
        time = $(this).val();
        if(!isNaN(time) && time != ''){
            var Y = time.substring(0, 4);
            var m = time.substring(4, 6);
            var d = time.substring(6, 8);
            time = Y + '-' + m + '-' + d;
            $('.date').val(time);
        }
    });
    startDate = new Date(1970, 1, 1);
    $(".date").datePicker({createButton:true, startDate:startDate})
        .dpSetPosition($.dpConst.POS_TOP, $.dpConst.POS_RIGHT)
});
</script>
<body>
	<jsp:include page="../company/includeHeader.jsp"></jsp:include>
	
	<div class="navbar" id="modulemenu">
		<ul>
			<li>${company.name }&nbsp;<span class="icon-angle-right"></span></li>
			<li class=" active"><a href="goaddUser.htm" target=""id="submenubrowseUser">用户</a></li>
			<li class=" "><a href="goDept.htm"target="" id="submenudept">部门</a></li>
			<li class=" "><a href="goDynamic.htm" target=""id="submenudynamic">动态</a></li>
			<li class="right "><a href="goaddUser.htm" target=""id="submenuaddUser"><i class="icon-plus"></i>&nbsp;添加用户</a></li>
			<li class=" "><a href="goCompanyInfo.htm" target="" id="submenuview">公司</a></li>
		</ul>
	</div>
	<div id="wrap">
		<div class="outer" style="min-height: 628.8068181276321px;">
			<form method="post" target="hiddenwin" id="dataform" action="editUser.htm">
			<input type="hidden" value="${user1.userId}" name="userId">
				<table align="center" class="table-5">
					<caption>编辑用户</caption>
					<tbody>
						<tr>
							<th class="rowhead">所属部门</th>
							<td><select name="deptId" id="dept" class="select-3">
									<option value="${user1.department.departmentId}" selected="selected">${user1.department.name}</option>
									<c:forEach items="${all}" var="deptBean">
										<option value="${deptBean.deptId}">/${deptBean.deptName}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th class="rowhead">用户名</th>
							<td><input type="text" name="name" id="account" value="${user1.name}"
								class="text-3" autocomplete="off"
								placeholder="英文、数字和下划线的组合，三位以上"><span class="star">
										* </span></td>
						</tr>
						<tr>
							<th class="rowhead">真实姓名</th>
							<td><input type="text" name="realName" id="realname"
								value="${user1.realName}" class="text-3"><span class="star"> * </span></td>
						</tr>
						
						<tr>
							<th class="rowhead">职位</th>
							<td><select name="position" id="role" class="select-3">
									<option value="${user1.position}" selected="selected">${user1.position}</option>
									<option value="dev">开发人员</option>
									<option value="qa">测试人员</option>
							</select> 职位影响内容和用户列表的顺序。</td>
						</tr>
						<tr>
							<th class="rowhead">邮箱</th>
							<td><input type="text" name="email" id="email" value="${user1.email}"
								class="text-3"></td>
						</tr>
						<tr>
							<th class='rowhead'>加入日期</th>
      						<td><input type='text' name='joinDate' id='begin' value='${user1.joinDate}' class='text-3 date' onchange='computeWorkDays()' />
						</tr>
						<tr>
							<td colspan="2" class="a-center"><input type="submit"
								id="submit" value="保存" class="button-s"> <input
									type="button" onclick="javascript:history.go(-1);" value="返回"
									class="button-b"></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		<div id="divider"></div>
	</div>
	<div id="footer">
		<div id="crumbs">
			<a href="">禅道管理</a> &nbsp;<span
				class="icon-angle-right"></span><a
				href="">组织</a> &nbsp;<span
				class="icon-angle-right"></span>添加用户
		</div>
	</div>
</body>
</html>
