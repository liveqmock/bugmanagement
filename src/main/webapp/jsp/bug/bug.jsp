<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pt" uri="/page-tags"%>
<%@ taglib prefix="ct" uri="/column-tags"%>
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>Bug列表 - BUG管理</title>
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

<jsp:include page="includeHeader.jsp"></jsp:include>

 <div class="navbar" id="modulemenu">
 <ul>
	  <jsp:include page="../includeJsp/includeSelectPro.jsp"></jsp:include>
      <li class=" active"><a href="bug.htm" target="" id="submenubug">浏览Bug</a></li>
      <li ><a href="goAddBug.htm" target="" id="submenubug">提Bug</a></li>
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
    <script src='<c:url value="/js/js/jquery/dropmenu/dropmenu.js"/>' type="text/javascript"></script>
    <script language="Javascript">browseType = "all";</script>
    <script language="Javascript">moduleID = 0;</script>
    <script language="Javascript">customed = false;</script>
    
   <div id="featurebar">
       <div class="f-left">
       <span id="allTab" ><a href="bug.htm">所有</a></span>
       <span id="assigntomeTab"><a href="bugassigntome.htm">指派给我</a></span>
       <span id="openedbymeTab"><a href="bugopenedbyme.htm">由我创建</a></span>
       <span id="resolvedbymeTab"><a href="bugresolvedbyme.htm">由我解决</a></span>
       <span id="assigntonullTab"><a href="bugassigntonull.htm">未指派</a></span>
       <span id="unresolvedTab"><a href="bugunresolved.htm">未解决</a></span>
       <span id="unclosedTab"><a href="bugunclosed.htm">未关闭</a></span>
       <span id="longlifebugsTab"><a href="buglonglifebugs.htm">久未处理</a></span>
       </div>
       <div class="f-right">
       <span class='link-button'><a href='TestChart.htm' target='' class=''><i class='icon-green-common-report'></i> 报表</a></span>
       <span class="link-button"><a href="goAddBug.htm" target="" class=""><i class="icon-green-bug-create"></i>提Bug</a>
       </span>  
       </div>
   </div>


    
   <div class="treeSlider" id="bugTree"><span>&nbsp;</span>
   </div>
   <form method="post" >
    <table class="cont-lt1">
      <tbody>
       <tr valign="top">
       
       <!-- 树形区域 -->
       
         <td class="side" id="treebox">
          <div class="box-title">${curProject.name }</div>
          <div class="box-content">
            <ul class="tree treeview">
               <c:forEach items="${moduleBeans}" var="moduleBean" varStatus="status">
              	<c:choose>
              		<c:when test="${moduleBean.hasChildren}">
              			<li class="collapsable"><a href="goModuleBug.htm?moduleId=${moduleBean.moduleId}">${moduleBean.moduleName}</a><ul>
              		</c:when>
              		<c:when test="${!moduleBean.hasChildren && !moduleBean.last}">
              			<li><a href="goModuleBug.htm?moduleId=${moduleBean.moduleId}">${moduleBean.moduleName}</a></li>
              		</c:when>
              		<c:when test="${!moduleBean.hasChildren && moduleBean.last}">
              			<li><a href="goModuleBug.htm?moduleId=${moduleBean.moduleId}">${moduleBean.moduleName}</a></li></ul></li>
              		</c:when>
              	</c:choose>
              </c:forEach>
            </ul>
            <div class="a-right">
            <a href="showModule.htm" target="">维护模块</a>
          </div>
        </div>
       </td>
       
       <td class="divider"></td>
       
       <!-- bug列表  如果没有bug 显示相关提示-->
       
       <td>
       
       <c:choose><c:when test="${message=='noproject'}">
       <h1>${message}</h1>
       </c:when>
       <c:when test="${message=='没有BUG'}">
       <h1>${message}</h1>
       </c:when><c:otherwise>
         <table class="table-1 fixed colored tablesorter datatable" id="bugList">
           <thead>
               <tr class="colhead" style="">
                       <th class="w-id" >
                             <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="bugId" text="ID" />
                       </th>
                       <th class="w-severity" > 
                             <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="severity" text="级别" />
                       </th>
                       <th class="w-pri" >      
                             <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="priority" text="P" />
                       </th>
                        <th style="width:25%;">                    
                             <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="title" text="bug标题" />
                       </th>
                       <th class="w-80px" style="width:8%;">
                            <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="module" text="模块" />
                        </th>
                        <th class="w-80px" style="width:8%;">
                            <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="status" text="状态" />
                        </th>
                        <th class="w-user" style="width:8%;">
                            <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="creator" text="创建" />
                        </th>
                        <th class="w-date" style="width:10%;">
                            <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="createdAt" text="创建日期" />
                        </th>
            
                         <th class="w-user" style="width:8%;">
                              <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="assignedTo" text="指派" />
                         </th>
                         
                         <th class="w-user" style="width:8%;">
                              <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="assignedTo" text="解决" />
                          </th>
                          <th class="w-resolution" style="width:8%;">
                               <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="resolution" text="方案" />
                          </th>
                         
                         <th class="w-140px {sorter:false}" >操作
                         </th>
                 </tr>
            </thead>
            <tbody>
            <c:forEach var="x" items="${buglistx}" varStatus="status">
                 <tr class="a-center" style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
                      <td class="active" style="font-weight:bold" >
                          <input type="checkbox" name="bugIDList[]" value="6"/> 
                          <a href="showBug/${x.bugId }.htm">${x.bugId}</a>
                      </td>
                      <td id="002"><span class="<c:out value="severity${x.severity}" />">${x.severity}</span></td>
                      <td><span class="<c:out value="pri${x.priority}" />">${x.priority}</span></td>

                        <td class="a-left" title="${x.title}">
                        <c:choose>
                        <c:when test="${x.confirm}"><span class="confirm1">[已确认] </span></c:when>
                        <c:otherwise><span class="confirm0">[未确认] </span></c:otherwise>
                        </c:choose>
                        <a href="showBug/${x.bugId }.htm">${x.title}</a>
                        </td>

						<td>${x.module.name}</td>
                        <td>${x.status}</td>
            
                        <c:choose><c:when test="${user.realName==x.creator.realName}">
                         <td class="red">${x.creator.realName}</td>
                        </c:when><c:otherwise>
                         <td>${x.creator.realName}</td>
                        </c:otherwise></c:choose>
                       

                        <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${x.createdAt}" /></td>
            
            <td>${x.assignedTo.user.realName}</td>
            <td id="解决"><c:if test="${x.confirm}">${x.assignedTo.user.realName}</c:if></td>
            <td>${x.resolution}</td>
            
            <td class="a-right">
              <c:choose>
              	<c:when test="${(!x.confirm)}"><a href="gobugconfirmbug.htm?onlybody=yes&bugId=${x.bugId}" target="" class="link-icon iframe cboxElement" title="确认"><i class="icon-green-bug-confirmBug"></i></a></c:when>
                  <c:otherwise><i class="disabled icon-gray-bug-confirmBug" title="确认"></i></c:otherwise>
                  
              </c:choose>
              <a href="gobugAssignTo.htm?onlybody=yes&bugId=${x.bugId}" target="" class="link-icon iframe cboxElement" title="指派"><i class="icon-green-bug-assignTo"></i></a>
              <c:choose>
              		<c:when test="${x.status=='激活'}"><a href="gobugresolve.htm?onlybody=yes&bugId=${x.bugId}" target="" class="link-icon iframe cboxElement" title="解决"><i class="icon-green-bug-resolve"></i></a></c:when>
                  <c:otherwise><i class="disabled icon-gray-bug-resolve" title="解决"></i></c:otherwise>
              </c:choose>
              
              <c:choose>
              	<c:when test="${x.status=='已解决'}"><a href="gobugclose.htm?onlybody=yes&bugId=${x.bugId}" target="" class="link-icon iframe cboxElement" title="关闭"><i class="icon-green-bug-close"></i></a></c:when>
                <c:otherwise><i class="disabled icon-gray-bug-close" title="关闭"></i></c:otherwise>
              </c:choose>
              <a href="goeditBug.htm?bugId=${x.bugId}" target="" class="link-icon " title="编辑"><i class="icon-green-common-edit"></i></a>
              <a href="gocopyBug.htm?bugId=${x.bugId}" target="" class="link-icon " title="复制"><i class="icon-green-common-copy"></i></a>
              </td>
            </tr> 
            </c:forEach>
            
            </tbody>
            <tfoot>
              <tr style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
                     <td colspan="12" style="background-color: white; background-position: initial initial; background-repeat: initial initial;">
                        <div class="f-right">
                           <pt:page order="${order }" totalSize="${totalSize }" pageSize="${pageSize }" url="${url }" curPage="${curPage }" curCol="${curCol }"></pt:page>
                        </div>
                    </td>
                 </tr>
              </tfoot>
            </table>
            </c:otherwise></c:choose>
          </td>
         </tr>
       </tbody>
      </table>  
     </form>
   <!-- 编辑按钮的弹出一级菜单 -->
     <div id="moreActionMenu" class="listMenu hidden" style="display: none;">
        <ul>
            <li><a href="#" target="" onclick="setFormAction('','hiddenwin')">确认</a></li>
            <li><a href="#" target="" onmouseover="toggleSubMenu(this.id)" onmouseout="toggleSubMenu(this.id)" id="resolveItem">解决</a></li>
        </ul>
     </div>
 <!-- 编辑按钮的弹出二级菜单 -->
     <div id="resolveItemMenu" class="hidden listMenu">
       <ul>
         <li><a href="#" target="" onclick="setFormAction('','hiddenwin')">设计如此</a></li>
         <li><a href="#" target="" onclick="setFormAction('','hiddenwin')">外部原因</a></li>
         <li><a href="#" target="" onmouseover="toggleSubMenu(this.id,'right',2)" id="fixedItem">已解决</a></li>
         <li><a href="#" target="" onclick="setFormAction('','hiddenwin')">无法重现</a></li>
         <li><a href="#" target="" onclick="setFormAction('','hiddenwin')">延期处理</a></li>
         <li><a href="#" target="" onclick="setFormAction('','hiddenwin')">不予解决</a></li>
         <li><a href="#" target="" onclick="setFormAction('','hiddenwin')">转为需求</a></li>
       </ul>
     </div>
  <!--编辑，弹出版本选择三级菜单  -->
     <div id="fixedItemMenu" class="hidden listMenu">
        <ul>
            <li><a href="#" target="" onclick="setFormAction('','hiddenwin')">Trunk</a></li>
            <li><a href="#" target="" onclick="setFormAction('','hiddenwin')">1.0</a></li>
        </ul>
     </div>

  </div>
  <!-- 滚轮 -->
    <iframe frameborder="0" name="hiddenwin" id="hiddenwin" scrolling="no" class="hidden" src=""></iframe>
  <div id="divider"></div>
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
<script language='Javascript'>onlybody = "no"
</script>
<script language='Javascript'>$(function() 
{
    setModal4List('iframe', 'bugList');

    if(typeof page == 'undefined') page = '';
    if(page == 'create')
    {
        productID  = $('#product').val();
        moduleID   = $('#module').val();
        assignedto = $('#assignedTo').val();
        changeProductConfirmed = true;
        oldStoryID             = 0;
        oldProjectID           = 0;
        oldOpenedBuild         = '';
        oldTaskID              = 0;
        if(!assignedto)setAssignedTo(moduleID, productID);
        notice();
    }

    if(page == 'create' || page == 'edit' || page == 'assignedto' || page == 'confirmbug')
    {
        $("#story").chosen({no_results_text:noResultsMatch});
        $("#task").chosen({no_results_text:noResultsMatch});
        $("#mailto").chosen({no_results_text:noResultsMatch});
    }
});

