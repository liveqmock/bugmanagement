<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="pt" uri="/page-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<script src="<c:url value="/js/jquery-1.8.3.min.js"/>"
	type="text/javascript"></script>
<script src="<c:url value="/js/Chart.js"/>" type="text/javascript"></script>

<link rel="stylesheet"
	href="<c:url value="/css/theme/fontawesome/min.css"/>" type="text/css"
	media="screen">

<link rel="stylesheet"
	href="<c:url value="/css/theme/default/zh-cn.default.css"/>"
	type="text/css" media="screen">
	<script src='<c:url value="/js/js/all.js"/>' type='text/javascript'></script>
<link rel="icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon">
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/css/theme/browser/safari.css"/>">
<title>异常</title>
<script type="text/javascript">var config={"webRoot":"\/css\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/css\/theme\/","currentModule":"bug","currentMethod":"browse","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/css\/index.php\/bug-browse-1.html"}
</script>
<script type="text/javascript">
	$(function() {
		//饼图1
		var pieData =
<%=request.getAttribute("js4")%>
	;
		var ctx = $("#myChart").get(0).getContext("2d");
		var myNewChart = new Chart(ctx);
		myNewChart.Pie(pieData, {
			animationSteps : 100,
			animationEasing : 'easeOutBounce'
		});

		var pieData1 =
<%=request.getAttribute("js5")%>
	;
		var ctx1 = $("#myChart2").get(0).getContext("2d");
		var myNewChart1 = new Chart(ctx1);
		myNewChart1.Pie(pieData1, {
			animationSteps : 100,
			animationEasing : 'easeOutBounce'
		});
		
		
		var linedata = {
				labels :  <%=request.getAttribute("js2")%>,
				datasets : [
					{
						fillColor : "rgba(151,187,205,0.5)",
						strokeColor : "rgba(151,187,205,1)",
						pointColor : "rgba(151,187,205,1)",
						pointStrokeColor : "#fff",
						data : <%=request.getAttribute("js3")%>
					}
				]
			};
		var ctx2 = $("#myChart1").get(0).getContext("2d");
		var myNewChart2= new Chart(ctx2);
		myNewChart2.Line(linedata,{
			animationSteps: 100,
			animationEasing: 'easeOutBounce'
		});

	});
	
