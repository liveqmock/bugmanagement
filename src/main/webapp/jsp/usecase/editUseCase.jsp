<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>复制-BUGMM</title>

<script src="<c:url value="/js/jquery-1.8.3.min.js"/>" type="text/javascript"></script>
<link rel="stylesheet"
	href="<c:url value="/css/theme/fontawesome/min.css"/>" type="text/css"
	media="screen">
	<script type="text/javascript"
	src="<c:url value="/js/xheditor/xheditor-1.1.6-zh-cn.js"/>"></script>
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
		
		
		var str=$("#str").val();
		
		var arr=str.split(";");
		
		$("#stage").each(function(){
			var val=$("#stage").find("option").val();
			for(var i=0;i<arr.length;i++){
				$("#stage").find("option[value='"+arr[i]+"']").attr("selected","selected");
			}
		});
		
	
	});
</script>

</head>
<body>
	<jsp:include page="includeHeader.jsp"></jsp:include>

	<div class="navbar" id="modulemenu">
		<ul>
			<jsp:include page="../includeJsp/includeSelectPro.jsp"></jsp:include>
			<li class=" "><a href="" target="" id="submenubrowse">浏览用例</a></li>
			<li class=""><a href="" target="" id="submenucreate">创建用例</a></li>
		</ul>
	</div>

<div id="wrap">
  <div class="outer" style="min-height: 714px;">
<input type="hidden" value="${userCase.stage}" id="str">

<form method="post" enctype="multipart/form-data" id="dataform" action="EditUserCase.htm">
<div id="titlebar">
  <div id="main">
  <input type="hidden" value="${userCase.caseId}" name="usercaseId">
  CASE #${userCase.caseId}::  <input type="text" name="title" id="title" value="${userCase.title}" class="text-1"><span class="star"> * </span>
  </div>
  <div> <input type="submit" id="submit" value="保存" class="button-s"> </div>
</div>

<table class="cont-rt5">
  <tbody><tr valign="top">
    <td>
      <fieldset>
        <legend>前置条件</legend>
        <textarea name="precondition" id="precondition" rows="4" class="text-1">${userCase.precondition}</textarea>
      </fieldset>
      <table class="table-1">
       <tbody><tr class="colhead">
          <th class="w-30px">编号</th>
          <th>步骤</th>
          <th>预期</th>
          <th class="w-100px">操作</th>
        </tr>
        <c:forEach items="${stepList}" var="stepList">
          <tr id="row1" class="a-center">
          	<th class="stepID">${stepList.num}</th>
	          <td class="w-p50">
	          		<textarea name="steps" id="steps" rows="3" class="w-p100">${stepList.content}</textarea>
	          </td>
			  <td>
			  	<textarea name="expects" id="expects" rows="3" class="w-p100">${stepList.expect}</textarea>
			  </td>
			  <td class="a-left w-100px"><nobr>
			  	<input type="button" tabindex="-1" class="addbutton" onclick="preInsert(1)" value="之前添加"><br>
			  	<input type="button" tabindex="-1" class="addbutton" onclick="postInsert(1)" value="之后添加"><br>
			  	<input type="button" tabindex="-1" class="delbutton" onclick="deleteRow(1)" value="删除"><br></nobr>
			  </td>
		  </tr>
		</c:forEach>     
		</tbody></table>

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

      <div class="a-center">
        <input type="submit" id="submit" value="保存" class="button-s">
      </div>
      
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
                <c:if test="${hisList.comment!=null}">
                <div class="history">        
                	<div class="comment13320">${hisList.comment}</div>        
        		</div>  
        		</c:if>
          	</li>	
          </c:forEach>
   </ol>
