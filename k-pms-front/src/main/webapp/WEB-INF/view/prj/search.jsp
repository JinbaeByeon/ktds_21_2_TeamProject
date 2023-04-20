<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 검색</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		$("#cancel-btn").click(function() {
			window.close();
		});
		
		$("#regist-btn").click(function() {
			var checkOne = $("#check-one:checked");
			
			if (checkOne.length == 0) {
				alert("프로젝트를 선택하세요");
				return;
			}
			
			checkOne.each(function() {
				var each = $(this).closest("tr").data();
				console.log(each);
				opener.addPrjFn(each);
			});
			window.close();
		});
		
	});
</script>
</head>
<body>
	<div class="search-popup content">
		<h1>프로젝트 검색</h1>
		<form>
			<div class="search-group">
				<label for="prjNm">프로젝트명</label>
				<input type="text" name="prjNm" class="grow-1 mr-10" value="${prjNm}"/>
				<button class="search-btn" id="btn-search">검색</button>
			</div>
		</form>
		<div class="grid">
			<div class="grid-count align-right">
						총 ${prjList.size() > 0 ? prjList.size() : 0}건
			</div>
			<table>
				<thead>
					<tr>
						<th></th>
						<th>프로젝트명</th>
						<th>고객사</th>
						<th>프로젝트 상태</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty prjList}">
							<c:forEach items="${prjList}"
										var="prj">
								<tr data-prjid="${prj.prjId}"
									data-prjnm="${prj.prjNm}"
									data-cstmr="${prj.cstmr}"
									data-prjstts="${prj.prjStts}" >
									<td>
										<input type="radio" id="check-one" name="check-one" value="${prj.prjId}" />
									</td>
									<td>${prj.prjNm}</td>
									<td>${prj.cstmr}</td>
									<td>${prj.prjStts}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4">검색된 프로젝트가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<div class="align-right">
			<button id="regist-btn" class="btn-primary">등록</button>
			<button id="cancel-btn" class="btn-delete">취소</button>
		</div>
	</div>
</body>
</html>