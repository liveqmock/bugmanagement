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
						<li class='active'><a href='turnToHomePage.htm'
							class='active' id='menumy'><i class="icon-home"></i> 我的地盘</a></li>
						<li><a href='goPerExceptionRecord.htm' id='menuproject'>异常</a></li>
						<li><a href='question.htm' id='menucompany'>问答</a></li>
						<li><a href='bug.htm' id='menuwebapp'>BUG</a></li>
						<li><a href='usecase.htm' id='menureport'>用例</a></li>
						<li><a href='taskList.htm' id='menuqa'>测试</a></li>
						<li><a href='projectList.htm' id='menuproject'>项目</a></li>
						<li><a href='goDept.htm' id='menucompany'>组织</a></li>
					</ul>
				</td>
			</tr>
		</table>
	</div>
	<div class="navbar" id="modulemenu">
		<ul>
			<li><span id="myname"><i class="icon-user"></i>
					${user.realName}&nbsp;<span class="icon-angle-right"></span></span></li>
			<li ><a href="turnToHomePage.htm" target=""
				id="submenuindex">首页</a></li>
			<li class=" active"><a href="goMyInfo.htm" target="" id="submenuprofile">档案</a></li>
			<li class=" "><a href="goDynamic.htm" target="" id="submenuprofile">动态</a>
</li>
		</ul>
	</div>
	<div id="wrap">
		<div class="outer" style="min-height: 731px;">
			<script src="/js/jquery/jquerytools/min.js" type="text/javascript"></script>
			<script>
				/* sort table after page load. */
				$(function() {
					sortTable();
				});

				function sortTable() {
					$('.tablesorter').tablesorter({
						widgets : [ 'zebra' ],
						widgetZebra : {
							css : [ 'odd', 'even' ]
						}
					});
					$('.tablesorter tbody tr').hover(function() {
						$(this).addClass('hoover')
					}, function() {
						$(this).removeClass('hoover')
					});

					/* IE6下面click事件和colorbox冲突。暂时去除该功能。*/
					if ($.browser.msie
							&& Math.floor(parseInt($.browser.version)) == 6)
						return;
					$('.tablesorter tbody tr').click(function() {
						if ($(this).attr('class').indexOf('clicked') > 0) {
							$(this).removeClass('clicked');
						} else {
							$(this).addClass('clicked');
						}
					});
				}
			</script>
			<table align="center" class="table-4">
				<caption>
					<div class="f-left">我的档案</div>
					<div class="f-right">
						<a href="goEditMyInfo.htm">修改档案</a>
					</div>
				</caption>
				<tbody>
					<tr>
						<th class="rowhead">所属部门</th>
						<td>${user1.department.name}</td>
					</tr>

					<tr>
						<th class="rowhead">用户名</th>
						<td>${user1.name}</td>
					</tr>
					<tr>
						<th class="rowhead">真实姓名</th>
						<td>${user1.realName}</td>
					</tr>
					<tr>
						<th class="rowhead">性别</th>
						<td>${user1.gender}</td>
					</tr>
					<tr>
						<th class="rowhead">职位</th>
						<td>${user1.position}</td>
					</tr>
					<tr>
						<th class="rowhead">邮箱</th>
						<td>${user1.email}</td>
					</tr>
					<tr>
						<th class="rowhead">加入日期</th>
						<td><fmt:formatDate  value="${user1.joinDate}"/></td>
					</tr>
				</tbody>
			</table>
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
