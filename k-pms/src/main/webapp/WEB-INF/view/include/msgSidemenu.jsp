<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />

	<div class="side-menu inline bg-gray">
		<ul class="menu-list">
			<li class="menu-item active-item" >
				<a href="${context}/sndmsg/send">쪽지보내기</a>
			</li>
			<li class="menu-item active-item" >
				<a href="${context}/rcvmsg/list">받은쪽지함</a>
			</li>
			<li class="menu-item active-item" >
				<a href="${context}/sndmsg/list">보낸쪽지함</a>
			</li>
			<li class="menu-item line">
			</li>
			<li class="menu-item active-item" >
				<a href="${context}/msg/trash">휴지통</a>
			</li>
		</ul>
	</div>