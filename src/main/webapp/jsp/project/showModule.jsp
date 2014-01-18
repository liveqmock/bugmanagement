<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>${curProject.name }::维护项目视图模块 - 大数据</title>
<script language='Javascript'>var config={"webRoot":"\/pro\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/pro\/theme\/","currentModule":"tree","currentMethod":"browsetask","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/pro\/index.php\/tree-browsetask-1-1-3.html"}
</script>

<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<script src='<c:url value="/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<link rel="icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon" />

</head>
<body>
<style>
#colorbox, #cboxOverlay, #cboxWrapper{z-index:9999;}
</style>

<jsp:include page="includeHeader.jsp"></jsp:include>

<div class="navbar" id="modulemenu">
 <ul>
<jsp:include page="../includeJsp/includeSelectPro.jsp"></jsp:include>

<li class=' active'><a href='showModule.htm' target=''>模块</a>
</li>
<li class=' '><a href='versionList.htm' target=''>版本</a>
</li>
<li class='right '><a href='newProject.htm' target='' id="submenucreate"><i class="icon-plus"></i>&nbsp;添加项目</a>
</li>
<li class='right '><a href='projectList.htm' target='' id="submenuall"><i class="icon-th-large"></i>&nbsp;所有项目</a>
</li>
</ul>
</div>
<div id='wrap'>
  <div class='outer'>
<script language='javascript'>$(function() { $(".tree").treeview({ persist: "cookie", collapsed: false, unique: false}) })</script>
<table class='cont-lt5'>
  <tr valign='top'>
    <td class='side'>
      <form method='post' target='hiddenwin' action='/pro/tree-updateOrder-1-task.html'>
        <table class='table-1'>
          <caption>${curProject.name }::维护项目视图模块</caption>
          <tr>
            <td>
              <div id='main'>
              <ul class='tree'>
              <c:forEach items="${moduleBeans}" var="moduleBean" varStatus="status">
              	<c:choose>
              		<c:when test="${moduleBean.hasChildren}">
              			<li class="collapsable">${moduleBean.moduleName}<a href='showModule.htm?mmoduleId=${moduleBean.moduleId}' >下级模块</a><ul>
              		</c:when>
              		<c:when test="${!moduleBean.hasChildren && !moduleBean.last}">
              			<li>${moduleBean.moduleName}<a href='showModule.htm?moduleId=${moduleBean.moduleId}' >下级模块</a><a href='deleteModule.htm?moduleId=${moduleBean.moduleId }' onclick="return confirm('are you sure?')">删除模块</a></li>
              		</c:when>
              		<c:when test="${!moduleBean.hasChildren && moduleBean.last}">
              			<li>${moduleBean.moduleName}<a href='showModule.htm?moduleId=${moduleBean.moduleId}' >下级模块</a><a href='deleteModule.htm?moduleId=${moduleBean.moduleId }' onclick="return confirm('are you sure?')">删除模块</a></li></ul></li>
              		</c:when>
              	</c:choose>
              </c:forEach>
              </ul>			
				</div>
              <div class='a-center'>
                 <input type='submit' id='submit' value='更新排序'  class='button-s' />               
                 </div>
            </td>
          </tr>
        </table>
      </form>
    </td>
    <td class='divider'></td>
    <td>
      <form method='post' action='updateModule.htm'>
        <table align='center' class='table-1'>
                    <caption>维护项目子模块</caption>
          <tr>
            <td width='10%'>
              <nobr>
              <a href='showModule.htm' >${curProject.name }</a>&nbsp;<span class="icon-angle-right"></span>
	            <c:if test="${module ne null }">
	            	<c:forEach items="${menuModules }" var="moduleBean">
	            		<a href='showModule.htm?moduleId=${moduleBean.moduleId }' >${moduleBean.moduleName }</a>&nbsp;<span class="icon-angle-right"></span>
	            	</c:forEach>
				</c:if>
			</nobr>
            </td>
            <td>
            	<c:forEach items="${subModules }" var="module">
            		<span><input type='text' name='moduleNames' value='${module.name }' style="margin-bottom:5px;" /><br /></span>
            	</c:forEach>      
				</td>
          </tr>
          <tr>
            <td></td>
            <td colspan='2'>
               <input type='submit' id='submit' value='保存'  class='button-s' /> <input type='button' onClick='javascript:history.go(-1);' value='返回' class='button-b' />
              <input type='hidden' value='${module.moduleId }' name='parentModuleId' />
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
    <a href='/pro/my/' >${company.name }</a>
&nbsp;<span class="icon-angle-right"></span><a href='/pro/project/' >项目</a>
&nbsp;<span class="icon-angle-right"></span><a href='/pro/project-task-1.html' >${curProject.name }</a>
&nbsp;<span class="icon-angle-right"></span>维护项目视图模块  </div>
  <div id="poweredby">
    <span>Powered by <a href='http://www.zentao.net' target='_blank'>ZenTaoPMS</a> (pro3.1)</span>
        <a href='/pro/misc-downNotify.html' >下载桌面提醒</a>
    <a href='/pro/misc-qrCode.html' target='' class='qrCode '><i class='icon-mobile-phone icon-large'></i>手机访问</a>
  </div>
</div>
<script language='Javascript'>onlybody = "no"
</script>
<script language='Javascript'>function syncModule(rootID, type)
{
    moduleID = type == 'task' ? $('#projectModule').val() : $('#productModule').val();
    type     = type == 'task' ? 'task' : 'story';

    link = createLink('tree', 'ajaxGetSonModules', 'moduleID=' + moduleID + '&rootID=' + rootID + '&type=' + type);
    $.getJSON(link, function(modules)
    {
        $('.helplink').addClass('hidden');
        $.each(modules, function(key, value)
        {   
            moduleName = value;
            $('.text-3').each(function()
            {
                if(this.value == moduleName) modules[key] = null;
                if(!this.value) $(this).parent().addClass('hidden');
            })
        });  
        $.each(modules, function(key, value)
        {  
            if(value) $('#sonModule').append("<span><input name=modules[] value=" + value + " style=margin-bottom:5px class=text-3 /><br /><span>");
        })
    })
}

function syncProject(obj)
{
    link = createLink('tree', 'ajaxGetOptionMenu', 'rootID=' + obj.value + "&viewType=task&rootModuleID=0&returnType=json");
    $.getJSON(link, function(modules)
    {
        $('.helplink').addClass('hidden');
        $('#' + type + 'Module').empty();
        $.each(modules, function(key, value)
        {  
            $('#' + type + 'Module').append('<option value=' + key + '>' + value + '</option')
        }); 
    })
    $('#copyModule').attr('onclick', null);
    $('#copyModule').bind('click', function(){syncModule(obj.value, 'task')});
}

$(document).ready(function()
{
    $("a.iframe").colorbox({width:480, height:240, iframe:true, transition:'none'});
});

</script>
</body>
</html>
