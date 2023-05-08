<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		$("#all_check").change(function(){
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		$(".check_idx").change(function(){
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("#cancel_btn").click(function(){
			window.close();	
		});
		
		$("#regist_btn").click(function(){
			var checkbox = $(".check_idx:checked");
			if(checkbox.length == 0) {
				alert("비품을 선택하세요");
				return;
			}
			checkbox.each(function(){
				var each = $(this).closest("tr").data();
				opener.addEqpFn(each);
			});
		});
	});
</script>
</head>
<body>
	<div class="search-popup content">
		<h1>비품검색</h1>
		<form>
			<div class="search-group">
				<label for="">비품명</label>
				<input type="text" name="eqpNm" class="grow-1 mr-10" value="${eqpNm}"/>
				<button class="btn-search" id="btn-search-btn">검색</button>
			</div>
		</form>
		<div class="grid">
			<div class="grid-count align-right">
						총 ${eqpList.size() > 0 ? eqpList.size() : 0}건
			</div>
			<table>
				<thead>
					<tr>
						<th>
							<input type="checkbox" id="all_check" />
						</th>
						<th>비품명</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty eqpList}">
							<c:forEach items="${eqpList}" var="eqp">
								<tr data-eqpid = "${eqp.eqpId}"
									data-eqpnm = "${eqp.eqpNm}"}>
									<td>
										<input type="checkbox" class="check_idx" value="${eqp.eqpId}" />
									</td>
									<td>${eqp.eqpNm}</td>
									<td>${eqp.crtDt}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="3">검색된 비품이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<div class="align-right">
					<button id="regist_btn" class="btn-primary">등록</button>
					<button id="cancel_btn" class="btn-delete">취소</button>
		</div>
	</div>
</body>
</html>