/**
 * Load all fields.
 * 
 * @param  int $productID 
 * @access public
 * @return void
 */
function loadAll(productID)
{
    if(page == 'create') setAssignedTo();

    if(!changeProductConfirmed)
    {
        firstChoice = confirm(confirmChangeProduct);
        changeProductConfirmed = true;    // Only notice the user one time.
    }
    if(changeProductConfirmed || firstChoice)
    {
        $('#taskIdBox').innerHTML = '<select id="task"></select>';  // Reset the task.
        $('#task').chosen({no_results_text: noResultsMatch});
        loadProductModules(productID); 
        loadProductProjects(productID); 
        loadProductBuilds(productID);
        loadProductStories(productID);
    }
}

/**
 * Load product's modules.
 * 
 * @param  int    $productID 
 * @access public
 * @return void
 */
function loadProductModules(productID)
{
    link = createLink('tree', 'ajaxGetOptionMenu', 'productID=' + productID + '&viewtype=bug&rootModuleID=0&returnType=html&needManage=true');
    $('#moduleIdBox').load(link);
}

/**
 * Load product stories 
 * 
 * @param  int    $productID 
 * @access public
 * @return void
 */
function loadProductStories(productID)
{
    link = createLink('story', 'ajaxGetProductStories', 'productID=' + productID + '&moduleId=0&storyID=' + oldStoryID);
    $('#storyIdBox').load(link, function(){$('#story').chosen({no_results_text:noResultsMatch});});
}

