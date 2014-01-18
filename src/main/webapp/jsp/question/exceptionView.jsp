<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>查看异常 - 禅道管理</title>
<script language='Javascript'>var config={"webRoot":"\/pro\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/pro\/theme\/","currentModule":"bug","currentMethod":"view","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/pro\/index.php\/bug-view-1.html"}
</script>
<link rel='stylesheet' href='/pro/theme/fontawesome/min.css?v=pro3.1' type='text/css' media='screen' />
<!--[if lt IE 8]><link rel='stylesheet' href='/pro/theme/fontawesome/ie7.min.css?v=pro3.1' type='text/css' media='screen' />
<link rel='stylesheet' href='/pro/theme/default/style.ie7.css?v=pro3.1' type='text/css' media='screen' />
<![endif]--><script src='/pro/js/all.js?v=pro3.1' type='text/javascript'></script>
<link rel='stylesheet' href='/pro/theme/default/zh-cn.default.css?v=pro3.1' type='text/css' media='screen' />
<style>.content .stepTitle{margin:7px 0 7px -15px; display:block; color: green}
</style><link rel='icon' href='/pro/favicon.ico' type='image/x-icon' />
<link rel='shortcut icon' href='/pro/favicon.ico' type='image/x-icon' />
</head>
<body>
<style>
#colorbox, #cboxOverlay, #cboxWrapper{z-index:9999;}
</style>

<jsp:include page="includeHeader.jsp"></jsp:include>

<div class="navbar" id="modulemenu">
  <ul>
<li><div id='currentItem'><a onclick="showDropMenu('product', '1', 'bug', 'browse', '')">dota2外挂<span id='dropIcon'></span></a></div><div id='dropMenu'></div></li>
<li class=' active'><a href='/pro/bug-browse-1.html' target='' id=submenubug>Bug</a>
</li>
<li class=' '><a href='/pro/testcase-browse-1.html' target='' id=submenutestcase>用例</a>
</li>
<li class=' '><a href='/pro/testtask-browse-1.html' target='' id=submenutesttask>测试任务</a>
</li>
</ul>
</div>
<div id='wrap'>
  <div class='outer'>
<link rel="stylesheet" href="/pro/js/kindeditor/themes/default/default.css" />
<script src='/pro/js/kindeditor/kindeditor-min.js' type='text/javascript'></script>
<script src='/pro/js/kindeditor/lang/zh_CN.js' type='text/javascript'></script>
<script language='javascript'>
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
                cssPath:['/pro/js/kindeditor/plugins/code/prettify.css'],
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
  <div id='main' >BUG #1 踢人一起掉</div>
  <div>
    <span class='link-button'><a href='/pro/bug-assignTo-1.html?onlybody=yes' target='' class='iframe'><i class='icon-green-bug-assignTo iframe'></i> 指派</a>
</span><span class='link-button'><a href='/pro/bug-close-1.html?onlybody=yes' target='' class='iframe'><i class='icon-green-bug-close iframe'></i> 关闭</a>
</span><span class='link-button'><a href='/pro/bug-activate-1.html?onlybody=yes' target='' class='iframe'><i class='icon-green-bug-activate iframe'></i> 激活</a>
</span><span class='link-button'><a href='/pro/testcase-create-1-0-bug-1.html' target='' class=''><i class='icon-green-testcase-createCase'></i> 建用例</a>
</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class='link-button'><a href='/pro/bug-edit-1.html' target='' class='link-icon ' title='编辑'><i class='icon-green-common-edit'></i></a></span><span class='link-button'><a href='#commentBox' target='' title='备注' onclick='setComment()'><i class="icon-comment-alt"></i></a>
</span><span class='link-button'><a href='/pro/bug-create-1-bugID=1.html' target='' class='link-icon ' title='复制'><i class='icon-green-common-copy'></i></a></span><span class='link-button'><a href='/pro/bug-delete-1.html' target='hiddenwin' class='link-icon ' title='删除'><i class='icon-green-common-delete'></i></a></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class='link-button'><a href='/pro/bug-browse-1.html' target='' class='link-icon' title=返回><i class="icon-goback icon-level-up icon-large icon-rotate-270"></i></a>
</span><span class='link-button'><a href='/pro/bug-view-2.html' target='' id='next' class='link-icon' title='#2 test'><i class="icon-pre icon-chevron-sign-right"></i></a>
</span>  </div>
</div>

