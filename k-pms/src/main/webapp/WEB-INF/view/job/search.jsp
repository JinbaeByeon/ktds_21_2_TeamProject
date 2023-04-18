<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		
		$(".grid > table > tbody > tr > td").not(".check").click(function(){
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

	<div class="search-popup content">
		<h1>직무검색</h1>
		<form>
			<div class="search-group">
				<label for="jobNm">직무명</label>
				<input type="text" id="jobNm" name="jobNm" class="grow-1 mr-10" value="${jobNm}"/>
				<button class="btn-search" id="search-btn">검색</button>
			</div>
		</form>
		<div class = "grid">
			<div class = "grid-count align-right">
				총${jobList.size()}건
			</div>
			<table>
				<thead>
					<tr>
						<th>
						</th>
						<th>직무명</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty jobList}">
							<c:forEach items="${jobList}" var="job">
								<tr data-jobid="${job.jobId}"
									data-jobnm="${job.jobNm}">
									<td>  
										<input type="radio" name="check_idx" class="check_idx" value="${job.jobId}"/>
									</td>
									<td>${job.jobNm}</td>
									<td>${job.crtDt}</td>
								</tr>
							</c:forEach>
						</c:when>
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