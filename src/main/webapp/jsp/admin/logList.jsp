<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="pt" uri="/page-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
<title>后台管理::大数据 - BUG管理</title>
<script type="text/javascript">var config={"webRoot":"\/css\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/css\/theme\/","currentModule":"bug","currentMethod":"browse","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/css\/index.php\/bug-browse-1.html"}
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

<link rel='icon' href='<c:url value="/pic/logo.png"/>'
	type='image/x-icon' />
<link rel='shortcut icon' href='<c:url value="/pic/logo.png"/>'
	type='image/x-icon' />
<link rel="stylesheet"
	href='<c:url value="/css/theme/default/dropmenu.css"/>' type="text/css"
	media="screen" />
</head>
<body>

	<div id='header'>
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
						<li><a href='goUserList.htm' id='menureport'>用户列表</a></li>
						<li  class='active'><a href='goLogList.htm' id='menuqa'>所有日志</a></li>
					</ul>
				</td>
			</tr>
		</table>
	</div>
	<div class="navbar" id="modulemenu">
		<ul>
			<li><span id="myname"><i class="icon-user"></i>
					${user.realName}&nbsp;<span class="icon-angle-right"></span></span></li>
			<li class=" active"><a href="" target="" id="submenuindex">所有日志</a>
			</li>
			
		</ul>
	</div>
	<div id="wrap">
		<div class="outer" style="min-height: 714px;">

			<script type="text/javascript">
     $(function()
       {
            $('.colored').colorize();
            $('tfoot td').css('background', 'white').unbind('click').unbind('hover');
       }
       );
    </script>
			<script src='<c:url value="/js/js/jquery/dropmenu/dropmenu.js"/>'
				type="text/javascript"></script>
			<div class="treeSlider" id="bugTree">
				<span>&nbsp;</span>
			</div>
			<form method="post">
				<table class="cont-lt1">
					<tbody>
						<tr valign="top">
							<td class="divider"></td>
							<td>
								<table class="table-1 fixed colored tablesorter datatable"
									id="bugList">
									<thead>
										<tr class="colhead" style="">
											<th class="w-id" style="width: 16%;">
												<div class="header">
													<a href="">日志ID</a>
												</div>
											</th>
											<th class="w-date" style="width: 16%;">
												<div class="header">
													<a href="">用户操作</a>
												</div>
											</th>

											<th style="width: 20%;">
												<div class="header">
													<a href="">操作时间</a>
												</div>
											</th>
											<th class="w-80px" style="width: 16%;">
												<div class="header">
													<a href="">浏览器</a>
												</div>
											</th>
											<th class="w-user" style="width: 16%;">
												<div class="header">
													<a href="">用户ID</a>
												</div>
											</th>
											<th class="w-date" style="width: 16%;">
												<div class="header">
													<a href="">用户IP</a>
												</div>
											</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${logList}" var="log">
										<tr class="a-center"
											style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
											<td>${log.operateLogId}</td>
											<td>${log.userOperate}</td>
											<td><fmt:formatDate value="${log.operateTime}"/></td>
											<td>${log.browser}</td>
											<td>${log.userId}</td>
											<td>${log.userIp}</td>
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

							</td>
						</tr>
					</tbody>
				</table>
			</form>

		</div>

		<div id="divider"></div>
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

</body>
</html>
