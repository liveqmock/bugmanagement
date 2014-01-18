<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>${curProject.name }::编辑版本 - 大数据</title>
<script language='Javascript'>var config={"webRoot":"\/pro\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/pro\/theme\/","currentModule":"build","currentMethod":"create","clientLang":"zh-cn","requiredFields":"product,name,builder,date","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/pro\/index.php\/build-create-1.html"}
</script>
<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<!--[if lt IE 8]><link rel='stylesheet' href='/css/theme/fontawesome/ie7.min.css?v=pro3.1' type='text/css' media='screen' />
<link rel='stylesheet' href='/css/theme/default/style.ie7.css?v=pro3.1' type='text/css' media='screen' />
<![endif]-->
<script src='<c:url value="/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<style>.table-1 input{margin-bottom:3px}
</style>
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
<li class=' '><a href='showModule.htm' target=''>模块</a>
</li>
<li class=' active'><a href='versionList.htm' target=''>版本</a>
</li>
<li class='right '><a href='newProject.htm' target='' id="submenucreate"><i class="icon-plus"></i>&nbsp;添加项目</a>
</li>
<li class='right '><a href='projectList.htm' target='' id="submenuall"><i class="icon-th-large"></i>&nbsp;所有项目</a>
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
                cssPath:['<c:url value="/js/js/kindeditor/plugins/code/prettify.css"/>'],
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
<form method='post' action="updateVersion.htm" id='dataform'>
	<input type="hidden" name="versionId" value="${version.versionId }"/>
  <table class='table-1 fixed'> 
    <caption>编辑版本</caption>  
    <tr>
      <th class='rowhead'>名称</th>
      <td><input type='text' name='name' id='name' value='${version.name }' class='text-3' />
</td>
    </tr>     
    <tr>
      <th class='rowhead'>描述</th>
      <td><textarea name='description' id='desc' rows='10' class='area-1'>${version.description }</textarea>
</td>
    </tr>
    <tr><td colspan='2' class='a-center'> <input type='submit' id='submit' value='保存'  class='button-s' /> <input type='button' onClick='javascript:history.go(-1);' value='返回' class='button-b' /></td></tr>
  </table>
</form>
  </div>
  <div id='divider'></div>
</div>
<div id='footer'>
  <div id="crumbs">
    <a href='turnToHomePage.htm' >Bug管理</a>
&nbsp;<span class="icon-angle-right"></span>项目
&nbsp;<span class="icon-angle-right"></span>${version.project.name }
&nbsp;<span class="icon-angle-right"></span>创建版本  </div>
  <div id="poweredby">
    <span>Powered by SICD</span>
  </div>
</div>
<script language='Javascript'>onlybody = "no"
</script>
<script language='Javascript'>$(document).ready(function()
{
    $("a.preview").colorbox({width:1000, height:550, iframe:true, transition:'none', scrolling:true});
})

</script>
</body>
</html>
