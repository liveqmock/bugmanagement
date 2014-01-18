<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>${version.name } - ${version.project.name }- Bug管理</title>
<script>var config={"webRoot":"\/pro\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/pro\/theme\/","currentModule":"build","currentMethod":"view","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/pro\/index.php\/build-view-1.html"}
</script>
<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<!--[if lt IE 8]><link rel='stylesheet' href='/css/theme/fontawesome/ie7.min.css?v=pro3.1' type='text/css' media='screen' />
<link rel='stylesheet' href='/css/theme/default/style.ie7.css?v=pro3.1' type='text/css' media='screen' />
<![endif]-->
<script src='<c:url value="/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<link rel="icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon" />

<style>.mainTable  { width:100%;}
.headTable  { width:100%; height:30px; margin:0px; border:0px}
.contentDiv { height:195px; overflow-y:auto}
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
<li class=' active'><a href='versionList.htm' target=''>版本</a>
</li>
<li class='right '><a href='newProject.htm' target='' id="submenucreate"><i class="icon-plus"></i>&nbsp;添加项目</a>
</li>
<li class='right '><a href='projectList.htm' target='' id="submenuall"><i class="icon-th-large"></i>&nbsp;所有项目</a>
</li>
</ul>
</div>

<div id='wrap'>
  <div class='outer'>
<table class='cont-rt5'> 
  <caption class=''>Version - ${version.name }</caption>
  <tr valign='top'>
    <td>
      <fieldset>
        <legend>描述</legend>
        <div class='content'>${version.description }</div>
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
      <div class='a-center f-16px strong mb-10px'>
      <span class='link-button'><a href='editVersion.htm?versionId=${version.versionId }' target='' class='link-icon ' title='编辑版本'><i class='icon-green-common-edit'></i></a></span>
      <span class='link-button'><a href='deleteVersion.htm?versionId=${version.versionId }' class='link-icon ' title='删除版本'><i class='icon-green-common-delete'></i></a></span>
      <span class='link-button'><a href='versionList.htm' target='' class='link-icon' title=返回><i class="icon-goback icon-level-up icon-large icon-rotate-270"></i></a></span>
      </div>
    </td>
    <td class="divider"></td>
    <td class="side">
      <fieldset>
        <legend>基本信息</legend>
        <table class='table-1 a-left fixed'>
          <tr>
            <th width='25%' class='a-right'>项目</th>
            <td>${version.project.name }</td>
          </tr>
          <tr>
            <th class='rowhead'>创建日期</th>
            <td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${version.createdAt }" /></td>
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
&nbsp;<span class="icon-angle-right"></span>项目
&nbsp;<span class="icon-angle-right"></span>${version.name }</div>
  <div id="poweredby">
    <span>Powered by SICD</span>
  </div>
</div>
<script>$(document).ready(function()
{
    $("a.preview").colorbox({width:1000, height:550, iframe:true, transition:'none', scrolling:true});
})

</script>
</body>
</html>
