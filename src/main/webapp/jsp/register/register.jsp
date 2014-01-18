<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册-BUGMM</title>

<link rel="stylesheet" href="<c:url value="/css/min.css"/>" type="text/css" media="screen">
<script src="<c:url value="/js/all.js"/>" type="text/javascript"></script>
<script src="<c:url value="/js/register.js"/>" type="text/javascript"></script>
<script src="<c:url value="/js/jquery-1.8.3.min.js"/>" type="text/javascript"></script>
<link rel="stylesheet" href="<c:url value="/css/zh-cn.default.css"/>" type="text/css" media="screen">
<link rel="icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon">
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon">
<link type="text/css" rel="stylesheet" href="<c:url value="/css/safari.css"/>">
<link type="text/css" rel="stylesheet" href="<c:url value="/css/register.css"/>">



</head>
<body>
	

	<div id="container">
		<div id="logo"></div>
		<div id="login-panel">
			<div class="panel-head">
				<h2>欢迎注册</h2>
			</div>
			<div class="panel-content" id="login-form">
				<form method="post" action="userRegister.htm" name="form1">
					<table>
						<tbody>
							<tr>
								<td class="attr">邮箱</td>
								<td><input class="text-2" type="text" name="userEmail"
									id="account" onblur="checkReg(0)">
									<span id="email"></span>
								</td>
								
							</tr>
							<tr>
								<td class="attr">用户名</td>
								<td><input class="text-2" type="text" name="userName"
									id="account" onblur="checkReg(1)">
									<span id="name"></span></td>
							</tr>
							<tr>
								<td class="attr">公司名</td>
								<td><input class="text-2" type="text" name="companyname"
									id="account" onblur="checkReg(2)">
									<span id="company"></span></td>
							</tr>
							<tr>
								<td class="attr">性别</td>
								<td><input type="radio" name="userGender" required="required" value="男" checked="checked"><label for="signup_gender_0" class="required">男</label><input type="radio" id="signup_gender_1" name="userGender" required="required" value="女"><label for="signup_gender_1" class="required">女</label></td>
							</tr>
							
							<tr>
								<td class="attr">密码</td>
								<td><input class="text-2" type="password" name="userPassword"
									id="account" onblur="checkPwd()">
									<span id="pwd"></span></td>
							</tr>
							<tr>
								<td class="attr">再次输入</td>
								<td><input class="text-2" type="password" name="txtRpewd"
									id="account" onblur="checkRpwd()">
									<span id="Rpwd"></span></td>
							</tr>
							
							<tr>
								<td class="attr"></td>
								<td><input type="button" id="loginOK" value="注册"
									class="button-s" onclick="validate()"></td>
							</tr>
							<tr>
								<td class="attr"></td>
								<td>已有账号？点击<a href="newLogin.htm">这里登录。</a></td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>


			<div id="demoUsers" class="panel-foot">
				<span></span> 

			</div>

		</div>

		<p style="margin-top: 25px; color: #fff; text-align: center">
			<span class="copyright">©2013 BUGManagement.COM 陕ICP备1102461-7</span>
		</p>
	</div>

</body>
</html>