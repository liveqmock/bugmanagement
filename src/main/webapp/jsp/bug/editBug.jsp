<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑Bug-BUG管理</title>
<style type="text/css">
.chzn-results li{

width: 200px;
}

</style>
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
</head>
<body>
	<jsp:include page="includeHeader.jsp"></jsp:include>
	
	<div class="navbar" id="modulemenu">
		<ul>
			<jsp:include page="../includeJsp/includeSelectPro.jsp"></jsp:include>
			<li class=" "><a href="bug.htm" target="" id="submenubrowse">浏览Bug</a></li>
			<li class=" active"><a href="" target="" id="submenucreate">提Bug</a></li>
		</ul>
	</div>
	<div id='wrap'>
  <div class='outer'>
<form method='post' target='hiddenwin' enctype='multipart/form-data' id='dataform' action="editBug.htm">
<div id='titlebar'>
  <div id='main'>
  <input type="hidden" value="${bug.bugId}" name="bugId">
  BUG #${bug.bugId}::  <input type='text' name='title' id='title' value="${bug.title}" class=text-1 /><span class="star">*</span>
 </div>
  <div> <input type='submit' value='保存'  class='button-s' /> </div>
</div>

<table class='cont-rt5'>
  <tr valign='top'>
    <td>
      <table class='table-1 bd-none'>
        <tr class='bd-none'><td class='bd-none'>
          <fieldset>
            <legend>重现步骤</legend>
            <textarea class="xheditors" id="activeContentRichEditor"
			name="chongxian" style="height: 240px;width: 89%">${bug.steps}</textarea>
           
          </fieldset>
          <fieldset>
          <legend>备注</legend>
           <textarea rows='12' class="xheditors" id="activeContentRichEditor"
			name="beizhu" style="height: 125px;width: 89%"></textarea>
          </fieldset>
          <fieldset>
          <legend>附件</legend>
          <div id='fileform'>
    			<div class='fileBox' id='fileBox1'>
    				<input type='file' name='files' class='fileControl'  tabindex='-1' />
    				<label tabindex='-1' class='fileLabel'>标题：</label>
    				<input type='text' name='labels' class='text-3' tabindex='-1' /> 
    				<a href='javascript:void();' onclick='addFile(this)' class='link-icon'><i class='icon-add'></i></a>
    				<a href='javascript:void();' onclick='delFile(this)' class='link-icon'><i class='icon-delete'></i></a>
  				</div>  
					<script type="text/javascript">
					
					function maxFilesize(){return "(<span class='red'>50M</span>)";}
					
					function setFileFormWidth(percent)
					{
					    totalWidth = Math.round($('#fileform').parent().width() * percent);
					    titleWidth = totalWidth - $('.fileControl').width() - $('.fileLabel').width() - $('.icon').width();
					    if($.browser.mozilla) titleWidth  -= 8;
					    if(!$.browser.mozilla) titleWidth -= 12;
					    $('#fileform .text-3').css('width', titleWidth + 'px');
					};
					
					function addFile(clickedButton)
					{
					    fileRow = "  <div class='fileBox' id='fileBox$i'>\n    <input type='file' name='files[]' class='fileControl'  tabindex='-1' \/>\n    <label tabindex='-1' class='fileLabel'>\u6807\u9898\uff1a<\/label>\n    <input type='text' name='labels[]' class='text-3' tabindex='-1' \/> \n    <a href='javascript:void();' onclick='addFile(this)' class='link-icon'><i class='icon-add'><\/i><\/a>\n    <a href='javascript:void();' onclick='delFile(this)' class='link-icon'><i class='icon-delete'><\/i><\/a>\n  <\/div>";
					    fileRow = fileRow.replace('$i', $('.fileID').size() + 1);
					    $(clickedButton).parent().after(fileRow);
					
					    setFileFormWidth(0.9);
					    updateID();
					}
					
					function delFile(clickedButton)
					{
					    if($('.fileBox').size() == 1) return;
					    $(clickedButton).parent().remove();
					    updateID();
					}
					
					
					function updateID()
					{
					    i = 1;
					    $('.fileID').each(function(){$(this).html(i ++);});
					}
					
					$(function(){setFileFormWidth(0.9);});
					</script>
					</div>
          </fieldset>
          <div class='a-center'>
             <input type='submit' value='保存'  class='button-s' />  <input type='button' value='返回'  onclick='self.location="but.htm"' class='button-c' />           </div>
        </td></tr>
      </table>
     

