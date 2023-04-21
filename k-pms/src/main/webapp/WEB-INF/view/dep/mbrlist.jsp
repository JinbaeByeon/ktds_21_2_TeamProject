<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />
<c:set scope="request" var="selected" value="dep"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀원 조회 및 등록</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	
	$().ready(function() {
		
		function tmlist() {
			$.ajax({
				type: "post",
				url: "${context}/api/dep/mbrlist"
				success: function(result) {
					
				}
			})
		}
		
	});
		 
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/depSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
				<div class="path">팀원 조회 및 등록</div>
				<div class="grid">
					<div class="grid-count align-right">
						 총 ${depList.size() > 0 ? depList.size() : 0}건  
					</div>
					<table>
						<thead>
							<tr>
								<th>순번</th>
								<th>부서ID</th>
								<th>부서명</th>
								<th>부서장ID</th>
								<th>부서장명</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty depList}">
									<c:forEach items="${depList}"
												var="dep"
												varStatus="index">
										<tr data-depid="${dep.depId}"
											data-depnm="${dep.depNm}">
											<td>${index.index + 1}</td>
											<td>${dep.depId}</td>
											<td><a href="${context}/dep/mbrlist/"></a>${dep.depNm}</td>
											<td>${dep.depHdId}</td>
											<td>${dep.hdNmEmpVO.lNm}${dep.hdNmEmpVO.fNm}</td>
										</tr>
									</c:forEach>
								</c:when>
							</c:choose>
						</tbody>
					</table>
				</div>
				<div class="grid">
					<div class="grid-count align-right">
					 총 ${depVO.tmList.size() > 0 ? depVO.tmList.size() : 0}건
					</div>
						<table>
							<thead>
								<tr>
									<th>순번</th>
									<th>팀ID</th>
									<th>팀명</th>
									<th>팀장ID</th>
									<th>팀장 성명</th>
								</tr>
							</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty depVO.tmList}">
									<c:forEach items="${depVO.tmList}"
												var="tm"
												varStatus="index">
											<tr data-depid="${tm.depId}"
												data-tmid="${tm.tmId}"
												data-tmnm="${tm.tmNm}">
												<td>${index.index + 1}</td>
												<td>${tm.tmId}</td>
												<td>${tm.tmNm}</td>
												<td>${tm.tmHdId}</td>
												<td>${tm.tmHdEmpVO.lNm}${tm.tmHdEmpVO.fNm}</td>
											</tr>
									</c:forEach>
								</c:when>
							</c:choose>
						</tbody>
					</table>
					<div class="grid">	
						<div class="grid-count align-right">
							 총 ${depVO.empList.size() > 0 ? depVO.empList.size() : 0}건
						</div>
					<table>
						<thead>
							<tr>
								<th>순번</th>
								<th>직원ID</th>
								<th>이름</th>
								<th>생년월일</th>
								<th>이메일</th>
								<th>전화번호</th>
								<th>직급연차</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>								
								<c:when test="${not empty depVO.empList}">
									<c:forEach items="${depVO.empList}"
												var="emp"
												varStatus="index">
										<tr>
											<td>${index.index + 1}</td>
											<td>${emp.empId}</td>
											<td>${emp.lNm}${emp.fNm}</td>
											<td>${emp.brthdy}</td>
											<td>${emp.eml}</td>
											<td>${emp.phn}</td>
											<td>${emp.pstnPrd}</td>
										</tr>
									</c:forEach>
							    </c:when>
							</c:choose>
						</tbody>
					</table>
					</div>
				</div>			
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>