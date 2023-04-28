<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set scope="request" var="selected" value="msg"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp"/>
<script type="text/javascript">
	$().ready(function() {
		$("#reply_btn").click(function() {
			// 1. 체크된 VALUE(rcvmsg.msgid)를 가져온다.
			// 2. location.href = "${context}/sndmsg/send/"+rcvmsg.msgid;
			
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function() {
				console.log($(this).val());
				form.append("<input type='hidden' name='msgId' value='"+ $(this).val() +"'>");
			});
			
			$.post("${context}/api/rcvmsg/send/",form.serialize(), function(response) {
				if (response.status == "200 OK") {
					location.reload();
				} else {
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		
		$("#delete_btn").click(function() {
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function() {
				console.log($(this).val());
				form.append("<input type='hidden' name='rcvMsgIdList' value='"+ $(this).val() +"'>");
			});
			
			if(!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			$.post("${context}/api/rcvmsg/delete",form.serialize(), function(response) {
				if (response.status == "200 OK") {
					location.reload();
				}
				else {
					alert(response.status == "500");
				}
			});
		});
	})
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp"/>
		<div>
			<jsp:include page="../include/msgSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp"/>
			<div class="path">쪽지 > 받은쪽지함</div>
		<div class="grid">
				<div class="grid-count">
					<div class="align-left left">
						<button id="reply_btn" class="btn-reply" onclick="location.href='${context}/sndmsg/send'" disabled>답장</button>
						<button id="delete_btn" class="btn-delete" disabled>삭제</button>
					</div>
					<table>
						<thead>
							<tr>
								<th>제목</th>
							</tr>
							<tr>
								<th>보낸사람</th>
							</tr>
							<tr>
								<th>받는사람</th>
							</tr>
							<tr>
								<th>날짜</th>
							</tr>
						</thead>
						<tbody>
							<div class="create-group">
						<textarea name="cntnt"></textarea>
							</div>
						</tbody>
					</table>
</body>
</html>