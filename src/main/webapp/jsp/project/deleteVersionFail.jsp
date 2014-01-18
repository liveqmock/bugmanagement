<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>删除版本</title>

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
				<h3>删除版本错误</h3>
			</div>
			<div class="panel-content" id="login-form">
				<br>
				<p style="margin-left: 80px;">该版本下拥有bug或测试任务。先删除这些内容再删除版本。 <a href="javascript:history.go(-1);">返回上一页</a></p>
			</div>
		</div>

	</div>

</body>
</html>