<div id='actionbox'>
<fieldset>
  <legend>
  历史记录    
  </legend>

  <ol id='historyItem'>
  		<c:forEach items="${hisList}" var="hisList" varStatus="status">
             <li value='${status.index+1}'>
            	<span>
        			${hisList.operateTime}, 由 <strong>${hisList.user.realName}</strong>${hisList.operation}。
                </span>
          	</li>	
          </c:forEach>
   </ol>
</fieldset>
</div>
    </td>
    <td class='divider'></td>
    <td class='side'>
      <fieldset>
        <legend>基本信息</legend>
        <table class='table-1 a-left'>
          <tr>
            <td class='rowhead'>所属项目</td>
            <td>
            	<span><strong>${bug.module.project.name}</strong></span>
			</td>
          </tr>
          <tr>
            <td class='rowhead'>所属模块</td>
            <td>
              <span id='moduleIdBox'><select name='module' id='module' onchange='loadModuleRelated()' class='select-3'>
						<option value="${bug.module.moduleId}" selected="selected">${bug.module.name}</option>
						<c:forEach items="${modulebean}" var="modulebean">
							<option value="${modulebean.moduleId}">${modulebean.moduleName}</option>
						</c:forEach>
					</select>
				</span>
            </td>
          </tr>
          
          <tr>
            <td class='rowhead'>Bug类型</td>
            <td><select name='type' id='type' class=select-3>
            <option value="${bug.type}"selected="selected">${bug.type}</option>
				<option value='代码错误'>代码错误</option>
				<option value='界面优化'>界面优化</option>
				<option value='设计缺陷'>设计缺陷</option>
				<option value='配置相关'>配置相关</option>
				<option value='安装部署'>安装部署</option>
				<option value='安全相关'>安全相关</option>
				<option value='性能问题'>性能问题</option>
				<option value='标准规范'>标准规范</option>
				<option value='测试脚本'>测试脚本</option>
				<option value='其他'>其他</option>
				</select>
				</td>
          </tr>
          <tr>
            <td class='rowhead'>严重程度</td>
            <td><select name='severity' id='severity' class=select-3>
            <option value="${bug.severity}" selected="selected">${bug.severity}</option>
				<option value='3'>3</option>
				<option value='1'>1</option>
				<option value='2'>2</option>
				<option value='4'>4</option>
				</select>
			</td>
          </tr>
          <tr>
            <td class='rowhead'>优先级</td>
            <td><select name='pri' id='pri' class=select-3>
				<option value='${bug.priority}' selected='selected'>${bug.priority}</option>
				<option value='3'>较高</option>
				<option value='1'>较低</option>
				<option value='2'>普通</option>
				<option value='4'>最高</option>
				</select>
			</td>
          </tr>
          <tr>
            <td class='rowhead'>Bug状态</td>
            <td><select name='status' id='status' class=select-3>
				<option value='${bug.status}' selected='selected'>${bug.status}</option>
				<option value='激活'>激活</option>
				<option value='已解决'>已解决</option>
				<option value='已关闭'>已关闭</option>
				</select>
			</td>
          </tr>
          <tr>
            <td class='rowhead'>是否确认</td>
           <c:choose>
           	<c:when test="${bug.confirm==true}">
           		<td><strong>确认</strong></td>
           	</c:when>
           	<c:otherwise>
           		<td><strong>未确认</strong></td>
           	</c:otherwise>
            </c:choose>
          </tr>
          <tr>
            <td class='rowhead'>指派给</td>
            <td><select name='assignedTo' id='assignedTo' class=select-3>
					<option value="${bug.assignedTo.user.userId}" selected="selected">${bug.assignedTo.user.realName}</option>
						<c:forEach items="${userList}" var="userList">
							<option value="${userList.user.userId}">${userList.user.realName}</option>
						</c:forEach>
				</select>
			</td>
          </tr>
          <tr>
            <td class='rowhead'>操作系统</td>
            <td><select name='os' id='os' class=select-3>
					<option value='${bug.os}'>${bug.os}</option>
					<option value='all'>全部</option>
					<option value='windows'>Windows</option>
					<option value='winxp'>Windows XP</option>
					<option value='win7'>Windows 7</option>
					<option value='vista'>Windows Vista</option>
					<option value='win2000'>Windows 2000</option>
					<option value='win2003'>Windows 2003</option>
					<option value='win2008'>Windows 2008</option>
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
			</td>
          </tr>
          <tr>
            <td class='rowhead'>浏览器</td>
            <td><select name='browser' id='browser' class=select-3>
					<option value='${bug.browser}'>${bug.browser}</option>
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
					<option value='opera9'>opera9</option>
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
            <td class='rowhead'>关键词</td>
            <td><input type='text' name='keywords' id='keywords' value='${bug.keyword}' class="text-1" />
