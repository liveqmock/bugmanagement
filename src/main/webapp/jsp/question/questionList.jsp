<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>维护部门结构::大数据 - BUG管理</title>
<script language='Javascript'>
var config={"webRoot":"\/","cookieLife":30,"requestType":"PATH_INFO","pathType":"clean","requestFix":"-","moduleVar":"m","methodVar":"f","viewVar":"t","defaultView":"html","themeRoot":"\/css\/theme\/","currentModule":"dept","currentMethod":"browse","clientLang":"zh-cn","requiredFields":"","submitting":"\u7a0d\u5019...","save":"\u4fdd\u5b58","router":"\/company\/dept"};
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
<style type="">
.question-summary table{
width: 100%;
}
table{
border: 0px;
}.mini-counts {
    height: 25px;
    font-size: 160%;
    font-weight: normal;
}.unanswered {
    background: none repeat scroll 0% 0% transparent;
    color: rgb(154, 68, 68);
}.narrow .status {
    float: left;
    margin: 0px 3px 0px 0px;
    padding: 5px;
    width: 48px;
    height: 38px;
}.votes {
    color: rgb(85, 85, 85);
    padding: 0px 0px 7px;
    text-align: center;
}#nav-askquestion {
    color: rgb(255, 255, 255);
    padding: 6px 12px;
    display: block;
    

}#chong{
background: rgb(119, 119, 119);
display: block;
width:inherit;
font-size: 125%;
margin: 20px;
float: left;
}

</style>
</head>
<body>
<jsp:include page="includeHeader.jsp"></jsp:include>

 <div class="navbar" id="modulemenu">
  <ul>
<li><span id="myname"><i class="icon-user"></i> ${user.realName}&nbsp;<span class="icon-angle-right"></span></span></li>
<li class=" active"><a href="" target="" id="submenuindex">首页</a>
</li>
<li class=" "><a href="" target="" id="submenutodo">待办</a>
</li>
<li class=" "><a href="" target="" id="submenueffort">日志</a>
</li>
<li class=" "><a href="" target="" id="submenutask">异常</a>
</li>
<li class=" "><a href="" target="" id="submenubug">Bug</a>
</li>
<li class=" "><a href="" target="" id="submenutesttask">测试</a>

