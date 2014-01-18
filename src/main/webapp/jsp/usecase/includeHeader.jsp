<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/" var="basePath" />

<div id='header'>
	<table class='cont navbar' id='topbar'>
		<tr>
			<td class='w-p50' id='companyname'>${company.name}</td>
			<td class='a-right'>今天是${year}年${month}月${day}日，星期${week}，${user.realName}<a
				href="<c:url value="/j_spring_security_logout" />">退出</a>&nbsp;&nbsp;
			</td>
		</tr>
	</table>
	<table class='cont navbar' id='navbar'>
		<tr>
			<td id='mainmenu'>
				<ul>
					<li><a href='${basePath}turnToHomePage.htm' class='active' id='menumy'><i
							class="icon-home"></i> 我的地盘</a></li>
					<li><a href='${basePath}goPerExceptionRecord.htm' id='menuproject'>异常</a></li>
					<li><a href='${basePath}question.htm' id='menucompany'>问答</a></li>
					<li><a href='${basePath}bug.htm' id='menuwebapp'>BUG</a></li>
					<li class='active'><a href='${basePath}usecase.htm' id='menureport'>用例</a></li>
					<li><a href='${basePath}taskList.htm' id='menuqa'>测试</a></li>
					<li><a href='${basePath}projectList.htm' id='menuproject'>项目</a></li>
					<li><a href='${basePath}goDept.htm' id='menucompany'>组织</a></li>
				</ul>
			</td>
		</tr>
	</table>
</div>