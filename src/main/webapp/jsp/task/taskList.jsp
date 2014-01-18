<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pt" uri="/page-tags"%>

<!DOCTYPE html>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>${curProject.name }::测试任务 - BUG管理</title>
<script language='Javascript'>var config={"webRoot":"\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/theme\/","currentModule":"testtask","currentMethod":"browse","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/index.php\/testtask-browse.html"}
</script>
<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<!--[if lt IE 8]><link rel='stylesheet' href='/css/theme/fontawesome/ie7.min.css?v=pro3.1' type='text/css' media='screen' />
<link rel='stylesheet' href='/css/theme/default/style.ie7.css?v=pro3.1' type='text/css' media='screen' />
<![endif]-->
<script src='<c:url value="/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<link type="text/css" rel="stylesheet" href="<c:url value="/css/theme/browser/safari.css"/>">

<link rel="icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon">
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon">
</head>
<body>
<style>
#colorbox, #cboxOverlay, #cboxWrapper{z-index:9999;}
</style>
<jsp:include page="includeHeader.jsp"></jsp:include>

<div class="navbar" id="modulemenu">
 <ul>
<jsp:include page="../includeJsp/includeSelectPro.jsp"></jsp:include>
<li class=' active'><a href='taskList.htm' target=''>浏览任务</a>
</li>
<li class=' '><a href='newTask.htm' target=''>创建任务</a>
</li>
</ul>
</div>
<div id='wrap'>
  <div class='outer'>
<script>
$(function()
{
    $('.colored').colorize();
    $('tfoot td').css('background', 'white').unbind('click').unbind('hover');
}
);
</script>
<script>confirmDelete = "\u60a8\u786e\u8ba4\u8981\u5220\u9664\u8be5\u6d4b\u8bd5\u4efb\u52a1\u5417\uff1f"
</script>
<table class='table-1 colored tablesorter fixed' id='taskList'>
  <caption class='caption-tl'>
    <div class='f-left'>待测列表</div>
    <div class='f-right'><span class='link-button'><a href='newTask.htm' target='' class=''><i class='icon-green-testtask-create'></i> 提交测试</a>
</span></div>
  </caption>
  <thead>
    <tr class='colhead'>
    <th class='w-id'>  <div class='headerSortUp'><a href='' >ID</a>
</div></th>
    <th>               <div class='header'><a href='' >任务名称</a>
</div></th>
    <th style="width:10%;">               <div class='header'><a href='' >所属项目</a>
</div></th>
    <th style="width:10%;">               <div class='header'><a href='' >版本</a>
</div></th>
    <th class='w-user' style="width:15%;"><div class='header'><a href='' >负责人</a>
</div></th>
    <th class='w-80px' style="width:10%;"><div class='header'><a href='' >开始日期</a>
</div></th>
    <th class='w-80px' style="width:10%;"><div class='header'><a href='' >结束日期</a>
</div></th>
    <th class='w-50px'><div class='header'><a href='' >状态</a>
</div></th>
    <th class='w-100px {sorter:false}'>操作</th>
  </tr>
  </thead>
  <tbody>
  	<c:forEach items="${tasks }" var="task">
    <tr class='a-center'>
    <td><a href='showTask.htm' >#${task.taskId }</a>
</td>
    <td class='a-left' title="${task.name }"><a href='showTask.htm?taskId=${task.taskId }' >${task.name }</a>
</td>
    <td class='a-center'><a href='showProject.htm?projectId=${task.version.project.projectId }' >${task.version.project.name }</a>
</td>
    <td  class="a-center" title="">${task.version.name }</td>
    <td>${task.owner.user.name }</td>
    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${task.startDate }" /></td>
    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${task.endDate }" /></td>
    <td>${task.status }</td>
    <td class='a-center'>
      <a href='showCases.htm?taskId=${task.taskId }' target='' class='link-icon ' title='用例'><i class='icon-green-testtask-cases'></i></a><a href='linkCases.htm?taskId=${task.taskId }' target='' class='link-icon ' title='关联用例'><i class='icon-green-testtask-linkCase'></i></a><a href='editTask.htm?taskId=${task.taskId }' target='' class='link-icon ' title='编辑测试任务'><i class='icon-green-common-edit'></i></a><a href='deleteTask.htm?taskId=${task.taskId }' onclick="return confirm('are you sure?')" target='' class='link-icon' title='删除测试任务'><i class="icon-green-common-delete"></i></a>
    </td>
  </tr>
  </c:forEach>
    </tbody>
  <tfoot><tr><td colspan='9'>
	
	<pt:page totalSize="${totalSize }" pageSize="${pageSize }" url="${url }" curPage="${curPage }"></pt:page>
	
	</td></tr>
	</tfoot>
</table>
  </div>
    <iframe frameborder='0' name='hiddenwin' id='hiddenwin' scrolling='no' class='hidden'></iframe>
  <div id='divider'></div>
</div>
 <div id='footer'>
  <div id="crumbs">
    <a href='' >BUG管理</a>
     &nbsp;<span class="icon-angle-right"></span><a href='taskList.htm' >测试任务</a>
     &nbsp;<span class="icon-angle-right"></span>测试列表
  </div>
  <div id="poweredby">
    <span>Powered by <a href=''>SICD</a> </span>
  </div>
 </div>
</body>
</html>
