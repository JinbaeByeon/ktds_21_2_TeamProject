<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직무 검색</title>
<jsp:include page="../include/stylescript.jsp"/>
<script type="text/javascript"> <!-- -->
	$().ready(function() {
		
		function checkIndex(){
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		}
		
		$(".check_idx").change(function(){
			checkIndex();
		});
		
		$(".list_table > tbody > tr > td").not(".check").click(function(){
			var check_idx = $(this).closest("tr").find(".check_idx");
			check_idx.prop("checked",check_idx.prop("checked")==false);
			checkIndex();
		});
		
		$("#cancel_btn").click(function() {
			window.close();
		});
		
		$("#regist_btn").click(function() {
			var checkbox = $(".check_idx:checked");
			if (checkbox.length == 0) {
				alert("직무를 선택하세요.");
				return;
			}
			
			checkbox.each(function() {
				var each = $(this).closest("tr").data();
				opener.addJobFn(each);
			});
		});
	});

</script>
</head>
<body>
	<div class="container search_page">
    <h2>직무 검색</h2>
    <div class="search_wrapper">
    	<form>
	        <div class="search_box">
	            <select>
	            <option>직무명</option>
	            </select>
	            <div class="search_field">
	            	<input type="text" id="jobNm" name="jobNm" class="input" value="${jobNm}"/>
	            </div>
	            <div class="search-icon">
		          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
		         </div>
	        </div>
	  	</form>
    </div>
    <div class="total">총${jobList.size()}건</div>
    <table class="list_table search_table">
        <thead>
            <tr>
                 <th></th>
                 <th>직무명</th>
                 <th>직무 관리번호</th>
            </tr>
        </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty jobList}">
                        <c:forEach items="${jobList}" var="job">
                            <tr data-jobid="${job.jobId}"
                                data-jobnm="${job.jobNm}">
                                <td class="check"> 
                                    <input type="radio" name="check_idx" class="check_idx" value="${job.jobId}"/>
                                </td>
                                <td>${job.jobNm}</td>
                                <td>${job.jobId}</td>
                            </tr>
                        </c:forEach>
                    </c:when>
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