<table class='cont-rt5'>
  <tr valign='top'>
    <td>
      <fieldset>
        <legend>重现步骤</legend>
        <div class='content'></div>
      </fieldset>
      <style>.button-c {padding:1px}</style>
<script language='Javascript'>
$(function(){
     $(".edit").colorbox({width:400, height:200, iframe:true, transition:'none', scrolling:true});
})

/* Delete a file. */
function deleteFile(fileID)
{
    if(!fileID) return;
    hiddenwin.location.href =createLink('file', 'delete', 'fileID=' + fileID);
}
/* Download a file, append the mouse to the link. Thus we call decide to open the file in browser no download it. */
function downloadFile(fileID)
{
    if(!fileID) return;
    var sessionString = '?sid=3g3c8ik6juj4ihes44um42gbr5';
    var url = createLink('file', 'download', 'fileID=' + fileID + '&mouse=left') + sessionString;
    window.open(url, '_blank');
    return false;
}
</script>
<fieldset>
  <legend>附件</legend>
  <div>
    </div>
</fieldset>      <script language='Javascript'>
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
<script src='/pro/js/jquery/reverseorder/raw.js' type='text/javascript'></script>

<div id='actionbox'>
<fieldset>
  <legend>
  历史记录    <span onclick='toggleOrder(this)' class='hand'> <span title='切换顺序' class='log-asc'></span></span>
    <span onclick='toggleShow(this);' class='hand'><span title='切换显示' class='change-show'></span></span>
  </legend>

  <ol id='historyItem'>
                <li value='1'>
            <span>
        2013-10-14 14:48:11, 由 <strong>admin</strong> 创建。
              </span>
          </li>
            <li value='2'>
            <span>
        2013-10-14 14:48:40, 由 <strong>admin</strong> 指派给 <strong>大法师</strong>。
        <span id='switchButton3' class='hand change-show' onclick=switchChange(3)></span>      </span>
            <div class='history'>        <div class='changes hidden' id='changeBox3'>
        修改了 <strong><i>指派给</i></strong>，旧值为 ""，新值为 "dfs"。<br />
        </div>
                <div class='comment11'>速度解决</div>        
        </div>          </li>
            <li value='3'>
            <span>
        2013-10-25 21:42:38, 由 <strong>admin</strong> 指派给 <strong>大法师</strong>。
              </span>
          </li>
            <li value='4'>
            <span>
        2013-10-26 22:55:22, 由 <strong>直升机</strong> 确认Bug。
              </span>
          </li>
            <li value='5'>
            <span>
        2013-10-26 22:55:30, 由 <strong>直升机</strong> 确认Bug。
              </span>
          </li>
            <li value='6'>
            <span>
        2013-10-26 22:56:08, 由 <strong>直升机</strong> 解决，方案为 <strong>设计如此</strong>。              </span>
          </li>
            <li value='7'>
            <span>
        2013-10-26 22:56:19, 由 <strong>直升机</strong> 解决，方案为 <strong>设计如此</strong>。              </span>
          </li>
      </ol>

</fieldset>
</div>
      <div class='a-center actionlink'><span class='link-button'><a href='/pro/bug-assignTo-1.html?onlybody=yes' target='' class='iframe'><i class='icon-green-bug-assignTo iframe'></i> 指派</a>
</span><span class='link-button'><a href='/pro/bug-close-1.html?onlybody=yes' target='' class='iframe'><i class='icon-green-bug-close iframe'></i> 关闭</a>
</span><span class='link-button'><a href='/pro/bug-activate-1.html?onlybody=yes' target='' class='iframe'><i class='icon-green-bug-activate iframe'></i> 激活</a>
</span><span class='link-button'><a href='/pro/testcase-create-1-0-bug-1.html' target='' class=''><i class='icon-green-testcase-createCase'></i> 建用例</a>
</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class='link-button'><a href='/pro/bug-edit-1.html' target='' class='link-icon ' title='编辑'><i class='icon-green-common-edit'></i></a></span><span class='link-button'><a href='#commentBox' target='' title='备注' onclick='setComment()'><i class="icon-comment-alt"></i></a>
</span><span class='link-button'><a href='/pro/bug-create-1-bugID=1.html' target='' class='link-icon ' title='复制'><i class='icon-green-common-copy'></i></a></span><span class='link-button'><a href='/pro/bug-delete-1.html' target='hiddenwin' class='link-icon ' title='删除'><i class='icon-green-common-delete'></i></a></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class='link-button'><a href='/pro/bug-browse-1.html' target='' class='link-icon' title=返回><i class="icon-goback icon-level-up icon-large icon-rotate-270"></i></a>
</span><span class='link-button'><a href='/pro/bug-view-2.html' target='' id='next' class='link-icon' title='#2 test'><i class="icon-pre icon-chevron-sign-right"></i></a>
</span></div>
      <div id='commentBox' class='hidden'>
        <fieldset>
          <legend>备注</legend>
          <form method='post' action='/pro/bug-edit-1-true.html'>
            <table align='center' class='table-1'>
            <tr><td><textarea name='comment' id='comment' rows='5' class='w-p100'></textarea>