/**
 * Load projects of product. 
 * 
 * @param  int    $productID 
 * @access public
 * @return void
 */
function loadProductProjects(productID)
{
    link = createLink('product', 'ajaxGetProjects', 'productID=' + productID + '&projectID=' + oldProjectID);
    $('#projectIdBox').load(link);
}

/**
 * loadProductBuilds 
 * 
 * @param  productID $productID 
 * @access public
 * @return void
 */
function loadProductBuilds(productID)
{
    link = createLink('build', 'ajaxGetProductBuilds', 'productID=' + productID + '&varName=openedBuild&build=' + oldOpenedBuild);

    if(page == 'create')
    {
        $('#buildBox').load(link, function(){ notice(); });
    }
    else
    {
        $('#openedBuildBox').load(link);
        link = createLink('build', 'ajaxGetProductBuilds', 'productID=' + productID + '&varName=resolvedBuild&build=' + oldResolvedBuild);
        $('#resolvedBuildBox').load(link);
    }
}

/**
 * Load project related bugs and tasks.
 * 
 * @param  int    $projectID 
 * @access public
 * @return void
 */
function loadProjectRelated(projectID)
{
    if(projectID)
    {
        loadProjectTasks(projectID);
        loadProjectStories(projectID);
        loadProjectBuilds(projectID);
        loadAssignedTo(projectID);
    }
    else
    {
        $('#taskIdBox').innerHTML = '<select id="task"></select>';  // Reset the task.
        loadProductStories($('#product').val());
        loadProductBuilds($('#product').val());
    }
}

