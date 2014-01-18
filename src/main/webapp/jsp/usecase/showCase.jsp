<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:url value="/" var="basePath" />

<!DOCTYPE html>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>CASE #${userCase.caseId } ${userCase.title } - ${curProject.name } - 大数据</title>
<script>var config={"webRoot":"\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/theme\/","currentModule":"bug","currentMethod":"view","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/index.php\/bug-view-75.html"}
</script>  
<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<!--[if lt IE 8]><link rel='stylesheet' href='/css/theme/fontawesome/ie7.min.css?v=pro3.1' type='text/css' media='screen' />
<link rel='stylesheet' href='/css/theme/default/style.ie7.css?v=pro3.1' type='text/css' media='screen' />
<![endif]-->
<script src='<c:url value="/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<link rel="icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>" type="image/x-icon" />

<style>#story {width:90%}
.delbutton{font-size:12px; color:red; width:80px; padding:0}
.addbutton{font-size:12px; color:darkgreen; width:80px; padding:0}
</style>

<script>
	$().ready(function() {
		$("#addComment").click(addComment);
	});

	var addComment = function() {
		$.ajax({
			type : "post",
			url : "${basePath}addComment.htm",
			data : {
				"objectId" : "${userCase.caseId }",
				"objectType" : "usercase",
				"comment" : $("#usercaseComment").val()
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
<li class='active'><a href='usecase.htm' target=''>浏览用例</a>
</li>
<li class=' '><a href='goAddUseCase.htm' target=''>创建用例</a>
</li>
</ul>
</div>
<div id='wrap'>
  <div class='outer'>
<script language='javascript'>
$(function()
{
    $('.colored').colorize();
    $('tfoot td').css('background', 'white').unbind('click').unbind('hover');
}
);
</script>
<link rel="stylesheet" href='<c:url value="/js/js/kindeditor/themes/default/default.css" />' />
<script src='<c:url value="/js/js/kindeditor/kindeditor-min.js" />' type='text/javascript'></script>
<script src='<c:url value="/js/js/kindeditor/lang/zh_CN.js" />' type='text/javascript'></script>
<script language='javascript'>
var editor = {"id":["comment","lastComment"],"tools":"simpleTools"};

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
                cssPath:['<c:url value="/js/js/kindeditor/plugins/code/prettify.css" />'],
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
  <div id='main' >
    CASE #${userCase.caseId } ${userCase.title }
      </div>
  <div>
    <span class='link-button'><a href='${basePath}goruncase.htm?caseId=${userCase.caseId}' target='' class='runCase'><i class='icon-green-testtask-runCase runCase'></i> 执行</a></span>
    <span class='link-button'><a href='${basePath}caseresult.htm?caseId=${userCase.caseId}' target='' class='results'><i class='icon-green-testtask-results results'></i> 结果</a></span>
    <span class='link-button'><a href='${basePath}goBugFromUc.htm?usercaseId=${userCase.caseId }' target='' class=''><i class='icon-green-bug-createBug'></i> 提Bug</a></span>&nbsp;&nbsp;&nbsp;&nbsp;
    <span class='link-button'><a href='${basePath}goEditeUserCase.htm?usercaseId=${userCase.caseId }' target='' class='link-icon ' title='编辑'><i class='icon-green-common-edit'></i></a></span>
    <span class='link-button'><a href='#commentBox' target='' title='备注' onclick='setComment()'><i class="icon-comment-alt"></i></a></span>
    <span class='link-button'><a href='${basePath}goBugFromUc.htm?usercaseId=${userCase.caseId }' target='' class='link-icon ' title='复制'><i class='icon-green-common-copy'></i></a></span>
    <span class='link-button'><a href='/testcase-delete-48.html' target='hiddenwin' class='link-icon ' title='删除'><i class='icon-green-common-delete'></i></a></span>&nbsp;&nbsp;&nbsp;&nbsp;
    <span class='link-button'><a href='${basePath}usecase.htm' target='' class='link-icon' title=返回><i class="icon-goback icon-level-up icon-large icon-rotate-270"></i></a></span>
    </div>
</div>

<table class='cont-rt5'>
  <tr valign='top'>
    <td>
      <fieldset>
        <legend>前置条件</legend>
        ${userCase.precondition }
      </fieldset>
      <table class='table-1 colored'>
        <tr class='colhead'>
          <th class='w-30px'>编号</th>
          <th class='w-p70'>步骤</th>
          <th>预期</th>
        </tr>
        <c:forEach items="${steps }" var="step">
        	<tr><th class='rowhead w-id a-center strong'>${step.num }</th><td>${step.content }</td><td>${step.expect }</td></tr>
        </c:forEach> 
      </table>
      <style>.button-c {padding:1px}</style>
<script language='Javascript'>
$(function(){
     $(".edit").colorbox({width:400, height:200, iframe:true, transition:'none', scrolling:true});
})
</script>
<fieldset>
  <legend>附件</legend>
  <div>
  	<c:forEach items="${resources }" var="resource" varStatus="status">
		  <a href='${basePath}downloadResource.htm?resourceId=${resource.resourceId }' target='_blank'>
		  <c:choose>
		  	<c:when test="${empty resource.resourceName}">
		  		资源${status.count }
		  	</c:when>
		  	<c:otherwise>
		  		${resource.resourceName }
		  	</c:otherwise>
		  </c:choose>
		  </a>
		 <a href="${basePath}deleteResource.htm?resourceId=${resource.resourceId }" onclick="return confirm('are you sure?')" class='button-c '> x </a>
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
      <span class='link-button'><a href='${basePath}goruncase.htm?caseId=${userCase.caseId}' target='' class='runCase'><i class='icon-green-testtask-runCase runCase'></i> 执行</a></span>
      <span class='link-button'><a href='${basePath}caseresult.htm?caseId=${userCase.caseId}' target='' class='results'><i class='icon-green-testtask-results results'></i> 结果</a></span>
      <span class='link-button'><a href='${basePath}goBugFromUc.htm?usercaseId=${userCase.caseId }' target='' class=''><i class='icon-green-bug-createBug'></i> 提Bug</a></span>&nbsp;&nbsp;&nbsp;&nbsp;
      <span class='link-button'><a href='${basePath}goEditeUserCase.htm?usercaseId=${userCase.caseId }' target='' class='link-icon ' title='编辑'><i class='icon-green-common-edit'></i></a></span>
      <span class='link-button'><a href='#commentBox' target='' title='备注' onclick='setComment()'><i class="icon-comment-alt"></i></a></span>
      <span class='link-button'><a href='${basePath}goBugFromUc.htm?usercaseId=${userCase.caseId }' target='' class='link-icon ' title='复制'><i class='icon-green-common-copy'></i></a></span>
      <span class='link-button'><a href='/testcase-delete-48.html' target='hiddenwin' class='link-icon ' title='删除'><i class='icon-green-common-delete'></i></a></span>&nbsp;&nbsp;&nbsp;&nbsp;
      <span class='link-button'><a href='${basePath}usecase.htm' target='' class='link-icon' title=返回><i class="icon-goback icon-level-up icon-large icon-rotate-270"></i></a></span>
      </div>
      <div id='commentBox' class='hidden'>
        <fieldset>
          <legend>备注</legend>
            <table align='center' class='table-1'>
            <tr><td><textarea name='comment' id='usercaseComment' rows='5' class='w-p100'></textarea>
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
        <table class='table-1 a-left fixed'>
          <tr>
            <td class='rowhead w-p20'>所属项目</td>
            <td><a href='${basePath}showProject.htm?projectId=${userCase.module.project.projectId }' target='' >${userCase.module.project.name }</a>
</td>
          </tr>
          <tr>
            <td class='rowhead w-p20'>所属模块</td>
            <td>${userCase.module.name } </td>
          </tr>
          <tr>
            <td class='rowhead w-p20'>用例类型</td>
            <td>${userCase.caseType }</td>
          </tr>
          <tr>
            <td class='rowhead w-p20'>适用阶段</td>
            <td>${userCase.stage }<br /></td>
          </tr>
          <tr>
            <td class='rowhead'>优先级</td>
            <td>${userCase.priority }</td>
          </tr>
          <tr>
            <td class='rowhead'>用例状态</td>
            <td>${userCase.status }</td>
          </tr>
           <tr>
            <td class='rowhead'>创建时间</td>
            <td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${userCase.createdAt }" /></td>
          </tr>
          <tr>
            <td class='rowhead'>结果</td>
            <td>${userCase.result }</td>
          </tr>
          <tr>
            <td class='rowhead'>关键词</td>
            <td>${userCase.keyword }</td>
          </tr>
          <tr>
            <td class='rowhead'>相关用例</td>
            <td><a href="${basePath}showCase.htm?caseId=${userCase.relatedCase.caseId}">${userCase.relatedCase.title }</a></td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>相关Bug</legend>
        <table class='table-1 a-left'>
          <tr>
            <td class='rowhead w-p20'>来源Bug</td>
            <td><a href='${basePath}showBug.htm?bugId=${userCase.fromBug.bugId }' >${userCase.fromBug.title }</a></td>
          </tr>
          <tr>
            <td valign="top" class='rowhead w-p20'>生成Bug</td>
            <td><a href='${basePath}showBug.htm?bugId=${userCase.toBug.bugId }' >${userCase.toBug.title }</a></td>
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
    <a href='' >BUG管理</a>
     &nbsp;<span class="icon-angle-right"></span><a href='usecase.htm' >用例</a>
     &nbsp;<span class="icon-angle-right"></span>显示用例
  </div>
  <div id="poweredby">
    <span>Powered by <a href=''>SICD</a> </span>
  </div>
 </div>

<script language='Javascript'>onlybody = "no"
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
    $('.stepID').each(function(){$(this).html(i ++)});
}
$(document).ready(function() 
{
    if(onlybody != 'yes')$(".runCase").colorbox({width:900, height:550, iframe:true, transition:'none', onCleanup:function(){parent.location.href=parent.location.href;}});
    if(onlybody != 'yes')$(".results").colorbox({width:900, height:550, iframe:true, transition:'none'});
})

</script>
</body>
</html>
<script language='Javascript'>
$('.nofixed').remove();
</script>
