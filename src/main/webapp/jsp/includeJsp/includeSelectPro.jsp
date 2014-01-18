<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	var showProjectsMenu = function() {
		if ($('#dropMenu').css('display') != 'block') {
			$('#dropMenu').css({
				top : '125px',
				left : '20px',
				display : 'block'
			});
			var innerdiv = "<div id='searchResult'><div id='defaultMenu' class='f-left'><ul>";
			<c:forEach items="${comProjects}" var="project">
			innerdiv += "<li><a href='changeCurProject.htm?projectId=${project.projectId }'>${project.name }</a>";
			</c:forEach>
			innerdiv += "</ul></div></div>";
			$('#dropMenu').append(innerdiv);
		} else {
			$('#searchResult').remove();
			$('#dropMenu').css({
				display : 'none'
			});
		}
	}
</script>
<li>
	<div id='currentItem'>
		<a onclick="showProjectsMenu()">${curProject.name }<span
			id='dropIcon'></span></a>
	</div>
	<div id='dropMenu'></div>
</li>