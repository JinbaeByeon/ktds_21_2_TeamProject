<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		
		$("#cancel_btn").click(function() {
			window.close();	
		});
		
		$("#regist_btn").click(function() {
			
			var checkbox = $(".check_idx:checked");
			if (checkbox.length == 0) {
				alert("팀을 선택하세요");
				return;
			}
			
			checkbox.each(function() {
				var each = $(this).closest("tr").data();
				console.log(each);
				opener.addTmFn(each);
			});
		});
		
	});
</script>
</head>
<body>
	<div class="search-popup content">
		<h1>팀 검색</h1>
		<form>
			<div class="search-group">
				<label for="">팀명</label>
				<input type="text" name="tmNm" class="grow-1 mr-10" value="${tmNm}"/>
				<button class="btn-search" id="btn-search-btn">검색</button>
			</div>
		</form>
		<div class="grid">
			<div class="grid-count align-right">
						총 ${tmList.size() > 0 ? tmList.size() : 0}건
			</div>
			<table>
				<thead>
					<tr>
						<th>
							<input type="checkbox" />
						</th>
						<th>팀명</th>
						<th>팀ID</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty tmList}">
							<c:forEach items="${tmList}" var="tm">
								<tr data-tmid="${tm.tmId}"
									data-tmnm="${tm.tmNm}">
									<td>
										<input type="checkbox" name="check_idx" class="check_idx" value="${tm.tmId}" />
									</td>
									<td>${tm.tmNm}</td>
									<td>${tm.tmId}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="3">검색된 팀이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<div class="align-right">
					<button id="cancel_btn" class="btn-delete">취소</button>
					<button id="regist_btn" class="btn-primary">등록</button>
		</div>
	</div>
</body>
</html>