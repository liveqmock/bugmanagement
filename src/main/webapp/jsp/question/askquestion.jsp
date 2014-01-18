<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>

  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>添加问题::大数据 - BUG管理</title>
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
.post-signature {
    
    padding-left: 5px;
    padding-top: 2px;
    text-align: left;
    vertical-align: top;
    width: 175px;
    height: 58px;
}.fw {
    border: 0px none;
    width: 100%;
}#tabs a.youarehere {
    background: none repeat scroll 0% 0% rgb(255, 255, 255);
    border-width: 0px;
    border-style: solid;
    
    -moz-border-top-colors: none;
    -moz-border-right-colors: none;
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    border-image: none;
    color: black;
    font-size: 120%;
    height: 30px;
    line-height: 20px;
    margin-top: 3px;
    padding: 0px 11px;
}#tabs a {
    background: none repeat scroll 0% 0% rgb(255, 255, 255);
    border-width: 0px;
    border-style: solid;
    
    -moz-border-top-colors: none;
    -moz-border-right-colors: none;
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    border-image: none;
    color: rgb(119, 119, 119);
    font-size: 90%;
    height: 24px;
    line-height: 20px;
    margin-top: 3px;
    padding: 0px 11px;
}
.subheader a {
    color: rgb(0, 0, 0);
}.subheader h1, .subheader h2 {
    
    font-size: 18px;
    line-height: 34px;
    margin-bottom: -20px;
}
.vote{
margin-top: 15px;
}
.post-text{
margin-top: 10px;
}
input[type="button"], input[type="submit"], .button, a.button:link, a.button:visited {
    padding: 0.3em 0.6em;
    box-shadow: 0px 2px 1px rgba(0, 0, 0, 0.3), 0px 1px 0px rgba(255, 255, 255, 0.4) inset;
    background-color: rgb(51, 51, 51);
    color: rgb(255, 255, 255);
    border: 1px solid rgb(0, 0, 0) !important;
    border-radius: 3px 3px 3px 3px;
    text-decoration: none;
}

</style>
</head>
<body>
<jsp:include page="includeHeader.jsp"></jsp:include>

 <div class="navbar" id="modulemenu">
  <ul>
<li><span id="myname"><i class="icon-user"></i> ${user.realName}&nbsp;<span class="icon-angle-right"></span></span></li>
<li class=" "><a href="" target="" id="submenuindex">首页</a>
</li>
<li class=" "><a href="" target="" id="submenutodo">待办</a>
</li>
<li class=" "><a href="" target="" id="submenueffort">日志</a>
</li>
<li class=" active"><a href="" target="" id="submenutask">异常</a>
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
  <div class="outer" style="min-height: 402px; ">


<div class="wrapper">
  <table class="cont" id="row1">
    <tbody>
    <tr valign="top">
      <td width="66%" style="padding-right:20px">
        <div class="block linkbox1" id="projectbox">
          <div id="question-header">
			       <h1 itemprop="name"><a href="" class="question-hyperlink">${question.title}</a></h1>
		  </div>

        
                </div>
           </td>
      <td width="33%">
      <div class="dynamic">
          <table class="table-1 colored fixed">
            <caption>
              <div class="f-left"><i class="icon icon-quote-right"></i>&nbsp; 相关异常</div>
              <div class="f-right"><a href="" target="">更多&nbsp;<i class="icon-th icon icon-double-angle-right"></i></a></div>
            </caption>
            <tbody><tr style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial; "><td class="nobr" width="95%">10月22日 09:28, admin <em>登录系统</em>  <a href=""></a>。</td><td class="divider"></td></tr></tbody></table>
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
