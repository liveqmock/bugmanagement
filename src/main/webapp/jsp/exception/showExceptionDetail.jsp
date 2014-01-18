<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
   <script src='<c:url value="/SyntaxHighlighter/Scripts/shCore.js"/>' type='text/javascript'></script>
<script src='<c:url value="/SyntaxHighlighter/Scripts/shBrushJava.js"/>' type='text/javascript'></script>
 <link rel="stylesheet"
	href="<c:url value="/SyntaxHighlighter/Styles/SyntaxHighlighter.css"/>" type="text/css"
	media="screen"> 
<title>异常</title>
<script type="text/javascript">var config={"webRoot":"\/css\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/css\/theme\/","currentModule":"bug","currentMethod":"browse","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/css\/index.php\/bug-browse-1.html"}
</script>

<script type="text/javascript">
	$(function() {
		
		dp.SyntaxHighlighter.ClipboardSwf = '././SyntaxHighlighter/Scripts/clipboard.swf';
	    dp.SyntaxHighlighter.HighlightAll("code");
		//饼图1
		var pieData =
<%=request.getAttribute("json")%>
	;
		var ctx = $("#myChart").get(0).getContext("2d");
		var myNewChart = new Chart(ctx);
		myNewChart.Pie(pieData, {
			animationSteps : 100,
			animationEasing : 'easeOutBounce'
		});

		var pieData1 =
<%=request.getAttribute("json1")%>
	;
		var ctx1 = $("#myChart1").get(0).getContext("2d");
		var myNewChart1 = new Chart(ctx1);
		myNewChart1.Pie(pieData1, {
			animationSteps : 100,
			animationEasing : 'easeOutBounce'
		});

	});
</script>
</head>
<body>
	<jsp:include page="includeHeader.jsp"></jsp:include>

	<div class="navbar" id="modulemenu">
		<ul>
			<jsp:include page="../includeJsp/includeSelectPro.jsp"></jsp:include>
			<li><a href='goPerExceptionRecord.htm' target=''>我的异常</a>
			</li>
			<li><a href='goCompanyExceptionRecord.htm' target=''>项目异常</a>
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
    	
    	<div id="featurebar">
				<div class="f-left">
					<span id="assigntomeTab" class="active">详细异常记录信息</span>
				</div>
				<div class="f-right">
					<span class="link-button"><a href="newQuestion.htm?recordId=${record.recordId }" target="" class=""><i class="icon-green-bug-create"></i>提问题</a></span>
					<span class="link-button"><a href="goExceptionToBug.htm?recordId=${record.recordId }" target="" class=""><i class="icon-green-bug-create"></i>提BUG</a></span>
				</div>
			</div>
			<table class="cont-lt1">
				<tbody>
					<tr valign="top" style="overflow: auto;">
						<td width="65%" style="overflow: auto;">
							<div class="box-title" style="overflow: auto; width: 96%;">异常详细信息</div>
							<div class="box-content"
								style="overflow: auto; width: 96%; padding-right: 11px;">
								<ul>
									<li><span><strong>异常记录ID：</strong>${record.recordId}</span></li>
									<li><span><strong>所属异常ID：</strong>${record.myException.exceptionId}</span></li>
									<li><span><strong>异常类：</strong>${record.exceptionClass}</span></li>
									<li><span><strong>异常消息：</strong>${record.detailMsg}</span></li>
									<li><span><strong>产生时间：</strong>${record.createdAt}</span></li>
									<li><span><strong>开发者：</strong>${record.developer.user.realName}</span></li>
									<c:if test="${!empty record.sourceInfo}">
									<li><span><strong>源码信息：</strong>${record.sourceInfo}</span></li>
									<li><span><strong>出错的代码行：</strong>${record.lineNum}</span></li>
									<li><span><strong>出错的源码：</strong></span>
									
									<pre class='java:collapse:firstline[${record.lineNum-14}]' name="code">
										${record.sourceCode}
									</pre>
									</li>
									</c:if>
									<li><span><strong>栈信息：<br></strong><font
											color="red">${record.stack}</font></span></li>

								</ul>
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
										<td class="a-left">
											<div>
												<p><strong>异常类型：</strong><br>${record.myException.category}</p>
												<p><strong>异常类：</strong><br>${record.exceptionClass}</p>
												<p><strong>异常说明：</strong><br>${record.myException.description}</p>
											</div>
										</td>
									</tr>
									<tr valign="top" style="border-bottom: 1px solid #EEE">
										<td class="a-center">
											<div style="height: 200px; overflow: auto">
												<table class="table-1 colored">
													<caption>在我的异常记录中的比例</caption>
													<tbody>
														<tr>
															<th>标题</th>
															<th>个数</th>
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
											<div id="chart1div" class="chartDiv">
												<canvas id="myChart" width="250" height="250"></canvas>
											</div>
										</td>
									</tr>
									<tr valign="top" style="border-bottom: 1px solid #EEE">
										<td class="a-center">
											<div style="height: 200px; overflow: auto">
												<table class="table-1 colored">
													<caption>在所有异常记录中的比例</caption>
													<tbody>
														<tr>
															<th>标题</th>
															<th>个数</th>
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
											<div id="chart1div" class="chartDiv">
												<canvas id="myChart1" width="250" height="250"></canvas>
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
	<div id='footer'>
		<div id="crumbs">
			<a href=''>BUG管理</a> &nbsp;<span class="icon-angle-right"></span><a
				href=''>异常</a> &nbsp;<span class="icon-angle-right"></span>异常
		</div>
		<div id="poweredby">
			<span>Powered by <a href=''>SICD</a>
			</span>
		</div>
	</div>
</body>
</html>