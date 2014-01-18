<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli'>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>维护部门结构::大数据 - BUG管理</title>
<script language="Javascript">var config={"webRoot":"\/css\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/css\/theme\/","currentModule":"bug","currentMethod":"browse","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/css\/index.php\/bug-browse-1.html"}
</script>
<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<link rel="icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon"/>
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon"/>
<script src='<c:url value="/js/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<style>body{background:white}
tr, td, th {border:1px solid #eee}
</style>
<link rel='icon' href='<c:url value="/pic/logo.png"/>' type='image/x-icon' />
<link rel='shortcut icon' href='<c:url value="/pic/logo.png"/>' type='image/x-icon' />
<link rel="stylesheet" href='<c:url value="/css/theme/default/dropmenu.css"/>'  type="text/css" media="screen" />
</head>
<body>
<div id="cboxOverlay" style="display: none; ">
</div>
<div id="colorbox" class="" style="padding-right: 50px; display: none; ">
   <div id="cboxWrapper">
      <div>
         <div id="cboxTopLeft" style="float: left; "></div>
         <div id="cboxTopCenter" style="float: left; "></div>
         <div id="cboxTopRight" style="float: left; "></div>
      </div>
      <div style="clear: left; ">
         <div id="cboxMiddleLeft" style="float: left; "></div>
         <div id="cboxContent" style="float: left; ">
            <div id="cboxLoadedContent" style="width: 0px; height: 0px; overflow: hidden; float: left; "></div>
            <div id="cboxLoadingOverlay" style="float: left; "></div>
            <div id="cboxLoadingGraphic" style="float: left; "></div>
            <div id="cboxTitle" style="float: left; "></div>
            <div id="cboxCurrent" style="float: left; "></div>
            <div id="cboxNext" style="float: left; "></div>
            <div id="cboxPrevious" style="float: left; "></div>
            <div id="cboxSlideshow" style="float: left; "></div>
            <div id="cboxClose" style="float: left; "></div>
         </div>
         <div id="cboxMiddleRight" style="float: left; "></div>
      </div>
      <div style="clear: left; ">
         <div id="cboxBottomLeft" style="float: left; "></div>
         <div id="cboxBottomCenter" style="float: left; "></div>
         <div id="cboxBottomRight" style="float: left; "></div>
      </div>
   </div>
   <div style="position: absolute; width: 9999px; visibility: hidden; display: none; "></div>
</div>
<h1>CASE::${usercase.title}</h1>
<fieldset>
  <legend>前置条件</legend>
  ${usercase.precondition}</fieldset>
<table class="table-1">
  <caption>
    <div class="f-left">RESULT# ${usercase.runner.user.realName}  执行: <span class="blocked">${result}</span></div>
      </caption>
  <tbody><tr>
    <th class="w-30px">编号</th>
    <th class="w-p40">步骤</th>
    <th class="w-p20">预期</th>
    <th>测试结果</th>
    <th class="w-p20">实际情况</th>
  </tr>
  <c:forEach var="x" items="${steps}" varStatus="status">
    <tr>
    <th>${x.num}</th>
    <td>${x.content}</td>
    <td>${x.expect}</td>
    <c:choose>
                         <c:when test="${x.result=='阻塞'}"><td class="blocked a-center">阻塞</td><c:set var="result" value="blocked"></c:set></c:when>
                         <c:otherwise>
                           <c:choose>
                             <c:when test="${x.result=='通过'}"><td class="pass a-center">通过</td><c:set var="result" value="pass"></c:set></c:when>
                             <c:otherwise>
                                <c:choose>
                                   <c:when test="${x.result=='失败'}"><td class="fail a-center">失败</td><c:set var="result" value="fail"></c:set></c:when>
                                   <c:otherwise><td></td></c:otherwise>
                                </c:choose>
                              </c:otherwise>
                            </c:choose>
                         </c:otherwise>
                     </c:choose>
    <td>${x.reality}</td>
  </tr>
  </c:forEach>
     </tbody>
   </table>
 </body>
</html>