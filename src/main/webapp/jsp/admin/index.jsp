<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
<title>后台管理::大数据 - BUG管理</title>
<script type="text/javascript">
	var config = {
		"webRoot" : "\/",
		"cookieLife" : 30,
		"requestType" : "PATH_INFO",
		"pathType" : "clean",
		"requestFix" : "-",
		"moduleVar" : "m",
		"methodVar" : "f",
		"viewVar" : "t",
		"defaultView" : "html",
		"themeRoot" : "\/css\/theme\/",
		"currentModule" : "dept",
		"currentMethod" : "browse",
		"clientLang" : "zh-cn",
		"requiredFields" : "",
		"submitting" : "\u7a0d\u5019...",
		"save" : "\u4fdd\u5b58",
		"router" : "\/company\/dept"
	};
</script>
<link rel='stylesheet'
	href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css'
	media='screen' />
<link rel="icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon" />
<script src='<c:url value="/js/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet'
	href='<c:url value="/css/theme/default/zh-cn.default.css"/>'
	type='text/css' media='screen' />
<style>
.table-1 input {
	margin-bottom: 3px
}
</style>
<link rel='icon' href='<c:url value="/pic/logo.png"/>'
	type='image/x-icon' />
<link rel='shortcut icon' href='<c:url value="/pic/logo.png"/>'
	type='image/x-icon' />
<link rel="stylesheet"
	href='<c:url value="/css/theme/default/dropmenu.css"/>' type="text/css"
	media="screen" />
<link rel="stylesheet"
	href="<c:url value="/css/theme/default/index.css"/>" type="text/css"
	media="screen" />
</head>
<body>
	<div id='header'>
		<table class='cont navbar' id='topbar'>
			<tr>
				<td class='w-p50'>${company.name}</td>
				<td class='a-right'>今天是${year}年${month}月${day}日，星期${week}，${user.realName}<a
					href="<c:url value="/j_spring_security_logout" />">退出</a>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<table class='cont navbar' id='navbar'>
			<tr>
				<td id='mainmenu'>
					<ul>
						<li class='active'><a href='goIndex.htm' class='active'
							id='menumy'><i class="icon-home"></i>概况统计</a></li>
						<li><a href='goCompanyList.htm' id='menuproject'>公司列表</a></li>
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
			<li class=" active"><a href="" target="" id="submenuindex">概况统计</a>
			</li>
			
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
											
												<span class="a-center" style="font-size: 30px;"> 注册公司总数：<font color="red">${companySum}</font></span> 
												</div>
											
										</caption>
									</table>
								</div>
							</td>
							<td width="20%" style="padding-right: 40px;">
								<div class="dynamic">
									<table class="table-1 colored fixed" >
										<caption style="height: 50px;">
											<div class="a-center">
											<span class="a-center" style="font-size: 30px;"> 注册项目总数：<font color="red">${projectSum}</font></span> 
											
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
												 <span class="a-center" style="font-size: 30px;"> 注册用户总数：<font color="red">${userSum}</font></span> 
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
												<i class="icon icon-th-large"></i>&nbsp; 最近创建的公司
											</div>
											<div class="f-right">
												<a href="goCompanyList.htm" target="">更多&nbsp;<i
													class="icon-th icon icon-double-angle-right"></i></a>
											</div>
										</caption>
										<tbody>
														<tr>
															<th>公司名称</th>
															<th>创建人</th>
															<th>创建时间</th>
															<th>电话</th>
															<th>地址</th>
														</tr>
														<c:forEach items="${companyList}" var="company">
														<tr class="a-center"
															style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
															<td>${company.name}</td>
															<td>${company.user.realName}</td>
															<td><fmt:formatDate value="${company.createdAt}"/></td>
															<td>${company.phone}</td>
															<td>${company.address}</td>
														</tr>
													</c:forEach>
													</tbody>
									</table>
								</div>
							</td>
							<td width="48%">
								<div class="dynamic">
									<table class="table-1 colored fixed">
										<caption>
											<div class="f-left">
												<i class="icon icon-quote-right"></i>&nbsp; 最新动态
											</div>
											<div class="f-right">
												<a href="goLogList.htm" target="">更多&nbsp;<i
													class="icon-th icon icon-double-angle-right"></i></a>
											</div>
										</caption>
										<tbody>
														<tr>
															<th>日志ID</th>
															<th>用户操作</th>
															<th>操作时间</th>
															<th>浏览器</th>
															<th>用户ID</th>
														</tr>
														<c:forEach items="${logList}" var="log">
														<tr class="a-center"
															style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
															<td>${log.operateLogId}</td>
															<td>${log.userOperate}</td>
															<td><fmt:formatDate value="${log.operateTime}"/></td>
															<td>${log.browser}</td>
															<td>${log.userId}</td>
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
												<i class="icon icon-list-ul"></i>&nbsp; 最近创建的项目
											</div>
											<div class="f-right">
												<a href="goProjectList.htm">更多&nbsp;<i
													class="icon-th icon icon-double-angle-right"></i></a>
											</div>
										</caption>
										<tbody>
														<tr>
															<th>项目ID</th>
															<th>项目名称</th>
															<th>创建时间</th>
															<th>所属公司</th>
															<th>计划启动时间</th>
															<th>计划结束时间</th>
														</tr>
														<c:forEach items="${projectList}" var="project">
														<tr class="a-center"
															style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
															<td>${project.projectId}</td>
															<td>${project.name}</td>
															<td><fmt:formatDate value="${project.createdAt}"/></td>
															<td>${project.company.name}</td>
															<td><fmt:formatDate value="${project.startDate}"/></td>
															<td><fmt:formatDate value="${project.endDate}"/></td>
														</tr>
													</c:forEach>
													</tbody>
									</table>
								</div>
							</td>
							
							<td width="48%"><div class="block linkbox2">
									<table class="table-1 fixed colored">
										<caption>
											<div class="f-left">
												<i class="icon-user"></i>&nbsp; 最近加入的用户
											</div>
											<div class="f-right">
												<a href="goUserList.htm">更多&nbsp;<i
													class="icon-th icon icon-double-angle-right"></i></a>
											</div>
										</caption>
										<tbody>
														<tr>
															<th>用户ID</th>
															<th>真实姓名</th>
															<th>职位</th>
															<th>邮箱</th>
															<th>加入时间</th>
															<th>所属公司</th>
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
