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
<title>부서 상세조회</title>
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
				<div class="path">부서관리 > 부서 상세조회</div>
					<div>	
						<div>
							부서명: ${depVO.depNm}
						</div>
						<div>
							부서ID: ${depVO.depId}
						</div>
						<div>
							부서장ID: ${depVO.depHdId}
						</div>
						<div>
							부서 생성일: ${depVO.depCrtDt}
						</div>
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
									<th>팀생성일</th>
								</tr>
							</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty depVO.tmList}">
									<c:forEach items="${depVO.tmList}"
												var="tm"
												varStatus="index">
											<tr>
												<td>${index.index + 1}</td>
												<td>${tm.tmId}</td>
												<td>${tm.tmNm}</td>
												<td>${tm.tmHdId}</td>
												<td>${tm.tmCrtDt}</td>
											</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="5" class="no-items">
											등록된 팀이 없습니다.
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
						팀명클릭해서 팀원목록 출력
						부서원목록 출력
			</div>			
		</div>
	</div>
</body>
</html>