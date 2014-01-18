<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>访问受限 - BUG管理</title>

<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<script src='<c:url value="/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<link rel="icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon" />
</head>
<body>
<table align='center' class='table-3'> 
  <caption>${user.name } 访问受限</caption>
  <tr>
    <td>
      抱歉，您无权执行该操作。请联系管理员获取权限。<br /><br />点击<a href="javascript:history.go(-1);">后退</a>返回上页。<br /><br /><a href='turnToHomePage.htm' >我的地盘</a>
<a href="<c:url value="/j_spring_security_logout" />" >重新登录</a>
    </td>
  </tr>  
</table>
</body>
</html>