</td></tr>
            <tr><td> <input type='submit' id='submit' value='保存'  class='button-s' /> <input type='button' onClick='javascript:history.go(-1);' value='返回' class='button-b' /></td></tr>
            </table>
          </form>
        </fieldset>
      </div>
    </td>
    <td class='divider'></td>
    <td class='side'>
      <fieldset>
        <legend>基本信息</legend>
        <table class='table-1 a-left'>
          <tr valign='middle'>
            <th class='rowhead'>所属产品</th>
            <td><a href='/pro/bug-browse-1.html' target='' >W:dota2外挂</a>
          </tr>
          <tr>
            <th class='rowhead'>所属模块</th>
            <td> 
              <a href='/pro/bug-browse-1-byModule-1.html' target='' >踢人</a>
            </td>
          </tr>
          <tr valign='middle'>
            <th class='rowhead'>所属计划</th>
            <td>          </tr>
          <tr>
            <td class='rowhead'>Bug类型</td>
            <td>代码错误</td>
          </tr>
          <tr>
            <td class='rowhead'>严重程度</td>
            <td><strong>1</strong></td>
          </tr>
          <tr>
            <td class='rowhead'>优先级</td>
            <td><strong>3</strong></td>
          </tr>
          <tr>
            <td class='rowhead'>Bug状态</td>
            <td><strong>已解决</strong></td>
          </tr>
          <tr>
            <td class='rowhead'>激活次数</td>
            <td>0</td>
          </tr>
          <tr>
            <td class='rowhead'>是否确认</td>
            <td>已确认</td>
          </tr>
          <tr>
            <td class='rowhead'>当前指派</td>
            <td>admin 于 2013-10-26 22:56:19</td>
          </tr>
          <tr>
            <td class='rowhead'>操作系统</td>
            <td>Windows 7</td>
          </tr>
          <tr>
            <td class='rowhead'>浏览器</td>
            <td>IE系列</td>
          </tr>
          <tr>
            <td class='rowhead'>关键词</td>
            <td></td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>相关用例</legend>
        <table class='table-1 a-left'>
          <tr>
            <td class='rowhead w-p20'>来源用例</td>
            <td></td>
          </tr>
          <tr>
            <td valign="top" class='rowhead w-p20'>生成用例</td>
            <td>
                        </td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>BUG的一生</legend>
        <table class='table-1 a-left fixed'>
          <tr>
            <th class='rowhead w-p20'>由谁创建</th>
            <td> admin 于 2013-10-14 14:48:11</td>
          </tr>
          <tr>
            <th class='rowhead'>影响版本</th>
            <td>
              1.0<br />            </td>
          </tr>
          <tr>
            <th class='rowhead'>由谁解决</th>
            <td>直升机 于 2013-10-26 22:56:19          </tr>
          <tr>
            <th class='rowhead'>解决版本</th>
            <td>1.0</td>
          </tr>
          <tr>
            <th class='rowhead'>解决方案</th>
            <td>
              设计如此            </td>
          </tr>
          <tr>
            <th class='rowhead'>由谁关闭</th>
            <td></td>
          </tr>
          <tr>
            <th class='rowhead'>最后修改</th>
            <td>直升机 于 2013-10-26 22:56:19</td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>项目/需求/任务</legend>
        <table class='table-1 a-left fixed'>
          <tr>
            <td class='rowhead w-p20'>所属项目</td>
            <td><a href='/pro/project-browse-1.html' >dota2外挂</a>
