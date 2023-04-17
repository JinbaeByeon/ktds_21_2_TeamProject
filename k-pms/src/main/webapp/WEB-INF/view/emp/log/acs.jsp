<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<c:set scope="request" var="selected" value="emp"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>홈페이지</title>
	<jsp:include page="../../include/stylescript.jsp"/>
	<script type="text/javascript">
		$().ready(function(){
			
		});
		
		function movePage(pageNo) {
			var empId = $("#empId").val();
			var qryStr = "&crtr=" + empId;
			qryStr += "&pageNo=" + pageNo;
			location.href = "${context}/emp/log/acs?"  + qryStr;
		}
	</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../../include/header.jsp"/>
		<div>
			<jsp:include page="../../include/empSidemenu.jsp"/>
			<jsp:include page="../../include/content.jsp"/>
			<div class="path"> 임직원 관리 > 화면접근이력 조회</div>
			<form>
				<div class="search-group">
					<label for="">ID</label>
					<input type="text" id="empId" name="crtr" class="grow-1 mr-10" value="${empId}"/>
					<button class="btn-search" id="search-btn">검색</button>
				</div>
			</form>
			<div class="grid">
				<div class="grid-count align-right">
					총 ${acsLogList.size()}건
				</div>
				<table>
					<thead>
						<tr>
							<th>사원 ID</th>
							<th>사원명</th>
							<th>액세스 기록</th>
							<th>액세스 날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty acsLogList}">
								<c:forEach items="${acsLogList}"
										   var="acsLog">
									<tr>
										<td>${acsLog.crtr}</td>
										<td>${acsLog.emp.fNm}</td>
										<td>${acsLog.acsLog}</td>
										<td>${acsLog.crtDt}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="4" class="no-items">
									등록된 사원이 없습니다.
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					
					</tbody>
				</table>
				<c:import url="../../include/pagenate.jsp">
                  <c:param name="pageNo" value="${pageNo}"/>
                  <c:param name="pageCnt" value="${pageCnt}"/>
                  <c:param name="lastPage" value="${lastPage}"/>
               	</c:import>
			</div>
			<jsp:include page="../../include/footer.jsp"/>
		</div>
	</div>
</body>
</html>