</script>
</head>
<body>
	<div id="header">
		<table class='cont navbar' id='topbar'>
			<tr>
				<td class='w-p50'><span id="companyname">${company.name}</span>
				</td>
				<td class='a-right'>今天是${year}年${month}月${day}，星期${week}，${user.realName}<a
					href="<c:url value="/j_spring_security_logout" />">退出</a>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<table class='cont navbar' id='navbar'>
			<tr>
				<td id='mainmenu'>
					<ul>
						<li><a href='goIndex.htm' class='active'
							id='menumy'><i class="icon-home"></i>概况统计</a></li>
						<li><a href='goCompanyList.htm' id='menuproject'>公司列表</a></li>
						<li><a href='goProjectList.htm' id='menuwebapp'>项目列表</a></li>
						<li class='active'><a href='goUserList.htm' id='menureport'>用户列表</a></li>
						<li><a href='goLogList.htm' id='menuqa'>所有日志</a></li>
					</ul>
				</td>
			</tr>
		</table>
	</div>





	<div class="navbar" id="modulemenu">
		<ul>
			<li><span id="myname"><i class="icon-user"></i>
					${user.realName}&nbsp;<span class="icon-angle-right"></span></span></li>
			<li class=" active"><a href="" target="" id="submenuindex">用户列表</a>
			</li>
			
		</ul>
	</div>

	<div id="wrap">
		<div class="outer" style="min-height: 628.8068181276321px;">
		
			<script type="text/javascript">
     $(function()
       {
            $('.colored').colorize();
            $('tfoot td').css('background', 'white').unbind('click').unbind('hover');
       }
       );
    </script>
			<table class="cont-lt1">
				<tbody>
					<tr valign="top" style="overflow: auto;">
						<td width="65%" style="overflow: auto;">
							<div class="box-title" style="overflow: auto; width: 96%;">所有用户列表</div>
							<div class="box-content"
								style="overflow: auto; width: 96%; padding-right: 11px;">
								<table class="table-1 fixed colored">
										<tbody>
														<tr>
															<th style="width: 16%">用户ID</th>
															<th style="width: 16%">真实姓名</th>
															<th style="width: 16%">职位</th>
															<th style="width: 20%">邮箱</th>
															<th style="width: 16%">加入时间</th>
															<th style="width: 16%">所属公司</th>
														</tr>
														<c:forEach items="${userList}" var="user">
														<tr class="a-center"
															style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
															<td>${user.userId}</td>
															<td>${user.realName}</td>
															<td>${user.position}</td>
															<td>${user.email}</td>
															<td><fmt:formatDate value="${user.joinDate}"/></td>
															<td>${user.department.company.name}</td>
														</tr>
													</c:forEach>
													</tbody>
													<tfoot>
										<tr
											style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
											<td colspan="12"
												style="background-color: white; background-position: initial initial; background-repeat: initial initial;">

												<div class="f-right">
								<pt:page totalSize="${totalSize }" pageSize="${pageSize }" url="${url }" curPage="${curPage }"></pt:page>
												</div>
											</td>
										</tr>
									</tfoot>
									</table>
							</div>
						</td>
						<td class="divider"></td>
						<td style="width: 35%">
							<table class="table-1">
								<caption>
									<div class="f-left">统计</div>
									<div class="f-right">
										<a href="">返回</a>
									</div>
								</caption>
								<tbody>
									<tr valign="top" style="border-bottom: 1px solid #EEE">
										<td class="a-center">
											<div style="height: 200px; overflow: auto">
												<table class="table-1 colored">
													<caption>按职位统计用户</caption>
													<tbody>
														<tr>
															<th>职位</th>
															<th>个数</th>
															<th>百分比</th>
														</tr>
														<c:forEach var="pie" items="${pieList1}">
															<tr class="a-center"
																style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
																<td>${pie.label}</td>
																<td>${pie.value}</td>
																<td>${pie.bfb}</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
											<div id="chart1div" class="chartDiv">
												<canvas id="myChart" width="250" height="250"></canvas>
											</div>
										</td>
									</tr>
									<tr valign="top" style="border-bottom: 1px solid #EEE">
										<td class="a-center">
											<div style="height: 300px; overflow: auto">
												<table class="table-1 colored">
													<caption>最近10天加入的用户</caption>
													<tbody>
														<tr>
															<th>日期</th>
															<th>个数</th>
															<th>百分比</th>
														</tr>
														<c:forEach var="pie1" items="${pieList}">
															<tr class="a-center"
																style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
																<td>${pie1.label}</td>
																<td>${pie1.value}</td>
																<td>${pie1.bfb}</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
											<div id="chart1div" class="chartDiv">
												<canvas id="myChart1" width="400" height="280"></canvas>
											</div>
										</td>
									</tr>
									<tr valign="top" style="border-bottom: 1px solid #EEE">
										<td class="a-center">
											<div style="height: 200px; overflow: auto">
												<table class="table-1 colored">
													<caption>按照性别统计</caption>
													<tbody>
														<tr>
															<th>性别</th>
															<th>个数</th>
															<th>百分比</th>
														</tr>
														<c:forEach var="pie2" items="${pieList2}">
															<tr class="a-center"
																style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
																<td>${pie2.label}</td>
																<td>${pie2.value}</td>
																<td>${pie2.bfb}</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
											<div id="chart1div" class="chartDiv">
												<canvas id="myChart2" width="250" height="250"></canvas>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>

		</div>
		<div id="divider"></div>
	</div>
	<div id="footer">
		<div id="crumbs">
			<a href="http://demo.zentao.net/my/">禅道管理</a> &nbsp;<span
				class="icon-angle-right"></span><a href="http://demo.zentao.net/qa/">测试</a>
			&nbsp;<span class="icon-angle-right"></span><a
				href="http://demo.zentao.net/bug-browse-12.html">测试</a> &nbsp;<span
				class="icon-angle-right"></span>报表统计
		</div>
	</div>
</body>
</html>