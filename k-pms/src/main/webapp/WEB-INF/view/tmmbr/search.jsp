<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀원 검색</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		$("#cancel-btn").click(function() {
			window.close();
		});
		
		$("#regist-btn").click(function() {
			var checkOne = $("#check-one:checked");
			
			if (checkOne.length == 0) {
				alert("팀원을 선택하세요");
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
		<h1>팀원 검색</h1>
			<div class="search-group">
				<label for="search-keyword-nm">팀명</label>
				<input type="text" id="search-keyword-nm" class="search-input" value="${tmNm}" />
				<button class="search-btn" id="btn-search">검색</button>
			</div>
		<div class="grid">
			<div class="grid-count align-right">
						총 ${tmMbrList.size() > 0 ? tmMbrList.size() : 0}건
			</div>
			<table>
				<thead>
					<tr>
						<th></th>
						<th>직원ID</th>
						<th>이름</th>
						<th>팀명</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty tmMbrList}">
							<c:forEach items="${tmMbrList}"
										var="tmmbr">
								<tr data-empid="${tmmbr.empId}"
									data-fnm="${tmmbr.empVO.fNm}"
									data-lnm="${tmmbr.empVO.lNm}"
									data-tmnm="${tmmbr.tmVO.tmNm}" >
									<td>
										<input type="checkbox" id="all_check" name="all_check" value="${tmNm}" />
									</td>
									<td>${tmmbr.empId}</td>
									<td>${tmmbr.empVO.fNm} ${tmmbr.empVO.lNm}</td>
									<td>${tmmbr.tmVO.tmNm}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4">검색된 팀원이 없습니다.</td>
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