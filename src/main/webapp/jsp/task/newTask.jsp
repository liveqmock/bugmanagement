<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>测试任务::提交测试 - BUG管理</title>
 <script language='Javascript'>var config={"webRoot":"\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/theme\/","currentModule":"testtask","currentMethod":"create","clientLang":"zh-cn","requiredFields":"project,build,begin,end,name","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/index.php\/testtask-create-12.html"}
</script>
<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<!--[if lt IE 8]><link rel='stylesheet' href='/css/theme/fontawesome/ie7.min.css?v=pro3.1' type='text/css' media='screen' />
<link rel='stylesheet' href='/css/theme/default/style.ie7.css?v=pro3.1' type='text/css' media='screen' />
<![endif]-->
<script src='<c:url value="/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<link type="text/css" rel="stylesheet" href="<c:url value="/css/theme/browser/safari.css"/>">

<link rel="icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon">
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon">
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
<li class=' active'><a href='newTask.htm' target=''>创建任务</a>
</li>
</ul>
</div>
<div id='wrap'>
  <div class='outer'>
<script language='javascript'>
Date.firstDayOfWeek = 1;
Date.format = 'yyyy-mm-dd';
$.dpText = {"TEXT_OR":"\u6216 ","TEXT_PREV_YEAR":"\u53bb\u5e74","TEXT_PREV_MONTH":"\u4e0a\u6708","TEXT_PREV_WEEK":"\u4e0a\u5468","TEXT_YESTERDAY":"\u6628\u5929","TEXT_THIS_MONTH":"\u672c\u6708","TEXT_THIS_WEEK":"\u672c\u5468","TEXT_TODAY":"\u4eca\u5929","TEXT_NEXT_YEAR":"\u660e\u5e74","TEXT_NEXT_MONTH":"\u4e0b\u6708","TEXT_CLOSE":"\u5173\u95ed","TEXT_DATE":"\u9009\u62e9\u65f6\u95f4\u6bb5","TEXT_CHOOSE_DATE":"\u9009\u62e9\u65e5\u671f"}
Date.dayNames     = ["\u65e5","\u4e00","\u4e8c","\u4e09","\u56db","\u4e94","\u516d"];
Date.abbrDayNames = ["\u65e5","\u4e00","\u4e8c","\u4e09","\u56db","\u4e94","\u516d"];
Date.monthNames   = ["\u4e00\u6708","\u4e8c\u6708","\u4e09\u6708","\u56db\u6708","\u4e94\u6708","\u516d\u6708","\u4e03\u6708","\u516b\u6708","\u4e5d\u6708","\u5341\u6708","\u5341\u4e00\u6708","\u5341\u4e8c\u6708"]; 

$(function() {
    $('.date').each(function(){
        time = $(this).val();
        if(!isNaN(time) && time != ''){
            var Y = time.substring(0, 4);
            var m = time.substring(4, 6);
            var d = time.substring(6, 8);
            time = Y + '-' + m + '-' + d;
            $('.date').val(time);
        }
    });

    startDate = new Date(1970, 1, 1);
    $(".date").datePicker({createButton:true, startDate:startDate})
        .dpSetPosition($.dpConst.POS_TOP, $.dpConst.POS_RIGHT)
});
</script>
<link rel="stylesheet" href='<c:url value="/js/js/kindeditor/themes/default/default.css" />' />
<script src='<c:url value="/js/js/kindeditor/kindeditor-min.js" />' type='text/javascript'></script>
<script src='<c:url value="/js/js/kindeditor/lang/zh_CN.js" />' type='text/javascript'></script>
<script language='javascript'>
var editor = {"id":["desc"],"tools":"simpleTools"};

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
<script src='<c:url value="/js/js/misc/date.js" />' type='text/javascript'></script>
<form method='post' action="addTask.htm" id='dataform'>
  <table class='table-1'> 
    <caption>提交测试</caption> 
    <tr>
      <th class='rowhead'>版本</th>
      <td><span id='buildBox'>
      <select name='versionId' id='build' class=select-3>
		<option value='' selected='selected'></option>
		<c:forEach items="${versions }" var="version">
			<option value="${version.versionId }">${version.name }</option>
		</c:forEach>
		</select>
		</span></td>
    </tr>  
    <tr>
      <th class='rowhead'>负责人</th>
      <td><select name='ownerId' id='owner'>
		<option value='' selected='selected'></option>
		<c:forEach items="${users }" var="user">
			<option value="${user.userId }">${user.realName }</option>
		</c:forEach>
		</select>
		</td>
    </tr>  
    <tr>
      <th class='rowhead'>优先级</th>
      <td><select name='priority' id='pri' class=select-3>
		<option value='0' selected='selected'></option>
		<option value='1'>1</option>
		<option value='2'>2</option>
		<option value='3'>3</option>
		<option value='4'>4</option>
		</select>
		</td>
    </tr>  
    <tr>
      <th class='rowhead'>开始日期</th>
      <td><input type='text' name='startDate' id='begin' value='' class='text-3 date' />
</td>
    </tr>  
    <tr>
      <th class='rowhead'>结束日期</th>
      <td><input type='text' name='endDate' id='end' value='' class='text-3 date' />
</td>
    </tr>  
    <tr>
      <th class='rowhead'>当前状态</th>
      <td><select name='status' id='status' class='select-3'>
		<option value='未开始'>未开始</option>
		<option value='进行中'>进行中</option>
		<option value='已完成'>已完成</option>
		<option value='被阻塞'>被阻塞</option>
		</select>
		</td>
    </tr>  
    <tr>
      <th class='rowhead'>任务名称</th>
      <td><input type='text' name='name' id='name' value='' class='text-1' />
</td>
    </tr>  
    <tr>
      <th class='rowhead'>任务描述</th>
      <td><textarea name='description' id='desc' rows=10 class='area-1'></textarea>
</td>
    </tr>  
    <tr>
      <td colspan='2' class='a-center'> <input type='submit' id='submit' value='保存'  class='button-s' /> <input type='button' onClick='javascript:history.go(-1);' value='返回' class='button-b' /> </td>
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
     &nbsp;<span class="icon-angle-right"></span><a href='' >BUG</a>
     &nbsp;<span class="icon-angle-right"></span>BUG
  </div>
  <div id="poweredby">
    <span>Powered by <a href=''>SICD</a> </span>
  </div>
 </div>
</body>
</html>
