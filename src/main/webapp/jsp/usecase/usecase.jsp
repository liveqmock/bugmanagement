<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pt" uri="/page-tags"%>
<%@ taglib prefix="ct" uri="/column-tags"%>

<!DOCTYPE html>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>测试用例::大数据 - BUG管理</title>
<script language="Javascript">var config={"webRoot":"\/css\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/css\/theme\/","currentModule":"bug","currentMethod":"browse","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/css\/index.php\/bug-browse-1.html"};
</script>
<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<link rel="icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon"/>
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon"/>
<script src='<c:url value="/js/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<style>.table-1 input{margin-bottom:3px}
</style>
<style>#story {width:90%}
.delbutton{font-size:12px; color:red; width:80px; padding:0}
.addbutton{font-size:12px; color:darkgreen; width:80px; padding:0}
.w-220px{width:220px}</style>
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
	<li class=" active"><a href="usecase.htm" target="" id="submenubrowse">浏览用例</a></li>
	<li class=" "><a href="goAddUseCase.htm" target="" id="submenucreate">创建用例</a></li>
 </ul>
</div>
<div id='wrap'>
  <div class='outer'>
   <script language='javascript'>$(function() { $(".tree").treeview({ persist: "cookie", collapsed: false, unique: false});});</script>
   <script language='javascript'>
$(function()
{
    $('.colored').colorize();
    $('tfoot td').css('background', 'white').unbind('click').unbind('hover');
}
);
</script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/dropmenu.css"/>' type='text/css' media='screen' />
<script src='<c:url value="/js/js/jquery/dropmenu/dropmenu.js"/>' type='text/javascript'></script>
<script language='Javascript'>browseType = "all";
</script>
<script language='Javascript'>moduleID = 0;
</script>
<script language='Javascript'>confirmDelete = "\u60a8\u786e\u8ba4\u8981\u5220\u9664\u8be5\u6d4b\u8bd5\u7528\u4f8b\u5417\uff1f"
</script>

<div id='featurebar'>
  <div class='f-left'>
    <span id='allTab'><a href='usecase.htm' >所有测试用例</a></span></div>
  <div class='f-right'>
   <span class='link-button'><a href='goAddUseCase.htm' target='' class=''><i class='icon-green-testcase-create'></i> 建用例</a></span>
  </div>
