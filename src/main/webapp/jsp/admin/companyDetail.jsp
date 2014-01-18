<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
<title>后台管理::大数据 - BUG管理</title>
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
		$(function(){
			
		var pieData1 = <%=request.getAttribute("js5")%>;
		var ctx1 = $("#myChart").get(0).getContext("2d");
		var myNewChart1 = new Chart(ctx1);
		myNewChart1.Pie(pieData1, {
			animationSteps : 100,
			animationEasing : 'easeOutBounce'
		});
		});
</script> 

</head>
<body>
	<div id='header'>
		<table class='cont navbar' id='topbar'>
			<tr>
				<td class='a-right'>今天是${year}年${month}月${day}日，星期${week}，${user.realName}<a
					href="<c:url value="/j_spring_security_logout" />">退出</a>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<table class='cont navbar' id='navbar'>
			<tr>
				<td id='mainmenu'>
					<ul>
						<li><a href='goIndex.htm' class='active' id='menumy'><i
								class="icon-home"></i>概况统计</a></li>
						<li class='active'><a href='goCompanyList.htm'
							id='menuproject'>公司列表</a></li>
						<li><a href='goProjectList.htm' id='menuwebapp'>项目列表</a></li>
						<li><a href='goUserList.htm' id='menureport'>用户列表</a></li>
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
			<li><a href="goCompanyList.htm" target="" id="submenuindex">公司列表&nbsp;<span
					class="icon-angle-right"></span></a></li>
			<li class=" active"><a href="" target="" id="submenuindex">公司详细信息</a></li>
		</ul>
	</div>
	<div id="wrap">
		<div class="outer" style="min-height: 402px;">
			<script src="/pro/js/jquery/sparkline/min.js?v=1380411804"
				type="text/javascript"></script>
			<script type="text/javascript">
				$(function() {
					$('.colored').colorize();
					$('tfoot td').css('background', 'white').unbind('click')
							.unbind('hover');
				});
			</script>

			<div class="wrapper">
				<table class="cont" id="row3">
					<tbody>
						<tr valign="top">
							<td width="20%" style="padding-right: 40px;">
								<div class="dynamic">
									<table class="table-1 colored fixed">
										<caption style="height: 50px;">
											<div class="a-center">

												<span class="a-center" style="font-size: 30px;">
													公司项目总数：<font color="red">${proSum}</font>
												</span>
											</div>

										</caption>
									</table>
								</div>
							</td>
							<td width="20%" style="padding-right: 40px;">
								<div class="dynamic">
									<table class="table-1 colored fixed">
										<caption style="height: 50px;">
											<div class="a-center">
												<span class="a-center" style="font-size: 30px;">
													公司部门总数：<font color="red">${departSum}</font>
												</span>

											</div>

										</caption>

									</table>
								</div>
							</td>

							<td width="20%">
								<div class="dynamic">
									<table class="table-1 colored fixed">
										<caption style="height: 50px;">
											<div class="a-center">
												<span class="a-center" style="font-size: 30px;">
													公司员工总数：<font color="red">${userSum}</font>
												</span>
											</div>
										</caption>

									</table>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				<table class="cont" id="row1" style="margin-top: 40px;">
					<tbody>
						<tr valign="top">
							<td width="48%" style="padding-right: 20px;">
								<div class="dynamic">
									<table class="table-1 colored fixed">
										<caption>
											<div class="f-left">
												<i class="icon icon-th-large"></i>&nbsp; 公司基本信息
											</div>
										</caption>
										<tbody>
											<tr>
												<td><span><strong>ID：</strong>${company.companyId}</span></td>
											</tr>
											<tr>
												<td><span><strong>公司名：</strong>${company.name}</span></td>
											</tr> 
											<tr>
												<td><span><strong>创建人：</strong>${company.user.realName}</span></td>
											</tr>
											<tr>
												<td><span><strong>创建时间：</strong>${company.createdAt}</span></td>
											</tr>
											<tr>
												<td><span><strong>电话：</strong>${company.phone}</span></td>
											</tr>
											<tr>
												<td><span><strong>地址：</strong>${company.address}</span></td>
											</tr>
										</tbody>
									</table>
								</div>
							</td>

							<td width="48%">
								<div class="dynamic">
									<table class="table-1 colored fixed">
										<caption>
											<div class="f-left">
												<i class="icon icon-list-ul"></i>&nbsp; 公司部门列表
											</div>
										</caption>
										<tbody>
											<tr>
												<th style="width: 10%">部门ID</th>
												<th style="width: 15%">部门名称</th>
												<th style="width: 15%">父类部门</th>
												<th style="width: 15%">创建时间</th>
												<th style="width: 35%">部门成员</th>
											</tr>
											<c:forEach items="${departList}" var="depart">
												<tr class="a-center"
													style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
													<td>${depart.departmentId}</td>
													<td>${depart.name}</td>
													<td>${depart.parent.name}</td>
													<td><fmt:formatDate value="${depart.createdAt}" /></td>
													<td><c:forEach items="${depart.users}" var="user">
															<span>${user.realName};</span>
														</c:forEach></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				<table class="cont" id="row2" style="margin-top: 20px;">
					<tbody>
						<tr valign="top">
							<td width="48%" style="padding-right: 20px">
								<div class="block linkbox2" style="height: 217px;">
									<table class="table-1 fixed colored">
										<caption>
											<div class="f-left">
												<i class="icon icon-list-ul"></i>&nbsp; 公司项目列表
											</div>
										</caption>
										<tbody>
											<tr>
												<th>项目ID</th>
												<th>项目名称</th>
												<th>创建时间</th>
												<th>计划启动时间</th>
												<th>计划结束时间</th>
											</tr>
											<c:forEach items="${projectList}" var="project">
												<tr class="a-center"
													style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
													<td>${project.projectId}</td>
													<td><a href="projectDetail.htm?projectId=${project.projectId}">${project.name}</a></td>
													<td><fmt:formatDate value="${project.createdAt}" /></td>
													<td><fmt:formatDate value="${project.startDate}" /></td>
													<td><fmt:formatDate value="${project.endDate}" /></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</td>

							<td width="48%"><div class="block linkbox2">
									<table class="table-1 fixed">
										<caption>
											<div class="f-left">
												<i class="icon-user"></i>&nbsp; 统计
											</div>
										</caption>
										<tbody>
											<tr valign="top" style="border-bottom: 1px solid #EEE">
												<td class="a-center">
													<div style="height: 150px; overflow: auto">
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
														<canvas id="myChart" width="250" height="250"></canvas>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div id="divider"></div>
		</div>

		<script type="text/javascript">
			onlybody = "no";
		</script>
		<script type="text/javascript">
			$(function() {
				if (typeof (listName) != 'undefined')
					setModal4List('iframe', listName, function() {
						$(".colorbox").colorbox({
							width : 960,
							height : 550,
							iframe : true,
							transition : 'none'
						});
					});
			});
			$(function() {
				/* Set the heights of every block to keep them same height. */
				projectBoxHeight = $('#projectbox').height();
				productBoxHeight = $('#productbox').height();
				if (projectBoxHeight < 180)
					$('#projectbox').css('height', 180);
				if (productBoxHeight < 180)
					$('#productbox').css('height', 180);

				row2Height = $('#row2').height() - 10;
				row2Height = row2Height > 200 ? row2Height : 200;
				$('#row2 .block').each(function() {
					$(this).css('height', row2Height);
				});

				$('.projectline').each(function() {
					$(this).sparkline('html', {
						height : '25px'
					});
				});
			});
		</script>



	</div>
	<div id='footer'>
		<div id="crumbs">
			<a href=''>BUG管理</a> &nbsp;<span class="icon-angle-right"></span><a
				href=''>后台管理</a>

		</div>
		<div id="poweredby">
			<span>Powered by <a href=''>SICD</a>
			</span>
		</div>
	</div>
	<script language='Javascript'>
		onlybody = "no";
	</script>
</body>
</html>
