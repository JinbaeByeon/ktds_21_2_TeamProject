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
						<div>
							팀명: ${tmVO.tmNm}
						</div>
						<div>
							팀ID: ${tmVO.tmId}
						</div>
						<div>
							팀장ID: ${tmVO.tmHdId}
						</div>
						<div>
							팀 생성일: ${tmVO.tmCrtDt}
						</div>
					</div>
					
					<div class="grid-count align-right">
						 총 ${tmVO.empList.size() > 0 ? tmVO.empList.size() : 0}건
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
							<c:when test="${not empty tmVO.empList}">
								<c:forEach items="${tmVO.empList}"
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
							<c:otherwise>
								<tr>
									<td colspan="7" class="no-items">
										등록된 팀원이 없습니다.
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>			
		</div>
</body>
</html>