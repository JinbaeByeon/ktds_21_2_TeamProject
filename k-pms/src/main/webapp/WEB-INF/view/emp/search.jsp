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
<title>직원 검색 페이지</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		$("#all_check").change(function(){
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		function checkIndex(){
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		}
		
		$(".check_idx").change(function(){
			checkIndex();
		});
		
		$(".grid > table > tbody > tr > td").not(".check").click(function(){
			var check_idx = $(this).closest("tr").find(".check_idx");
			check_idx.prop("checked",check_idx.prop("checked")==false);
			checkIndex();
		});
		
		$("#cancel_btn").click(function(){
			window.close();	
		});
		
		$("#regist_btn").click(function(){
			var checkbox = $(".check_idx:checked");
			if(checkbox.length == 0) {
				alert("직원을 선택하세요");
				return;
			}
			checkbox.each(function(){
				var emp = $(this).closest("tr").data();
				opener.addEmpFn(emp);
			});
		});
	});
</script>
</head>
<body>
	<div class="search-popup content">
		<h1>직원검색</h1>
		<form>
			<input type="hidden" name="depId" value="${depId}">
			<div class="search-group">
				<label for="">직원명</label>
				<input type="text" name="fNm" class="grow-1 mr-10" value="${fNm}"/>
				<button class="btn-search" id="search-btn">검색</button>
			</div>
		</form>
		<div class="grid">
			<div class="grid-count align-right">
						총 ${empList.size() > 0 ? empList.size() : 0}건
			</div>
			<table>
				<thead>
					<tr>
						<th>
							<input type="checkbox" id="all_check" />
						</th>
						<th>이름</th>
						<th>성</th>
						<th>부서ID</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty empList}">
							<c:forEach items="${empList}" var="emp">
								<tr data-empid = "${emp.empId}"
									data-fnm = "${emp.fNm}"
									data-lnm = "${emp.lNm}">
									<td class="check">
										<input type="checkbox" class="check_idx" value="${emp.empId}" />
									</td>
									<td>${emp.fNm}</td>
									<td>${emp.lNm}</td>
									<td>${emp.depId} </td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4">검색된 직원이 없습니다.</td>
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