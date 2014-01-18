<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pt" uri="/page-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
<title>个人异常记录::大数据 - BUG管理</title>
<script language="Javascript">var config={"webRoot":"\/css\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/css\/theme\/","currentModule":"bug","currentMethod":"browse","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/css\/index.php\/bug-browse-1.html"}
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

	<jsp:include page="includeHeader.jsp"></jsp:include>
	
	<div class="navbar" id="modulemenu">
		<ul>
			<jsp:include page="../includeJsp/includeSelectPro.jsp"></jsp:include>
			<li class=' active'><a href='goPerExceptionRecord.htm' target=''>我的异常</a>
			</li>
			<li class=' '><a href='goCompanyExceptionRecord.htm' target=''>项目异常</a>
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
			<div id="featurebar">
				<div class="f-left">
					<span id="assigntomeTab" class="active">异常记录列表
					<c:if test="${myException ne null }">
						: ${myException.exceptionClass }
					</c:if>
					</span>
				</div>
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
											<th class="w-id" style="width: 10%;">
												<div class="headerSortUp">
													<a href="">ID</a>
												</div>
											</th>
											<th class="w-date" style="width: 10%;">
												<div class="header">
													<a href="">异常类型</a>
												</div>
											</th>

											<th style="width: 25%;">
												<div class="header">
													<a href="">异常类</a>
												</div>
											</th>
											<th class="w-80px" style="width: 25%;">
												<div class="header">
													<a href="">栈信息</a>
												</div>
											</th>
											<th class="w-user" style="width: 10%;">
												<div class="header">
													<a href="">创建</a>
												</div>
											</th>
											<th class="w-date" style="width: 10%;">
												<div class="header">
													<a href="">创建日期</a>
												</div>
											</th>
											<th class="w-date" style="width: 10%;">
												<div class="header">
													<a href="">操作</a>
												</div>
											</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${exList}" var="ex">
										<tr class="a-center"
											style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
											<td class="active" style="font-weight: bold"><a href="goExceptionDetail.htm?recordId=${ex.recordId }">${ex.recordId}</a></td>
											<td><span class="">${ex.myException.category}</span></td>
											<td><span class=""><a href="recordsByException.htm?myExceptionId=${ex.myException.exceptionId}">${ex.exceptionClass}</a></span></td>
											<td><span class=""><a href="goExceptionDetail.htm?recordId=${ex.recordId}">${ex.stack}</a></span></td>
											<td><span class="">${ex.developer.user.realName}</span></td>
											<td><span class="">${ex.createdAt}</span></td>
											<td><a href="goExceptionDetail.htm?recordId=${ex.recordId}">详细信息</a>&nbsp;<a href="questionsByException.htm?myExceptionId=${ex.myException.exceptionId}">相关问题</a></td>
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
				href=''>异常</a> &nbsp;<span class="icon-angle-right"></span>异常
		</div>
		<div id="poweredby">
			<span>Powered by <a href=''>SICD</a>
			</span>
		</div>
	</div>

</body>
</html>