</fieldset>
</div>

    </td>
    <td class="divider"></td>
    <td class="side">
      <fieldset>
        <legend>基本信息</legend>
        <table class="table-1 a-left" cellpadding="0" cellspacing="0">
          <tbody>
          <tr>
            <td class='rowhead'>所属项目</td>
            <td>
            	<span><strong>${userCase.module.project.name}</strong></span>
			</td>
          </tr>
           <tr>
            <td class='rowhead'>所属模块</td>
            <td>
              <span id='moduleIdBox'><select name='module' id='module' onchange='loadModuleRelated()' class='select-3'>
						<option value="${userCase.module.moduleId}" selected="selected">${userCase.module.name}</option>
						<c:forEach items="${modulebean}" var="modulebean">
							<option value="${modulebean.moduleId}">${modulebean.moduleName}</option>
						</c:forEach>
					</select>
				</span>
            </td>
          </tr>
         
          <tr>
            <td class="rowhead">用例类型</td>
            <td><select name="type" id="type" class="select-1">
				<option value="${userCase.caseType}" selected="selected">${userCase.caseType}</option>
				<option value="功能测试">功能测试</option>
				<option value="性能测试">性能测试</option>
				<option value="配置相关">配置相关</option>
				<option value="安装部署">安装部署</option>
				<option value="安全相关">安全相关</option>
				<option value="接口测试">接口测试</option>
				<option value="其他">其他</option>
				</select><span class="star"> * </span>
          </td>
          </tr>
          <tr>
            <th class="rowhead">适用阶段</th>
            <td><select name="stage" id="stage" class="select-1" multiple="multiple">
			<option value="单元测试阶段">单元测试阶段</option>
			<option value="功能测试阶段">功能测试阶段</option>
			<option value="集成测试阶段">集成测试阶段</option>
			<option value="系统测试阶段">系统测试阶段</option>
			<option value="冒烟测试阶段">冒烟测试阶段</option>
			<option value="版本验证阶段">版本验证阶段</option>
				</select>
			</td>
          </tr>  
          <tr>
            <td class="rowhead">优先级</td>
            <td><select name="pri" id="pri" class="select-1">
			<option value="${userCase.priority}" selected="selected">${userCase.priority}</option>
			<option value="3">3</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="4">4</option>
				</select>
          </td>
          </tr>
          <tr>
            <td class="rowhead">用例状态</td>
            <td><select name="status" id="status" class="select-1">
					<option value="${userCase.status}" selected="selected">${userCase.status}</option>
					<option value="正常" >正常</option>
					<option value="被阻塞">被阻塞</option>
					<option value="研究中">研究中</option>
				</select>
			</td>
          </tr>
          <tr>
            <td class="rowhead">关键词</td>
             <td><input type="text" name="keywords" id="keywords" value="${userCase.keyword}" class="text-1"></td>
          </tr>
          <tr>
            <td class="rowhead">相关用例</td>
            <td><input type="text" name="linkCase" id="linkCase" value="${userCase.relatedCase.caseId}" class="text-1"></td>
          </tr>
        </tbody>
        </table>
      </fieldset>
      <fieldset>
        <legend>创建编辑</legend>
        <table class="table-1 a-left">
          <tbody><tr>
            <td class="rowhead w-p20">由谁创建 </td>
            <td>${userCase.creator.user.name}于${userCase.createdAt}</td>
          </tr><tr>
            <td class="rowhead">最后编辑</td>
            <c:if test="${hs.user.name!=null}">
            <td>${hs.user.name}&nbsp;&nbsp;于${hs.operateTime}做了编辑</td>
            </c:if>
          </tr>
        </tbody></table>
      </fieldset>
    </td>
  </tr>
</tbody></table>
  </form>
  </div>
  <div id="divider"></div>
</div>
<div id="footer">
  <div id="crumbs">
    <a href="">Bug管理</a>
&nbsp;<span class="icon-angle-right"></span><a href="usecase.htm">用例</a>
&nbsp;<span class="icon-angle-right"></span><a href="">${userCase.module.project.name}</a>
&nbsp;<span class="icon-angle-right"></span>用例管理&nbsp;<span class="icon-angle-right"></span>编辑  </div>
  
</div>

<script type="text/javascript">
var newRowID = 0;
function deleteRow(rowID)
{
    if($('.stepID').size() == 1) return;
    $('#row' + rowID).remove();
    updateStepID();
}

function preInsert(rowID)
{
    $('#row' + rowID).before(createRow());
    updateStepID();
}

function postInsert(rowID)
{
    $('#row' + rowID).after(createRow());
    updateStepID();
}

function createRow()
{
    if(newRowID == 0) newRowID = $('.stepID').size();
    newRowID ++;
    var newRow = "<tr class='a-center' id='row" + newRowID + "'>";
    newRow += "<th class='stepID'></th>";
   
    newRow += "<td class='w-p50'><textarea name='steps' rows=3 class='w-p100'></textarea></td>";
    newRow += "<td><textarea name='expects' rows=3 class='w-p100'></textarea></td>";
    
    newRow += "<td class='a-left w-100px'><nobr>";
    
    newRow += "<input type='button' tabindex='-1' class='addbutton' value='之前添加' onclick=preInsert("  + newRowID + ")/><br/>";
    newRow += "<input type='button' tabindex='-1' class='addbutton' value='之后添加' onclick=postInsert(" + newRowID + ")/><br/>";
    newRow += "<input type='button' tabindex='-1' class='delbutton' value='删除' onclick=deleteRow("  + newRowID + ")/><br/>";
    newRow += "</nobr></td>";
   
    return newRow;
}

function updateStepID()
{
    var i = 1;
    $('.stepID').each(function(){$(this).html(i ++);});
}
</script>
</body></html>
