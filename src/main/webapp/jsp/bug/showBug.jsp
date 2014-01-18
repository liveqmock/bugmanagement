<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:url value="/" var="basePath" />

<!DOCTYPE html>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>BUG #${bug.bugId } ${bug.title } - ${curProject.name } - Bug管理</title>
<script>var config={"webRoot":"\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/theme\/","currentModule":"bug","currentMethod":"view","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/index.php\/bug-view-75.html"}
</script>
<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<!--[if lt IE 8]><link rel='stylesheet' href='/css/theme/fontawesome/ie7.min.css?v=pro3.1' type='text/css' media='screen' />
<link rel='stylesheet' href='/css/theme/default/style.ie7.css?v=pro3.1' type='text/css' media='screen' />
<![endif]-->
<script src='<c:url value="/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<style>.table-1 input{margin-bottom:3px}
</style>
<link rel="icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon">
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon">

<script>
	$().ready(function() {
		$("#addComment").click(addComment);
	});

	var addComment = function() {
		$.ajax({
			type : "post",
			url : "${basePath}addComment.htm",
			data : {
				"objectId" : "${bug.bugId }",
				"objectType" : "bug",
				"comment" : $("#bugComment").val()
			},
			success : function(msg) {
				if (msg === "success") {
					window.location.reload();
				}
			}

		});
	};
</script>

</head>
<body>
<style>
#colorbox, #cboxOverlay, #cboxWrapper{z-index:9999;}
</style>
<jsp:include page="includeHeader.jsp"></jsp:include>

 <div class="navbar" id="modulemenu">
 <ul>
	  <jsp:include page="../includeJsp/includeSelectPro.jsp"></jsp:include>
      <li class=" active"><a href='<c:url value="/bug.htm"></c:url>' target="" id="submenubug">浏览Bug</a></li>
      <li ><a href='<c:url value="/goAddBug.htm"></c:url>' target="" id="submenubug">提Bug</a></li>
    </ul>
 </div>
<div id='wrap'>
  <div class='outer'>
<link rel="stylesheet" href='<c:url value="/js/js/kindeditor/themes/default/default.css" />' />
<script src='<c:url value="/js/js/kindeditor/kindeditor-min.js" />' type='text/javascript'></script>
<script src='<c:url value="/js/js/kindeditor/lang/zh_CN.js" />' type='text/javascript'></script>
<script>
var editor = {"id":["comment","lastComment"],"tools":"bugTools"};

var bugTools =
[ 'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic','underline', '|', 
'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist', 'insertunorderedlist', '|',
'emoticons', 'image', 'code', 'link', '|', 'removeformat','undo', 'redo', 'fullscreen', 'source', 'savetemplate', 'about'];

var simpleTools = 
[ 'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic','underline', '|', 
'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist', 'insertunorderedlist', '|',
'emoticons', 'image', 'code', 'link', '|', 'removeformat','undo', 'redo', 'fullscreen', 'source', 'about'];

var fullTools = 
[ 'formatblock', 'fontname', 'fontsize', 'lineheight', '|', 'forecolor', 'hilitecolor', '|', 'bold', 'italic','underline', 'strikethrough', '|',
'justifyleft', 'justifycenter', 'justifyright', 'justifyfull', '|',
'insertorderedlist', 'insertunorderedlist', '|',
'emoticons', 'image', 'insertfile', 'hr', '|', 'link', 'unlink', '/',
'undo', 'redo', '|', 'selectall', 'cut', 'copy', 'paste', '|', 'plainpaste', 'wordpaste', '|', 'removeformat', 'clearhtml','quickformat', '|',
'indent', 'outdent', 'subscript', 'superscript', '|',
'table', 'code', '|', 'pagebreak', 'anchor', '|', 
'fullscreen', 'source', 'preview', 'about'];

