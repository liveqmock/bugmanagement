<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dli'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>

  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <title>问题回答::大数据 - BUG管理</title>
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

<link rel="stylesheet" href="<c:url value="/SyntaxHighlighter/Styles/SyntaxHighlighter.css"/>" type="text/css" media="screen" /> 
<script src='<c:url value="/SyntaxHighlighter/Scripts/shCore.js"/>' type='text/javascript'></script>
<script src='<c:url value="/SyntaxHighlighter/Scripts/shBrushJava.js"/>' type='text/javascript'></script>

<link rel="stylesheet" href='<c:url value="/js/js/kindeditor/themes/default/default.css" />' />
<script src='<c:url value="/js/js/kindeditor/kindeditor-min.js" />' type='text/javascript'></script>
<script src='<c:url value="/js/js/kindeditor/lang/zh_CN.js" />' type='text/javascript'></script>

<script type="text/javascript">
	var editor = {"id":["acontent"],"tools":"simpleTools"};
	
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

	$(function() {
		
		$code = $('code');
		 $code.replaceWith($code.html());
		$("pre").attr({"class":"java:nocontrols", "name":"code"});
		
		dp.SyntaxHighlighter.ClipboardSwf = '././SyntaxHighlighter/Scripts/clipboard.swf';
	    dp.SyntaxHighlighter.HighlightAll("code");
	    
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
	});
</script>

	
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
			<jsp:include page="../includeJsp/includeSelectPro.jsp"></jsp:include>
			<li><a href='question.htm' target=''>公开问题</a>
			</li>
			<li><a href='comQuestions.htm' target=''>内部问题</a>
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
          <div class="question"  id="question">
                  <table style="width: 100%;">
                      <tbody>
                        <tr>
                          <td class="votecell" style="width: 10%;">
                            <div class="vote" style="text-align: center;">
                                <a href="voteup.htm?questionId=${question.questionId}&objectId=${question.questionId}&objectType=question" class="vote-up-off" title="This question shows research effort; it is useful and clear"><img src="images/votedown.png"/></a><br />
                                <span class="vote-count-post" style="height: 25px;font-size: 160%;font-weight: normal;">${question.votes}</span><br />
                                <a href="votedown.htm?questionId=${question.questionId}&objectId=${question.questionId}&objectType=question" class="vote-down-off" title="This question does not show any research effort; it is unclear or not useful"><img src="images/voteup.png"/></a>
                            </div>
                           </td>
            
                          <td class="postcell" style="width: 90%; overflow: auto;">
                            <div>
                                <div class="post-text">
                                    <p>${question.content}</p>
                                </div>
                                <table class="fw">
      							 <tbody>
      							 <tr>
      							  <td class="vt">
                                       	<div class="post-menu"></div>                    
   							      </td>

                                 <td class="post-signature" align="right"> 
                                    <div class="user-info user-hover">
                                        <div class="user-action-time">
                                    		asked by ${question.developer.user.realName}<br />
                                    		<span class="relativetime"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss EE" value="${question.createdAt}" /></span>
                                        </div>
                                    </div>
                            	</td>
	                            </tr>
	                           </tbody>
                          	</table>
                              </div>
                          </td>
                          
                        </tr>
                    </tbody>
                </table>    
            </div>

        <div id="answers">

				<a name="tab-top"></a>
				<div id="answers-header">
					<div class="subheader answers-subheader" style="padding-bottom: 30px;">
						<h2>${fn:length(answerlist)} Answer</h2>
					</div>
				</div>
				
				<c:forEach var="x" items="${answerlist}" varStatus="status">
				<div id="answer" class="answer" >
   				 <table  style="width: 100%">
   				     <tbody>
    				    <tr>
      				      <td class="votecell" style="width: 10%;">
      				             <div class="vote" style="text-align: center;">
       				             <a href="voteup.htm?questionId=${question.questionId}&objectId=${x.answerId}&objectType=answer" class="vote-up-off" title="This answer is useful"><img src="images/votedown.png"/></a><br />
       				             <span class="vote-count-post" style="height: 25px;font-size: 160%;font-weight: normal;">${x.votes}</span><br />
        				            <a href="votedown.htm?questionId=${question.questionId}&objectId=${x.answerId}&objectType=answer" class="vote-down-off" title="This answer is not useful"><img src="images/voteup.png"/></a>
                                </div>
                          </td>



						    <td class="answercell" style="width: 90%;">
   								 <div class="post-text">
  								  <p>${x.content}</p>
   							     </div>
      							 <table class="fw">
      							 <tbody>
      							 <tr>
      							  <td class="vt">
                                       	<div class="post-menu"></div>                    
   							      </td>
    							  
                                 <td class="post-signature" align="right"> 
                                    <div class="user-info user-hover">
                                        <div class="user-action-time">
                                    		answered by ${x.developer.user.realName}<br />
                                    		<span class="relativetime"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss EE" value="${x.createdAt}" /></span>
                                        </div>
                                    </div>
                            	</td>
	                            </tr>
	                           </tbody>
                          	</table>
                          </td>        
                          </tr>
              </tbody>
             </table>
          </div>
          </c:forEach>
          
          <form id="post-form" action="answer.htm" method="post" class="post-form">

		          	<h2 class="space">Your Answer</h2>
			          <div id="post-editor" class="post-editor">
        		         <textarea id="acontent" class="wmd-input" name="post-text" cols="100" rows="10" tabindex="101"></textarea>

   		  	             <div class="fl" style="margin-top: 8px; height:24px;">&nbsp;</div>
      		  	    
   		  	           </div>
							
           
			            <div class="form-submit cbt">
									<input id="submit-button" value="Post Your Answer" tabindex="110" type="submit"/>
   		  	      		  	   
   		  	             </div>
   		  	             <input type="hidden" name="questionId" value="${question.questionId}"/>
   		  	             
                 </form>
                 </div>
                </div>
           </td>
      <td width="33%">
      <div class="dynamic" style="margin-top: 60px;">
          <table class="table-1 colored fixed">
            <caption>
              <div class="f-left"><i class="icon icon-quote-right"></i>&nbsp; 所属异常</div>
              <div class="f-right"><a href="questionsByException.htm?myExceptionId=${question.myException.exceptionId }" target="">更多问题&nbsp;<i class="icon-th icon icon-double-angle-right"></i></a></div>
            </caption>
            <tbody><tr style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial; "><td class="nobr" width="95%">${question.myException.exceptionClass }</td><td class="divider"></td></tr></tbody></table>
          </div>
          </td>
    </tr>
  </tbody>
  </table>
  
    </div>
    <iframe frameborder="0" name="hiddenwin" id="hiddenwin" scrolling="no" class="hidden" src="/pro/misc-ping.html"></iframe>
  <div id="divider"></div>
</div>
  
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
