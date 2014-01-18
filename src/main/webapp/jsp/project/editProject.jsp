<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:url value="/" var="basePath" />

<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>编辑项目 - BUG管理</title>
<script language='Javascript'>var config={"webRoot":"\/pro\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/pro\/theme\/","currentModule":"project","currentMethod":"create","clientLang":"zh-cn","requiredFields":"name,code,begin,end","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/pro\/index.php\/project-create.html"}
</script>
<link rel='stylesheet' href='${basePath}css/theme/fontawesome/min.css' type='text/css' media='screen' />
<script src='${basePath}js/all.js' type='text/javascript'></script>
<link rel='stylesheet' href='${basePath}css/theme/default/zh-cn.default.css' type='text/css' media='screen' />
<style>
#productsBox  span{display:block; float:left; width:250px; overflow:hidden; word-break:keep-all; white-space:nowrap}
#whitelistBox span{display:block; float:left; width:150px; overflow:hidden; word-break:keep-all; white-space:nowrap}
caption a{padding:5px}
</style>
<link rel='icon' href="${basePath}images/favor.ico" type='image/x-icon' />
<link rel='shortcut icon' href='${basePath}images/favor.ico' type='image/x-icon' />
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
<li class=' '><a href='versionList.htm' target=''>版本</a>
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
<link rel='stylesheet' href='${basePath}/js/js/kindeditor/themes/default/default.css'/>
<script src='${basePath}/js/js/kindeditor/kindeditor-min.js' type='text/javascript'></script>
<script src='${basePath}/js/js/kindeditor/lang/zh_CN.js' type='text/javascript'></script>
<script language='javascript'>
var editor = {"id":["desc","goal"],"tools":"simpleTools"};

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
                cssPath:['${basePath}/js/kindeditor/plugins/code/prettify.css'],
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
<script src='${basePath}/js/js/misc/date.js' type='text/javascript'></script>
<script language='Javascript'>holders = {"code":"\u56e2\u961f\u5185\u90e8\u7684\u7b80\u79f0"}
</script>
<form method='post' action="updateProject.htm" method="post" id='dataform'>
<input type="hidden" name="projectId" value="${project.projectId }" />
  <table align='center' class='table-1 a-left'> 
    <caption>
      <div class='f-left'>编辑项目</div>
    </caption> 
        <tr>
      <th class='rowhead'>项目名称</th>
      <td><input type='text' name='name' id='name' value='${project.name }' class='text-3' />
</td>
    </tr>  
    <tr>
      <th class='rowhead'>开始日期</th>
      <td><input type='text' name='startDate' id='begin' value='<fmt:formatDate pattern="yyyy-MM-dd" value="${project.startDate }" />' class='text-3 date' onchange='computeWorkDays()' />
</td>
    </tr>  
    <tr>
      <th class='rowhead'>结束日期</th>
      <td>
         <input type='text' name='endDate' id='end' value='<fmt:formatDate pattern="yyyy-MM-dd" value="${project.endDate }" />' class='text-3 date' onchange='computeWorkDays()' />
      </td>
    </tr>
    <tr>
      <th class='rowhead'>项目目标</th>
      <td><textarea name='goal' id='goal' rows='6' class='area-1'>${project.goal }</textarea>
</td>
    </tr>  
    <tr>
      <th class='rowhead'>项目描述</th>
      <td><textarea name='description' id='desc' rows='6' class='area-1'>${project.description }</textarea>
</td>
    </tr>    
    <tr>
      <td colspan='2' class='a-center'> <input type='submit' id='submit' value='保存'  class='button-s' /> <input type='button' onClick='javascript:history.go(-1);' value='返回' class='button-b' /></td>
    </tr>
  </table>
</form>
  </div>
    <iframe frameborder='0' name='hiddenwin' id='hiddenwin' scrolling='no' class='hidden'></iframe>
  <div id='divider'></div>
</div>
<div id='footer'>
  <div id="crumbs">
    <a href='turnToHomePage.htm' >Bug管理</a>
