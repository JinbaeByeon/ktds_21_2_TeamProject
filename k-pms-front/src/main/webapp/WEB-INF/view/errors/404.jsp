<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set scope="request" var="selected" value="prj"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {});
</script>
</head>
<body>
	<div class="main-layout">
		<div style="text-align: center;">
			<img src="${context}/img/error_404.png" alt="Trulli" style="height: 99vh;">
			<div
				style="position: absolute; bottom: 50px; left: 0; right: 0; text-align: center;">
				<span style="font-size: 24px;"><a href="${context}/index">홈으로 가기</a></span>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>