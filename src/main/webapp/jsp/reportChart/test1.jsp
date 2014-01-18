<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="<c:url value="/js/jquery-1.8.3.min.js"/>" type="text/javascript"></script>
<script src="<c:url value="/js/Chart.js"/>" type="text/javascript"></script>
 <link rel="stylesheet"
	href="<c:url value="/css/theme/fontawesome/min.css"/>" type="text/css"
	media="screen">
<link rel="stylesheet"
	href="<c:url value="/css/theme/default/zh-cn.default.css"/>"
	type="text/css" media="screen">
<link rel="icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon">
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon">
<link type="text/css" rel="stylesheet" href="<c:url value="/css/theme/browser/safari.css"/>"> 
<title>Insert title here</title>

<script type="text/javascript">

$(function(){
	
	var pieData = <%=request.getAttribute("json")%>;
	var ctx = $("#myChart").get(0).getContext("2d");

	var myNewChart = new Chart(ctx);
	
	
	myNewChart.Pie(pieData,{
		animationSteps: 100,
		animationEasing: 'easeOutBounce'
	});
	
});
</script>
</head>
<body>
<canvas id="myChart" width="400" height="400"></canvas>
</body>
</html>