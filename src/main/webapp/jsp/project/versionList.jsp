<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>${curProject.name }::版本列表 - 大数据</title>
<script language='Javascript'>var config={"webRoot":"\/pro\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/pro\/theme\/","currentModule":"project","currentMethod":"build","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/pro\/index.php\/project-build-1.html"}
</script>
<link rel='stylesheet' href='<c:url value="/css/theme/fontawesome/min.css"/>' type='text/css' media='screen' />
<!--[if lt IE 8]><link rel='stylesheet' href='/css/theme/fontawesome/ie7.min.css?v=pro3.1' type='text/css' media='screen' />
<link rel='stylesheet' href='/css/theme/default/style.ie7.css?v=pro3.1' type='text/css' media='screen' />
<![endif]-->
<script src='<c:url value="/js/all.js"/>' type='text/javascript'></script>
<link rel='stylesheet' href='<c:url value="/css/theme/default/zh-cn.default.css"/>' type='text/css' media='screen' />
<style>#productsBox  span{display:block; float:left; width:250px; overflow:hidden; word-break:keep-all; white-space:nowrap}
#whitelistBox span{display:block; float:left; width:150px; overflow:hidden; word-break:keep-all; white-space:nowrap}
caption a{padding:5px}
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
<script src='/pro/js/jquery/tablesorter/min.js?v=1380411804' type='text/javascript'></script>
<script src='/pro/js/jquery/tablesorter/metadata.js?v=1380411804' type='text/javascript'></script>
<script language='javascript'>

/* sort table after page load. */
$(function() { sortTable(); } );

function sortTable()
{
    $('.tablesorter').tablesorter(
        {
            widgets: ['zebra'], 
            widgetZebra: {css: ['odd', 'even'] }
        }
    ); 
    $('.tablesorter tbody tr').hover(
        function(){$(this).addClass('hoover')},
        function(){$(this).removeClass('hoover')}
    );

    /* IE6下面click事件和colorbox冲突。暂时去除该功能。*/
    if($.browser.msie && Math.floor(parseInt($.browser.version)) == 6) return; 
    $('.tablesorter tbody tr').click(
        function()
        {
            if($(this).attr('class').indexOf('clicked') > 0)
            {
                $(this).removeClass('clicked');
            }
            else
            {
                $(this).addClass('clicked');
            }
        }
    );
}
</script>
<script language='Javascript'>confirmDelete = "\u60a8\u786e\u8ba4\u5220\u9664\u8be5\u7248\u672c\u5417\uff1f"
</script>
<table class='table-1 tablesorter fixed' id='buildList'>
  <caption class='caption-tl pb-10px'>
    <div class='f-left'>版本列表</div>
    <div class='f-right'><span class='link-button'><a href='newVersion.htm' target='' class=''><i class='icon-green-build-create'></i> 创建版本</a>
</span></div>
  </caption>
  <thead>
  <tr class='colhead'>
    <th class='w-id'>ID</th>
    <th class='w-120px'>项目</th>
    <th>名称</th>
    <th>创建日期</th>
    <th class='w-150px'>操作</th>
  </tr>
  </thead>
  <tbody>
  	<c:forEach items="${versions }" var="version">
    <tr class='a-center'>
    <td>${version.versionId }</td>
    <td>${version.project.name }</td>
    <td class='a-center'><a href='showVersion.htm?versionId=${version.versionId }' >${version.name }</a></td>
    <td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${version.createdAt }" /></td>
    <td class='a-right'>
      <a href='newTask.htm' target='' class='link-icon ' title='提交测试'><i class='icon-green-testtask-create'></i></a>
      <a href='VersionToBug.htm?versionId=${version.versionId}' target='' class='link-icon ' title='查看bug'><i class='icon-green-project-bug'></i></a>
      <span class='link-button'><a href='editVersion.htm?versionId=${version.versionId }' target='' class='link-icon ' title='编辑版本'><i class='icon-green-common-edit'></i></a></span>
      <a href='deleteVersion.htm?versionId=${version.versionId }' target='' class='link-icon' title='删除版本'><i class="icon-green-common-delete"></i></a>
    </td>
  </tr>
  </c:forEach>
    </tbody>
</table>
  </div>
    <iframe frameborder='0' name='hiddenwin' id='hiddenwin' scrolling='no' class='hidden'></iframe>
  <div id='divider'></div>
</div>
<div id='footer'>
  <div id="crumbs">
    <a href='turnToHomePage.htm' >Bug管理</a>
&nbsp;<span class="icon-angle-right"></span>项目
&nbsp;<span class="icon-angle-right"></span>创建版本  </div>
  <div id="poweredby">
    <span>Powered by SICD</span>
  </div>
</div>
<script language='Javascript'>onlybody = "no"
</script>
<script language='Javascript'>function setWhite(acl)
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

</script>
</body>
</html>
