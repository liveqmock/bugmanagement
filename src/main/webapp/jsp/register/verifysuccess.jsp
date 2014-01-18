<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆-BUGMM</title>

<link rel="stylesheet" href="<c:url value="/css/min.css"/>" type="text/css" media="screen">
<script src="<c:url value="/js/all.js"/>" type="text/javascript"></script>
<script src="<c:url value="/js/jquery-1.8.3.min.js"/>" type="text/javascript"></script>
<link rel="stylesheet" href="<c:url value="/css/zh-cn.default.css"/>" type="text/css" media="screen">
<link rel="icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon">
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon">
<link type="text/css" rel="stylesheet" href="<c:url value="/css/safari.css"/>">
<link type="text/css" rel="stylesheet" href="<c:url value="/css/login.css"/>">



</head>
<body>
	

	<div id="container">
		<div id="logo"></div>
		<div id="login-panel">
			<div class="panel-head">
				<h3>欢迎使用『大数据』 BUG管理</h3>
			</div>
			<div class="panel-content" id="login-form">
				<h1 style="margin-left: 80px;">恭喜您激活成功成功，马上返回登录！</h1>
				<a href="goLoginPage.htm" type="button"class="button-s" style="margin-left: 80px;">登陆</a>
			</div>
		</div>

		<p style="margin-top: 25px; color: #fff; text-align: center">
			<span class="copyright">©2013 BUGManagement.COM 陕ICP备1102461-7</span>
		</p>
	</div>

</body>
</html>