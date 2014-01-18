<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>维护部门结构::大数据 - BUG管理</title>
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
<li class=' active'><a href='goDept.htm' target='' id='submenudept'>部门</a>
</li>
<li class=' '><a href='goToUserList.htm' target='' id='submenubrowseUser'>用户</a>
</li>
<li class=' '><a href='goDynamic.htm' target='' id='submenudept'>动态</a>
</li>
<li class=' '><a href='goCompanyInfo.htm' target='' id='submenudept'>公司</a>
</li>
</ul>
</div>
<div id='wrap'>
  <div class='outer'>
<script language='javascript'>$(function() { $(".tree").treeview({ persist: "cookie", collapsed: false, unique: false}) })</script>
<table class="cont-lt4">                 
  <tr valign='top'>
    <td class='side'>
<form method='post' target='hiddenwin' action='updateDept.htm'>
        <table class='table-1'>
          <caption>维护部门结构::大数据</caption>
          <tr>
            <td>
              <div id='main'>
              <ul class='tree'>
              <c:forEach items="${deptBeans}" var="deptBean" varStatus="status">
              	<c:choose>
              		<c:when test="${deptBean.hasChildren}">
              			<li class="collapsable">${deptBean.deptName}<a href='goDept.htm?deptId=${deptBean.deptId}' >下级部门</a><ul>
              		</c:when>
              		<c:when test="${!deptBean.hasChildren && !deptBean.last}">
              			<li>${deptBean.deptName}<a href='goDept.htm?deptId=${deptBean.deptId}' >下级部门</a><a href='deleteDept.htm?deptId=${deptBean.deptId}' onclick="return confirm('are you sure?')">删除部门</a></li>
              		</c:when>
              		<c:when test="${!deptBean.hasChildren && deptBean.last}">
              			<li>${deptBean.deptName}<a href='goDept.htm?deptId=${deptBean.deptId}' >下级部门</a><a href='deleteDept.htm?deptId=${deptBean.deptId}' onclick="return confirm('are you sure?')">删除部门</a></li></ul></li>
              		</c:when>
              	</c:choose>
              </c:forEach>
              </ul>
             </div>
              <div class='a-center'> <input type='submit' id='submit' value='更新'  class='button-s' /> </div>
            </td>
          </tr>
        </table>
 </form>
    </td>
    <td class='divider'></td>
    <td>
      <form method='post' action='updateDept.htm'>
        <table align='center' class='table-1'>
          <caption>下级部门</caption>
          <tr>
            <td width='10%'>
             <nobr>
	            <a href='goDept.htm' >大数据</a>&nbsp;<span class="icon-angle-right"></span>
	            <c:if test="${department ne null }">
	            	<c:forEach items="${menuDepts }" var="deptBean">
	            		<a href='goDept.htm?deptId=${deptBean.deptId }' >${deptBean.deptName }</a>&nbsp;<span class="icon-angle-right"></span>
	            	</c:forEach>
				</c:if>
			</nobr>
            </td>
            <td>
            	<c:forEach items="${subDepts }" var="dept">
            		<input type='text' name='deptNames' value='${dept.name }'  /><br />
            	</c:forEach>      
				</td>
          </tr>
          <tr>
            <td></td>
            <td>
               <input type='submit' value='保存'  class='button-s' /> <input type='button' onClick='javascript:history.go(-1);' value='返回' class='button-b' />
              <input type='hidden' value='${department.departmentId }' name='parentDeptId' />
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>  
  </div>
    <iframe frameborder='0' name='hiddenwin' id='hiddenwin' scrolling='no' class='hidden'></iframe>
  <div id='divider'></div>
</div>
<div id='footer'>
  <div id="crumbs">
    <a href='/pro/my/' >Bug管理</a>
&nbsp;<span class="icon-angle-right"></span><a href='/pro/company/' >组织</a>
&nbsp;<span class="icon-angle-right"></span>维护部门结构  </div>
  <div id="poweredby">
    <span>Powered by <a href='http://www.zentao.net' target='_blank'>ZenTaoPMS</a> (pro3.1)</span>
        <a href='/pro/misc-downNotify.html' >下载桌面提醒</a>
    <a href='/pro/misc-qrCode.html' target='' class='qrCode '><i class='icon-mobile-phone icon-large'></i>手机访问</a>
  </div>
</div>
<script language='Javascript'>onlybody = "no"
</script>
</body>
</html>
