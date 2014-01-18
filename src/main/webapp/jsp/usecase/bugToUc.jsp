<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>创建用例-BUGMM</title>

<script src="<c:url value="/js/jquery-1.8.3.min.js"/>" type="text/javascript"></script>
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
	
	});
</script>

</head>
<body>
	<jsp:include page="includeHeader.jsp"></jsp:include>

	<div class="navbar" id="modulemenu">
		<ul>
			<jsp:include page="../includeJsp/includeSelectPro.jsp"></jsp:include>
			<li class=" "><a href="" target="" id="submenubrowse">浏览用例</a></li>
			<li class=" active"><a href="" target="" id="submenucreate">创建用例</a></li>
		</ul>
	</div>

<div id="wrap">
  <div class="outer" style="min-height: 714px;">


<form method="post" enctype="multipart/form-data" id="dataform" class="ajaxForm" action="addUCFromBug.htm">
<input type="hidden" value="${bug.bugId}" name="bugId">
  <table class="table-1"> 
    <caption>建用例</caption>
    <tbody><tr>
      <th class="rowhead">项目模块</th>
      <td>
        <select name="product" id="product" class="select-3">
			<option value="${curPproject.projectId}" selected="selected">${curProject.name}</option>
			<c:forEach items="${projectList}" var="projectList">
				<option value="${projectList.projectId}">${projectList.name}</option>
			</c:forEach>
		</select>
        <span id="moduleIdBox">
        <select name="module" id="module">
			<c:forEach items="${modulebean}" var="modulebean">
				<option value="${modulebean.moduleId}">${modulebean.moduleName}</option>
			</c:forEach>
		</select>
			<a href="" target="_blank">维护模块</a>
			<a href="">刷新</a>
        </span>
      </td>
    </tr>  
    <tr>
      <th class="rowhead">用例类型</th>
      <td><select name="type" id="type" class="select-3">
			<option value="功能测试" selected="selected">功能测试</option>
			<option value="性能测试">性能测试</option>
			<option value="配置相关">配置相关</option>
			<option value="安装部署">安装部署</option>
			<option value="安全相关">安全相关</option>
			<option value="接口测试">接口测试</option>
			<option value="其他">其他</option>
		  </select>
		<span class="star"> * </span>
	 </td>
    </tr>  
    <tr>
      <th class="rowhead">适用阶段</th>
      <td><select name="stage" id="stage" class="select-3" multiple="multiple">
			<option value="" selected="selected"></option>
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
      <th class="rowhead">优先级</th>
      <td><select name="pri" id="pri" class="select-3">
			<option value="3">3</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="4">4</option>
		  </select>
	 </td>
    </tr>  
    <tr>
      <th class="rowhead">用例标题</th>
      <td><input type="text" name="title" id="title" value="${bug.title}" class="text-1"><span class="star"> * </span></td>
    </tr>  
    <tr>
      <th class="rowhead">前置条件</th>
      <td><textarea name="precondition" id="precondition" rows="4" class="text-1"></textarea></td>
    </tr>  
    <tr>
      <th class="rowhead">用例步骤</th>
      <td>
        <table class="w-p90">
          <tbody><tr class="colhead">
            <th class="w-30px">编号</th>
            <th>步骤</th>
            <th class="w-200px">预期</th>
            <th class="w-100px">操作</th>
          </tr>
          <tr id="row1" class="a-center">
          	<th class="stepID">1</th>
	          <td class="w-p50">
	          		<textarea name="steps" id="steps" rows="3" class="w-p100"></textarea>
	          </td>
			  <td>
			  	<textarea name="expects" id="expects" rows="3" class="w-p100"></textarea>
			  </td>
			  <td class="a-left w-100px"><nobr>
			  	<input type="button" tabindex="-1" class="addbutton" onclick="preInsert(1)" value="之前添加"><br>
			  	<input type="button" tabindex="-1" class="addbutton" onclick="postInsert(1)" value="之后添加"><br>
			  	<input type="button" tabindex="-1" class="delbutton" onclick="deleteRow(1)" value="删除"><br></nobr>
			  </td>
		  </tr>
			 
		  <tr id="row2" class="a-center">
			  <th class="stepID">2</th>
			  <td class="w-p50">
			  		<textarea name="steps" id="steps" rows="3" class="w-p100"></textarea>
              </td>
              <td>
              		<textarea name="expects" id="expects" rows="3" class="w-p100"></textarea>
			  </td>
			  <td class="a-left w-100px"><nobr>
				  <input type="button" tabindex="-1" class="addbutton" onclick="preInsert(2)" value="之前添加"><br>
				  <input type="button" tabindex="-1" class="addbutton" onclick="postInsert(2)" value="之后添加"><br>
				  <input type="button" tabindex="-1" class="delbutton" onclick="deleteRow(2)" value="删除"><br></nobr>
			  </td>
			</tr>
			<tr id="row3" class="a-center">
				<th class="stepID">3</th>
				<td class="w-p50">
					<textarea name="steps" id="steps" rows="3" class="w-p100"></textarea>
				</td>
				<td>
					<textarea name="expects" id="expects" rows="3" class="w-p100"></textarea>
				</td>
				<td class="a-left w-100px"><nobr>
					<input type="button" tabindex="-1" class="addbutton" onclick="preInsert(3)" value="之前添加"><br>
					<input type="button" tabindex="-1" class="addbutton" onclick="postInsert(3)" value="之后添加"><br>
					<input type="button" tabindex="-1" class="delbutton" onclick="deleteRow(3)" value="删除"><br></nobr>
				</td>
			</tr>
		</tbody>
		</table>
      </td> 
    </tr>
    <tr>
      <th class="rowhead">关键词</th>
      <td><input type="text" name="keywords" id="keywords" value="" class="text-1"></td>
    </tr>  
     <tr>
      <th class="rowhead">附件</th>
      <td>
		   <div id="fileform">
			     <div class="fileBox" id="fileBox1">
			    	<input type="file" name="files" class="fileControl" tabindex="-1">
			    	<label tabindex="-1" class="fileLabel">标题：</label>
			    	<input type="text" name="labels" class="text-3" tabindex="-1" style="width: 961px;"> 
			    	<a href="javascript:void();" onclick="addFile(this)" class="link-icon"><i class="icon-add"></i></a>
			    	<a href="javascript:void();" onclick="delFile(this)" class="link-icon"><i class="icon-delete"></i></a>
			  	</div>  
			  	<div class="fileBox" id="fileBox2">
			    	<input type="file" name="files" class="fileControl" tabindex="-1">
			    	<label tabindex="-1" class="fileLabel">标题：</label>
			    	<input type="text" name="labels" class="text-3" tabindex="-1" style="width: 961px;"> 
			    	<a href="javascript:void();" onclick="addFile(this)" class="link-icon"><i class="icon-add"></i></a>
			    	<a href="javascript:void();" onclick="delFile(this)" class="link-icon"><i class="icon-delete"></i></a>
			    </div>
		  </div>
<script type="text/javascript">
$(function()
{
    var maxUploadInfo = maxFilesize();
    parentTag = $('#fileform').parent();
    if(parentTag.attr('tagName') == 'TD') parentTag.parent().find('th').append(maxUploadInfo); 
    if(parentTag.attr('tagName') == 'FIELDSET') parentTag.find('legend').append(maxUploadInfo);
});

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
</td>
    </tr>  
    <tr>
      <td colspan="2" class="a-center"> <input type="submit" id="submit" value="保存" class="button-s"> <input type="button" onclick="javascript:history.go(-1);" value="返回" class="button-b"> </td>
    </tr>
  </tbody>
  </table>
</form>
</div>
  <div id="divider"></div>
</div>
<div id="footer">
  <div id="crumbs">
    <a href="http://test.demo.zentao.net/my/">禅道管理</a>
&nbsp;<span class="icon-angle-right"></span><a href="">用例</a>
&nbsp;<span class="icon-angle-right"></span><a href="">2:都懂点</a>
&nbsp;<span class="icon-angle-right"></span>用例管理&nbsp;<span class="icon-angle-right"></span>建用例  </div>

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