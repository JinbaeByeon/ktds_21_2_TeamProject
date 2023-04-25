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
		
		$(".tm-tbody tr").click(function() {
			$(".tm-tbody").find("tr").removeClass("active");
			$(this).toggleClass("active");
			var activeTmId = $(".active").data("tmid");
			
			$(".tmmbr-tbody").find("tr").remove();

			$.get("${context}/api/tmmbr/list/" + activeTmId, function(response) {
				for (var i in response.data) {
					var tmmbrId = response.data[i].tmMbrId;
					var tmId = response.data[i].tmId;
					var empId = response.data[i].empId;
					var fNm = (response.data[i].empVO.fNm == null) ? "" : response.data[i].empVO.fNm;
					var lNm = (response.data[i].empVO.lNm == null) ? "" : response.data[i].empVO.lNm;
					var tmNm = response.data[i].tmVO.tmNm;
					
					var tr = $("<tr data-tmmbrid='" + tmmbrId + "'data-empid='" + empId + "'data-tmid='" + tmId + "'data-fnm='" + fNm + "'data-lnm='" + lNm + "'data-tmnm='" + tmNm + "'></tr>");
					var td = "<td><input type='checkbox' class='check-idx' value=" + tmmbrId + " /></td>"
					td += "<td>" + empId + "</td>"
					td += "<td>" + fNm + "</td>"
					td += "<td>" + lNm + "</td>"
					
					$(".tmmbr-tbody").append(tr);
					tr.append(td);
				}
			})

		});
		
/* 		$('.check-idx').change(function() {
			if ($(this).prop("checked") == true) {
				 $(this).closest("tr").toggleClass("active")
			}
			else {
				 $(this).closest("tr").removeClass("active")
			 }
		}); */
		
		$("#search-btn").click(function() {
			location.href = "${context}/tm/search?tmNm=" + $("#searh-tmNm").val();
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
		<h1>팀원 추가</h1>
			<table class="scroll-table">
				<thead>
					<tr><th colspan=2 class="table-title">- 팀</th></tr>
					<tr>
						<th>팀ID</th>
						<th>팀명</th>
					</tr>
				</thead>
				<tbody class="tm-tbody">
					<c:choose>
						<c:when test="${not empty tmList}">
							<c:forEach items="${tmList}" var="tm">
								<tr data-tmid="${tm.tmId}"
									data-tmnm="${tm.tmNm}">
									<td>${tm.tmId}</td>
									<td>${tm.tmNm}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="2">검색된 팀이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		
			<table class="scroll-table">
				<thead>
					<tr><th colspan=4 class="table-title">- 팀원</th></tr>
					<tr>
						<th class="input"><input type="checkbox" id="all_check" /></th>
						<th>직원ID</th>
						<th>성</th>
						<th>이름</th>
					</tr>
				</thead>
				<tbody class="tmmbr-tbody"></tbody>
			</table>
		
		
		<div class="align-right">
			<button id="regist-btn" class="btn-primary">등록</button>
			<button id="cancel-btn" class="btn-delete">취소</button>
		</div>
	</div>
</body>
</html>