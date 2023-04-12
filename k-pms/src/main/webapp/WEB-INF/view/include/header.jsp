<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"/>

<div class="header bg-black">
	<ul class="nav">
		<li class="nav-item" data-menu="emp"><a href="${context}/emp/list">회원관리</a></li>
		<li class="nav-item" data-menu="dep"><a href="${context}/dep/list">부서관리</a></li>
		<li class="nav-item" data-menu="eqp"><a href="${context}/eqp/list">비품관리</a></li>
		<li class="nav-item" data-menu="prj"><a href="${context}/prj/list">프로젝트관리</a></li>
		<li class="nav-item" data-menu="sys"><a href="${context}/sys/list">시스템관리</a></li>
	</ul>
	<div class="inline profile">
		${sessionScope.__USER__.fNm} <a href="${context}/emp/lgt">(Logout)</a>
	</div>
</div>