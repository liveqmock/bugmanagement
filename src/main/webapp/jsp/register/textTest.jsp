<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>编辑活动</title>


<script type="text/javascript" src="<c:url value="/js/jquery.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/xheditor/xheditor-1.1.6-zh-cn.js"/>"></script>

</head>
<body>
<textarea class="xheditors" id="activeContentRichEditor" name="activityIntroduce" style="height:200px;width:61%;"></textarea>			
</body>
<script type="text/javascript">
$(function(){
	if($('textarea.xheditors').length!=0){
		$('textarea.xheditors').xheditor({
			upLinkUrl:"uploadFile.htm",
			upLinkExt:"zip,rar,txt,doc,docx,pdf,ppt,pptx,pps,ppsx,xlsx,xls,7z",
			upImgUrl:"uploadPic.htm",
			upImgExt:"jpg,jpeg,gif,png", tools:'simple',
			forcePtag:false,
			html5Upload:false,  
			emotMark:true
				});
		}	
	});
	</script>
</html>