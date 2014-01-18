<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <meta http-equiv='X-UA-Compatible' content='IE=edge'>
  <title>提问题 - BUG管理</title>
<script>var config={"webRoot":"\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/theme\/","currentModule":"bug","currentMethod":"create","clientLang":"zh-cn","requiredFields":"title,openedBuild","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/index.php\/bug-create-16-moduleID=0.html"}
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
<link rel="stylesheet" href="<c:url value="/css/theme/default/index.css"/>" type="text/css" media="screen"/>

<link rel="stylesheet" href='<c:url value="/js/js/kindeditor/themes/default/default.css" />' />
<script src='<c:url value="/js/js/kindeditor/kindeditor-min.js" />' type='text/javascript'></script>
<script src='<c:url value="/js/js/kindeditor/lang/zh_CN.js" />' type='text/javascript'></script>

<style>#steps {width:99.6%}
.text-1 {width: 85%}
#task, #story{width: 85.4%;}
#mailto{width: 85.5%}
#keywords{width: 85.1%;}
.w-p100 {margin:0}
/* The build template setting. */
.button-c {padding:2px}
.ke-outline .ke-icon-savetemplate {background-image: url(theme/default/images/kindeditor/save.gif); background-position: center; width: 56px; height: 20px;} 
</style>
</head>
<body>
<style>
#colorbox, #cboxOverlay, #cboxWrapper{z-index:9999;}
</style>
<jsp:include page="includeHeader.jsp"></jsp:include>

<div class="navbar" id="modulemenu">
		<ul>
			<jsp:include page="../includeJsp/includeSelectPro.jsp"></jsp:include>
			<li class=' active'><a href='question.htm' target=''>公开问题</a>
			</li>
			<li><a href='question.htm' target=''>内部问题</a>
			</li>
		</ul>
	</div>
<div id='wrap'>
  <div class='outer'>
<style>
#colorbox, #cboxOverlay, #cboxWrapper{z-index:9999;}
</style>
<script>
var editor = {"id":["steps"],"tools":"bugTools"};

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
                cssPath:['/js/kindeditor/plugins/code/prettify.css'],
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

<form method='post' action="addQuestion.htm">
	<input type="hidden" name="myExceptionId" value="${record.myException.exceptionId }">
  <table class='table-1'> 
    <caption>提问题</caption>
    <tr>
      <th class='rowhead'>异常信息</th>
      <td>${record.exceptionClass }
	</td>
    </tr>
    <tr>
      <th class='rowhead'>标题</th>
      <td><input type='text' name='title' id='title' value='' class='text-1' />
		</td>
    </tr> 
    <tr>
      <th class='rowhead'>问题内容</th>
      <td style='position:relative'>
        <div class='w-p85 bd-none padding-zero f-left'>
        <textarea name='content' id='steps' rows='20'>
        <c:if test="${!empty record.exceptionClass}">
	        <p><strong>异常类:</strong><br>
	        ${record.exceptionClass}</p>
        </c:if>
        <c:if test="${!empty record.detailMsg}">
	        <p><strong>异常消息:</strong><br>
	        ${record.detailMsg}</p>
        </c:if>
        <c:if test="${!empty record.sourceInfo}">
			<p><strong>源码信息:</strong><br>
			${record.sourceInfo}</p>
			<p><strong>出错的代码行:</strong><br>
			${record.lineNum}</p>
			<strong>出错的源码:</strong><br>
			<pre>
				<code>${record.sourceCode}</code>
			</pre>
		</c:if>
		<c:if test="${!empty record.stack}">
	       	 <p><strong>栈信息:</strong><br>
	         <span style="color:#E53333;"> ${record.stack}</span></p>
	    </c:if>
        </textarea>
		</div>
        <div class='bd-none' id='tplBox' style='position:absolute;top:0px;left:86%'>
</div>
      </td>
    </tr>   
    <tr>
      <td colspan='2' class='a-center'>
         <input type='submit' id='submit' value='保存'  class='button-s' /> <input type='button' onClick='javascript:history.go(-1);' value='返回' class='button-b' /><input type='hidden' name='case' id='case' value='0'  />
      </td>
    </tr>
  </table>
</form>
  </div>
    <iframe frameborder='0' name='hiddenwin' id='hiddenwin' scrolling='no' class='hidden'></iframe>
  <div id='divider'></div>
</div>
<div id='footer'>
  <div id="crumbs">
    <a href='' >BUG管理</a>
     &nbsp;<span class="icon-angle-right"></span><a href='' >我的地盘</a>
     
  </div>
  <div id="poweredby">
    <span>Powered by <a href=''>SICD</a> </span>
  </div>
 </div>
</body>
</html>
