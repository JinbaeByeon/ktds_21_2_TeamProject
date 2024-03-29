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
<title>팀 상세 - ${tmVO.tmNm}</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		$(".sidebar > ul li a").removeClass("active")
		$("#tm_list").addClass("active");
		
		$("#list-btn").click(function(response) {
			location.href = "${context}/tm/list"
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
				<div class="path">팀 > 팀 조회 > 팀 상세조회</div>
			<table class="detail_page detail_table">
                <tr>
                    <th>팀명</th>
                    <td colspan="3">${tmVO.tmNm}</td>
                </tr>
                <tr>
                    <th>팀장명</th>
                    <td colspan="3">${tmVO.tmHdEmpVO.lNm}${tmVO.tmHdEmpVO.fNm}</td>
                </tr>
                <tr>
                    <th>팀 생성일</th>
                    <td colspan="3">${tmVO.tmCrtDt}</td>
                </tr>
                <tr>
                    <th>소속 팀원</th>
                    <td colspan="3">
                        <div class="total">총 ${tmVO.tmMbrList.size() > 0 ? tmVO.tmMbrList.size() : 0}건</div>
                        <table class="list_table inner_table">
                        <thead>
							<tr>
								<th>팀 직책</th>
								<th>직급</th>
								<th>이름</th>
								<th>직무</th>
								<th>생년월일</th>
								<th>이메일</th>
								<th>전화번호</th>
								<th>직급연차</th>
							</tr>
                        </thead>
                        <tbody>
							<tr>
								<td>팀장</td>
								<td>${tmHdEmpVO.pstn.pstnNm}</td>
								<td>${tmHdEmpVO.lNm}${tmHdEmpVO.fNm}</td>
								<td>${tmHdEmpVO.job.jobNm}</td>
								<td>${tmHdEmpVO.brthdy}</td>
								<td>${tmHdEmpVO.eml}</td>
								<td>${tmHdEmpVO.phn}</td>
								<td>${tmHdEmpVO.pstnPrd}</td>
							</tr>
							<c:choose>								
								<c:when test="${not empty tmVO.tmMbrList}">
									<c:forEach items="${tmVO.tmMbrList}"
												var="tmMbr"
												varStatus="index">
											<c:if test="${tmMbr.empId != tmVO.tmHdId}">
												<tr>
													<td>팀원</td>
													<td>${tmMbr.empVO.pstn.pstnNm}</td>
													<td>${tmMbr.empVO.lNm}${tmMbr.empVO.fNm}</td>
													<td>${tmMbr.empVO.job.jobNm}</td>
													<td>${tmMbr.empVO.brthdy}</td>
													<td>${tmMbr.empVO.eml}</td>
													<td>${tmMbr.empVO.phn}</td>
													<td>${tmMbr.empVO.pstnPrd}</td>
												</tr>
											</c:if>
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

            </table>
                

        <div class="buttons">
			<button id="list-btn" class="btn new">목록</button>
        </div>
			<jsp:include page="../include/footer.jsp" />	
			</div>			
		</div>
</body>
</html>