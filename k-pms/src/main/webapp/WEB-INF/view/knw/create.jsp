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
							
							if()
							$.post("${context}/api/knw/create", $("#create-form").serialize(), function(response) {
								if (response.status == "200 OK") {
									location.href = "${context}/knw/list";
								} else {
									alert(response.errorCode + " / " + response.message);
								}
							});
						});
				
				$("#cancel_btn").click(function() {
					location.href = "${context}/knw/list"
				});

				$("#addPrj").click(
						function(event) {
							event.preventDefault();
							gnr = window.open("${context}/prj/search",
									"프로젝트 검색", "width=500, height=500");
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
								<input type="hidden" id="prjId" name="prjId" />
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
											<td id="prjNm"></td>
											<td id="cstmr"></td>
											<td id="prjStts"></td>
										</tr>
									</tbody>
								</table>
							</div>
							<button id="addPrj" class="btn-primary">등록</button>
						</div>
					</div>
					<div class="create-group">
						<label for="ttl">제목</label> <input type="text" id="ttl" name="ttl" />
					</div>
					<div class="create-group">
						<label for="cntnt">내용</label>
						<textarea id="cntnt" name="cntnt"></textarea>
					</div>
				</form>
			</div>

			<div class="align-right">
				<button id="save_btn" class="btn-primary">등록</button>
				<button id="cancel_btn" class="btn-delete">취소</button>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>