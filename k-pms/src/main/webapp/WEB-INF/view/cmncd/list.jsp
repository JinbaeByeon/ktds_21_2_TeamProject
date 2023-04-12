<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

				$("table > tbody > tr").click(function() {
					$("#isModify").val("true"); // 수정모드
					var data = $(this).data();
					console.log(data);

					$("#cdId").val(data.cdid);
					$("#cdNm").val(data.cdnm);
					$("#prcdncCdId").val(data.prcdnccdid);
					$("#crtr").val(data.crtr);
					$("#crtDt").val(data.crtdt);
					$("#mdfyr").val(data.mdfyr);
					$("#mdfyDt").val(data.mdfydt);

					$("#useYn").prop("checked", data.useyn == "Y");
				});

				$("#new_btn").click(function() {
					$("#isModify").val("false"); // 등록모드

					$("#gnrId").val("");
					$("#gnrNm").val("");
					$("#prcdncCdId").val("");
					$("#crtDt").val("");
					$("#mdfyr").val("");
					$("#mdftDt").val("");

					$("#useYn").prop("checked", false);
				});

				$("#save_btn").click(
						function() {

							if ($("#isModify").val() == "false") {
								// 신규 등록
								$.post("${context}/api/cmncd/create", $(
										"#detail_form").serialize(), function(
										response) {
									if (response.status == "200 OK") {
										location.reload(); //새로고침
									} else {
										alert(response.errorCode + " / "
												+ response.message);
									}
								});
							} else {
								// 수정
								$.post("${context}/api/cmncd/update", $(
										"#detail_form").serialize(), function(
										response) {
									if (response.status == "200 OK") {
										location.reload(); //새로고침
									} else {
										alert(response.errorCode + " / "
												+ response.message);
									}
								});
							}

						});

				$("#delete_btn").click(
						function() {
							var cdId = $("#cdId").val();
							if (cdId == "") {
								alert("선택된 공통코드가 없습니다.");
								return;
							}

							if (!confirm("정말 삭제하시겠습니까?")) {
								return;
							}

							$.get("${context}/api/cmncd/delete/" + cdId,
									function(response) {
										if (response.status == "200 OK") {
											location.reload(); //새로고침
										} else {
											alert(response.errorCode + " / "
													+ response.message);
										}
									});
						});

				$("#search-btn").click(function() {
					movePage(0);
				});

			});

	function movePage(pageNo) {
		// 전송
		// 입력값
		var cdNm = $("#search-keyword").val();
		// URL 요청
		location.href = "${context}/cmncd/list?cdNm=" + cdNm + "&pageNo=" + pageNo;

	}
</script>
</head>
<body>

	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/cmnCdSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />

			<div class="search-group">
				<label for="search-keyword">코드명</label> <input type="text"
					id="search-keyword" class="search-input" value="${cmnCdVO.cdNm}" />
				<div class="search-keyword1">
					<button class="btn-search" id="search-btn">&#128269;</button>
				</div>
			</div>
			<div class="grid">
				<div class="grid-count align-right">총 ${cmnCdList.size() > 0 ? cmnCdList.size() : 0} 건</div>
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="all_check"></th>
							<th>코드ID</th>
							<th>코드명</th>
							<th>상위코드ID</th>
							<th>등록자</th>
							<th>등록일</th>
							<th>수정자</th>
							<th>수정일</th>
							<th>사용여부</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty cmnCdList}">
								<c:forEach items="${cmnCdList}" var="cmnCd">
									<tr data-cdid="${cmnCd.cdId}" data-cdNm="${cmnCd.cdNm}"
										data-prcdnccdid="${cmnCd.prcdncCdId}" data-crtr="${cmnCd.crtr}"
										data-crtdt="${cmnCd.crtDt}" data-mdfyr="${cmnCd.mdfyr}"
										data-mdfydt="${cmnCd.mdfyDt}" data-useyn="${cmnCd.useYn}">
										<td><input type="checkbox" class="check_idx"
											value="${cmnCd.cdId}"></td>
										<td>${cmnCd.cdId}</td>
										<td>${cmnCd.cdNm}</td>
										<td>${cmnCd.prcdncCdId}</td>
										<td>${cmnCd.crtr}</td>
										<td>${cmnCd.crtDt}</td>
										<td>${cmnCd.mdfyr}</td>
										<td>${cmnCd.mdfyDt}</td>
										<td>${cmnCd.useYn}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="8" class="no-items">등록된 장르가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<c:import url="../include/pagenate.jsp">
				<c:param name="pageNo" value="${pageNo}" />
				<c:param name="pageCnt" value="${pageCnt}" />
				<c:param name="lastPage" value="${lastPage}" />
				<c:param name="path" value="${context}/cmncd" />
			</c:import>
			<div class="grid-detail">
				<form id="detail_form">
					<!-- isModify == true : 수정(update)-->
					<!-- isModify == false : 등록(insert) -->
					<input type="hidden" id="isModify" value="false" />
					<div class="input-group inline">
						<div class="input-group inline">
							<label for="cdId" style="width: 180px;">코드ID</label> <input
								type="text" id="cdId" name="cdId" value=""
								placeholder="코드유형_코드명">
						</div>
						<div class="input-group inline">
							<label for="cdNm" style="width: 180px;">코드명</label> <input
								type="text" id="cdNm" name="cdNm">
						</div>
						<div class="input-group inline">
							<label for="prcdncCdId" style="width: 180px;">상위코드ID</label> <input
								type="text" id="prcdncCdId" name="prcdncCdId">
						</div>
						<div class="input-group inline">
							<label for="crtr" style="width: 180px;">등록자</label> <input
								type="text" id="crtr" name="crtr" disabled value="">
						</div>
						<div class="input-group inline">
							<label for="crtDt" style="width: 180px;">등록일</label> <input
								type="text" id="crtDt" disabled value="">
						</div>
						<div class="input-group inline">
							<label for="mdfyr" style="width: 180px;">수정자</label> <input
								type="text" id="mdfyr" disabled value="">
						</div>
						<div class="input-group inline">
							<label for="mdftDt" style="width: 180px;">수정일</label> <input
								type="text" id="mdfyDt" disabled value="">
						</div>
						<div class="input-group inline">
							<label for="useYn" style="width: 180px;">사용여부</label> <input
								type="checkbox" id="useYn" name="useYn" value="Y" checked>
						</div>
					</div>
				</form>
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