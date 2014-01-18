<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>TASK #${task.taskId } ${task.name }/测试 - BUG管理</title>
<script language='Javascript'>var config={"webRoot":"\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/theme\/","currentModule":"testtask","currentMethod":"view","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/index.php\/testtask-view-16.html"}
</script>
<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<!--[if lt IE 8]><link rel='stylesheet' href='/css/theme/fontawesome/ie7.min.css?v=pro3.1' type='text/css' media='screen' />
<link rel='stylesheet' href='/css/theme/default/style.ie7.css?v=pro3.1' type='text/css' media='screen' />
<![endif]-->
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
<li class=' '><a href='taskList.htm' target=''>浏览任务</a>
</li>
<li class=' '><a href='newTask.htm' target=''>创建任务</a>
</li>
</ul>
</div>
<div id='wrap'>
  <div class='outer'>
<link rel="stylesheet" href='<c:url value="/js/js/kindeditor/themes/default/default.css" />' />
<script src='<c:url value="/js/js/kindeditor/kindeditor-min.js" />' type='text/javascript'></script>
<script src='<c:url value="/js/js/kindeditor/lang/zh_CN.js" />' type='text/javascript'></script>
<script language='javascript'>
var editor = {"id":["lastComment"],"tools":"simpleTools"};

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
  <div id='main' >TESTTASK #${task.taskId } ${task.name }</div>
  <div>
  	<c:if test="${task.status ne '已完成' }">
    <span class='link-button'><a href='closeTask.htm?taskId=${task.taskId }' target='' class=''><i class='icon-green-testtask-close'></i> 关闭</a></span>
	</c:if>
	<span class='link-button'><a href='showCases.htm?taskId=${task.taskId }' target='' class=''><i class='icon-green-testtask-cases'></i> 用例</a>
</span><span class='link-button'><a href='linkCases.htm?taskId=${task.taskId }' target='' class=''><i class='icon-green-testtask-linkCase'></i> 关联用例</a>
</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class='link-button'><a href='editTask.htm?taskId=${task.taskId }' target='' class='link-icon ' title='编辑测试任务'><i class='icon-green-common-edit'></i></a></span>
<span class='link-button'><a href='deleteTask.htm?taskId=${task.taskId }' onclick="return confirm('are you sure?')" class='link-icon ' title='删除测试任务'><i class='icon-green-common-delete'></i></a></span><span class='link-button'><a href='taskList.htm' target='' class='link-icon' title=返回><i class="icon-goback icon-level-up icon-large icon-rotate-270"></i></a>
</span>  </div>
</div>

<table class='cont-rt5'>
  <tr valign='top'>
    <td>
      <fieldset>
        <legend>任务描述</legend>
        <div class='content'>${task.description }</div>
      </fieldset>
      <fieldset>
        <legend>测试总结</legend>
        <div class='content'>${task.summary }</div>
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
<div class="a-center actionlink">
  	<c:if test="${task.status ne '已完成' }">
    <span class='link-button'><a href='closeTask.htm?taskId=${task.taskId }' target='' class=''><i class='icon-green-testtask-close'></i> 关闭</a></span>
	</c:if>
	<span class='link-button'><a href='showCases.htm?taskId=${task.taskId }' target='' class=''><i class='icon-green-testtask-cases'></i> 用例</a>
</span><span class='link-button'><a href='linkCases.htm?taskId=${task.taskId }' target='' class=''><i class='icon-green-testtask-linkCase'></i> 关联用例</a>
</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class='link-button'><a href='editTask.htm?taskId=${task.taskId }' target='' class='link-icon ' title='编辑测试任务'><i class='icon-green-common-edit'></i></a></span>
<span class='link-button'><a href='deleteTask.htm?taskId=${task.taskId }' onclick="return confirm('are you sure?')" class='link-icon ' title='删除测试任务'><i class='icon-green-common-delete'></i></a></span><span class='link-button'>
</span>  </div>
    </td>
    <td class='divider'></td>
    <td class='side'>
      <fieldset>
        <legend>基本信息</legend>
        <table class='table-1 a-left fixed'>
          <tr>
            <th class='rowhead'>所属项目</th>
            <td><a href='/project-story-56.html' >${task.version.project.name }</a>
</td>
          </tr>  
          <tr>
            <th class='rowhead'>版本</th>
            <td>${task.version.name }</td>
          </tr>  
          <tr>
            <th class='rowhead'>负责人</th>
            <td>${task.owner.user.realName }</td>
          </tr>  
          <tr>
            <th class='rowhead'>优先级</th>
            <td>${task.priority }</td>
          </tr>  
          <tr>
            <th class='rowhead'>开始日期</th>
            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${task.startDate }" /></td>
          </tr>  
          <tr>
            <th class='rowhead'>结束日期</th>
            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${task.endDate }" /></td>
          </tr>  
          <tr>
            <th class='rowhead'>当前状态</th>
            <td>${task.status }</td>
          </tr>  
          <tr>
            <th class='rowhead'>测试总结</th>
            <td class='content'>${task.summary }</td>
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
    <a href='/my/' >禅道管理</a>
&nbsp;<span class="icon-angle-right"></span><a href='/testtask/' >测试</a>
&nbsp;<span class="icon-angle-right"></span><a href='/testtask-browse-12.html' >测试</a>
&nbsp;<span class="icon-angle-right"></span>测试任务&nbsp;<span class="icon-angle-right"></span>详情  </div>
  <div id="poweredby">
    <span>Powered by <a href=''>SICD</a> </span>
  </div>
</div>
</body>
</html>