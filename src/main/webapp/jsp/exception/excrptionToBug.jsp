<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加Bug-BUG管理</title>

<script src="<c:url value="/js/jquery-1.8.3.min.js"/>" type="text/javascript"></script>
<script type="text/javascript"
	src="<c:url value="/js/xheditor/xheditor-1.1.6-zh-cn.js"/>"></script>
<link rel="stylesheet"
	href="<c:url value="/css/theme/fontawesome/min.css"/>" type="text/css"
	media="screen">
<link rel="stylesheet"
	href="<c:url value="/css/theme/default/zh-cn.default.css"/>"
	type="text/css" media="screen">
<link rel="icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon">
<link rel="shortcut icon" href="<c:url value="/images/favor.ico"/>"
	type="image/x-icon">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/css/theme/browser/safari.css"/>">
<script type="text/javascript">
	jQuery(function($) {
		if ($('textarea.xheditors').length != 0) {
			$('textarea.xheditors')
					.xheditor(
							{
								upLinkUrl : "uploadFile.htm",
								upLinkExt : "zip,rar,txt,doc,docx,pdf,ppt,pptx,pps,ppsx,xlsx,xls,7z",
								upImgUrl : "uploadPic.htm",
								upImgExt : "jpg,jpeg,gif,png",
								tools : 'simple',
								forcePtag : false,
								html5Upload : false,
								emotMark : true
							});
		}
	});
</script>
<script type="text/javascript">
	$(function(){
		$("#product").change(function(){
			var projectId=$("#product").val();
			$("#module").find("option").remove();
			 $.ajax({
	            	type:"post",
	            	url:"loadModel.htm",
	            	dataType:"json", 
	            	data:"projectId="+projectId,
	            	success:function(value){
	            			
	            	var json =eval(value);
	            	
	            	
	            	for(var i=0;i<json.length;i++){
	            		var name=json[i]['moduleName'];
	            		var id=json[i]['moduleId'];
	            		$("#module").append("<option value="+id+">"+name+"</option>");
	            		
	            	}
	            	}
	          
	            }); 
		});
		  
		 $("#product").change(function(){
			var projectId=$("#product").val();
			$("#version").find("option").remove();
			 $.ajax({
	            	type:"post",
	            	url:"loadVersion.htm",
	            	dataType:"json", 
	            	data:"projectId="+projectId,
	            	success:function(value){
	            		var json =eval(value);
	            	for(var i=0;i<json.length;i++){
	            		var name=json[i]['name'];
	            		var id=json[i]['versionId'];
	            		$("#version").append("<option value="+id+">"+name+"</option>");
	            		
	            		
	            	}
	            	}
	          
	            });
			
		});
		 
	});



</script>

