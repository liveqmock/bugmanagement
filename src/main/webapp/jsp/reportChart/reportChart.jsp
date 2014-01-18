<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
	<script type="text/javascript" >var config={"webRoot":"\/css\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/css\/theme\/","currentModule":"bug","currentMethod":"browse","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/css\/index.php\/bug-browse-1.html"}
</script>
	<link rel="stylesheet"
	href="<c:url value="/css/theme/default/zh-cn.default.css"/>"
	type="text/css" media="screen">
<link rel="icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon">
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon">
<script src='<c:url value="/js/js/all.js"/>' type='text/javascript'></script>
<link type="text/css" rel="stylesheet" href="<c:url value="/css/theme/browser/safari.css"/>"> 
<title>报表</title>
<script type="text/javascript">

$(function(){
	//饼图1
	var pieData = <%=request.getAttribute("json")%>;
	var ctx = $("#myChart").get(0).getContext("2d");
	var myNewChart = new Chart(ctx);
	myNewChart.Pie(pieData,{
		animationSteps: 100,
		animationEasing: 'easeOutBounce'
	});
	
	
	//柱状图 1
	var bardata = {
			labels : ["代码错误","界面优化","设计缺陷","配置相关","安装部署","安全相关","性能问题","标准规范","测试脚本"],
			datasets : [
				{
					fillColor : "rgba(151,187,205,0.5)",
					strokeColor : "rgba(151,187,205,1)",
					data : <%=request.getAttribute("js")%>
				},
				
			]
		};
	var ctx1 = $("#myChart1").get(0).getContext("2d");
	var myNewChart1 = new Chart(ctx1);
	myNewChart1.Bar(bardata,{
		animationSteps: 100,
		animationEasing: 'easeOutBounce'
	});
	//饼图2
	var pieData1 = <%=request.getAttribute("js1")%>;
	var ctx2 = $("#myChart2").get(0).getContext("2d");
	var myNewChart2 = new Chart(ctx2);
	myNewChart2.Pie(pieData1,{
		animationSteps: 100,
		animationEasing: 'easeOutBounce'
	});
	
	//饼图3
	var pieData2 = <%=request.getAttribute("js2")%>;
	var ctx3 = $("#myChart3").get(0).getContext("2d");
	var myNewChart3 = new Chart(ctx3);
	myNewChart3.Pie(pieData2,{
		animationSteps: 100,
		animationEasing: 'easeOutBounce'
	});
	//饼图4
	var pieData3 = <%=request.getAttribute("js3")%>;
	var ctx4 = $("#myChart4").get(0).getContext("2d");
	var myNewChart4 = new Chart(ctx4);
	myNewChart4.Pie(pieData3,{
		animationSteps: 100,
		animationEasing: 'easeOutBounce'
	});
	//饼图5
	var pieData4 = <%=request.getAttribute("js4")%>;
	var ctx5 = $("#myChart5").get(0).getContext("2d");
	var myNewChart5 = new Chart(ctx5);
	myNewChart5.Pie(pieData4,{
		animationSteps: 100,
		animationEasing: 'easeOutBounce'
	});
	
	
	//柱状图 2
	var bardata1 = {
			labels : <%=request.getAttribute("js5")%>,
			datasets : [
				{
					fillColor : "rgba(151,187,205,0.5)",
					strokeColor : "rgba(151,187,205,1)",
					data : <%=request.getAttribute("js6")%>
				},
				
			]
		};
	var ctx6 = $("#myChart8").get(0).getContext("2d");
	var myNewChart6 = new Chart(ctx6);
	myNewChart6.Bar(bardata1,{
		animationSteps: 100,
		animationEasing: 'easeOutBounce'
	});
	
	//曲线图
	
	var linedata = {
			labels :  <%=request.getAttribute("js7")%>,
			datasets : [
				{
					fillColor : "rgba(151,187,205,0.5)",
					strokeColor : "rgba(151,187,205,1)",
					pointColor : "rgba(151,187,205,1)",
					pointStrokeColor : "#fff",
					data : <%=request.getAttribute("js8")%>
				}
			]
		};
	var ctx7 = $("#myChart6").get(0).getContext("2d");
	var myNewChart7= new Chart(ctx7);
	myNewChart7.Line(linedata,{
		animationSteps: 100,
		animationEasing: 'easeOutBounce'
	});
	
	//柱状图 3
	var bardata2 = {
			labels : <%=request.getAttribute("js9")%>,
			datasets : [
				{
					fillColor : "rgba(151,187,205,0.5)",
					strokeColor : "rgba(151,187,205,1)",
					data : <%=request.getAttribute("js10")%>
				},
				
			]
		};
	var ctx8= $("#myChart7").get(0).getContext("2d");
	var myNewChart8 = new Chart(ctx8);
	myNewChart8.Bar(bardata2,{
		animationSteps: 100,
		animationEasing: 'easeOutBounce'
	});
});
</script>
</head>
<body>
	<jsp:include page="../bug/includeHeader.jsp"></jsp:include>

	<div class="navbar" id="modulemenu">
		<ul>
			<jsp:include page="../includeJsp/includeSelectPro.jsp"></jsp:include>
			
			<li class=" active"><a href="bug.htm" target="" id="submenubug">浏览Bug</a></li>
      		<li ><a href="goAddBug.htm" target="" id="submenubug">提Bug</a></li>
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
					<tr valign="top">
						
						<td class="divider"></td>
						<td>
							<table class="table-1">
								<caption>
									<div class="f-left">报表</div>
									<div class="f-right">
										<a href="">返回</a>
									</div>
								</caption>
								<tbody>
									<tr valign="top" style="border-bottom: 1px solid #EEE">
										
										<td class="a-center">
											
											<div id="chart1div" class="chartDiv">
												<canvas id="myChart" width="250" height="250"></canvas>
											</div> 
										</td>
										
										<td width="30%">
											<div style="height: 250px; overflow: auto">
												<table class="table-1 colored">
													<caption>版本Bug统计</caption>
													<tbody>
														<tr>
															<th>版本</th>
															<th>bug数</th>
															<th>百分比</th>
														</tr>
														<c:forEach var="pie" items="${pieList}">
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
										</td>
									</tr>
									
									<tr valign="top" style="border-bottom: 1px solid #EEE">
										
										<td class="a-center">
											
											<div id="chart1div" class="chartDiv">
												<canvas id="myChart1" width="400" height="280"></canvas>
											</div> 
										</td>
										
										<td width="30%">
											<div style="height: 300px; overflow: auto">
												<table class="table-1 colored">
													<caption>Bug类型统计</caption>
													<tbody>
														<tr>
															<th>Bug类型</th>
															<th>Bug数</th>
															<th>百分比</th>
														</tr>
														<c:forEach var="pie1" items="${pieList1}">
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
										</td>
									</tr>
									<tr valign="top" style="border-bottom: 1px solid #EEE">
										
										<td class="a-center">
											
											<div id="chart1div" class="chartDiv">
												<canvas id="myChart6" width="450" height="350"></canvas>
											</div> 
										</td>
										
										<td width="30%">
											<div style="height: 300px; overflow: auto">
												<table class="table-1 colored">
													<caption>最近10天新增Bug</caption>
													<tbody>
														<tr>
															<th>日期</th>
															<th>数量</th>
															<th>百分比</th>
														</tr>
														<c:forEach var="pie7" items="${pieList7}">
														<tr class="a-center"
															style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
															<td>${pie7.label}</td>
															<td>${pie7.value}</td>
															<td>${pie7.bfb}</td>
														</tr>
														</c:forEach>
														
													</tbody>
												</table>
											</div>
										</td>
									</tr>
									<tr valign="top" style="border-bottom: 1px solid #EEE">
										
										<td class="a-center">
											
											<div id="chart1div" class="chartDiv">
												<canvas id="myChart7" width="400" height="280"></canvas>
											</div> 
										</td>
										
										<td width="30%">
											<div style="height: 250px; overflow: auto">
												<table class="table-1 colored">
													<caption>10个提交Bug最多的人</caption>
													<tbody>
														<tr>
															<th>姓名</th>
															<th>提交bug数</th>
															<th>百分比</th>
														</tr>
														<c:forEach var="pie9" items="${pieList9}">
														<tr class="a-center"
															style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
															<td>${pie9.label}</td>
															<td>${pie9.value}</td>
															<td>${pie9.bfb}</td>
														</tr>
														</c:forEach>
														
													</tbody>
												</table>
											</div>
										</td>
									</tr>
									<tr valign="top" style="border-bottom: 1px solid #EEE">
										
										<td class="a-center">
											
											<div id="chart1div" class="chartDiv">
												<canvas id="myChart2" width="250" height="250"></canvas>
											</div> 
										</td>
										
										<td width="30%">
											<div style="height: 250px; overflow: auto">
												<table class="table-1 colored">
													<caption>Bug状态统计</caption>
													<tbody>
														<tr>
															<th>Bug状态</th>
															<th>Bug数</th>
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
										</td>
									</tr>
									<tr valign="top" style="border-bottom: 1px solid #EEE">
										
										<td class="a-center">
											
											<div id="chart1div" class="chartDiv">
												<canvas id="myChart3" width="250" height="250"></canvas>
											</div> 
										</td>
										
										<td width="30%">
											<div style="height: 250px; overflow: auto">
												<table class="table-1 colored">
													<caption>Bug严重程度统计</caption>
													<tbody>
														<tr>
															<th>Bug严重程度</th>
															<th>Bug数</th>
															<th>百分比</th>
														</tr>
														<c:forEach var="pie3" items="${pieList3}">
														<tr class="a-center"
															style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
															<td>${pie3.label}</td>
															<td>${pie3.value}</td>
															<td>${pie3.bfb}</td>
														</tr>
														</c:forEach>
														
													</tbody>
												</table>
											</div>
										</td>
									</tr>
									<tr valign="top" style="border-bottom: 1px solid #EEE">
										
										<td class="a-center">
											
											<div id="chart1div" class="chartDiv">
												<canvas id="myChart4" width="250" height="250"></canvas>
											</div> 
										</td>
										
										<td width="30%">
											<div style="height: 250px; overflow: auto">
												<table class="table-1 colored">
													<caption>模块Bug统计</caption>
													<tbody>
														<tr>
															<th>模块名</th>
															<th>Bug数</th>
															<th>百分比</th>
														</tr>
														<c:forEach var="pie4" items="${pieList4}">
														<tr class="a-center"
															style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
															<td>${pie4.label}</td>
															<td>${pie4.value}</td>
															<td>${pie4.bfb}</td>
														</tr>
														</c:forEach>
														
													</tbody>
												</table>
											</div>
										</td>
									</tr>
									
									
									<tr valign="top" style="border-bottom: 1px solid #EEE">
										
										<td class="a-center">
											
											<div id="chart1div" class="chartDiv">
												<canvas id="myChart8" width="400" height="280"></canvas>
											</div> 
										</td>
										
										<td width="30%">
											<div style="height: 250px; overflow: auto">
												<table class="table-1 colored">
													<caption>指派给统计</caption>
													<tbody>
														<tr>
															<th>开发人员</th>
															<th>被指派Bug数</th>
															<th>百分比</th>
														</tr>
														<c:forEach var="pie6" items="${pieList6}">
														<tr class="a-center"
															style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
															<td>${pie6.label}</td>
															<td>${pie6.value}</td>
															<td>${pie6.bfb}</td>
														</tr>
														</c:forEach>
														
													</tbody>
												</table>
											</div>
										</td>
									</tr>
									<tr valign="top" style="border-bottom: 1px solid #EEE">
										
										<td class="a-center">
											
											<div id="chart1div" class="chartDiv">
												<canvas id="myChart5" width="250" height="250"></canvas>
											</div> 
										</td>
										
										<td width="30%">
											<div style="height: 250px; overflow: auto">
												<table class="table-1 colored">
													<caption>Bug是否确认统计</caption>
													<tbody>
														<tr>
															<th>标题</th>
															<th>Bug数</th>
															<th>百分比</th>
														</tr>
														<c:forEach var="pie5" items="${pieList5}">
														<tr class="a-center"
															style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
															<td>${pie5.label}</td>
															<td>${pie5.value}</td>
															<td>${pie5.bfb}</td>
														</tr>
														</c:forEach>
														
													</tbody>
												</table>
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