/**
 * Load project tasks.
 * 
 * @param  projectID $projectID 
 * @access public
 * @return void
 */
function loadProjectTasks(projectID)
{
    link = createLink('task', 'ajaxGetProjectTasks', 'projectID=' + projectID + '&taskID=' + oldTaskID);
    $('#taskIdBox').load(link, function(){$('#task').chosen({no_results_text:noResultsMatch});});
}

/**
 * Load project stories.
 * 
 * @param  projectID $projectID 
 * @access public
 * @return void
 */
function loadProjectStories(projectID)
{
    link = createLink('story', 'ajaxGetProjectStories', 'projectID=' + projectID + '&productID=' + $('#product').val() + '&moduleID=0&storyID=' + oldStoryID);
    $('#storyIdBox').load(link, function(){$('#story').chosen({no_results_text:noResultsMatch});});
}

/**
 * Load builds of a project.
 * 
 * @param  int      $projectID 
 * @access public
 * @return void
 */
function loadProjectBuilds(projectID)
{
    productID = $('#product').val();
    if(page == 'create') oldOpenedBuild = $('#openedBuild').val() ? $('#openedBuild').val() : 0;

    if(page == 'create')
    {
        link = createLink('build', 'ajaxGetProjectBuilds', 'projectID=' + projectID + '&productID=' + productID + '&varName=openedBuild&build=' + oldOpenedBuild + "&index=0&needCreate=true");
        $('#buildBox').load(link);
    }
    else
    {
        link = createLink('build', 'ajaxGetProjectBuilds', 'projectID=' + projectID + '&productID=' + productID + '&varName=openedBuild&build=' + oldOpenedBuild);
        $('#openedBuildBox').load(link);

        link = createLink('build', 'ajaxGetProjectBuilds', 'projectID=' + projectID + '&productID=' + productID + '&varName=resolvedBuild&build=' + oldResolvedBuild);
        $('#resolvedBuildBox').load(link);
    }
}

/**
 * Set story field.
 * 
 * @param  moduleID $moduleID 
 * @param  productID $productID 
 * @access public
 * @return void
 */
function setStories(moduleID, productID)
{
    link = createLink('story', 'ajaxGetProductStories', 'productID=' + productID + '&moduleID=' + moduleID);
    $.get(link, function(stories)
    {
        if(!stories) stories = '<select id="story" name="story" class="select-3"></select>';
        $('#story').replaceWith(stories);
        $('#story_chzn').remove();
        $("#story").chosen({no_results_text: ''});
    });
}

/**
 * notice for create build.
 * 
 * @access public
 * @return void
 */
function notice()
{
    if($('#openedBuild').find('option').length <= 1) 
    {
        if($('#project').val() == '')
        {
            $('#buildBox').append('<a href="' + createLink('release', 'create','productID=' + $('#product').val()) + '" target="_blank">' + createRelease + ' </a>');
            $('#buildBox').append('<a href="javascript:loadProductBuilds(' + $('#product').val() + ')">' + refresh + '</a>');
        }
        else
        {
            $('#buildBox').append('<a href="' + createLink('build', 'create','projectID=' + $('#project').val()) + '" target="_blank">' + createBuild + '</a>');
            $('#buildBox').append('<a href="javascript:loadProjectBuilds(' + $('project').val() + ')">' + refresh + '</a>');
        }
    }
}


</script>
</body>
</html>

