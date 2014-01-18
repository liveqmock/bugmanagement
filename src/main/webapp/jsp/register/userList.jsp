<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pt" uri="/page-tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>用户列表 - BUG管理</title>
<script language="Javascript">var config={"webRoot":"\/css\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/css\/theme\/","currentModule":"bug","currentMethod":"browse","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/css\/index.php\/bug-browse-1.html"}
</script>
<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<link rel="icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon"/>
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon"/>
<script src='<c:url value="/js/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<style>.table-1 input{margin-bottom:3px}
</style>
<style>.closed, .closed a{color:gray; text-decoration:line-through;}
.resolved, .resolved a{color:#8EC21F; text-decoration:none;}
.tree .closed, .tree .closed a{color:#003366; text-decoration:none;}
.confirm0 {color:gray;  font-size:9px}
.confirm1 {color:green; font-size:9px}
tfoot .f-left {color:#141414;}
</style>
<link rel='icon' href='<c:url value="/pic/logo.png"/>' type='image/x-icon' />
<link rel='shortcut icon' href='<c:url value="/pic/logo.png"/>' type='image/x-icon' />
<link rel="stylesheet" href='<c:url value="/css/theme/default/dropmenu.css"/>'  type="text/css" media="screen" />
</head>
<body>
<style>
#colorbox, #cboxOverlay, #cboxWrapper{z-index:9999;}
</style>

<jsp:include page="../company/includeHeader.jsp"></jsp:include>

<div class="navbar" id="modulemenu">
  <ul>
<li>${company.name }&nbsp;<span class="icon-angle-right"></span></li>
<li ><a href='goDept.htm' target='' id='submenudept'>部门</a>
</li>
<li class=' active'><a href='goToUserList.htm' target='' id='submenubrowseUser'>用户</a>
</li>
<li><a href='goDynamic.htm' target='' id='submenudept'>动态</a>
</li>
<li><a href='goCompanyInfo.htm' target='' id='submenudept'>公司</a>
</li>
<li class="right "><a href="goaddUser.htm" target=""id="submenuaddUser"><i class="icon-plus"></i>&nbsp;添加用户</a></li>


</ul>
</div>
 <div id="wrap">
   <div class="outer" style="min-height: 714px;">
    <script language="javascript">
     $(function(){ $(".tree").treeview({ persist: "cookie", collapsed: false, unique: false});});
    </script>
    <script language="javascript">
     $(function()
       {
            $('.colored').colorize();
            $('tfoot td').css('background', 'white').unbind('click').unbind('hover');
       }
       );
    </script>
   <div class="treeSlider" id="bugTree"><span>&nbsp;</span>
   </div>
   <form method="post" >
    <table class="cont-lt1">
      <tbody>
       <tr valign="top">
       
       <!-- 树形区域 -->
       
         <td class="side" id="treebox" style="width: 15%">
          <div class="box-title">部门结构</div>
          <div class="box-content">
            <ul class="tree treeview">
               <c:forEach items="${all}" var="deptBean" varStatus="status">
              	<c:choose>
              		<c:when test="${deptBean.hasChildren}">
              			<li class="collapsable"><a href="goDeptUser.htm?deptId=${deptBean.deptId}">${deptBean.deptName}</a><ul>
              		</c:when>
              		<c:when test="${!deptBean.hasChildren && !deptBean.last}">
              			<li><a href="goDeptUser.htm?deptId=${deptBean.deptId}">${deptBean.deptName}</a></li>
              		</c:when>
              		<c:when test="${!deptBean.hasChildren && deptBean.last}">
              			<li><a href="goDeptUser.htm?deptId=${deptBean.deptId}">${deptBean.deptName}</a></li></ul></li>
              		</c:when>
              	</c:choose>
              </c:forEach>
            </ul>
            <div class="a-right">
            <a href="goDept.htm" target="">维护部门结构</a>
          </div>
        </div>
       </td>
       
       <td class="divider"></td>
       
       <!-- bug列表  如果没有bug 显示相关提示-->
       
       <td>
         <table class="table-1 fixed colored tablesorter datatable" id="bugList">
           <thead>
               <tr class="colhead" >
                       <th class="w-id" style="width:10%;">
                           <div class="header"><a href="">ID</a></div>
                       </th>
                       <th class="w-severity" style="width:10%;"> 
                             <div class="header">真实姓名</div>
                       </th>
                       <th class="w-pri" style="width:10%;">      
                             <div class="header">用户名</div>
                       </th>
                        <th style="width:10%;">                    
                             <div class="header">职位</div>
                       </th>
                        <th class="w-80px" style="width:15%;">
                            <div class="header">邮箱</div>
                        </th>
                        <th class="w-user" style="width:10%;">
                            <div class="header">性别</div>
                        </th>
                        <th class="w-date" style="width:15%;">
                            <div class="header"><a href="">加入时间</a></div>
                        </th>
            
                         <th class="w-user" style="width:10%;">
                              <div class="header"><a href="">所属部门</a></div>
                         </th>
                         
                         <th class="w-user" style="width:15%;">
                              <div class="header"><a href="">操作</a></div>
                         </th>
                 </tr>
            </thead>
            <tbody>
            <c:forEach var="user" items="${userList}">
                 <tr class="a-center" style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
                      <td class="active" style="font-weight:bold" >
                          ${user.userId}
                      </td>
                      <td><span>${user.realName}</span></td>
                      <td><span>${user.name}</span></td>
                      <td><span>${user.position}</span></td>
                      <td><span>${user.email}</span></td>
                      <td><span>${user.gender}</span></td>
                      <td><fmt:formatDate value="${user.joinDate}"></fmt:formatDate></td>
                      <td><span>${user.department.name}</span></td>
                      <td><a href="goEditUser.htm?userId=${user.userId}">编辑用户</a></td>
            </tr> 
            </c:forEach>
            
            </tbody>
            <tfoot>
              <tr style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
                     <td colspan="12" style="background-color: white; background-position: initial initial; background-repeat: initial initial;">
                        <div class="f-right">
                           <pt:page totalSize="${totalSize}" pageSize="${pageSize }" url="${url }" curPage="${curPage }"></pt:page>
                        </div>
                    </td>
                 </tr>
              </tfoot>
            </table>

          </td>
         </tr>
       </tbody>
      </table>  
     </form>
  <div id="divider"></div>
 </div>
 </div>
 <div id='footer'>
  <div id="crumbs">
    <a href='' >BUG管理</a>
     &nbsp;<span class="icon-angle-right"></span><a href='' >组织</a>
     &nbsp;<span class="icon-angle-right"></span>用户
  </div>
  <div id="poweredby">
    <span>Powered by <a href=''>SICD</a> </span>
  </div>
 </div>
</body>
</html>

