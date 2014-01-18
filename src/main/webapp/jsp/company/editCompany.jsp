<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
<title>我的地盘::大数据 - BUG管理</title>
<script type="text/javascript">
	var config = {
		"webRoot" : "\/",
		"cookieLife" : 30,
		"requestType" : "PATH_INFO",
		"pathType" : "clean",
		"requestFix" : "-",
		"moduleVar" : "m",
		"methodVar" : "f",
		"viewVar" : "t",
		"defaultView" : "html",
		"themeRoot" : "\/css\/theme\/",
		"currentModule" : "dept",
		"currentMethod" : "browse",
		"clientLang" : "zh-cn",
		"requiredFields" : "",
		"submitting" : "\u7a0d\u5019...",
		"save" : "\u4fdd\u5b58",
		"router" : "\/company\/dept"
	};
</script>
<link rel='stylesheet'
	href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css'
	media='screen' />
<link rel="icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon" />
<script src='<c:url value="/js/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet'
	href='<c:url value="/css/theme/default/zh-cn.default.css"/>'
	type='text/css' media='screen' />
<style>
.table-1 input {
	margin-bottom: 3px
}
</style>
<link rel='icon' href='<c:url value="/pic/logo.png"/>'
	type='image/x-icon' />
<link rel='shortcut icon' href='<c:url value="/pic/logo.png"/>'
	type='image/x-icon' />
<link rel="stylesheet"
	href='<c:url value="/css/theme/default/dropmenu.css"/>' type="text/css"
	media="screen" />
<link rel="stylesheet"
	href="<c:url value="/css/theme/default/index.css"/>" type="text/css"
	media="screen" />
</head>
<body>
	<div id='header'>
		<table class='cont navbar' id='topbar'>
			<tr>
				<td class='w-p50'><span id='companyname'>${company.name}</span>
				</td>
				<td class='a-right'>今天是${year}年${month}月${day}日，星期${week}，${user.realName}<a
					href="<c:url value="/j_spring_security_logout" />">退出</a>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<table class='cont navbar' id='navbar'>
			<tr>
				<td id='mainmenu'>
					<ul>
						<li ><a href='turnToHomePage.htm'
							 id='menumy'><i class="icon-home"></i> 我的地盘</a></li>
						<li><a href='goPerExceptionRecord.htm' id='menuproject'>异常</a></li>
						<li><a href='question.htm' id='menucompany'>问答</a></li>
						<li><a href='bug.htm' id='menuwebapp'>BUG</a></li>
						<li><a href='usecase.htm' id='menureport'>用例</a></li>
						<li><a href='taskList.htm' id='menuqa'>测试</a></li>
						<li><a href='projectList.htm' id='menuproject'>项目</a></li>
						<li class='active'><a class='active' href='goDept.htm' id='menucompany'>组织</a></li>
					</ul>
				</td>
			</tr>
		</table>
	</div>
	<div class="navbar" id="modulemenu">
		<ul>
			<li><span id="myname"><i class="icon-user"></i>
					${user.realName}&nbsp;<span class="icon-angle-right"></span></span></li>
			<li ><a href='goDept.htm' target='' id='submenudept'>部门</a></li>
			<li class=' '><a href='goToUserList.htm' target='' id='submenubrowseUser'>用户</a></li>
			<li class=''><a href='goDynamic.htm' target='' id='submenudept'>动态</a></li>
			<li class=' active '><a href='goCompanyInfo.htm' target='' id='submenudept'>公司</a></li>
		</ul>
	</div>
	<div id="wrap">
		<div class="outer" style="min-height: 685px;">
			<form method="post" target="hiddenwin" action="editCompanyInfo.htm">
				<table align="center" class="table-4 a-left">
					<caption>更新信息</caption>
					<tbody>
						
						<tr>
							<th class="rowhead">公司名</th>
							<td><input type="text" name="name" id="account"
								value="${company1.name}"><span class="star"> * </span>
							</td>
						</tr>
						<tr>
							<th class="rowhead">公司创建人</th>
							<td>${company1.user.name}</td>
						</tr>
						
						<tr>
							<th class="rowhead">公司电话</th>
							<td><input type="text" name="phone" id="phone"
								value="${company1.phone}"></td>
						</tr>
						<tr>
							<th class="rowhead">公司地址</th>
							<td><input type="text" name="adress" id="address"
								value="${company1.address}"></td>
						</tr>
						<tr>
							<th class="rowhead">公司邮编</th>
							<td><input type="text" name="zipcode" id="zipcode"
								value="${company1.zipcode}"></td>
						</tr>
						<tr>
							<th class="rowhead">创建日期</th>
							<td><fmt:formatDate value="${company1.createdAt}" /></td>
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
	<div id='footer'>
		<div id="crumbs">
			<a href=''>BUG管理</a> &nbsp;<span class="icon-angle-right"></span><a
				href=''>我的地盘</a>
		</div>
		<div id="poweredby">
			<span>Powered by <a href=''>SICD</a>
			</span>
		</div>
	</div>
	<script language='Javascript'>
		onlybody = "no";
	</script>
</body>
</html>
