<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pt" uri="/page-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
<title>问题列表::大数据 - BUG管理</title>
<script>var config={"webRoot":"\/css\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/css\/theme\/","currentModule":"bug","currentMethod":"browse","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/css\/index.php\/bug-browse-1.html"};
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
			<li class=' active'><a href='question.htm' target=''>公开问题</a>
			</li>
			<li><a href='comQuestions.htm' target=''>内部问题</a>
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
					<span id="assigntomeTab" class="active">问题列表
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
											<th style="width: 10%;">
												<div class="header">
													<a href="">异常ID</a>
												</div>
											</th>
											<th style="width: 5%;">
												<div class="header">
													<a href="">票数</a>
												</div>
											</th>
											<th style="width: 5%;">
												<div class="header">
													<a href="">回复数</a>
												</div>
											</th>
											<th class="w-80px" style="width: 35%;">
												<div class="header">
													<a href="">标题</a>
												</div>
											</th>
											<th class="w-user" style="width: 10%;">
												<div class="header">
													<a href="">创建者</a>
												</div>
											</th>
											<th class="w-date" style="width: 15%;">
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
										<c:forEach items="${questionlist}" var="question">
										<tr class="a-center"
											style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
											<td class="active" style="font-weight: bold"><a href="answers.htm?questionId=${question.questionId }">${question.questionId }</a></td>
											<td><span class=""><a href="questionsByException.htm?myExceptionId=${question.myException.exceptionId }">${question.myException.exceptionId }</a></span></td>
											<td><span class="">${question.votes }</span></td>
											<td><span class="">${question.answers.size() }</span></td>
											<td><span class=""><a href="answers.htm?questionId=${question.questionId }">${question.title }</a></span></td>
											<td><span class="">${question.developer.user.realName}</span></td>
											<td><span class=""><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${question.createdAt}" /></span></td>
											<td><a href="answers.htm?questionId=${question.questionId }">查看问题</a></td>
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
