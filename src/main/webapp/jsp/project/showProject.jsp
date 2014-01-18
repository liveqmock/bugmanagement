<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>项目信息 - Bug管理</title>
<script>var config={"webRoot":"\/pro\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/pro\/theme\/","currentModule":"project","currentMethod":"view","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/pro\/index.php\/project-view-2.html"}
</script>
<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<script src='<c:url value="/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<link rel="icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon" />

<style>#productsBox  span{display:block; float:left; width:250px; overflow:hidden; word-break:keep-all; white-space:nowrap}
#whitelistBox span{display:block; float:left; width:150px; overflow:hidden; word-break:keep-all; white-space:nowrap}
caption a{padding:5px}
</style>
</head>
<body>
<style>
#colorbox, #cboxOverlay, #cboxWrapper{z-index:9999;}
</style>

<jsp:include page="includeHeader.jsp"></jsp:include>

<div class="navbar" id="modulemenu">
 <ul>
<jsp:include page="../includeJsp/includeSelectPro.jsp"></jsp:include>

<li class=' '><a href='showModule.htm' target=''>模块</a>
</li>
<li class=' '><a href='versionList.htm' target=''>版本</a>
</li>
<li class='right '><a href='newProject.htm' target=''><i class="icon-plus"></i>&nbsp;添加项目</a>
</li>
<li class='right '><a href='projectList.htm' target=''><i class="icon-th-large"></i>&nbsp;所有项目</a>
</li>
</ul>
</div>

<div id='wrap'>
  <div class='outer'>
<div id='titlebar'>
  <div id='main' >PROJECT #${project.projectId } ${project.name }</div>
  <div>
    <span class='link-button'><a href='editProject.htm?projectId=${project.projectId }' target='' class='link-icon ' title='编辑项目'><i class='icon-green-common-edit'></i></a></span><span class='link-button'><a href='deleteProject.htm?projectId=${project.projectId }' class='link-icon ' title='删除项目'><i class='icon-green-common-delete'></i></a></span><span class='link-button'><a href='projectList.htm' target='' class='link-icon' title=返回><i class="icon-goback icon-level-up icon-large icon-rotate-270"></i></a>
</span>  </div>
</div>

<table class='cont-rt5'>
  <tr valign='top'>
    <td>
      <fieldset>
        <legend>项目目标</legend>
        <div class='content'>${project.goal }</div>
      </fieldset>
      <fieldset>
        <legend>项目描述</legend>
        <div class='content'>${project.description }</div>
      </fieldset>

<div id='actionbox'>
<fieldset>
  <legend>
  	历史记录 
  </legend>

  <ol id='historyItem'>
  		<c:forEach items="${histories }" var="history" varStatus="status">
       <li value='${status.count }'>
            <span><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${history.operateTime }" />, 
				     由 <strong>${history.user.name }</strong> ${history.operation } </span>
			<c:if test="${history.comment ne null and history.comment ne '' }">
            <div class='history'>
                <div>${history.comment }</div>
        	</div>
        	</c:if>          
        </li>
        </c:forEach>
  </ol>

</fieldset>
</div>
      <div class='a-center actionLink'><span class='link-button'><a href='editProject.htm?projectId=${project.projectId }' target='' class='link-icon ' title='编辑项目'><i class='icon-green-common-edit'></i></a></span><span class='link-button'><a href='deleteProject.htm?projectId=${project.projectId }' class='link-icon ' title='删除项目'><i class='icon-green-common-delete'></i></a></span><span class='link-button'><a href='projectList.htm' target='' class='link-icon' title=返回><i class="icon-goback icon-level-up icon-large icon-rotate-270"></i></a>
</span></div>
    </td>
    <td class="divider"></td>
    <td class="side">
      <fieldset>
        <legend>基本信息</legend>
        <table class='table-1 a-left'>
          <tr>
            <th width='25%' class='a-right'>项目名称</th>
            <td>${project.name }</td>
          </tr>
          <tr>
            <th class='rowhead'>起始时间</th>
            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${project.startDate }" /></td>
          </tr>
          <tr>
            <th class='rowhead'>截止时间</th>
            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${project.endDate }" /></td>
          </tr>
          <tr> 
            <th class='rowhead'>项目状态</th>
            <c:set var="now" value="<%=(new java.util.Date()).getTime()%>" />
		    <c:set var="start" value="${project.startDate.getTime() }" />
		    <c:set var="end" value="${project.endDate.getTime() }" />
		    <td>
		    <c:choose>
		    	<c:when test="${start > now }">
		    		未开始
		    	</c:when>
		    	<c:when test="${start < now and end > now }">
		    		进行中
		    	</c:when>
		    	<c:when test="${end < now }">
		    		已结束
		    	</c:when>
		    </c:choose>
		    </td>
          </tr>  
        </table>
      </fieldset>
    </td>
  </tr>