</li>
<li class=" "><a href="" target="" id="submenumyProject">项目</a>
</li>
<li class=" "><a href="" target="" id="submenudynamic">动态</a>
</li>
<li class=" "><a href="" target="" id="submenuprofile">档案</a>
</li>
<li class=" "><a href="" target="" id="submenuchangePassword">密码</a>
</li>
</ul>
</div>
 <div id="wrap">
  <div class="outer" style="min-height: 402px;max-width: 97%; text-align:center;margin-left:auto; margin-right:auto;">

    <div class="wrapper" style="min-height: 402px;max-width: 67%; text-align:center;margin-left:auto; margin-right:auto;">
      
      <table class="cont" id="row1">
        <tbody>
        <tr><td id="chong" ><a id="nav-askquestion" href="">Ask Question</a></td></tr>
        <tr valign="top">
          <td width="60%" style="padding-right:20px">
          <div class="block linkbox1" id="projectbox">
          <div style="overflow: auto;margin-top: -10px;margin-bottom: 30px;">
          <c:forEach var="x" items="${questionlist}" varStatus="status"> 
            
               <div class="question-summary" id="" style=" ">
                     <table>
                      <tbody>
                        <tr>  <td style="max-width: 120px;">
                                <div onclick="" class="cp" style="text-align: center;padding: 0px;border: 0px none;font-size: 100%;vertical-align: baseline;background: none repeat scroll 0% 0% transparent;margin: 10px">
                                    <div class="votes" style="float: left;margin-left: 10px">
                                        <div class="mini-counts" style="height: 25px;font-size: 160%;font-weight: normal;">${x.votes}</div>
                                        <div>votes</div>
                                    </div>
                                    <div class="status unanswered" style="float: left;margin-left: 10px">
                                        <div class="mini-counts" style="height: 25px;font-size: 160%;font-weight: normal;">${x.answers.size()}</div>
                                        <div>answers</div>
                                    </div>
                                    
                                </div>
                                </td>
                                <td>
                                <div class="summary" style="margin-left:0px;padding: 0px;border: 0px none;font-size: 100%;vertical-align: baseline;background: none repeat scroll 0% 0% transparent;text-align:left;">
        
                                      <h3 style=""><a href="answers.htm?questionId=${x.questionId}" class="question-hyperlink" style="font-weight: bold;color: rgb(0, 119, 204);" title="">${x.title}</a></h3>
                                      
                                      <div class="started" style="width: auto;line-height: inherit;font-size: 90%;padding-top: 4px;white-space: nowrap;float: right;margin-right: 10px;color: rgb(119, 119, 119);">
                                                    <a href="" class="started-link"><span title="" class="relativetime"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss EE" value="${x.createdAt}" /></span></a>
                                                    <a href="">${x.developer.user.realName}</a> 
                                      </div>
                                 </div>
                                 </td>
                        </tr>
                        </tbody> 
                       </table> 
                   </div>
             
             </c:forEach>
             </div></div>
             
             <div class="f-right">
                        <div style="float:right; clear:none;" class="pager">共<strong>6</strong>条记录，每页
                           <strong>
                           <select name="_recPerPage" id="_recPerPage" onchange="submitPage(&quot;changeRecPerPage&quot;)" >
                             <option value="5">5</option>
                             <option value="10">10</option>
                             <option value="20" selected="selected">20</option>
                             <option value="30">30</option>
                             <option value="50">50</option>
                             <option value="100">100</option>
                             <option value="200">200</option>
                             <option value="500">500</option>
                             <option value="1000">1000</option>
                           </select>
                           </strong>条，<strong>1/1</strong> 首页 上页 下页 末页 <input type="hidden" id="_recTotal" value="6"/>
                           <input type="hidden" id="_pageTotal" value="1"/>
                           <input type="text" id="_pageID" value="1" style="text-align:center;width:30px;"/> 
                           <input type="button" id="goto" value="GO!" onclick="submitPage(&quot;changePageID&quot;);"/> 
                           <script language="Javascript">
                               vars = 'productID=1&browseType=all&param=0&orderBy=&recTotal=_recTotal_&recPerPage=_recPerPage_&pageID=_pageID_';
                               pageCookie = 'pagerBugBrowse';
                               function submitPage(mode)
                                  {
                                     pageTotal  = parseInt(document.getElementById('_pageTotal').value);
                                     pageID     = document.getElementById('_pageID').value;
                                     recPerPage = document.getElementById('_recPerPage').value;
                                     recTotal   = document.getElementById('_recTotal').value;
                                     $.cookie(pageCookie, recPerPage, {expires:config.cookieLife, path:config.webRoot});
                                            if(mode == 'changePageID')
                                                     {
                                                        if(pageID > pageTotal) pageID = pageTotal;
                                                        if(pageID < 1) pageID = 1;
                                                      }
                                             else if(mode == 'changeRecPerPage')
                                                      {
                                                        pageID = 1;
                                                      }
                                            vars = vars.replace('_recTotal_', recTotal);
                                            vars = vars.replace('_recPerPage_', recPerPage);
                                            vars = vars.replace('_pageID_', pageID);
                                            location.href=createLink('bug', 'browse', vars);
                                  }
                           </script>
                       </div>
              </div>
          </td>
        <td width="20%">
         
          <div class="dynamic">
          <table class="table-1 colored fixed">
          
            <caption>
              <div class="f-left"><i class="icon icon-quote-right"></i>&nbsp; 异常类描述</div>
              <div class="f-right"><a href="" target="">更多&nbsp;<i class="icon-th icon icon-double-angle-right"></i></a></div>
            </caption>
            <tbody>
            <tr style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial; ">
            <td class="nobr" width="95%">只是个异常  <a href=""></a>。</td><td class="divider"></td>
            </tr>
            </tbody>
            </table>
          </div>
        </td>
      </tr>
      </tbody>
     </table>
    </div>
    <iframe frameborder="0" name="hiddenwin" id="hiddenwin" scrolling="no" class="hidden" src="/pro/misc-ping.html"></iframe>
  <div id="divider"></div>
</div>

<script language="Javascript">onlybody = "no";
</script>
<script language="Javascript">$(function() 
{ 
    if(typeof(listName) != 'undefined') setModal4List('iframe', listName, function(){$(".colorbox").colorbox({width:960, height:550, iframe:true, transition:'none'});});
});
$(function() 
{ 
    /* Set the heights of every block to keep them same height. */
    projectBoxHeight = $('#projectbox').height();
    productBoxHeight = $('#productbox').height();
    if(projectBoxHeight < 180) $('#projectbox').css('height', 180);
    if(productBoxHeight < 180) $('#productbox').css('height', 180);

    row2Height = $('#row2').height() - 10;
    row2Height = row2Height > 200 ? row2Height : 200;
    $('#row2 .block').each(function(){$(this).css('height', row2Height);});

    $('.projectline').each(function()
    {
        $(this).sparkline('html', {height:'25px'});
    });
});

</script>


  
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
 <script language='Javascript'>onlybody = "no";</script>
</body>
</html>