</head>
<body>
	<jsp:include page="../bug/includeHeader.jsp"></jsp:include>
	
	<div class="navbar" id="modulemenu">
		<ul>
			<jsp:include page="../includeJsp/includeSelectPro.jsp"></jsp:include>
			<li class=" "><a href="bug.htm" target="" id="submenubrowse">浏览Bug</a></li>
			<li class=" active"><a href="addBug.htm" target="" id="submenucreate">提Bug</a></li>
		</ul>
	</div>
	<div id="wrap">
		<div class="outer" style="min-height: 714px;">

			<form method="post" enctype="multipart/form-data" id="dataform"class="ajaxForm" action="addBug.htm">
				<table class="table-1">
					<caption>提Bug</caption>
					<tbody>
						<tr>
							<th class="rowhead">项目模块</th>
							<td><select name="product" id="product"class="select-3"autocomplete="off">
								<option value="${project.projectId}" selected="selected">${project.name}</option>
								<c:forEach items="${projectList}" var="projectList">
									<option value="${projectList.projectId}">${projectList.name}</option>
								</c:forEach>

							</select> <span id="moduleIdBox"> <select name="module" id="module">
										<option value="0" selected="selected">/</option>
								</select><span class="star"> * </span> <a href="" target="_blank">模块维护
								</a><a href="">刷新</a></span></td>
						</tr>
						<tr>
							<th class="rowhead">影响版本</th>
							<td><span id="buildBox"> <select name="version"
									id="version" size="4" multiple="multiple" class="select-3">
										
								</select><span class="star"> * </span> <a href="" target="_blank">创建发布
								</a> <a href="javascript:loadProductBuilds(36)">刷新</a></span></td>
						</tr>
						<tr>
							<th class="rowhead"><nobr>当前指派</nobr></th>
							<td><span id="assignedToBox"><select
									name="assignedTo" id="assignedTo" class="select-3">
										<option value="" selected="selected">/</option>
										<c:forEach items="${userList}" var="userList">
										<option value="${userList.user.userId}">${userList.user.realName}</option>
										</c:forEach>
								</select> </span></td>
						</tr>
						<tr>
							<th class="rowhead">Bug标题</th>
							<td><input type="text" name="title" id="title" value=""
								class="text-1"><span class="star"> * </span></td>
						</tr>
						<tr>
							<th class="rowhead">重现步骤</th>
							<td><textarea class="xheditors" id="activeContentRichEditor"
									name="chongxian" style="height: 200px; width: 61%;">
									&lt;p&gt;[步骤] 执行程序&lt;/p&gt;
									&lt;p&gt;[结果] 出错&lt;/p&gt;
									&lt;p&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;异常类：${record.exceptionClass}&lt;/p&gt;
									&lt;p&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;异常信息：${record.detailMsg}&lt;/p&gt;
									&lt;p&gt;&amp;nbsp; &amp;nbsp; 源码信息：${record.sourceInfo}&lt;/p&gt;
									&lt;p&gt;&amp;nbsp; &amp;nbsp; 出错代码行：${record.lineNum}&lt;/p&gt;
									&lt;p&gt;[期望] 正常运行&lt;/p&gt;
									</textarea>
							</td>
						</tr>

						<tr>
							<th class="rowhead">类型/严重程度</th>
							<td><select name="type" id="type" class="select-2">
									<option value="codeerror" selected="selected">代码错误</option>
									<option value='界面优化'>界面优化</option>
									<option value='设计缺陷'>设计缺陷</option>
									<option value='配置相关'>配置相关</option>
									<option value='安装部署'>安装部署</option>
									<option value='安全相关'>安全相关</option>
									<option value='性能问题'>性能问题</option>
									<option value='标准规范'>标准规范</option>
									<option value='测试脚本'>测试脚本</option>
							</select> <select name="severity" id="severity" class="select-2">
									<option value="1" selected="selected">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
							</select></td>
						</tr>
						<tr>
      						<th class='rowhead'><nobr>系统/浏览器</nobr></th>
							   <td>
							        <select name='os' id='os' class=select-2>
										<option value=''></option>
										<option value='all'>全部</option>
										<option value='windows'>Windows</option>
										<option value='winxp'>Windows XP</option>
										<option value='win7'>Windows 7</option>
										<option value='vista'>Windows Vista</option>
										<option value='win2000'>Windows 2000</option>
										<option value='win2003'>Windows 2003</option>
										<option value='win2008' selected='selected'>Windows 2008</option>
										<option value='winnt'>Windows NT</option>
										<option value='win98'>Windows 98</option>
										<option value='andriod'>Andriod</option>
										<option value='ios'>IOS</option>
										<option value='wp7'>sdf</option>
										<option value='symbian'>Symbian</option>
										<option value='linux'>Linux</option>
										<option value='freebsd'>FreeBSD</option>
										<option value='mac'>Mac OS</option>
										<option value='unix'>Unix</option>
										<option value='others'>其他</option>
									</select>
							        <select name='browser' id='browser' class=select-2>
										<option value='all'>全部</option>
										<option value='ie'>IE系列</option>
										<option value='ie8'>IE8</option>
										<option value='ie9'>IE9</option>
										<option value='ie6'>IE6</option>
										<option value='ie7'>IE7</option>
										<option value='chrome'>chrome</option>
										<option value='firefox'>firefox系列</option>
										<option value='firefox2'>firefox2</option>
										<option value='firefox3'>firefox3</option>
										<option value='firefox4'>firefox4</option>
										<option value='opera'>opera系列</option>
										<option value='opera9' selected='selected'>opera9</option>
										<option value='oprea10'>opera10</option>
										<option value='oprea11'>opera11</option>
										<option value='safari'>safari</option>
										<option value='maxthon'>傲游</option>
										<option value='uc'>UC</option>
										<option value='other'>其他</option>
									</select>
							   </td>
    					</tr>
							<tr>
							<th class="rowhead"><nobr>抄送给</nobr></th>
							
							<td><select name="mailto" id="mailto"
								class="text-1 chzn-done" multiple=""
								data-placeholder="选择要发信通知的用户..." style="display: none;">
									<c:forEach items="${userList1}" var="userList1">
										<option value="${userList1.userId}">${userList1.realName}</option>
									</c:forEach>
							</select>
								<div id="mailto_chzn"
									class="chzn-container chzn-container-multi"
									style="width: 1181px;">
									<ul class="chzn-choices">
										 <li class="search-field"><input type="text"
											value="选择要发信通知的用户..." class="default" autocomplete="off"
											style="width: 176px;">
										</li> 
										<!-- <li class="search-choice" id="mailto_chzn_c_2">
											<span>dddd</span>
											<a href="javascript:void(0)" class="search-choice-close" rel="2"></a>
										</li> -->
									</ul>
									<div class="chzn-drop"
										style="width: 1180px; top: 29px;display: none;">
										<ul class="chzn-results">
										<c:forEach items="${userList1}" var="userList1">
											<li class="active-result">${userList1.realName}</li>
										</c:forEach>
										</ul>
									</div>
								</div>
								
								<script type="text/javascript">
									$(function(){
										$(".chzn-choices").click(function(){
											
											$(".chzn-drop").css("display","block");
											
											$(".chzn-results li").mouseover(function(){
												$(".active-result.highlighted").removeClass("highlighted");
												$(this).addClass("active-result highlighted");
												}); 
												
											});
										$(".chzn-results li").click(function(){
											var name=$(this).html();
											$(".active-result.highlighted").removeClass("active-result highlighted");
											$(this).remove();
											$(".default").val("");
											$(".search-field").prepend("<li class=search-choice><span>"+name+"</span><a href=javascript:void() class=search-choice-close rel=2 onclick=del(this)></a></li>");
											$("#mailto option").each(function(){
												if($(this).text()==name){
													 $(this).attr("selected", "selected");
												}
											});
											
										});
										 $(".chzn-results").mouseleave(function(){
											$(".chzn-drop").css("display","none");
										}); 
										 
									});
									
									function del(clickedButton){
										$(clickedButton).parent().remove();
										var name=$(clickedButton).parent().find("span").html();
										$(".chzn-results").append("<li class=active-result>"+name+"</li>");
										$("#mailto option").each(function(){
											if($(this).text()==name){
												 $(this).removeAttr("selected");
											}
										});
									}
								</script>
								</td>
						</tr>
						<tr>
							<th class="rowhead">关键词</th>
							<td><input type="text" name="keywords" id="keywords"
								value="" class="text-1"></td>
						</tr>
						<tr>
							<th class="rowhead">附件</th>
							<td><div id="fileform">
									<div class="fileBox" id="fileBox1">
										<input type="file" name="files" class="fileControl"
											tabindex="-1"> <label tabindex="-1" class="fileLabel">标题：</label>
										<input type="text" name="labels" class="text-3"
											tabindex="-1" style="width: 892px;"> <a
											href="javascript:void();" onclick="addFile(this)"
											class="link-icon"><i class="icon-add"></i></a> <a
											href="javascript:void();" onclick="delFile(this)"
											class="link-icon"><i class="icon-delete"></i></a>
									</div>
								</div> <script type="text/javascript">
									function maxFilesize() {
										return "(<span class='red'>50M</span>)";
									}

									/**
									 * Set the width of the file form.
									 * 
									 * @param  float  $percent 
									 * @access public
									 * @return void
									 */
									function setFileFormWidth(percent) {
										totalWidth = Math.round($('#fileform')
												.parent().width()
												* percent);
										titleWidth = totalWidth
												- $('.fileControl').width()
												- $('.fileLabel').width()
												- $('.icon').width();
										if ($.browser.mozilla)
											titleWidth -= 8;
										if (!$.browser.mozilla)
											titleWidth -= 12;
										$('#fileform .text-3').css('width',
												titleWidth + 'px');
									};

									/**
									 * Add a file input control.
									 * 
									 * @param  object $clickedButton 
									 * @access public
									 * @return void
									 */
									function addFile(clickedButton) {
										fileRow = "  <div class='fileBox' id='fileBox$i'>\n    <input type='file' name='files' class='fileControl'  tabindex='-1' \/>\n    <label tabindex='-1' class='fileLabel'>\u6807\u9898\uff1a<\/label>\n    <input type='text' name='labels' class='text-3' tabindex='-1' \/> \n    <a href='javascript:void();' onclick='addFile(this)' class='link-icon'><i class='icon-add'><\/i><\/a>\n    <a href='javascript:void();' onclick='delFile(this)' class='link-icon'><i class='icon-delete'><\/i><\/a>\n  <\/div>";
										fileRow = fileRow.replace('$i', $(
												'.fileID').size() + 1);
										$(clickedButton).parent()
												.after(fileRow);

										setFileFormWidth(0.85);
										updateID();
									}

									/**
									 * Delete a file input control.
									 * 
									 * @param  object $clickedButton 
									 * @access public
									 * @return void
									 */
									function delFile(clickedButton) {
										if ($('.fileBox').size() == 1)
											return;
										$(clickedButton).parent().remove();
										updateID();
									}

									/**
									 * Update the file id labels.
									 * 
									 * @access public
									 * @return void
									 */
									function updateID() {
										i = 1;
										$('.fileID').each(function() {
											$(this).html(i++);
										});
									}

									$(function() {
										setFileFormWidth(0.85);
									});
								</script></td>
						</tr>
						<tr>
							<td colspan="2" class="a-center"><input type="submit"
								id="submit" value="保存" class="button-s"> <input
								type="button" onclick="javascript:history.go(-1);" value="返回"
								class="button-b"><input type="hidden" name="case"
								id="case" value="0"></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		<div id="divider"></div>
	</div>
	<div id="footer">
		<div id="crumbs">
			<a href="turnToHomePage.htm">Bug道管理</a> &nbsp;<span
				class="icon-angle-right"></span><a
				href="bug.htm">Bug</a> &nbsp;<span
				class="icon-angle-right"></span>${curProject.name }
			&nbsp;<span class="icon-angle-right"></span>提Bug
		</div>
	</div>
</body>

</html>