<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 검색</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		$(".list_table > tbody > tr").click(function(){
			$(this).find(".radio_idx").prop("checked",true);
		});

		$("#cancel_btn").click(function() {
			window.close();
		});

		$("#regist_btn").click(function() {
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
	<div class="container search_page">
		<h2>프로젝트 검색</h2>
		<div class="search_wrapper">
			<form>
				<div class="search_box">
					<select>
						<option>프로젝트명</option>
					</select>
					<div class="search_field">
						<input type="text" class="input" name="prjNm" placeholder="Search" value="${prjNm}">
					</div>
					<div class="search-icon">
						<button class="btn-search" id="search-btn">
							<span class="material-symbols-outlined">search</span>
						</button>
					</div>
				</div>
			</form>
		</div>
		<div class="total">총 ${prjList.size() > 0 ? prjList.size() : 0}건</div>
		<table class="list_table search_table">
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
						<c:forEach items="${prjList}" var="prj">
							<tr data-prjid="${prj.prjId}" data-prjnm="${prj.prjNm}"
								data-cstmr="${prj.cstmr}" data-prjstts="${prj.prjStts}"
								class="prjtr">
								<td><input type="radio" id="check-one" name="check-one"
									value="${prj.prjId}" /></td>
								<td>${prj.prjNm}</td>
								<td>${prj.cstmr}</td>
								<td>${prj.prjStts}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4" class="no-items">검색된 프로젝트가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<div class="buttons">
			<button id="regist_btn" class="btn regist">등록</button>
			<button id="cancel_btn" class="btn delete">취소</button>
		</div>
	</div>
</body>
</html>