$(document).ready(function() 
{
    $.each(editor.id, function(key, editorID)
    {
        editorTool = simpleTools;
        if(editor.tools == 'bugTools')  editorTool = bugTools;
        if(editor.tools == 'fullTools') editorTool = fullTools;

        KindEditor.ready(function(K)
        {
            editor = K.create('#' + editorID,
            {
                items:editorTool,
                filterMode:true, 
                cssPath:['${basePath}js/kindeditor/plugins/code/prettify.css'],
                urlType:'relative', 
                uploadJson: createLink('file', 'ajaxUpload'),
                allowFileManager:true,
                langType:'zh_CN',
                afterBlur: function(){this.sync();},
                afterCreate : function()
                {
                    var doc = this.edit.doc; 
                    var cmd = this.edit.cmd; 
                    /* Paste in chrome.*/
                    /* Code reference from http://www.foliotek.com/devblog/copy-images-from-clipboard-in-javascript/. */
                    if(K.WEBKIT)
                    {
                        $(doc.body).bind('paste', function(ev)
                        {
                            var $this = $(this);
                            var original =  ev.originalEvent;
                            var file =  original.clipboardData.items[0].getAsFile();
                            var reader = new FileReader();
                            reader.onload = function (evt) 
                            {
                                var result = evt.target.result; 
                                var result = evt.target.result;
                                var arr = result.split(",");
                                var data = arr[1]; // raw base64
                                var contentType = arr[0].split(";")[0].split(":")[1];

                                html = '<img src="' + result + '" alt="" />';
                                $.post(createLink('file', 'ajaxPasteImage'), {editor: html}, function(data){cmd.inserthtml(data);});
                            };

                            reader.readAsDataURL(file);
                        });
                    }

                    /* Paste in firfox.*/
                    if(K.GECKO)
                    {
                        K(doc.body).bind('paste', function(ev)
                        {
                            setTimeout(function()
                            {
                                var html = K(doc.body).html();
                                if(html.search(/<img src="data:.+;base64,/) > -1)
                                {
                                    $.post(createLink('file', 'ajaxPasteImage'), {editor: html}, function(data){K(doc.body).html(data);});
                                }
                            }, 80);
                        });
                    }
                    /* End */
                }
            });
        });
    });
})
</script>
<div id='titlebar'>
  <div id='main' >BUG #${bug.bugId } ${bug.title }</div>
  <div>
    <span class='link-button'><a href='<c:url value="/gobugAssignTo.htm?onlybody=yes&bugId=${bug.bugId}"></c:url>' target='' class='iframe'><i class='icon-green-bug-assignTo iframe'></i> 指派</a></span>
    <c:choose>
    	<c:when test="${bug.status ne '激活' }">
    		<span class='link-button'><a href='<c:url value="/openBug.htm?bugId=${bug.bugId}"></c:url>' target=''><i class='icon-green-bug-activate iframe'></i> 激活</a></span>
    	</c:when>
    	<c:otherwise>
    		<span class='link-button'><a href='<c:url value="/gobugclose.htm?onlybody=yes&bugId=${bug.bugId}"></c:url>' target='' class='iframe'><i class='icon-green-bug-close iframe'></i> 关闭</a></span>
    	</c:otherwise>
    </c:choose>
    <span class='link-button'><a href='<c:url value="/goUcFromBug.htm?bugId=${bug.bugId }"></c:url>' target='' class=''><i class='icon-green-testcase-createCase'></i> 建用例</a></span>&nbsp;&nbsp;&nbsp;&nbsp;
    <span class='link-button'><a href='<c:url value="/goeditBug.htm?bugId=${bug.bugId }"></c:url>' target='' class='link-icon ' title='编辑'><i class='icon-green-common-edit'></i></a></span><span class='link-button'><a href='#commentBox' target='' title='备注' onclick='setComment()'><i class="icon-comment-alt"></i></a></span>
    <span class='link-button'><a href='<c:url value="/gocopyBug.htm?bugId=${bug.bugId }"></c:url>' target='' class='link-icon ' title='复制'><i class='icon-green-common-copy'></i></a></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class='link-button'><a href='bug.htm' target='' class='link-icon' title=返回><i class="icon-goback icon-level-up icon-large icon-rotate-270"></i></a>
</span>  
</div>
</div>

<table class='cont-rt5'>
  <tr valign='top'>
    <td>
      <fieldset>
        <legend>重现步骤</legend>
        <div class='content'>
        	<p class="stepTitle">${bug.steps }</p>
		</div>
      </fieldset>
      <style>.button-c {padding:1px}</style>
<script>
	$(function(){
	     $(".edit").colorbox({width:400, height:200, iframe:true, transition:'none', scrolling:true});
	})
</script>
<fieldset>
  <legend>附件</legend>
  <div>
  	<c:forEach items="${resources }" var="resource" varStatus="status">
		  <a href='<c:url value="downloadResource.htm?resourceId=${resource.resourceId }"></c:url>' target='_blank'>
		  <c:choose>
		  	<c:when test="${empty resource.resourceName}">
		  		资源${status.count }
		  	</c:when>
		  	<c:otherwise>
		  		${resource.resourceName }
		  	</c:otherwise>
		  </c:choose>
		  </a>
		 <a href='<c:url value="deleteResource.htm?resourceId=${resource.resourceId }"></c:url>' onclick="return confirm('are you sure?')" class='button-c '> x </a>
		 </c:forEach>
    </div>
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
      <div class='a-center actionlink'>
    <span class='link-button'><a href='<c:url value="gobugAssignTo.htm?onlybody=yes&bugId=${bug.bugId}"></c:url>' target='' class='iframe'><i class='icon-green-bug-assignTo iframe'></i> 指派</a></span>
    <c:choose>
    	<c:when test="${bug.status eq '关闭' }">
    		<span class='link-button'><a href='<c:url value="openBug.htm?bugId=${bug.bugId}"></c:url>' target=''><i class='icon-green-bug-activate iframe'></i> 激活</a></span>
    	</c:when>
    	<c:otherwise>
    		<span class='link-button'><a href='<c:url value="gobugclose.htm?onlybody=yes&bugId=${bug.bugId}"></c:url>' target='' class='iframe'><i class='icon-green-bug-close iframe'></i> 关闭</a></span>
    	</c:otherwise>
    </c:choose>
    <span class='link-button'><a href='<c:url value="goUcFromBug.htm?bugId=${bug.bugId }"></c:url>' target='' class=''><i class='icon-green-testcase-createCase'></i> 建用例</a></span>&nbsp;&nbsp;&nbsp;&nbsp;
    <span class='link-button'><a href='<c:url value="goeditBug.htm?bugId=${bug.bugId }"></c:url>' target='' class='link-icon ' title='编辑'><i class='icon-green-common-edit'></i></a></span><span class='link-button'><a href='#commentBox' target='' title='备注' onclick='setComment()'><i class="icon-comment-alt"></i></a></span>
    <span class='link-button'><a href='<c:url value="gocopyBug.htm?bugId=${bug.bugId }"></c:url>' target='' class='link-icon ' title='复制'><i class='icon-green-common-copy'></i></a></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class='link-button'><a href='bug.htm' target='' class='link-icon' title=返回><i class="icon-goback icon-level-up icon-large icon-rotate-270"></i></a>
</span>  
</div>
      <div id='commentBox' class='hidden'>
        <fieldset>
          <legend>备注</legend>
            <table align='center' class='table-1'>
            <tr><td><textarea name='comment' id='bugComment' rows='5' class='w-p100'></textarea>
</td></tr>
            <tr><td> <input id="addComment" type="button" value='保存'  class='button-s' /> <input type='button' onClick='javascript:history.go(-1);' value='返回' class='button-b' /></td></tr>
            </table>
        </fieldset>
      </div>
    </td>
    <td class='divider'></td>
    <td class='side'>
      <fieldset>
        <legend>基本信息</legend>
        <table class='table-1 a-left'>
          <tr valign='middle'>
            <th class='rowhead'>所属项目</th>
            <td><a href='' target='' >${bug.module.project.name }</a>
          </tr>
          <tr>
            <th class='rowhead'>所属模块</th>
            <td>${bug.module.name }</td>
          </tr>
          <tr>
            <td class='rowhead'>Bug类型</td>
            <td>${bug.type }</td>
          </tr>
          <tr>
            <td class='rowhead'>严重程度</td>
            <td><strong>${bug.severity }</strong></td>
          </tr>
          <tr>
            <td class='rowhead'>优先级</td>
            <td><strong>${bug.priority }</strong></td>
          </tr>
          <tr>
            <td class='rowhead'>Bug状态</td>
            <td><strong>${bug.status }</strong></td>
          </tr>
          <tr>
            <td class='rowhead'>是否确认</td>
            <td>
            	<c:choose>
            		<c:when test="${bug.confirm }">
            			已确认
            		</c:when>
            		<c:otherwise>
            			未确认
            		</c:otherwise>
            	</c:choose>
            </td>
          </tr>
          <tr>
            <td class='rowhead'>当前指派</td>
            <td>${bug.assignedTo.user.name }</td>
          </tr>
          <tr>
            <td class='rowhead'>操作系统</td>
            <td>${bug.os }</td>
          </tr>
          <tr>
            <td class='rowhead'>浏览器</td>
            <td>${bug.browser }</td>
          </tr>
          <tr>
            <td class='rowhead'>关键词</td>
            <td>${bug.keyword }</td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>相关用例</legend>
        <table class='table-1 a-left'>
          <tr>
            <td class='rowhead w-p20'>来源用例</td>
            <td>${bug.fromCase.title }</td>
          </tr>
          <tr>
            <td valign="top" class='rowhead w-p20'>生成用例</td>
            <td>${bug.toCase.title }</td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>其他相关</legend>
        <table class='table-1 a-left fixed'>
          <tr>
            <td class='rowhead w-p20'>抄送给</td>
            <td>${bug.mailto }</td>
          </tr>
          <tr>
            <td class='rowhead'>相关Bug</td>
            <td>${bug.relatedBug.title }</td>
          </tr>
        </table>
      </fieldset>
    </td>
  </tr>
</table>
  </div>
    <iframe frameborder='0' name='hiddenwin' id='hiddenwin' scrolling='no' class='hidden'></iframe>
  <div id='divider'></div>
</div>
 <div id='footer'>
  <div id="crumbs">
    <a href='turnToHomePage.htm' >BUG管理</a>
     &nbsp;<span class="icon-angle-right"></span>BUG
     &nbsp;<span class="icon-angle-right"></span>
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
        loadProductplans(productID);
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
 * Load product plans.
 * 
 * @param  productID $productID 
 * @access public
 * @return void
 */
function loadProductplans(productID)
{
    link = createLink('productplan', 'ajaxGetProductplans', 'productID=' + productID);
    $('#planIdBox').load(link);
}

/**
 * Load product builds. 
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
function setModal4List(colorboxClass, replaceID)
{
    if(onlybody != 'yes') $('.iframe').colorbox({width:900, height:500, iframe:true, transition:'none', onCleanup:function(){parent.location.href=parent.location.href;}})
}

</script>
</body>
</html>
<script>
$('fieldset:eq(5)').hide();
$('.icon-green-story-toStory').parent().hide();
</script>
