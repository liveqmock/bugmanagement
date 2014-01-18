<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>解决Bug - BUG管理</title>
<script language="Javascript">var config={"webRoot":"\/css\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/css\/theme\/","currentModule":"bug","currentMethod":"browse","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/css\/index.php\/bug-browse-1.html"}
</script>
<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<link rel="icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon"/>
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon"/>
<script src='<c:url value="/js/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<style>.table-1 input{margin-bottom:3px}
</style>
<link rel='icon' href='<c:url value="/pic/logo.png"/>' type='image/x-icon' />
<link rel='shortcut icon' href='<c:url value="/pic/logo.png"/>' type='image/x-icon' />
<link rel="stylesheet" href='<c:url value="/css/theme/default/dropmenu.css"/>'  type="text/css" media="screen" />

</head>
<body>
<script type="text/javascript">
$(function(){
$("#submit").click(
		function() {
                $.ajax({
						type:"post",
						url:"bugresolve.htm",
						data:$("#bugsheet").serializeArray(),
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

<style>
#colorbox, #cboxOverlay, #cboxWrapper{z-index:9999;}
</style>
  <div class='outer'>
<link rel="stylesheet" href="/js/js/kindeditor/themes/default/default.css" />
<script src='/js/js/kindeditor/kindeditor-min.js' type='text/javascript'></script>
<script src='/js/js/kindeditor/lang/zh_CN.js' type='text/javascript'></script>

<form method='post' target='hiddenwin' id="bugsheet" >
  <table class='table-1'>
    <caption>${bug.title}</caption>
    <tr>
      <td class='rowhead'>解决方案</td>
      <td>
      <select name='resolution' id='resolution' class="select-3" onchange="setDuplicate(this.value)">
        <option value='' selected='selected'></option>
        <c:forEach var="x" items="${resolutionlist}" varStatus="status">
           <option value='${x.dictionaryValue}'>${x.dictionaryValue}</option>
        </c:forEach>
      </select>
      </td>
    </tr>
    
    <!--   <tr>
      <td class='rowhead'>解决版本</td>
      <td>
      <select name='resolvedBuild' id='resolvedBuild' class="select-3">
         <option value='' selected='selected'></option>
         <c:forEach var="x" items="${version}">
         <option value='${x.versionId}'>${x.name}</option>
         </c:forEach>
     </select>
     </td>
    </tr>-->
    <tr>
      <td class='rowhead'>备注</td>
      <td><textarea name='comment' id='comment' rows='6' class='w-p98'></textarea></td>
    </tr>
    <tr>
      <td colspan='2' class='a-center'> <input type='submit' id='submit' value='保存'  class='button-s' /> </td>
    </tr>
  </table>
  <script language='Javascript'>
var fold   = '-';
var unfold = '+';
function switchChange(historyID)
{
    changeClass = $('#switchButton' + historyID).attr('class');
    if(changeClass.indexOf('change-show') > 0)
    {
        $('#switchButton' + historyID).attr('class', changeClass.replace('change-show', 'change-hide'));
        $('#changeBox' + historyID).show();
        $('#changeBox' + historyID).prev('.changeDiff').show();
    }
    else
    {
        $('#switchButton' + historyID).attr('class', changeClass.replace('change-hide', 'change-show'));
        $('#changeBox' + historyID).hide();
        $('#changeBox' + historyID).prev('.changeDiff').hide();
    }
}

function toggleStripTags(obj)
{
    var diffClass = $(obj).attr('class');
    if(diffClass.indexOf('diff-all') > 0)
    {
        $(obj).attr('class', diffClass.replace('diff-all', 'diff-short'));
        $(obj).attr('title', '文本格式');
    }
    else
    {
        $(obj).attr('class', diffClass.replace('diff-short', 'diff-all'));
        $(obj).attr('title', '原始格式');
    }
    var boxObj  = $(obj).next();
    var oldDiff = '';
    var newDiff = '';
    $(boxObj).find('blockquote').each(function(){
        oldDiff = $(this).html();
        newDiff = $(this).next().html();
        $(this).html(newDiff);
        $(this).next().html(oldDiff);
    })
}

function toggleShow(obj)
{
    var orderClass = $(obj).find('span').attr('class');
    if(orderClass == 'change-show')
    {
        $(obj).find('span').attr('class', 'change-hide');
    }
    else
    {
        $(obj).find('span').attr('class', 'change-show');
    }
    $('.changes').each(function(){
        var box = $(this).parent();
        while($(box).get(0).tagName.toLowerCase() != 'li') box = $(box).parent();
        var switchButtonID = ($(box).find('span').find("span").attr('id'));
        switchChange(switchButtonID.replace('switchButton', ''));
    })
}

function toggleOrder(obj)
{
    var orderClass = $(obj).find('span').attr('class');
    if(orderClass == 'log-asc')
    {
        $(obj).find('span').attr('class', 'log-desc');
    }
    else
    {
        $(obj).find('span').attr('class', 'log-asc');
    }
    $("#historyItem li").reverseOrder();
}

function toggleComment(actionID)
{
    $('.comment' + actionID).toggle();
    $('#lastCommentBox').toggle();
    $('.ke-container').css('width', '100%');
}

$(function(){
    var diffButton = "<span onclick='toggleStripTags(this)' class='hidden changeDiff diff-all hand' title='原始格式'></span>";
    var newBoxID = ''
    var oldBoxID = ''
    $('blockquote').each(function(){
        newBoxID = $(this).parent().attr('id');
        if(newBoxID != oldBoxID) 
        {
            oldBoxID = newBoxID;
            if($(this).html() != $(this).next().html()) $(this).parent().before(diffButton);
        }
    })
})
</script>
<script src='/js/js/jquery/reverseorder/raw.js' type='text/javascript'></script>

<div id='actionbox'>
<fieldset>
  <legend>
              历史记录    <span onclick='toggleOrder(this)' class='hand'> <span title='切换顺序' class='log-asc'></span></span>
    <span onclick='toggleShow(this);' class='hand'><span title='切换显示' class='change-show'></span></span>
  </legend>

  <ol id='historyItem'>
       <c:forEach var="y" items="${historylist}" varStatus="status">
        <li value='${status.index+1}'>
            <span>
                ${y.operateTime}, ${y.operation}
                <c:if test="${y.comment!=null&&y.comment!=''}">
                  <span id="switchButton${status.index+1}" class='hand change-show' onclick="switchChange(${status.index+1})"></span>
                </c:if>
            </span>
            <c:if test="${y.comment!=null&&y.comment!=''}">
             <div class="changes hidden" id="changeBox${status.index+1}" style="display: block; ">
                                        ${y.comment}<br></br>
             </div>
            </c:if>
        </li>
        </c:forEach>
   </ol>

</fieldset>
</div>
<input type="hidden" value="${bug.bugId}" name="bugId" />
</form>
  </div>
    <iframe frameborder='0' name='hiddenwin' id='hiddenwin' scrolling='no' class='hidden'></iframe>
  <div id='divider'></div>
<script language='Javascript'>onlybody = "yes"
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
function setDuplicate(resolution)
{
    if(resolution == 'duplicate')
    {
        $('#duplicateBugBox').show();
    }
    else
    {
        $('#duplicateBugBox').hide();
    }
}

</script>
</body>
</html>
