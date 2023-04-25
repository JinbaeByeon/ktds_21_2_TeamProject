<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 상세조회</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		$("#modify-btn").click(function() {
			location.href = "${context}/tm/update/" + $("#tmId").val();
		});
		
		$("#delete-btn").click(function() {
			if(!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			$.get("${context}/api/tm/delete/" + $("#tmId").val(), function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}/tm/list"
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
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/depSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
				<div class="path">팀관리 > 팀 상세조회</div>
					<div>
						<div class="create-group">
							<label for="tmNm">팀명</label>
							<input type="text" id="tmNm" name="tmNm" value="${tmVO.tmNm}" readonly/>
						</div>
						<div class="create-group">
							<label for="tmId">팀ID</label>
							<input type="text" id="tmId" name="tmId" value="${tmVO.tmId}" readonly/>
						</div>
						<div class="create-group">
							<label for="tmHdId">팀장ID</label>
							<input type="text" id="tmHdId" name="tmHdId" value="${tmVO.tmHdId}" readonly/>
						</div>
						<div class="create-group">
							<label for="tmHdNm">팀장성명</label>
							<input type="text" id="tmHdNm" name="tmHdNm" value="${tmVO.tmHdEmpVO.lNm}${tmVO.tmHdEmpVO.fNm}" readonly/>
						</div>
						<div class="create-group">
							<label for="tmCrtDt">팀 생성일</label>
							<input type="date" id="tmCrtDt" name="tmCrtDt" value="${tmVO.tmCrtDt}" readonly/>
						</div>
					</div>
					
					<div class="grid">
						<div>소속 팀원</div>
						<div class="grid-count align-right">
							 총 ${tmVO.tmMbrList.size() > 0 ? tmVO.tmMbrList.size() : 0}건
						</div>
						<table>
							<thead>
								<tr>
									<th>순번</th>
									<th>직급</th>
									<th>직원ID</th>
									<th>이름</th>
									<th>직무</th>
									<th>생년월일</th>
									<th>이메일</th>
									<th>전화번호</th>
									<th>직급연차</th>
								</tr>
							</thead>
						<tbody>
							<c:choose>								
								<c:when test="${not empty tmVO.tmMbrList}">
									<c:forEach items="${tmVO.tmMbrList}"
												var="tmMbr"
												varStatus="index">
											<tr>
												<td>${index.index + 1}</td>
												<td>${tmMbr.empVO.pstn.pstnNm}</td>
												<td>${tmMbr.empId}</td>
												<td>${tmMbr.empVO.lNm}${tmMbr.empVO.fNm}</td>
												<td>${tmMbr.empVO.job.jobNm}</td>
												<td>${tmMbr.empVO.brthdy}</td>
												<td>${tmMbr.empVO.eml}</td>
												<td>${tmMbr.empVO.phn}</td>
												<td>${tmMbr.empVO.pstnPrd}</td>
											</tr>
									</c:forEach>
							    </c:when>
								<c:otherwise>
									<tr>
										<td colspan="9" class="no-items">
											등록된 팀원이 없습니다.
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<div class="align-right">
					<button id="modify-btn" class="btn-primary">수정</button>
					<button id="delete-btn" class="btn-delete">삭제</button>
				</div>
			<jsp:include page="../include/footer.jsp" />	
			</div>			
		</div>
</body>
</html>