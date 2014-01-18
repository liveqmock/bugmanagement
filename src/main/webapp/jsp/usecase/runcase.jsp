<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli'>
<html xmlns='http://www.w3.org/1999/xhtml'>

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
<script type="text/javascript">
$(function(){
$("#submit1").click(
		function() {
                $.ajax({
						type:"post",
						url:"runcase.htm",
						data:$("#runcasesteps").serializeArray(),
						success:function(data){
							window.parent.location.reload();
							//location.reload();
							//history.go(0);
						  //  window.navigate(location);
			            },
			            error : function(textStatus,e){
			                alert("提交失败");
			            }
					});
		});
$("#submit2").click(
		function() {
                $.ajax({
						type:"post",
						url:"runcase2.htm",
						data:$("#runcasesteps").serializeArray(),
						success:function(data){
							window.parent.location.reload();
							//location.reload();
							//history.go(0);
						  //  window.navigate(location);
			            },
			            error : function(textStatus,e){
			                alert("提交失败");
			            }
					});
		});
});
</script>
<form  id="runcasesteps">
  <table class='table-1'>
    <caption class='caption-tl'>CASE::${usercase.title}</caption>
    <tr>
      <td colspan='5'><h5>前置条件</h5>${usercase.precondition}</td>
    </tr>
    <tr class='colhead'>
      <th class='w-30px'>编号</th>
      <th class='w-p40'>步骤</th>
      <th class='w-p20'>预期</th>
      <th class='w-100px'>测试结果</th>
      <th>实际情况</th>
    </tr>
    
    
    <c:forEach var="x" items="${steps}" varStatus="status">
      <tr>
      <th>${x.num}</th>
      <td>${x.content}</td>
      <td>${x.expect}</td>
      <td class='a-center'>
      <select name='steps[${status.index+1}]' id='steps${status.index+1}' >
          <option value='n/a' selected='selected'>N/A</option>
          <option value='通过'>通过</option>
          <option value='失败'>失败</option>
          <option value='阻塞'>阻塞</option>
     </select>
     </td>
     <td>
       <textarea name='reals[${status.index+1}]' id='reals[${status.index+1}]' rows=2 class='area-1'>
       ${x.reality}
       </textarea>
     </td>
    </tr>
    <input type="hidden" name='stepId[${status.index+1}]' value="${x.stepId}"></input>
    </c:forEach>
            
     <tr class='a-center'>
      <td colspan='5'>
         <input type='button' name="submit1" id='submit1' value="保存"  class='button-s' />
         <input type='button' name="submit2" id='submit2' value="通过"  class='button-s' />
        <!--  <c:if test="${(fn:length(steps)>status.index+1)||nextcaseId!=null}">
          <input type='button' value='下一个'  onclick='self.location="goruncase.htm?result=${result}nextisornot=${nextcaseId}&nextcaseId=${nextcaseId}"' class='button-c' />   
         </c:if> -->
      </td>
    </tr>
  </table>
  <input name="caseId" value="${usercase.caseId}" type="hidden"/>
  <input name="stepslength" value="${fn:length(steps)}" type="hidden"/>
  <input name="nextcaseId" value="${nextcaseId}" type="hidden"/>
  <input name="result" value="${result}" type="hidden"></input>
</form>


<table class='table-1'>
  <caption>
    <div class='f-left'>RESULT# ${usercase.runner.user.realName}  执行: <span class='blocked'>${result}</span></div>
  </caption>
  <tr>
    <th class='w-30px'>编号</th>
    <th class='w-p40'>步骤</th>
    <th class='w-p20'>预期</th>
    <th>测试结果</th>
    <th class='w-p20'>实际情况</th>
  </tr>
  <c:forEach var="z" items="${steps}" varStatus="status">
    <tr>
    <th>${z.num}</th>
    <td>${z.content}</td>
    <td>${z.expect}</td>
    
    <c:choose>
                         <c:when test="${z.result=='阻塞'}"><td class="blocked a-center">阻塞</td><c:set var="result" value="blocked"></c:set></c:when>
                         <c:otherwise>
                           <c:choose>
                             <c:when test="${z.result=='通过'}"><td class="pass a-center">通过</td><c:set var="result" value="pass"></c:set></c:when>
                             <c:otherwise>
                                <c:choose>
                                   <c:when test="${z.result=='失败'}"><td class="fail a-center">失败</td><c:set var="result" value="fail"></c:set></c:when>
                                   <c:otherwise><td></td></c:otherwise>
                                </c:choose>
                              </c:otherwise>
                            </c:choose>
                         </c:otherwise>
                     </c:choose>
    
    <td>${z.reality}</td>
  </tr>
  </c:forEach>
 </table>
<iframe frameborder='0' name='hiddenwin' id='hiddenwin' scrolling='no' class='hidden'></iframe>
<script language="Javascript">
$().ready(function(){setDebugWin('white')})
</script>
</body>
</html>
