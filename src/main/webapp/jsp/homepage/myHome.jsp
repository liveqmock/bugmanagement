<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>我的地盘::大数据 - BUG管理</title>
<script>
var config={"webRoot":"\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/css\/theme\/","currentModule":"dept","currentMethod":"browse","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/company\/dept"};
</script>
<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<link rel="icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon"/>
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon"/>
<script src='<c:url value="/js/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<style>.table-1 input{margin-bottom:3px}
</style>
<link rel='icon' href='<c:url value="/pic/logo.png"/>' type='image/x-icon' />
<link rel='shortcut icon' href='<c:url value="/pic/logo.png"/>' type='image/x-icon' />
<link rel="stylesheet" href='<c:url value="/css/theme/default/dropmenu.css"/>'  type="text/css" media="screen" />
<link rel="stylesheet" href="<c:url value="/css/theme/default/index.css"/>" type="text/css" media="screen"/>
</head>
<body>
<div id='header'>
  <table class='cont navbar' id='topbar'>
    <tr>
      <td class='w-p50'>
      	<span id='companyname'>${company.name}</span>
      </td>
      <td class='a-right'>今天是${year}年${month}月${day}日，星期${week}，${user.realName}<a href="<c:url value="/j_spring_security_logout" />" >退出</a>&nbsp;&nbsp;
      </td>
    </tr>
  </table>
  <table class='cont navbar' id='navbar'>
    <tr>
    <td id='mainmenu'>
    <ul>
     <li class='active'><a href='turnToHomePage.htm' class='active' id='menumy'><i class="icon-home"></i> 我的地盘</a></li>
     <li ><a href='goPerExceptionRecord.htm'  id='menuproject'>异常</a></li>
     <li ><a href='question.htm'  id='menucompany'>问答</a></li>
     <li ><a href='bug.htm'  id='menuwebapp'>BUG</a></li>
     <li ><a href='usecase.htm'  id='menureport'>用例</a></li>
     <li ><a href='taskList.htm'  id='menuqa'>测试</a></li>
     <li ><a href='projectList.htm' id='menuproject'>项目</a></li>
     <li ><a href='goDept.htm'  id='menucompany'>组织</a></li>
    </ul>
    </td>
    </tr>
  </table>
</div>
 <div class="navbar" id="modulemenu">
  <ul>
<li><span id="myname"><i class="icon-user"></i> ${user.realName}&nbsp;<span class="icon-angle-right"></span></span></li>
<li class=" active"><a href="turnToHomePage.htm" target="" id="submenuindex">首页</a>
</li>
<li class=" "><a href="goMyInfo.htm" target="" id="submenuprofile">档案</a>
</li>
<li class=" "><a href="goDynamic.htm" target="" id="submenuprofile">动态</a>
</li>
</ul>
</div>
<div id='wrap'>
  <div class='outer'>
<script src="/js/jquery/jquerytools/min.js" type="text/javascript"></script>
<script language='javascript'>
$(function()
{
    $('.colored').colorize();
    $('tfoot td').css('background', 'white').unbind('click').unbind('hover');
}
);
</script>
<link rel='stylesheet' href='/theme/default/index.css?v=5.2' type='text/css' media='screen' />
<table class="cont" id="row1">
<tr valign="top">
  <td width="66%">
  
<sec:authorize ifAnyGranted="ROLE_DEVELOPER">
    <table class="cont">
      <tr valign='top'>
        <td width='50%' style='padding-right:20px;'><div class='block linkbox2'>
        
        
<table class='table-1 fixed colored'>

  <caption>
    <div class='f-left'><span class='icon-bug'></span> 我的最新异常</div>
    <div class='f-right'><a href='goPerExceptionRecord.htm' >更多<span class='icon-more'></span></a>
</div>
  </caption>
  <c:forEach items="${records }" var="record">
  	<tr><td class='nobr'>#${record.recordId } <a href='goExceptionDetail.htm?recordId=${record.recordId }' >${record.exceptionClass }</a></td><td width='5'></td></tr>
  </c:forEach>
</table>
</div>
</td>
        <td width='50%' style='padding-right:20px;'><div class='block linkbox2'>
<table class='table-1 fixed colored'>
  <caption>
    <div class='f-left'><span class='icon-bug'></span> 指派给我的Bug</div>
    <div class='f-right'><a href='bugassigntome.htm' >更多<span class='icon-more'></span></a>
</div>
  </caption>
  <c:forEach items="${assignBugs }" var="bug">
  	<tr><td class='nobr'>#${bug.bugId } <a href='showBug.htm?bugId=${bug.bugId }' >${bug.title }</a></td><td width='5'></td></tr>
  </c:forEach>
</table>
</div>
</td>
      </tr>
      <tr valign='top' style="padding-top:25px">
        <td width='50%' style='padding-right:20px; padding-top:20px;'><div class='block linkbox2'>
<table class='table-1 fixed colored'>
  <caption>
    <div class='f-left'><span class='icon-bug'></span> 最新Bug</div>
    <div class='f-right'><a href='bug.htm' >更多<span class='icon-more'></span></a>
  </caption>
  <c:forEach items="${newBugs }" var="bug">  
  	<tr><td class='nobr'>#${bug.bugId } <a href='showBug.htm?bugId=${bug.bugId }' >${bug.title }</a></td><td width='5'></td></tr>
  </c:forEach>
</table>
</div>
</td>
        <td width='50%' style='padding-right:20px; padding-top:20px;'><div class='block linkbox2'>
