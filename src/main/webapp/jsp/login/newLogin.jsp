<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆-BUG管理</title>

<script>
var config={"webRoot":"\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/css\/theme\/","currentModule":"dept","currentMethod":"browse","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/company\/dept"};
</script>

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
				<form method="post"action="<c:url value='j_spring_security_check' />">
					<table>
						<tbody>
							<tr>
								<td class="attr">邮箱</td>
								<td><input class="text-2" type="text" name="j_username" value="541724998@qq.com"
									id="account"></td>
							</tr>
							<tr>
								<td class="attr">密码</td>
								<td><input class="text-2" type="password" name="j_password" value="111111"
									></td>
							</tr>
							<tr>
								<td class="attr"></td>
								<td><input type="checkbox" name="_spring_security_remember_me" /> Remember Me</td>
							</tr>
							<tr>
								<td class="attr"></td>
								<td><input type="submit" id="submit" value="登录"
									class="button-s"></td>
							</tr>
							<tr>
								<td class="attr"></td>
								<td>没有账号？点击<a href="goRegisterPage.htm">这里注册。</a></td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<div id="demoUsers" class="panel-foot">
				<span><font color="red">${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}</font></span> 
			</div>
		</div>
		<p style="margin-top: 25px; color: #fff; text-align: center">
			<span class="copyright">©2013 BUGManagement.COM 陕ICP备1102461-7</span>
		</p>
	</div>

</body>
</html>