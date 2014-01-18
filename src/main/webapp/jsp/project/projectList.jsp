<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>所有项目 - 大数据</title>
<script language='Javascript'>var config={"webRoot":"\/pro\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/pro\/theme\/","currentModule":"project","currentMethod":"index","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/pro\/index.php\/project-index-no-all-1.html"}
</script>
<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<script src='<c:url value="/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<link rel="icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon" />

<style>
#productsBox  span{display:block; float:left; width:250px; overflow:hidden; word-break:keep-all; white-space:nowrap}
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
<script>
$(function()
{
    $('.colored').colorize();
    $('tfoot td').css('background', 'white').unbind('click').unbind('hover');
}
);
</script>
<form method='post' action=''>
<table class='table-1 fixed colored'>
  <tr class='colhead'>
    <th class="w-id" style="width: 10%;">   ID</th>
    <th class="w-150px" style="width: 15%;">项目名称</th>
    <th style="width: 20%;">开始日期</th>
    <th style="width: 20%;">结束日期</th>
    <th style="width: 15%;">项目状态</th>
    <th style="width: 20%;">进度</th>
  </tr>
  <c:forEach items="${comProjects }" var="project">
      <tr class='a-center'>
    <td>
            <input type='checkbox' name='projectIDList' value='1' />
            <a href='showProject.htm?projectId=${project.projectId }' >${project.projectId }</a>
    </td>
    <td class='a-left'><a href='showProject.htm?projectId=${project.projectId }' >${project.name }</a>
</td>
    <td><fmt:formatDate pattern="yyyy年MM月dd日" value="${project.startDate }" /></td>
    <td><fmt:formatDate pattern="yyyy年MM月dd日" value="${project.endDate }" /></td>
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
    <td class='a-left'>
    	<c:choose>
    		<c:when test="${start > now }">
    			<img src='<c:url value="/css/theme/default/images/main/green.png"/>' width='0' height='13' text-align: />
      			<small>0%</small>
    		</c:when>
    		<c:when test="${end < now }">
    			<img src='<c:url value="/css/theme/default/images/main/green.png"/>' width='100' height='13' text-align: />
      			<small>100%</small>
    		</c:when>
    		<c:when test="${start < now and end > now }">
    			<img src='<c:url value="/css/theme/default/images/main/green.png"/>' width='<fmt:formatNumber type="number"  maxFractionDigits="2" value="${(now - start) * 100/(end - start) }" />' height='13' text-align: />
      			<small><fmt:formatNumber type="percent"  minFractionDigits="2" value="${(now - start) /(end - start) }" /></small>
    		</c:when>
    	</c:choose>
    </td>
  </tr>
  </c:forEach>
      <tfoot>
    <tr>
      <td colspan='10' class='a-right'>
        <div class='f-left'>
        <script type="text/javascript">
function selectAll(checker, scope, type)
{ 
    if(scope)
    {
        if(type == 'button')
        {
            $('#' + scope + ' input').each(function() 
            {
                $(this).attr("checked", true)
            });
        }
        else if(type == 'checkbox')
        {
            $('#' + scope + ' input').each(function() 
            {
                $(this).attr("checked", checker.checked)
            });
         }
    }
    else
    {
        if(type == 'button')
        {
            $('input').each(function() 
            {
                $(this).attr("checked", true)
            });
        }
        else if(type == 'checkbox')
        { 
            $('input').each(function() 
            {
                $(this).attr("checked", checker.checked)
            });
        }
    }
}
</script><input type='button' name='allchecker' id='allchecker' value='全选' onclick='selectAll(this, "", "button")' /><script type="text/javascript">
function selectReverse(scope)
{ 
    if(scope)
    {
        $('#' + scope + ' input').each(function() 
        {
            $(this).attr("checked", !$(this).attr("checked"))
        });
    }
    else
    {
        $('input').each(function() 
        {
            $(this).attr("checked", !$(this).attr("checked"))
        });
    }
}
</script><input type='button' name='reversechecker' id='reversechecker' value='反选' onclick='selectReverse("")'/>         <input type='submit' id='submit' value='批量编辑'  class='button-s' />         </div>
      </td>
    </tr>
  </tfoot>
  </table>
</form>
  </div>
    <iframe frameborder='0' name='hiddenwin' id='hiddenwin' scrolling='no' class='hidden'></iframe>
  <div id='divider'></div>
</div>
<div id='footer'>
  <div id="crumbs">
    <a href='turnToHomePage.htm' >BUG管理</a>
&nbsp;<span class="icon-angle-right"></span><a href='/pro/project/' >项目</a>
&nbsp;<span class="icon-angle-right"></span>所有项目  </div>
  <div id="poweredby">
    <span>Powered by <a href=''>SICD</a>
	</span>
  </div>
</div>
<script language='Javascript'>function setWhite(acl)
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
$().ready(function()
{
    $('.projectline').each(function()
    {
        $(this).sparkline('html', {height:'25px'});
    })
})

</script>
</body>
</html>
