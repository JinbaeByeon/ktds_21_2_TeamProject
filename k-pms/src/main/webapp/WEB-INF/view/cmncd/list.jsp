<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	$().ready(function() {
		$("#save_btn").click(function() {

			if ($("#isModify").val() == "false") {
				// 신규 등록
				$.post("${context}/cmncd/create", {cdNm: $("#cdNm").val(), useYn: $("#useYn:checked").val()}, function() {
					location.reload();
				});
			} else {
				// 수정
				$.post("${context}/gnr/update", $("#detail_form").serialize(), function(response) {
					location.reload();
				});
			}

		});
	});
</script>
</head>
<body>
	<table>
		<thead>
			<tr>
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
						<tr data-gnrid="${cmnCd.cdId}" data-gnrnm="${cmnCd.cdNm}"
							data-useyn="${cmnCd.prcdncCdId}" data-crtr="${cmnCd.crtr}"
							data-crtdt="${cmnCd.crtDt}" data-mdfyr="${cmnCd.mdfyr}"
							data-mdftdt="${cmnCd.mdfyDt}" data-useyn="${cmnCd.useYn}">
							<td><input type="checkbox" class="check_idx"
								value="${cmnCd.cdId}"></td>
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
	<div>
		<form id="detail_form">
			<!-- isModify == true : 수정(update)-->
			<!-- isModify == false : 등록(insert) -->
			<input type="hidden" id="isModify" value="false" />
			<div>
				<div>
					<label for="cdId" style="width: 180px;">코드ID</label> <input
						type="text" id="cdId" name="cdId" readonly value="">
				</div>
				<div>
					<label for="cdNm" style="width: 180px;">코드명</label> <input
						type="text" id="cdNm" name="cdNm">
				</div>
				<div>
					<label for="prcdncCdId" style="width: 180px;">상위코드ID</label> <input
						type="text" id="prcdncCdId" name="prcdncCdId">
				</div>
				<div>
					<label for="crtr" style="width: 180px;">등록자</label> <input
						type="text" id="crtr" name="crtr" disabled value="">
				</div>
				<div>
					<label for="crtDt" style="width: 180px;">등록일</label> <input
						type="text" id="crtDt" disabled value="">
				</div>
				<div>
					<label for="mdfyr" style="width: 180px;">수정자</label> <input
						type="text" id="mdfyr" disabled value="">
				</div>
				<div>
					<label for="mdftDt" style="width: 180px;">수정일</label> <input
						type="text" id="mdftDt" disabled value="">
				</div>
				<div>
					<label for="useYn" style="width: 180px;">사용여부</label> <input
						type="checkbox" id="useYn" name="useYn" value="Y" checked>
				</div>
			</div>
		</form>
	</div>
	<div>
		<button id="new_btn" class="btn-primary">신규</button>
		<button id="save_btn" class="btn-primary">저장</button>
		<button id="delete_btn" class="btn-delete">삭제</button>
	</div>
</body>
</html>