&nbsp;<span class="icon-angle-right"></span>项目
&nbsp;<span class="icon-angle-right"></span>编辑项目  </div>
  <div id="poweredby">
    <span>Powered by SICD</span>
  </div>
</div>
<script language='Javascript'>onlybody = "no"
</script>
<script language='Javascript'>
function setWhite(acl)
{
    acl == 'custom' ? $('#whitelistBox').removeClass('hidden') : $('#whitelistBox').addClass('hidden');
}

function switchStatus(projectID, status)
{
  if(status) location.href = createLink('project', 'task', 'project=' + projectID + '&type=' + status);
}

function switchGroup(projectID, groupBy)
{
    link = createLink('project', 'groupTask', 'project=' + projectID + '&groupBy=' + groupBy);
    location.href=link;
}

/**
 * Convert a date string like 2011-11-11 to date object in js.
 * 
 * @param  string $date 
 * @access public
 * @return date
 */
function convertStringToDate(dateString)
{
    dateString = dateString.split('-');
    return new Date(dateString[0], dateString[1] - 1, dateString[2]);
}

/**
 * Compute delta of two days.
 * 
 * @param  string $date1 
 * @param  string $date1 
 * @access public
 * @return int
 */
function computeDaysDelta(date1, date2)
{
    date1 = convertStringToDate(date1);
    date2 = convertStringToDate(date2);
    delta = (date2 - date1) / (1000 * 60 * 60 * 24) + 1;

    weekEnds = 0;
    for(i = 0; i < delta; i++)
    {
        if(date1.getDay() == 0 || date1.getDay() == 6) weekEnds ++;
        date1 = date1.valueOf();
        date1 += 1000 * 60 * 60 * 24;
        date1 = new Date(date1);
    }
    return delta - weekEnds; 
}

/**
 * Compute work days.
 * 
 * @access public
 * @return void
 */
function computeWorkDays(currentID)
{
    isBactchEdit = false;
    if(currentID)
    {
        index = currentID.replace('begins[', '');
        index = index.replace('ends[', '');
        index = index.replace(']', '');
        if(!isNaN(index)) isBactchEdit = true;
    }

    if(isBactchEdit)
    {
        beginDate = $('#begins\\[' + index + '\\]').val();
        endDate   = $('#ends\\[' + index + '\\]').val();
    }
    else
    {
        beginDate = $('#begin').val();
        endDate   = $('#end').val();
    }

    if(beginDate && endDate) 
    {
        if(isBactchEdit)  $('#dayses\\[' + index + '\\]').val(computeDaysDelta(beginDate, endDate));
        if(!isBactchEdit) $('#days').val(computeDaysDelta(beginDate, endDate));
    }
    else if($('input[checked="true"]').val()) 
    {
        computeEndDate();
    }
}

/**
 * Compute the end date for project.
 * 
 * @param  int    $delta 
 * @access public
 * @return void
 */
function computeEndDate(delta)
{
    beginDate = $('#begin').val();
    if(!beginDate) return;

    endDate = convertStringToDate(beginDate).addDays(parseInt(delta));
    endDate = endDate.toString('yyyy-M-dd');
    $('#end').val(endDate);
    computeWorkDays();
}

/* Auto compute the work days. */
$(function() 
{
    $(".chosenBox select").chosen({no_results_text: noResultsMatch});
    if(typeof(replaceID) != 'undefined') setModal4List('iframe', replaceID);
    $(".date").bind('dateSelected', function()
    {
        computeWorkDays(this.id);
    })
});
function switchCopyProject(switcher)
{
    if($(switcher).attr('checked'))
    {
        $('#copyProjectBox').removeClass('hidden');
    }
    else
    {
        $('#copyProjectBox').addClass('hidden');
    }
}

function setCopyProject(projectID)
{
    location.href = createLink('project', 'create', 'projectID=0&copyProjectID=' + projectID);
}

</script>
</body>
</html>
