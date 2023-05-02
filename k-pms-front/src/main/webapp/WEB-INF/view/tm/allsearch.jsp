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
			$("#all_check").prop("checked", false);
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
		
		$("#search-btn").click(function() {
			location.href = "${context}/tm/search?tmNm=" + $("#searh-tmNm").val();
		});
		
		$("#all_check").change(function() {
			$(".check-idx").prop("checked", $(this).prop("checked"));
		});
		
		$(document).on("change",".check-idx" , function() {
			var count = $(".check-idx").length;
			var checkCount = $(".check-idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("#cancel-btn").click(function() {
			window.close();
		});
		
		$("#regist_btn").click(function() {
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
	<div class="container search_page">
    <h2>팀원 추가</h2>
    <div class="scroll_div">
    	<h3>팀</h3>
	    <table class="list_table search_table scroll_table">
	        <thead>
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
    </div>
    <div style="height: 30px;"></div>
    <h3>팀원</h3>
    <div class="scroll_div">
	    <table class="list_table search_table scroll_table">
	        <thead>
	            <tr>
					<th class="input"><input type="checkbox" id="all_check" /></th>
                    <th>직원ID</th>
                    <th>성</th>
                    <th>이름</th>
	            </tr>
	        </thead>
	        <tbody class="tmmbr-tbody"></tbody>
	    </table>
	</div>
    
    <div class="buttons">
        <button id="cancel_btn" class="btn delete">취소</button>
        <button id="regist_btn" class="btn regist">등록</button>
    </div>
</div>
</body>
</html>