</table>
    </div>
  <div id='divider'></div>
</div>
<div id='footer'>
  <div id="crumbs">
    <a href='turnToHomePage.htm' >Bug管理</a>
&nbsp;<span class="icon-angle-right"></span><a href='projectList.htm' >项目</a>
&nbsp;<span class="icon-angle-right"></span><a href='showProject.htm?projectId=${project.projectId }' >bug管理</a>
&nbsp;<span class="icon-angle-right"></span>基本信息  </div>
  <div id="poweredby">
    <span>Powered by <a href=''>SICD</a>
	</span>
  </div>
</div>
<script>function setWhite(acl)
{
    acl == 'custom' ? $('#whitelistBox').removeClass('hidden') : $('#whitelistBox').addClass('hidden');
}

function switchStatus(projectID, status)
{
  if(status) location.href = createLink('project', 'task', 'project=' + projectID + '&type=' + status);
}

function switchGroup(projectID, groupBy)
{
    link = createLink('project', 'groupTask', 'project=' + projectID + '&groupBy=' + groupBy);
    location.href=link;
}

/**
 * Convert a date string like 2011-11-11 to date object in js.
 * 
 * @param  string $date 
 * @access public
 * @return date
 */
function convertStringToDate(dateString)
{
    dateString = dateString.split('-');
    return new Date(dateString[0], dateString[1] - 1, dateString[2]);
}

/**
 * Compute delta of two days.
 * 
 * @param  string $date1 
 * @param  string $date1 
 * @access public
 * @return int
 */
function computeDaysDelta(date1, date2)
{
    date1 = convertStringToDate(date1);
    date2 = convertStringToDate(date2);
    delta = (date2 - date1) / (1000 * 60 * 60 * 24) + 1;

    weekEnds = 0;
    for(i = 0; i < delta; i++)
    {
        if(date1.getDay() == 0 || date1.getDay() == 6) weekEnds ++;
        date1 = date1.valueOf();
        date1 += 1000 * 60 * 60 * 24;
        date1 = new Date(date1);
    }
    return delta - weekEnds; 
}

/**
 * Compute work days.
 * 
 * @access public
 * @return void
 */
function computeWorkDays(currentID)
{
    isBactchEdit = false;
    if(currentID)
    {
        index = currentID.replace('begins[', '');
        index = index.replace('ends[', '');
        index = index.replace(']', '');
        if(!isNaN(index)) isBactchEdit = true;
    }

    if(isBactchEdit)
    {
        beginDate = $('#begins\\[' + index + '\\]').val();
        endDate   = $('#ends\\[' + index + '\\]').val();
    }
    else
    {
        beginDate = $('#begin').val();
        endDate   = $('#end').val();
    }

    if(beginDate && endDate) 
    {
        if(isBactchEdit)  $('#dayses\\[' + index + '\\]').val(computeDaysDelta(beginDate, endDate));
        if(!isBactchEdit) $('#days').val(computeDaysDelta(beginDate, endDate));
    }
    else if($('input[checked="true"]').val()) 
    {
        computeEndDate();
    }
}

/**
 * Compute the end date for project.
 * 
 * @param  int    $delta 
 * @access public
 * @return void
 */
function computeEndDate(delta)
{
    beginDate = $('#begin').val();
    if(!beginDate) return;

    endDate = convertStringToDate(beginDate).addDays(parseInt(delta));
    endDate = endDate.toString('yyyy-M-dd');
    $('#end').val(endDate);
    computeWorkDays();
}

/* Auto compute the work days. */
$(function() 
{
    $(".chosenBox select").chosen({no_results_text: noResultsMatch});
    if(typeof(replaceID) != 'undefined') setModal4List('iframe', replaceID);
    $(".date").bind('dateSelected', function()
    {
        computeWorkDays(this.id);
    })
});

</script>
</body>
</html>

</html>