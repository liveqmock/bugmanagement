<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="<c:url value="/js/jquery-1.8.3.min.js"/>"
	type="text/javascript"></script>
   <script src='<c:url value="/SyntaxHighlighter/Scripts/shCore.js"/>' type='text/javascript'></script>
<script src='<c:url value="/SyntaxHighlighter/Scripts/shBrushJava.js"/>' type='text/javascript'></script>
 <link rel="stylesheet"
	href="<c:url value="/SyntaxHighlighter/Styles/SyntaxHighlighter.css"/>" type="text/css"
	media="screen">  

 <%-- <script src="<c:url value="/js/shCore.js"/>" type="text/javascript"></script>
<script src="<c:url value="/js/shBrushJava.js"/>" type="text/javascript"></script>
<link rel="stylesheet" href="<c:url value="/css/shCore.css"/>"
	type="text/css" media="screen">
<link rel="stylesheet" href="<c:url value="/css/shThemeMidnight.css"/>"
	type="text/css" media="screen">  --%>

<title>Insert title here</title>
<script type="text/javascript">
$(document).ready(function(){
	/* dp.sh.Brushes.Java; */
	/* SyntaxHighlighter.config.clipboardSwf = '././js/clipboard.swf';
	SyntaxHighlighter.all(); */
	
	 dp.SyntaxHighlighter.ClipboardSwf = '././SyntaxHighlighter/Scripts/clipboard.swf';
    dp.SyntaxHighlighter.HighlightAll("code"); 

   /*  SyntaxHighlighter.config.clipboardSwf='http://static.oschina.net/js/syntax-highlighter-2.1.382/scripts/clipboard.swf';
	SyntaxHighlighter.config.strings={
		expandSource:'展开代码',
		viewSource:'查看代码', 
		copyToClipboard:'复制代码',
		copyToClipboardConfirmation:'代码复制成功',
		print:'打印',
		help:'帮助',
		noBrush:'不能找到刷子:',
		brushNotHtmlScript:'刷子没有配置html-script选项'
		}; 
    SyntaxHighlighter.all();  */
});
</script>
</head>
<body>
	<h1>代码高亮演示 SyntaxHighlighter</h1>
	<pre class="java" name="code">
	@Override
	public void init(FilterConfig cfg) throws ServletException {
		super.init(cfg);
		OnlineUserManager.init();
		//this._dataInit();
	}

      </pre>
</body>

</html>