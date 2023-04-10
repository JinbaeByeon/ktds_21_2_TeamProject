<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		$("table > tbody > tr").click(function() {
			$("#isModify").val("true"); // 수정모드
			var data = $(this).data();
			$("#prjId").val(data.prjid);
			$("#prjNm").val(data.prjnm);
			$("#cstmr").val(data.cstmr);
			$("#strtDt").val(data.strtdt);
			$("#endDt").val(data.enddt);
			$("#prjStts").val(data.prjstts);
			$("#useYn").prop("checked", data.useyn == "Y");
		});
		
		$("#save-btn").click(function() {
			if ($("#isModify").val() == "false") {
				// 신규등록
				$.post("${context}/api/prj/create", $("#detail-form").serialize(), function(response) {
					if (response.status == "200 OK") {
						location.reload(); // 새로고침
					}
					else {
						alert(response.errorCode + "/" + response.message);
					}
				});
			}
			else {
				// 수정
				$.post("${context}/api/prj/update", $("#detail-form").serialize(), function(response) {
					if (response.status == "200 OK") {
						location.reload(); // 새로고침
					}
					else {
						alert(response.errorCode + "/" + response.message);
					}
				});				
			}
		});
		
		$("#delete-btn").click(function() {
			var prjId = $("#prjId").val();
			if(prjId == "") {
				alert("선택된 프로젝트가 없습니다.");
				return
			}
			
			if(!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			$.get("${context}/api/prj/delete/" + prjId, function(response) {
				if (response.status == "200 OK") {
					location.reload(); // 새로고침
				}
				else {
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
	});
</script>
</head>
<body>
<%-- 	총 ${prjList.size() > 0 ? prjList.get(0).totalCount : 0}건 --%>
	<table>
		<thead>
			<tr>
				<th><input type="checkbox" id="all_check" /></th>
				<th>순번</th>
				<th>프로젝트ID</th>
				<th>프로젝트명</th>
				<th>고객사</th>
				<th>시작일</th>
				<th>종료일</th>
				<th>상태</th>
				<th>사용여부</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${not empty prjList}">
					<c:forEach items="${prjList}"
								var="prj"
								varStatus="index">
						<tr data-prjid="${prj.prjId}"
							data-prjnm="${prj.prjNm}"
							data-cstmr="${prj.cstmr}"
							data-strtdt="${prj.strtDt}"
							data-enddt="${prj.endDt}"
							data-prjstts="${prj.prjStts}"
							data-useYn="${prj.useYn}" >
							<td>
								<input type="checkbox" class="check-idx" value="${prj.prjId}" />
							</td>
							<td>${index.index}</td>
							<td>${prj.prjId}</td>
							<td>${prj.prjNm}</td>
							<td>${prj.cstmr}</td>
							<td>${prj.strtDt}</td>
							<td>${prj.endDt}</td>
							<td>${prj.prjStts}</td>
							<td>${prj.useYn}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="9" class="no-items">
							등록된 프로젝트가 없습니다.
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	<div>
		<h2>입력 테스트</h2>
		<form id="detail-form">
			<input type="hidden" id="isModify" value="false" />
			<div class="input-group inline"> 
				<label for="prjId" style="width: 180px;">프로젝트ID</label><input type="text" id="prjId" name="prjId" readonly value=""/>
			</div>
			<div class="input-group inline">
				<label for="prjNm" style="width: 180px;">프로젝트명</label><input type="text" id="prjNm" name="prjNm" value=""/>
			</div>
			<div class="input-group inline">
				<label for="cstmr" style="width: 180px;">고객사</label><input type="text" id="cstmr" name="cstmr" value=""/>
			</div>
			<div class="input-group inline">
				<label for="strtDt" style="width: 180px;">시작일</label><input type="date" id="strtDt" name="strtDt" value=""/>
			</div>
			<div class="input-group inline">
				<label for="endDt" style="width: 180px;">종료일</label><input type="date" id="endDt" name="endDt" value=""/>
			</div>
			<div class="input-group inline">
				<label for="prjStts" style="width: 180px;">상태</label><input type="text" id="prjStts" name="prjStts" value=""/>
			</div>
			<div class="input-group inline">
				<label for="useYn" style="width: 180px;">사용여부</label><input type="checkbox" id="useYn" name="useYn" value="Y"/>
			</div>
		</form>
	</div>
		<button id="save-btn" class="btn-primary">저장</button>
		<button id="delete-btn" class="btn-delete">삭제</button>
</body>
</html>