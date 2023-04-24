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

		$("#search-btn").click(function() {
			location.href = "${context}/prjtmmbr/search?nm=" + $("#search-prjTmMbrNm").val();
		});
		
		$("#all_check").change(function() {
			$(".check-idx").prop("checked", $(this).prop("checked"));
		});
		
		$(".check-idx").change(function() {
			var count = $(".check-idx").length;
			var checkCount = $(".check-idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("#cancel-btn").click(function() {
			window.close();
		});
		
		$("#regist-btn").click(function() {
			var checkOne = $(".check-idx:checked");
			
			if (checkOne.length == 0) {
				alert("팀원을 선택하세요");
				return;
			}
			
			checkOne.each(function() {
				var each = $(this).closest("tr").data();
				console.log(each);
				opener.addTmMbrFn(each);
			});
			window.close();
		});
		
	});
</script>
</head>
<body>
	<div class="search-popup content">
		<h1>프로젝트 팀원 검색</h1>
			<div class="search-group">
				<label for="search-prjTmMbrNm">프로젝트 팀원명</label>
				<input type="text" id="search-prjTmMbrNm" class="grow-1 mr-10" value="${prjTmMbrSearchVO.nm}"/>
				<button class="btn-search" id="search-btn">검색</button>
			</div>
		<div class="grid">
			<div class="grid-count align-right">
						총 ${tmMbrList.size() > 0 ? tmMbrList.size() : 0}건
			</div>
			<table>
				<thead>
					<tr>
						<th><input type="checkbox" id="all_check" /></th>
						<th>직원ID</th>
						<th>성</th>
						<th>이름</th>
						<th>권한</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty ptmList}">
							<c:forEach items="${ptmList}"
										var="ptm">
								<tr 
									data-prjtmmbrid="${ptm.prjTmMbrId}"
									data-empid="${ptm.tmMbrVO.empId}"
									data-fnm="${ptm.tmMbrVO.empVO.fNm}"
									data-lnm="${ptm.tmMbrVO.empVO.lNm}"
									data-prjpstn="${ptm.prjPstn}" >
									<td>
										<input type="checkbox" class="check-idx" value="${tmmbr.tmId}" />
									</td>
									<td>${ptm.tmMbrVO.empId}</td>
									<td>${ptm.tmMbrVO.empVO.fNm}</td>
									<td>${ptm.tmMbrVO.empVO.lNm}</td>
									<td>${ptm.prjPstn}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="5">검색된 팀원이 없습니다.</td>
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