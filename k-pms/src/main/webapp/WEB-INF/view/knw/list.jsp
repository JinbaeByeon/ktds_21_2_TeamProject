<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(
			function() {
				$("#save_btn").click(
						function() {

							if ($("#isModify").val() == "false") {
								// 신규 등록
								$.post("${context}/knw/create", $(
										"#detail_form").serialize(),
										function() {
											location.reload();
										});
							} else {
								// 수정
								$.post("${context}/knw/update", $(
										"#detail_form").serialize(), function(
										response) {
									location.reload();
								});
							}

						});

				$("#new_btn").click(function() {
					location.href = "${context}/knw/create";
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

			<div class="search-group">
				<label for="search-keyword">제목</label> <input type="text"
					id="search-keyword" class="search-input" value="${cmnCdVO.cdNm}" />
				<div class="search-keyword1">
					<button class="btn-search" id="search-btn">&#128269;</button>
				</div>
			</div>
			<div class="grid">
				<div class="grid-count align-right">총 ${knwList.size() > 0 ? knwList.size() : 0}
					건</div>
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="all_check"></th>
							<th>지식관리ID</th>
							<th>제목</th>
							<th>내용</th>
							<th>조회수</th>
							<th>프로젝트ID</th>
							<th>등록자</th>
							<th>등록일</th>
							<th>수정자</th>
							<th>수정일</th>
							<th>사용여부</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty knwList}">
								<c:forEach items="${knwList}" var="knw">
									<tr data-knwid="${knw.knwId}" data-ttl="${knw.ttl}"
										data-cntnt="${knw.cntnt}" data-vwcnt="${knw.vwCnt}"
										data-prjId="${knw.prjId}" data-crtr="${knw.crtr}"
										data-crtdt="${knw.crtDt}" data-mdfyr="${knw.mdfyr}"
										data-mdfydt="${knw.mdfyDt}" data-useyn="${knw.useYn}">
										<td><input type="checkbox" class="check_idx"
											value="${knw.knwId}"></td>
										<td>${knw.knwId}</td>
										<td>${knw.ttl}</td>
										<td>${knw.cntnt}</td>
										<td>${knw.vwCnt}</td>
										<td>${knw.prjId}</td>
										<td>${knw.crtr}</td>
										<td>${knw.crtDt}</td>
										<td>${knw.mdfyr}</td>
										<td>${knw.mdfyDt}</td>
										<td>${knw.useYn}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="12" class="no-items">등록된 지식이 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<div class="align-right">
				<button id="new_btn" class="btn-primary">신규</button>
				<button id="save_btn" class="btn-primary">저장</button>
				<button id="delete_btn" class="btn-delete">삭제</button>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>