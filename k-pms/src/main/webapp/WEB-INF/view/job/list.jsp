<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {

		$(".grid > table > tbody > tr").click(function() {
			$("#isModify").val("true");
			var data = $(this).data();
			$("#jobId").val(data.jobid);
			$("#crtDt").val(data.crtdt);
			$("#crtr").val(data.crtr);
			$("#mdfyDt").val(data.mdfydt);
			$("#mdfyr").val(data.mdfyr);
			$("#delYn").val(data.delyn);
			$("#jobNm").val(data.jobnm);

			$("#useYn").prop("checked", data.useyn == "Y");
		});

		$("#new_btn").click(function() {
			$("#isModify").val("false");

			$("#jobId").val("");
			$("#crtDt").val("");
			$("#crtr").val("");
			$("#mdfyDt").val("");
			$("#mdfyr").val("");
			$("#delYn").val("");
			$("#jobNm").val("");

			$("useYn").prop("checked", false);
		});

		$("#delete_btn").click(function() {
			var jobId = $("#jobId").val();
			if (jobId == "") {
				alert("선택된 직무가 없습니다.");
				return;
			}

			if (!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			$.get("${context}/api/job/delete/" + jobId, function(response) {
				if (response.status == "200 OK") {
					location.reload();
				} else {
					alert(response.status == "500");
				}
			});
		});

		$("#save_btn").click(function() {

			if ($("#isModify").val() == "false") {
				// 신규등록
				$.post("${context}/api/job/create", {
					jobNm : $("#jobNm").val(),
					useYn : $("#useYn:checked").val()
				}, function(response) {
					if (response.status == "200 OK") {
						location.reload();
					} else {
						alert(response.status == "500");
					}
				});
			} else {
				$.post("${context}/api/job/update", {
					jobId : $("#jobId").val(),
					jobNm : $("#jobNm").val(),
					useYn : $("#useYn:checked").val()
				}, function(response) {

					if (response.status == "200 OK") {

					} else {
						alert(response.errorCode + "/" + response.message);
					}
				});
			}
		});
		$("#search-btn").click(function() {
			movePage(0)
		});
		
		$("#all_check").change(function() {
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		$(".check_idx").change(function() {
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		
		});
		
		$("#delete_all_btn").click(function() {
			var checkLen = $(".check_idx:checked").length;
			if(checkLen == 0) {
				alert("삭제할 직무가 없습니다.");
				return;
			}
			
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function() {
				console.log($(this).val());
				form.append("<input type='hidden' name='jobId' value='"+ $(this).val() +"'>");
			});
			
			$.post("${context}/api/job/delete", form.serialize(), function(response) {});
			location.reload(); // 새로고침
		});
	});
		function movePage(pageNo) {
			// 전송
			// 입력 값
			var jobNm=$("#search-keyword").val();
			// URL 요청
			location.href= "${context}/job/list?jobNm=" + jobNm + "&pageNo=" + pageNo;
		}

</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp"/>
		<div>
		<jsp:include page="../include/sidemenu.jsp"/>
		<jsp:include page="../include/content.jsp"/>
			<div class="path">직무관리 > </div>
			<div class="search-group">
				<label for="search-keyword">직무명</label>
				<input type="text" id="search-keyword" class="search-input" value="${jobVO.jobNm}"/>
				<button class="btn-search" id="search-btn">&#128269</button>
			</div>
			<div class="grid">
				<div class="grid-count align-right">
					총 ${jobList.size() > 0 ? jobList.get(0).totalCount : 0}건
				</div>
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="all_check"/></th>
							<th>순번</th>
							<th>직무ID</th>
							<th>직무명</th>
							<th>사용여부</th>
							<th>등록자</th>
							<th>등록일</th>
							<th>수정자</th>
							<th>수정일</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty jobList}">
								<c:forEach items="${jobList}"
										   var="job">
									<tr data-jobid="${job.jobId}"
										data-jobnm="${job.jobNm}"
										data-useyn="${job.useYn}"
										data-crtr="${job.crtr}"
										data-crtdt="${job.crtDt}"
										data-mdfyr="${job.mdfyr}"
										data-mdfydt="${job.mdfyDt}">
									<td>
										<input type="checkbox" class="check_idx" value="${job.jobId}"/>
									</td>
									<td>순번</td>
									<td>${job.jobId}</td>
									<td>${job.jobNm}</td>
									<td>${job.useYn}</td>
									<td>${job.crtr}</td>
									<td>${job.crtDt}</td>
									<td>${job.mdfyr}</td>
									<td>${job.mdfyDt}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="9" class="no-items">
										등록된 직무가 없습니다.
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				
				<div class="align-right">
				<button id="delete_all_btn" class="btn-delete">삭제</button>
				</div>
				</div>
				<div class="grid-detail">
				<form id="detail_form" >
				<input type="hidden" id="isModify" value="false" />
					<div class="input-group inline">
						<label for="jobId" style="width: 180px;">직무ID</label><input type="text" id="jobId" name="jobId" value="" readonly/>
					</div>
					<div class="input-group inline">
						<label for="jobNm" style="width: 180px;">직무명</label><input type="text" id="jobNm" name="jobNm" value=""/>
					</div>
					<div class="input-group inline">
						<label for="useYn" style="width: 180px;">사용여부</label><input type="checkBox" id="useYn" name="useYn" value="Y"/>
					</div>
					<div class="input-group inline">
						<label for="crtr" style="width: 180px;">등록자</label><input type="text" id="crtr" disabled value=""/>
					</div>
					<div class="input-group inline">
						<label for="crtDt" style="width: 180px;">등록일</label><input type="text" id="crtDt" disabled value=""/>
					</div>
					<div class="input-group inline">
						<label for="mdfyr" style="width: 180px;">수정자</label><input type="text" id="mdfyr" disabled value=""/>
					</div>
					<div class="input-group inline">
						<label for="mdfyDt" style="width: 180px;">수정일</label><input type="text" id="mdfyDt" disabled value=""/>
					</div>
				</form>
			</div>
			<div class="align-right">
				<button id="new_btn" class="btn-primary">신규</button>
				<button id="save_btn" class="btn-primary">저장</button>
				<button id="delete_btn" class="btn-delete">삭제</button>
			</div>
		<jsp:include page="../include/footer.jsp"/>
		</div>
	</div>
</body>
</html>