</div>
<div id='querybox' class='hidden'></div>
<div class='treeSlider' id='testcaseTree'><span>&nbsp;</span></div>
<form id='batchForm' method='post' action="usecase.htm">
<table class='cont-lt1'>
  <tr valign='top'>
    <td class='side'>
      <div class='box-title'>${curProject.name }</div>
      <div class='box-content'>
        <ul class='tree'>
           <c:forEach items="${moduleBeans}" var="moduleBean" varStatus="status">
              	<c:choose>
              		<c:when test="${moduleBean.hasChildren}">
              			<li class="collapsable"><a href="goModuleUseCase.htm?moduleId=${moduleBean.moduleId}">${moduleBean.moduleName}</a><ul>
              		</c:when>
              		<c:when test="${!moduleBean.hasChildren && !moduleBean.last}">
              			<li><a href="goModuleUseCase.htm?moduleId=${moduleBean.moduleId}">${moduleBean.moduleName}</a></li>
              		</c:when>
              		<c:when test="${!moduleBean.hasChildren && moduleBean.last}">
              			<li><a href="goModuleUseCase.htm?moduleId=${moduleBean.moduleId}">${moduleBean.moduleName}</a></li></ul></li>
              		</c:when>
              	</c:choose>
              </c:forEach>
         </ul>
        <div class='a-right'>
          <a href='showModule.htm' target='' >维护模块</a>
        </div>
      </div>
    </td>
    <td class='divider'></td>
    <td>
      <table class='table-1 colored tablesorter datatable fixed' id='caseList'>
                <thead>
                <tr class='colhead'>
                       <th class='w-id'>
                           <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="caseId" text="ID" />
                       </th>
                       <th class='w-pri'>
                          <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="priority" text="P" />
                       </th>
                       <th>
                           <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="title" text="用例标题" />
                       </th>
                       <th class='w-type'>
                             <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="module" text="模块" />
                        </th>
                        <th class='w-type'>
                             <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="caseType" text="类型" />
                        </th>
                       <th class='w-user'>  
                             <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="creator" text="创建" />
                        </th>
                       <th class='w-80px'>
                         <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="runner" text="执行" />
                       </th>
                       <th class='w-120px'>
                        <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="createdAt" text="创建时间" />
                       </th>
                       <th class='w-80px'>
                         <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="result" text="结果" />
                       </th>
                       <th class='w-status'>
                         <ct:col order="${order }" pageSize="${pageSize }" url="${url }" curCol="${curCol }" col="status" text="状态" />
                       </th>
                       <th class='w-150px {sorter:false}'>操作</th>
                  </tr>
                  <c:forEach var="x" items="${usercaselist}" varStatus="status">
                  <tr class='a-center'>
                     <td>
                          <input type='checkbox' name='caseIDList[]'  value='${x.caseId}'/> 
                          <a href='showCase/${x.caseId }.htm' >${x.caseId}</a>
                     </td>
                     <td><span class='pri3'>${x.priority}</span></td>
                     <td class='a-left' title="${x.title}"><a href='showCase/${x.caseId }.htm' >${x.title}</a></td>
                     <td>${x.module.name}</td>
                     <td>${x.caseType}</td>
                     <td>${x.creator.user.realName}</td>
                     <td>${x.runner.user.realName}</td>
                     <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${x.createdAt}" /></td>
                   <!-- <c:forEach var="y" items="${x.steps}">
                     <c:if test="${y.result=='阻塞'}"><c:set var="resulta" value="1"></c:set></c:if>
                     <c:if test="${y.result=='通过'}"><c:set var="resultb" value="1"></c:set></c:if>
                     <c:if test="${y.result=='失败'}"><c:set var="resultc" value="1"></c:set></c:if>
                     </c:forEach> --> 
                     <c:choose>
                         <c:when test="${x.result=='阻塞'}"><td class="blocked">阻塞</td><c:set var="result" value="blocked"></c:set></c:when>
                         <c:when test="${x.result=='失败'}"><td class="fail">失败</td><c:set var="result" value="fail"></c:set></c:when>
                         <c:when test="${x.result=='通过'}"><td class="pass">通过</td><c:set var="result" value="pass"></c:set></c:when>
                         <c:otherwise><td></td><c:set var="result" value="n/a"></c:set></c:otherwise>
                     </c:choose> 
                     
                     <td class=''>${x.status}</td>
                      <td class='a-right'>
                      <a href='goruncase.htm?caseId=${x.caseId}' target='' class='link-icon runCase' title='执行'><i class='icon-green-testtask-runCase'></i></a>
					  <a href='caseresult.htm?caseId=${x.caseId}' target='' class='link-icon results' title='结果'><i class='icon-green-testtask-results'></i></a>                               
                      <a href='goEditeUserCase.htm?usercaseId=${x.caseId }' target='' class='link-icon ' title='编辑'><i class='icon-green-common-edit'></i></a>
                      <a href='goCopyUserCase.htm?usercaseId=${x.caseId }' target='' class='link-icon ' title='复制'><i class='icon-green-common-copy'></i></a>
                      <a href='javascript:ajaxDelete("usecase.htm","caseList",confirmDelete)' target='' class='link-icon' title='删除'><i class="icon-green-common-delete"></i></a>
                      <a href='goBugFromUc.htm?usercaseId=${x.caseId }' target='' class='link-icon ' title='提Bug'><i class='icon-green-bug-createBug'></i></a>
                      </td>
                    </tr>
                    </c:forEach>
                </thead>
                <tfoot>
                  <tr>
                      <td colspan='10'>  
          				<pt:page order="${order }" totalSize="${totalSize }" pageSize="${pageSize }" url="${url }" curPage="${curPage }" curCol="${curCol }"></pt:page>
        			</td>
        </tr>
       </tfoot>
      </table>
    </td>              
  </tr>              
</table>             
</form>

<div id='moreActionMenu' class='listMenu hidden'>
  <ul>
  <li><a href='#' target='' onclick="setFormAction('/pro/testtask-batchRun-1-id_desc.html')">执行</a>
