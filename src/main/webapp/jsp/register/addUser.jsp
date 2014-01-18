<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加用户-BUG管理</title>

<link rel="stylesheet" href="<c:url value="/css/theme/fontawesome/min.css"/>" type="text/css" media="screen">
<script src="<c:url value="/js/all.js"/>" type="text/javascript"></script>
<script src="<c:url value="/js/jquery-1.8.3.min.js"/>" type="text/javascript"></script>
<link rel="stylesheet" href="<c:url value="/css/theme/default/zh-cn.default.css"/>" type="text/css" media="screen">
<link rel="icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon">
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon">
<link type="text/css" rel="stylesheet" href="<c:url value="/css/theme/browser/safari.css"/>">

</head>
<body>
	<jsp:include page="../company/includeHeader.jsp"></jsp:include>
	
	<div class="navbar" id="modulemenu">
		<ul>
			<li>${company.name }&nbsp;<span class="icon-angle-right"></span></li>
			<li class=" active"><a href="goToUserList.htm" target=""id="submenubrowseUser">用户</a></li>
			<li class=" "><a href="goDept.htm"target="" id="submenudept">部门</a></li>
			<li class=" "><a href="goDynamic.htm" target=""id="submenudynamic">动态</a></li>
			<li class="right "><a href="goaddUser.htm" target=""id="submenuaddUser"><i class="icon-plus"></i>&nbsp;添加用户</a></li>
			<li class=" "><a href="goCompanyInfo.htm" target="" id="submenuview">公司</a></li>
		</ul>
	</div>
	<div id="wrap">
		<div class="outer" style="min-height: 628.8068181276321px;">
		

			<form method="post" target="hiddenwin" id="dataform" action="addUser.htm">
				<table align="center" class="table-5">
					<caption>添加用户</caption>
					<tbody>
						<tr>
							<th class="rowhead">所属部门</th>
							<td><select name="deptId" id="dept" class="select-3">
							
									<option value="0" selected="selected">请选择</option>
									<c:forEach items="${deptBeans}" var="deptBean">
										<option value="${deptBean.deptId}">/${deptBean.deptName}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th class="rowhead">用户名</th>
							<td><input type="text" name="name" id="account" value=""
								class="text-3" autocomplete="off"
								placeholder="英文、数字和下划线的组合，三位以上"><span class="star">
										* </span></td>
						</tr>
						<tr>
							<th class="rowhead">真实姓名</th>
							<td><input type="text" name="realName" id="realname"
								value="" class="text-3"><span class="star"> * </span></td>
						</tr>
						<tr>
							<th class="rowhead">密码</th>
							<td><input type="password" name="password" id="password"
								value="" class="text-3" autocomplete="off" placeholder="六位以上"><span
									class="star"> * </span></td>
						</tr>
						<tr>
							<th class="rowhead">请重复密码</th>
							<td><input type="password" name="password2" id="password2"
								value="" class="text-3" autocomplete="off"><span
									class="star"> * </span></td>
						</tr>
						<tr>
							<th class="rowhead">职位</th>
							<td><select name="position" id="role" class="select-3">
									<option value="" selected="selected"></option>
									<option value="dev">开发人员</option>
									<option value="qa">测试人员</option>
									<option value="others">其他</option>
							</select> 职位影响内容和用户列表的顺序。</td>
						</tr>
						<tr>
							<th class="rowhead">邮箱</th>
							<td><input type="text" name="email" id="email" value=""
								class="text-3"></td>
						</tr>
						<tr>
							<th class="rowhead">性别</th>
							<td><input type="radio" name="gender" value="男"
								checked="checked" id="genderm"><label for="genderm">男</label>
									<input type="radio" name="gender" value="女" id="genderf"><label
										for="genderf">女</label></td>
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
