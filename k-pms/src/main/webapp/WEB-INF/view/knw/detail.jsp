<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	function addPrjFn(data) {

		$("#prjId").val("");
		$("#prjNm").empty();
		$("#cstmr").empty();
		$("#prjStts").empty();

		$("#prjId").val(data.prjid);
		$("#prjNm").append(data.prjnm);
		$("#cstmr").append(data.cstmr);
		$("#prjStts").append(data.prjstts);

	}

	$().ready(
			function() {

				$("#save_btn").click(
						function() {
							console.log($("#create-form").serialize());
							$.post("${context}/api/knw/update", $(
									"#create-form").serialize(), function(
									response) {
								if (response.status == "200 OK") {
									location.href = "${context}/knw/list";
								} else {
									alert(response.errorCode + " / "
											+ response.message);
								}
							});
						});

				$("#cancel_btn").click(function() {
					location.href = "${context}/knw/list"
				});

				$("#addPrj").click(
						function(event) {
							event.preventDefault();
							gnr = window.open("${context}/prj/search", "프로젝트 검색", "width=500, height=500");
						});

				$("#deletePrj").click(function(event) {
					event.preventDefault();
					$("#prjId").val("");
					$("#prjNm").empty();
					$("#cstmr").empty();
					$("#prjStts").empty();
				});

				$(".submit").click(
						function(event) {
							event.preventDefault();
							var commentForm = $(this).closest(".form-commentInfo");
							$.post("${context}/api/knwrpl/create", commentForm.serialize(), function(response) {
								console.log(response);
								if (response.status == "200 OK") {
									location.reload();
								} else {
									alert(response.errorCode + " / " + response.message);
								}
							});
						});

				$(".reply-btn").click(function() {
					event.preventDefault();
					$(this).closest(".reply").closest(".comment").find(".form-commentInfo").show();
				});

				$(".update-btn").click(
						function() {
							$(this).closest(".reply").closest(".comment").find(".form-updateComment").show();
						});

				$(".update-submit").click(
						function() {
							event.preventDefault();
							var commentForm = $(this).closest(".form-updateComment");
							$.post("${context}/api/knwrpl/update", commentForm.serialize(), function(response) {
								console.log(response);
								if (response.status == "200 OK") {
									location.reload();
								} else {
									alert(response.errorCode + " / " + response.message);
								}
							});
						});

				$(".x-btn").click(function() {
					var replyId = $(this).closest(".reply").find(".replyId").val();
					$.post("${context}/api/knwrpl/delete/" + replyId, function(response) {
						if (response.status == "200 OK") {
							location.reload();
						} else {
							alert(response.errorCode + " / " + response.message);
						}
					});
				});

			});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/cmnCdSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />

			<h1>지식 관리 등록</h1>
			<div>
				<form id="create-form">
					<input type="hidden" name="knwId" value="${knwVO.knwId}" />
					<div class="create-group">
						<label for="">프로젝트명</label>
						<div>
							<div class="grid">
								<input type="hidden" id="prjId" name="prjId"
									value="${prjVO.prjId}" />
								<table>
									<thead>
										<tr>
											<th>프로젝트명</th>
											<th>고객사</th>
											<th>프로젝트 상태</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td id="prjNm">${prjVO.prjNm}</td>
											<td id="cstmr">${prjVO.cstmr}</td>
											<td id="prjStts">${prjVO.prjStts}</td>
										</tr>
									</tbody>
								</table>
							</div>
							<button id="addPrj" class="btn-primary">등록</button>
							<button id="deletePrj" class="btn-primary">삭제</button>
						</div>
					</div>
					<div class="create-group">
						<label for="ttl">제목</label> <input type="text" id="ttl" name="ttl"
							value="ttl" />
					</div>
					<div class="create-group">
						<label for="cntnt">내용</label>
						<textarea id="cntnt" name="cntnt">${knwVO.cntnt}</textarea>
					</div>
				</form>
			</div>

			<div class="align-right">
				<button id="save_btn" class="btn-primary">등록</button>
				<button id="cancel_btn" class="btn-delete">취소</button>
			</div>

			<form class="form-commentInfo">
				<input type="hidden" name="knwId" value="${knwVO.knwId}" /> <input
					type="text" class="cnt" name="cnt" placeholder="댓글을 입력해 주세요." />
				<button class="submit">등록</button>
				<hr>
			</form>

			<div id="comments">
				<c:if test="${not empty knwVO.rplList}">
					<c:forEach items="${knwVO.rplList}" var="rplVO">
						<div class="comment">
							<input class="rplId" type="hidden" value="${rplVO.rplId}" />
							<div class="reply">
								<p class="cnt" style="margin-left: ${rplVO.depth * 30}px;">${rplVO.cnt}</p>
								<button class="reply-btn">답글</button>
								<c:if test="${rplVO.crtr eq sessionScope.__USER__.empId}">
									<button class="update-btn">수정</button>
								</c:if>
								<c:if test="${rplVO.crtr eq sessionScope.__USER__.empId}">
									<button>&#10006;</button>
								</c:if>
								<p class="info" >${rplVO.crtr} ${rplVO.crtDt} </p>
							</div>
							<form class="form-commentInfo" hidden="true">
								<input type="hidden" name="knwId" value="${knwVO.knwId}" /> <input
									type="hidden" name="prcdncRplId" value="${rplVO.rplId}" /> <input
									type="text" class="cnt" name="cnt" placeholder="답글을 입력해 주세요." />
								<button class="submit">등록</button>
							</form>
							<form class="form-updateComment" hidden="true">
								<input type="hidden" name="knwId" value="${knwVO.knwId}" /> <input
									type="hidden" name="rplId" value="${rplVO.rplId}" /> <input
									type="text" class="cnt" name="cnt" placeholder="${rplVO.cnt}"
									value="${rplVO.cnt}" />
								<button class="update-submit">완료</button>
							</form>
							<hr>
						</div>
					</c:forEach>
				</c:if>
			</div>


			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>