</li>  </ul>
</div>

  </div>
    <iframe frameborder='0' name='hiddenwin' id='hiddenwin' scrolling='no' class='hidden'></iframe>
  <div id='divider'></div>
</div>
<div id='footer'>
  <div id="crumbs">
    <a href='' >BUG管理</a>
     &nbsp;<span class="icon-angle-right"></span><a href='' >用例</a>
     &nbsp;<span class="icon-angle-right"></span>所有
  </div>
  <div id="poweredby">
    <span>Powered by <a href=''>SICD</a> </span>
  </div>
 </div>
<script language='Javascript'>onlybody = "no";
</script>
<script language='Javascript'>var newRowID = 0;
/**
 * Load modules and stories of a product.
 * 
 * @param  int     $productID 
 * @access public
 * @return void
 */
function loadAll(productID)
{
    loadProductModules(productID);
    setStories();
}

/**
 * Load stories of module. 
 * 
 * @access public
 * @return void
 */
function loadModuleRelated()
{
    setStories();
}

/**
 * Load module.
 * 
 * @param  int    $productID 
 * @access public
 * @return void
 */
function loadProductModules(productID)
{
    link = createLink('tree', 'ajaxGetOptionMenu', 'productID=' + productID + '&viewtype=case&rootModuleID=0&returnType=html&needManage=true');
    $('#moduleIdBox').load(link);
}

/**
 * Set story field.
 * 
 * @access public
 * @return void
 */
function setStories()
{
    moduleID  = $('#module').val();
    productID = $('#product').val();
    link = createLink('story', 'ajaxGetProductStories', 'productID=' + productID + '&moduleID=' + moduleID);
    $.get(link, function(stories)
    {
        if(!stories) stories = '<select id="story" name="story"></select>';
        $('#story').replaceWith(stories);
        $('#story_chzn').remove();
        $("#story").chosen({no_results_text: ''});
    });
}

/**
 * Delete a step row.
 * 
 * @param  int    $rowID 
 * @access public
 * @return void
 */
function deleteRow(rowID)
{
    if($('.stepID').size() == 1) return;
    $('#row' + rowID).remove();
    updateStepID();
}

/**
 * Insert before the step.
 * 
 * @param  int    $rowID 
 * @access public
 * @return void
 */
function preInsert(rowID)
{
    $('#row' + rowID).before(createRow());
    updateStepID();
}

/**
 * Insert after the step.
 * 
 * @param  int    $rowID 
 * @access public
 * @return void
 */
function postInsert(rowID)
{
    $('#row' + rowID).after(createRow());
    updateStepID();
}

/**
 * Create a step row.
 * 
 * @access public
 * @return void
 */
function createRow()
{
    if(newRowID == 0) newRowID = $('.stepID').size();
    newRowID ++;
    var newRow = "<tr class='a-center' id='row" + newRowID + "'>";
    newRow += "<th class='stepID'></th>";
    newRow += "<td class='w-p50'><textarea name='steps[]' rows=3 class='w-p100'></textarea></td>";
    newRow += "<td><textarea name='expects[]' rows=3 class='w-p100'></textarea></td>";
    newRow += "<td class='a-left w-100px'><nobr>";
    newRow += "<input type='button' tabindex='-1' class='addbutton' value='" + lblBefore + "' onclick='preInsert("  + newRowID + ")' /><br />";
    newRow += "<input type='button' tabindex='-1' class='addbutton' value='" + lblAfter  + "' onclick='postInsert(" + newRowID + ")' /><br />";
    newRow += "<input type='button' tabindex='-1' class='delbutton' value='" + lblDelete + "' onclick='deleteRow("  + newRowID + ")' /><br />";
    newRow += "</nobr></td>";
    return newRow;
}

/**
 * Update the step id.
 * 
 * @access public
 * @return void
 */
function updateStepID()
{
    var i = 1;
    $('.stepID').each(function(){$(this).html(i ++);});
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
    $(".results").colorbox({width:900, height:550, iframe:true, transition:'none'});
});

</script>
</body>
</html>
