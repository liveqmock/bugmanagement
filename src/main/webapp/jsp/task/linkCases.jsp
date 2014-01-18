<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pt" uri="/page-tags"%>

<!DOCTYPE html>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>${task.name }::关联用例 - BUG管理</title>
<script language='Javascript'>var config={"webRoot":"\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/theme\/","currentModule":"testtask","currentMethod":"linkcase","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/index.php\/testtask-linkCase-17.html"}
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
<li class=''><a href='taskList.htm' target=''>浏览任务</a>
</li>
<li class=''><a href='newTask.htm' target=''>创建任务</a>
</li>
</ul>
</div>
<div id='wrap'>
  <div class='outer'>
<script src='<c:url value="/js/js/jquery/tablesorter/min.js" />' type='text/javascript'></script>
<script src='<c:url value="/js/js/jquery/tablesorter/metadata.js"/>' type='text/javascript'></script>
<script language='javascript'>

/* sort table after page load. */
$(function() { sortTable(); } );

function sortTable()
{
    $('.tablesorter').tablesorter(
        {
            widgets: ['zebra'], 
            widgetZebra: {css: ['odd', 'even'] }
        }
    ); 
    $('.tablesorter tbody tr').hover(
        function(){$(this).addClass('hoover')},
        function(){$(this).removeClass('hoover')}
    );

    /* IE6下面click事件和colorbox冲突。暂时去除该功能。*/
    if($.browser.msie && Math.floor(parseInt($.browser.version)) == 6) return; 
    $('.tablesorter tbody tr').click(
        function()
        {
            if($(this).attr('class').indexOf('clicked') > 0)
            {
                $(this).removeClass('clicked');
            }
            else
            {
                $(this).addClass('clicked');
            }
        }
    );
}
</script>
<form method='post' action="addLinks.htm">
<table class='table-1 colored tablesorter fixed'>
	<input type="hidden" name="taskId" value="${task.taskId }">
  <caption class='caption-tl'>
    <div class='f-left'>未关联</div>
    <div class='f-right'>
      <span class='link-button'><a href='taskList.htm' target='' class='link-icon' title='返回'><i class="icon-goback icon-level-up icon-large icon-rotate-270"></i></a>
</span>    </div>
  </caption>
  <thead>
  <tr class='colhead'>
    <th class='w-id' style="width: 10%;">ID</th>
    <th class='w-pri' style="width: 10%;">P</th>
    <th style="width: 30%;">用例标题</th>
    <th style="width: 30%;">用例类型</th>
    <th class='w-user' style="width: 10%;">创建</th>
    <th class='w-status' style="width: 10%;">状态</th>
  </tr>
  </thead>
  <tbody>
  	<c:forEach items="${usercases }" var="usercase">
    <tr class='a-center'>
    <td class='a-left'>
      <input type='checkbox' name='cases' value='${usercase.caseId }' />
      <a href='showCase.htm?caseId=${usercase.caseId }'>${usercase.caseId }</a>
    </td>
    <td><span class='pri3'>${usercase.priority }</span></td>
    <td class='a-left'>
      ${usercase.title }</td>
    <td>${usercase.stage }</td>
    <td>${usercase.creator.user.realName }</td>
    <td>${usercase.status }</td>
  </tr>
  </c:forEach>
  </tbody>
    <tfoot> 
  <tr>
    <td colspan='7'>
            <div class='f-left'><script type="text/javascript">
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

</script>
<input type='button' name='reversechecker' id='reversechecker' value='反选' onclick='selectReverse("")'/> <input type='submit' id='submit' value='保存'  class='button-s' /> </div>
            <div class='f-right'>
            
            <pt:page totalSize="${totalSize }" pageSize="${pageSize }" url="${url }" curPage="${curPage }"></pt:page>

</div>
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
    <a href='' >BUG管理</a>
     &nbsp;<span class="icon-angle-right"></span><a href='' >BUG</a>
     &nbsp;<span class="icon-angle-right"></span>BUG
  </div>
  <div id="poweredby">
    <span>Powered by <a href=''>SICD</a> </span>
  </div>
 </div>
</body>
</html>