</td>
          </tr>
          <tr>
				<th class="rowhead"><nobr>抄送给</nobr></th>
					<td><select name="mailto" id="mailto"
								class="text-1 chzn-done" multiple="multiple" style="display: none;">
									<c:forEach items="${userList1}" var="userList1">
										<c:choose>
										<c:when test="${!userlist.contains(userList1)}">
											<option value="${userList1.userId}">${userList1.realName}</option>
										</c:when>
										<c:otherwise>
											<option value="${userList1.userId}" selected="selected">${userList1.realName}</option>
										</c:otherwise>
										</c:choose>
									</c:forEach>
							</select>
								<div id="mailto_chzn"
									class="chzn-container chzn-container-multi">
									<ul class="chzn-choices">
									 <c:forEach items="${userlist}" var="userlist">
										 <li class="search-choice">
											<span>${userlist.realName}</span>
											<a href="javascript:void(0)" class="search-choice-close" rel="2" onclick="del(this)"></a>
										</li> 
										</c:forEach>
										<li class="search-field"><input type="text"
												value="" class="default" autocomplete="off">
										</li> 
										
									</ul>
									<div class="chzn-drop"style="display: none;">
										<ul class="chzn-results">
											<c:forEach items="${userList1}" var="userList1">
											
											<c:if test="${!userlist.contains(userList1)}">
											<li class="active-result">${userList1.realName}</li>
											</c:if>
										
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
											$(".default").css("display","none");
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
         
        </table>
      </fieldset>

      <fieldset>
        <legend>其他相关</legend>
        <table class='table-1 a-left'>
          <tr>
            <td class='rowhead'>相关Bug</td>
            <td><input type='text' name='relateBug' id='linkBug' value='${bug.relatedBug.bugId}' class="text-1" /></td>
          </tr>
          <tr>
            <td class='rowhead'>来源用例</td>
            <td>${bug.fromCase.title}</td>
          </tr>
          <tr>
            <td class='rowhead'>生成用例</td>
            <td>${bug.toCase.title}</td>
          </tr>
        </table>
      </fieldset>
    </td>
  </tr>
</table>
</form>
  </div>
  <div id='divider'></div>
</div>
<div id='footer'>
  <div id="crumbs">
    <a href='turnToHomePage.htm' >Bug管理</a>&nbsp;<span class="icon-angle-right"></span><a href='bug.htm' >Bug</a>&nbsp;<span class="icon-angle-right"></span><a href='' >${bug.module.project.name}</a>&nbsp;<span class="icon-angle-right"></span>编辑  </div>
</div>
</body>
</html>