</td>
          </tr>
          <tr class='nofixed'>
            <td class='rowhead'>相关需求</td>
            <td>
                          </td>
          </tr>
          <tr>
            <td class='rowhead'>相关任务</td>
            <td></td>
          </tr>
        </table>
      </fieldset>
      <fieldset>
        <legend>其他相关</legend>
        <table class='table-1 a-left fixed'>
          <tr>
            <td class='rowhead w-p20'>抄送给</td>
            <td> </td>
          </tr>
          <tr>
            <td class='rowhead'>相关Bug</td>
            <td>
                          </td>
          </tr>
          <tr>
            <td class='rowhead'>相关用例</td>
            <td></td>
          </tr>
          <tr>
            <td class='rowhead'>转需求</td>
            <td></td>
          </tr>
          <tr>
            <td class='rowhead'>转任务</td>
            <td></td>
          </tr>
        </table>
      </fieldset>
    </td>
  </tr>
</table>
<script src="/pro/js/jquery/syntaxhighlighter/scripts/shCore.js" type="text/javascript"></script>
<script src="/pro/js/jquery/syntaxhighlighter/scripts/shAutoloader.js" type="text/javascript"></script>
<link href="/pro/js/jquery/syntaxhighlighter/styles/shCore.css" rel="stylesheet" type="text/css" />
<link href="/pro/js/jquery/syntaxhighlighter/styles/shThemeDefault.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
function path()
{
  var args = arguments;
  var result = [];
       
  for(var i = 0; i < args.length; i++) result.push(args[i].replace('@', '/pro/js/jquery/syntaxhighlighter/scripts/'));
       
  return result
}
 
SyntaxHighlighter.autoloader.apply(null, path(
  'applescript            @shBrushAppleScript.js',
  'actionscript3 as3      @shBrushAS3.js',
  'bash shell             @shBrushBash.js',
  'coldfusion cf          @shBrushColdFusion.js',
  'cpp c                  @shBrushCpp.js',
  'c# c-sharp csharp      @shBrushCSharp.js',
  'css                    @shBrushCss.js',
  'delphi pascal          @shBrushDelphi.js',
  'diff patch pas         @shBrushDiff.js',
  'erl erlang             @shBrushErlang.js',
  'groovy                 @shBrushGroovy.js',
  'java                   @shBrushJava.js',
  'jfx javafx             @shBrushJavaFX.js',
  'js jscript javascript  @shBrushJScript.js',
  'perl pl                @shBrushPerl.js',
  'php                    @shBrushPhp.js',
  'text plain             @shBrushPlain.js',
  'py python              @shBrushPython.js',
  'ruby rails ror rb      @shBrushRuby.js',
  'sass scss              @shBrushSass.js',
  'scala                  @shBrushScala.js',
  'sql                    @shBrushSql.js',
  'vb vbnet               @shBrushVb.js',
  'xml xhtml xslt html    @shBrushXml.js'
));
SyntaxHighlighter.defaults['toolbar'] = false;
SyntaxHighlighter.all();
</script>
  </div>
    <iframe frameborder='0' name='hiddenwin' id='hiddenwin' scrolling='no' class='hidden'></iframe>
  <div id='divider'></div>
</div>
<div id='footer'>
  <div id="crumbs">
    <a href='/pro/my/' >禅道管理</a>
&nbsp;<span class="icon-angle-right"></span><a href='/pro/qa/' >测试</a>
&nbsp;<span class="icon-angle-right"></span><a href='/pro/bug-browse-1.html' >W:dota2外挂</a>
&nbsp;<span class="icon-angle-right"></span>Bug详情  </div>
  <div id="poweredby">
    <span>Powered by <a href='http://www.zentao.net' target='_blank'>ZenTaoPMS</a> (pro3.1)</span>
        <a href='/pro/misc-downNotify.html' >下载桌面提醒</a>
    <a href='/pro/misc-qrCode.html' target='' class='qrCode '><i class='icon-mobile-phone icon-large'></i>手机访问</a>
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
function setModal4List(colorboxClass, replaceID)
{
    if(onlybody != 'yes') $('.iframe').colorbox({width:900, height:500, iframe:true, transition:'none', onCleanup:function(){parent.location.href=parent.location.href;}})
}

</script>
</body>
</html>
<script language='Javascript'>
$('.actionlink .link-button:first').before("<span class='link-button'><a href='\/pro\/effort-createForObject-bug-1.html' target='' class='effort'><i class='icon-green-effort-createForObject effort'><\/i>\u65e5\u5fd7<\/a>\n<\/span>");
$(".effort").colorbox({width:1024, height:600, iframe:true, transition:'elastic'});
</script>
