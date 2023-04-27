<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<div class="side-menu inline bg-gray">
	<ul class="menu-list">
		<li class="menu-item active-item" ><li><a href="${context}/tm/list">팀 관리</a></li>
		<li class="menu-item" ><li><a href="${context}/dep/mbrlist">팀원 관리</a></li>
		<li class="menu-item" >ABC</li>
		<li class="menu-item" >ABC</li>	
	</ul>
</div>