<table class='table-1 fixed colored'>
  <caption>
    <div class='f-left'><span class='icon-bug'></span> 未解决的Bug</div>
    <div class='f-right'><a href='bugunresolved.htm' >更多<span class='icon-more'></span></a>
  </caption>
  <c:forEach items="${unsolvedBugs }" var="bug">
  	<tr><td class='nobr'>#${bug.bugId } <a href='showBug.htm?bugId=${bug.bugId }' >${bug.title }</a></td><td width='5'></td></tr>
  </c:forEach>
</table>
</div>
</td>
      </tr>
    </table>
</sec:authorize>



<sec:authorize ifAnyGranted="ROLE_TESTER">
    <table class="cont">
      <tr valign='top'>
        <td width='50%' style='padding-right:20px;'><div class='block linkbox2'>
        
        
<table class='table-1 fixed colored'>

  <caption>
    <div class='f-left'><span class='icon-bug'></span> 我创建的Bug</div>
    <div class='f-right'><a href='bugopenedbyme.htm' >更多<span class='icon-more'></span></a>
</div>
  </caption>
  <c:forEach items="${myBugs }" var="bug">
  	<tr><td class='nobr'>#${bug.bugId } <a href='showBug.htm?bugId=${bug.bugId }' >${bug.title }</a></td><td width='5'></td></tr>
  </c:forEach>
</table>
</div>
</td>
        <td width='50%' style='padding-right:20px;'><div class='block linkbox2'>
<table class='table-1 fixed colored'>
  <caption>
    <div class='f-left'><span class='icon-bug'></span> 未关闭的Bug</div>
    <div class='f-right'><a href='bugunclosed.htm' >更多<span class='icon-more'></span></a>
</div>
  </caption>
  <c:forEach items="${unclosedBugs }" var="bug">
  	<tr><td class='nobr'>#${bug.bugId } <a href='showBug.htm?bugId=${bug.bugId }' >${bug.title }</a></td><td width='5'></td></tr>
  </c:forEach>
</table>
</div>
</td>
      </tr>
      <tr valign='top' style="padding-top:25px">
        <td width='50%' style='padding-right:20px; padding-top:20px;'><div class='block linkbox2'>
<table class='table-1 fixed colored'>
  <caption>
    <div class='f-left'><span class='icon-bug'></span> 最新用例</div>
    <div class='f-right'><a href='usecase.htm' >更多<span class='icon-more'></span></a>
  </caption>
  <c:forEach items="${newCases }" var="usercase">
  	<tr><td class='nobr'>#${usercase.caseId } <a href='showCase.htm?caseId=${usercase.caseId }' >${usercase.title }</a></td><td width='5'></td></tr>
  </c:forEach>
</table>
</div>
</td>
        <td width='50%' style='padding-right:20px; padding-top:20px;'><div class='block linkbox2'>
<table class='table-1 fixed colored'>
  <caption>
    <div class='f-left'><span class='icon-bug'></span> 最新测试</div>
    <div class='f-right'><a href='taskList.htm' >更多<span class='icon-more'></span></a>
  </caption>
  <c:forEach items="${newTasks }" var="task">
  	<tr><td class='nobr'>#${task.taskId } <a href='showTask.htm?taskId=${task.taskId }' >${task.name }</a></td><td width='5'></td></tr>
  </c:forEach>
</table>
</div>
</td>
      </tr>
    </table>
</sec:authorize>


  </td>
  <td width="33%">
    <div class='dynamic'>
<table class='table-1 colored fixed'>
  <caption>
    <div class='f-left'><i class="icon icon-quote-right"></i>&nbsp; 最新动态</div>
    <div class='f-right'><a href='' target='' >更多&nbsp;<i class='icon-th icon icon-double-angle-right'></i></a>
</div>
  </caption>
  <c:forEach items="${histories }" var="history">
  	<tr><td class='nobr' width='95%'><fmt:formatDate pattern="MM月dd日  hh:mm" value="${history.operateTime }" />, ${history.user.realName } ${history.operation } 
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
  	</td><td class='divider'></td></tr>
  </c:forEach>
  
</table>
</div>
  </td>
</tr>
</table>
    </div>
  <div id="divider"></div>
</div>

<script language="Javascript">onlybody = "no";
</script>
<script language="Javascript">$(function() 
{ 
    if(typeof(listName) != 'undefined') setModal4List('iframe', listName, function(){$(".colorbox").colorbox({width:960, height:550, iframe:true, transition:'none'});});
});
$(function() 
{ 
    /* Set the heights of every block to keep them same height. */
    projectBoxHeight = $('#projectbox').height();
    productBoxHeight = $('#productbox').height();
    if(projectBoxHeight < 180) $('#projectbox').css('height', 180);
    if(productBoxHeight < 180) $('#productbox').css('height', 180);

    row2Height = $('#row2').height() - 10;
    row2Height = row2Height > 200 ? row2Height : 200;
    $('#row2 .block').each(function(){$(this).css('height', row2Height);});

    $('.projectline').each(function()
    {
        $(this).sparkline('html', {height:'25px'});
    });
});

</script>


  
</div>
 <div id='footer'>
  <div id="crumbs">
    <a href='' >BUG管理</a>
     &nbsp;<span class="icon-angle-right"></span><a href='' >我的地盘</a>
     
  </div>
  <div id="poweredby">
    <span>Powered by <a href=''>SICD</a> </span>
  </div>
 </div>
 <script language='Javascript'>onlybody = "no";</script>
</body>
</html>
