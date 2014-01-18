<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pt" uri="/page-tags"%>

<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>${curProject.name }::用例 - BUG管理</title>
<script language='Javascript'>var config={"webRoot":"\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/theme\/","currentModule":"testtask","currentMethod":"cases","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/index.php\/testtask-cases-16.html"}
</script>
<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<!--[if lt IE 8]><link rel='stylesheet' href='/css/theme/fontawesome/ie7.min.css?v=pro3.1' type='text/css' media='screen' />
<link rel='stylesheet' href='/css/theme/default/style.ie7.css?v=pro3.1' type='text/css' media='screen' />
<![endif]-->
<script src='<c:url value="/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<link type="text/css" rel="stylesheet" href="<c:url value="/css/theme/browser/safari.css"/>" />

<link rel="icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon" />
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
<script language='javascript'>$(function() { $(".tree").treeview({ persist: "cookie", collapsed: false, unique: false}) })</script>
<script language='javascript'>
$(function()
{
    $('.colored').colorize();
    $('tfoot td').css('background', 'white').unbind('click').unbind('hover');
}
);
</script>
<script language='Javascript'>confirmUnlink = "\u60a8\u786e\u8ba4\u8981\u79fb\u9664\u8be5\u7528\u4f8b\u5417\uff1f"
</script>
<script language="Javascript">
var browseType = 'bymodule';
var moduleID   = '0';
</script>

<div id='featurebar'>
  <div class='f-left'>
    <span><strong>${task.name }</strong>:用例列表</span> </div>
  <div class='f-right'>
  <span class='link-button'><a href='taskList.htm' target='' class='link-icon' title=返回><i class="icon-goback icon-level-up icon-large icon-rotate-270"></i></a>
</span>  </div>
</div>
<div id='querybox' class='hidden'></div>

<form method='post' name='casesform'>
<table class='cont-lt1'>
  <tr valign='top'>
    <td class='side '>
      <div class='box-title'>${curProject.name }</div>
      <div class='box-content'><ul class='tree'><c:forEach items="${moduleBeans}" var="moduleBean" varStatus="status">
              	<c:choose>
              		<c:when test="${moduleBean.hasChildren}">
              			<li class="collapsable">${moduleBean.moduleName}<ul>
              		</c:when>
              		<c:when test="${!moduleBean.hasChildren && !moduleBean.last}">
              			<li>${moduleBean.moduleName}</li>
              		</c:when>
              		<c:when test="${!moduleBean.hasChildren && moduleBean.last}">
              			<li>${moduleBean.moduleName}</li></ul></li>
              		</c:when>
              	</c:choose>
              </c:forEach>
</ul>
</div>
    </td>
    <td class='divider '></td>
    <td>
          <table class='table-1 colored tablesorter datatable mb-zero fixed' id='caseList'>
        <thead>
          <tr class='colhead'>
            <th class='w-id'><nobr><div class='headerSortUp'><a href='' >ID</a>
</div></nobr></th>
            <th class='w-pri'>     <div class='header'><a href='' >P</a>
</div></th>
            <th>                   <div class='header'><a href='' >用例标题</a>
</div></th>
            <th>    <div class='header'><a href='' >用例类型</a>
</div></th>
            <th class='w-user'>    <div class='header'><a href='' >创建者</a>
</div></th>
            <th class='w-user'>    <div class='header'><a href='' >运行者</a>
</div></th>
            <th class='w-100px'>   <div class='header'><a href='' >创建时间</a>
</div></th>
            <th class='w-80px'>    <div class='header'><a href='' >结果</a>
</div></th>
            <th class='w-status'>  <div class='header'><a href='' >状态</a>
</div></th>
            <th class='w-100px {sorter: false}'>操作</th>
          </tr>
        </thead>
        <tbody>
        <c:forEach items="${usercases }" var="usercase">
                              <tr class='a-center'>
            <td class='a-center'>
               #${usercase.caseId }
            </td>
            <td><span class='pri3'>${usercase.priority }</span></td>
            <td class='a-left nobr'><a href='showCase.htm?caseId=${usercase.caseId }' target='_blank' >${usercase.title }</a>
            </td>
            <td>${usercase.stage }</td>
            <td>${usercase.creator.user.name }</td>
            <td>${usercase.runner.user.name }</td>
            <td><fmt:formatDate pattern="MM/dd hh:mm" value="${usercase.createdAt }" /></td>
            <td class=''>${usercase.result }</td>
            <td class='wait'>${usercase.status }</td>
            <td class='a-center'>
              <a href='goruncase.htm?caseId=${usercase.caseId}' target='' class='link-icon runCase' title='执行'><i class='icon-green-testtask-runCase'></i></a><a href='caseresult.htm?caseId=${usercase.caseId}' target='' class='link-icon iframe' title='结果'><i class='icon-green-testtask-results'></i></a><a href='unlinkCases.htm?taskId=${task.taskId }&caseId=${usercase.caseId}' target='' class='link-icon' title='移除'><i class="icon-green-testtask-unlinkCase"></i></a>
<i class='disabled icon-gray-bug-createBug' title='提Bug'></i>            </td>
          </tr>
          </c:forEach>
        </tbody>
        <tfoot>
          <tr>
            <td colspan='10'>

 <pt:page totalSize="${totalSize }" pageSize="${pageSize }" url="${url }" curPage="${curPage }"></pt:page>           </td>
          </tr>
        </tfoot>
      </table>
    </td>
  </tr>
</table>
</form>   
  </div>
    <iframe frameborder='0' name='hiddenwin' id='hiddenwin' scrolling='no' class='hidden'></iframe>
  <div id='divider'></div>
</div>
<div id='footer'>
  <div id="crumbs">
    <a href='/my/' >BUG管理</a>
&nbsp;<span class="icon-angle-right"></span><a href='/testtask/' >测试</a>
&nbsp;<span class="icon-angle-right"></span><a href='/testtask-browse-12.html' >测试</a>
&nbsp;<span class="icon-angle-right"></span>测试任务&nbsp;<span class="icon-angle-right"></span>用例  </div>
  <div id="poweredby">
    <span>Powered by <a href=''>SICD</a> </span>
  </div>
</div>
<script language='Javascript'>onlybody = "no"
</script>
<script language='Javascript'>function browseByModule(active)
{
    $('.side').removeClass('hidden');
    $('.divider').removeClass('hidden');
    $('#bymoduleTab').addClass('active');
    $('#' + active + 'Tab').removeClass('active');
    $('#querybox').addClass('hidden');
}

/* Swtich to search module. */
function browseBySearch(active)
{
    $('#querybox').removeClass('hidden');
    $('.side').addClass('hidden');
    $('.divider').addClass('hidden');
    $('#' + active + 'Tab').removeClass('active');
    $('#bysearchTab').addClass('active');
    $('#bymoduleTab').removeClass('active');
}

$(document).ready(function()
{
    setModal4List('runCase', 'caseList', function(){$(".results").colorbox({width:900, height:550, iframe:true, transition:'none'});});
    $('#' + browseType + 'Tab').addClass('active');
    $('#module' + moduleID).addClass('active'); 
    if(browseType == 'bysearch') ajaxGetSearchForm();
});

$(document).ready(function()
{
    $("a.iframe").colorbox({width:900, height:550, iframe:true, transition:'none'});
    $('#' + browseType + 'Tab').addClass('active');
    $('#module' + moduleID).addClass('active'); 
});
</script>
</body>
</html>