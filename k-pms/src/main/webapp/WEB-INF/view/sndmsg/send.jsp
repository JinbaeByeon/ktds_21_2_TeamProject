<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp"/>
<script type="text/javascript">
	$().ready(function() {
		$("#my_pc").click(function() {
			movePage(0)
		});
	});
	function movePage(pageNo) {
		var 
		location
	}
	 
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp"/>
		<div>
			<jsp:include page="../include/msgSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp"/>
			<div class="path">쪽지 > 쪽지보내기</div>
			<form id="create-form">
				<div class="create-group">
					<label for="rcvr">받는사람</label>
					<input type="text" id="rcvr" name="rcvr" value="${sndMsgVO.crtr}"/>
				</div>
				<div class="create-group">
					<label for="title">제목</label> 
					<input type="text" id="title" name="ttl" value="${sndMsgVO.ttl}"/>
				</div>
				<div class="create-group">
					<label for="file">첨부파일</label> 
					<input type="file" id="file" name="attch" value="${sndMsg.attch}"/><!-- 이게머지 -->
				</div>
				<div class="create-group">
					<textarea name="cntnt"></textarea>
					
				</div>
			</form>
			<div class="align-right">
				<button id="new_btn" class="btn-primary">전송</button>
			</div>
		</div>
	</div>
</body>
</html>