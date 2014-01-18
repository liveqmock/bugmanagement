<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<%@ taglib prefix="pt" uri="/page-tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>动态::大数据 - BUG管理</title>
<script language='Javascript'>var config={"webRoot":"\/pro\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/pro\/theme\/","currentModule":"dept","currentMethod":"browse","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/pro\/index.php\/dept-browse.html"}
</script>
<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<!--[if lt IE 8]><link rel='stylesheet' href='/css/theme/fontawesome/ie7.min.css?v=pro3.1' type='text/css' media='screen' />
<link rel='stylesheet' href='/css/theme/default/style.ie7.css?v=pro3.1' type='text/css' media='screen' />
<![endif]-->
<script src='<c:url value="/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<style>.table-1 input{margin-bottom:3px}
</style>
<link rel='icon' href='<c:url value="/pic/logo.png"/>' type='image/x-icon' />
<link rel='shortcut icon' href='<c:url value="/pic/logo.png"/>' type='image/x-icon' />
</head>
<body>
<style>
#colorbox, #cboxOverlay, #cboxWrapper{z-index:9999;}
</style>
<jsp:include page="includeHeader.jsp"></jsp:include>

<div class="navbar" id="modulemenu">
  <ul>
<li>${company.name }&nbsp;<span class="icon-angle-right"></span></li>
<li class=''><a href='goDept.htm' target='' id='submenudept'>部门</a>
</li>
<li class=' '><a href='goToUserList.htm' target='' id='submenubrowseUser'>用户</a>
</li>
<li class='active'><a href='goDynamic.htm' target='' id='submenudept'>动态</a>
</li>
<li class=' '><a href='goCompanyInfo.htm' target='' id='submenudept'>公司</a>
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
											<th class="w-id" style="width: 10%;">
												<div class="header">
													<a href="">动态ID</a>
												</div>
											</th>
											<th style="width: 10%;">
												<div class="header">
													<a href="">操作时间</a>
												</div>
											</th>
											<th style="width: 10%;">
												<div class="header">
													<a href="">操作者</a>
												</div>
											</th>
											<th class="w-date" style="width: 20%;">
												<div class="header">
													<a href="">动作</a>
												</div>
											</th>

											<th class="w-80px" style="width: 10%;">
												<div class="header">
													<a href="">操作对象类型</a>
												</div>
											</th>
											<th class="w-user" style="width: 10%;">
												<div class="header">
													<a href="">操作对象ID</a>
												</div>
											</th>
											<th class="w-date" style="width: 30%;">
												<div class="header">
													<a href="">备注</a>
												</div>
											</th>
										</tr>
									</thead>
									<tbody>
	<c:forEach items="${histories}" var="history">
  	<tr>
  		<td class="a-center">#${history.historyId}</td>
  		<td class="a-center"><fmt:formatDate pattern="MM月dd日  hh:mm" value="${history.operateTime}" /></td>
  		<td class="a-center">${history.user.realName } </td>
  		<td class="a-center">${history.operation }
  	
  	</td>
  		<td class="a-center">
  		<c:choose>
  		<c:when test="${history.objectType eq 'bug' }">
  		Bug
  		</c:when>
  		<c:when test="${history.objectType eq 'usercase' }">
  		测试用例
  		</c:when>
  		<c:when test="${history.objectType eq 'task' }">
  		测试任务
  		</c:when>
  	</c:choose>
  		
  		
  		</td>
  		<td class="a-center">${history.objectId }</td>
  		<td class="a-center">${history.comment }</td>
  	
  	<td class='divider'></td>
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
    <a href='/pro/my/' >Bug管理</a>
&nbsp;<span class="icon-angle-right"></span><a href='/pro/company/' >组织</a>
&nbsp;<span class="icon-angle-right"></span>动态 </div>
  <div id="poweredby">
    <span>Powered by <a href='http://www.zentao.net' target='_blank'>ZenTaoPMS</a> (pro3.1)</span>
        <a href='/pro/misc-downNotify.html' >下载桌面提醒</a>
    <a href='/pro/misc-qrCode.html' target='' class='qrCode '><i class='icon-mobile-phone icon-large'></i>手机访问</a>
  </div>
</div>
</body>
</html>