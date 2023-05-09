<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<c:set scope="request" var="selected" value="home"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>홈페이지</title>
	<jsp:include page="./include/stylescript.jsp"/>
	<script type="text/javascript">
		$().ready(function(){
			
		});
	</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="./include/header.jsp"/>
		<div>
			<jsp:include page="./include/sidemenu.jsp"/>
			<jsp:include page="./include/content.jsp"/>
		      <div class="list_section">
				
		        <table class="list_table">
		          <thead>
						<tr>
							<th style="width: 5%; text-align:center;"><input type="checkbox" id="all_check"/></th>
							<th style="width: 8%;">ID</th>
							<th style="width: 9%;">이름</th>
							<th style="width: 10%;">생성일</th>
							<th>
								<select id="emplmntStts-select">
									<option value="default">재직상태</option>
								</select>
							</th>
							<th style="width: 8%;">관리자여부</th>
							<th style="width: 7%;">직급</th>
							<th style="width: 7%;">직무</th>
							<th style="width: 7%;">부서</th>
							<th style="width: 9%;">최근로그인IP</th>
							<th style="width: 10%;">최근로그인날짜</th>
							<th style="width: 11%;">최근로그인실패날짜</th>
							<th style="width: 10%;">로그인실패횟수</th>
						</tr>
		          </thead>
		          <tbody>
						<c:choose>
							<c:when test="${not empty empList}">
								<c:forEach items="${empList}"
										   var="emp"
										   varStatus="index">
									<tr data-empid="${emp.empId}" 
									    data-fnm="${emp.fNm}"
									    data-lnm="${emp.lNm}"
									    data-crtdt="${emp.crtDt}"
									    data-emplmntstts="${emp.emplmntStts}"
									    data-admnyn="${emp.admnYn}"
									    data-pstnid="${emp.pstnId}"
									    data-jobid="${emp.jobId}"
									    data-depid="${emp.depId}"
									    data-lgncnt="${emp.lgnCnt}">
										<td class="check" style="text-align:center;">
											<input type="checkbox" class="check_idx" value="${emp.empId}">
										</td>
										<td>${emp.empId}</td>
										<td>${emp.lNm}${emp.fNm}</td>
										<td>${emp.crtDt}</td>
										<td>${emp.emplmntSttsVO.cdNm}</td>
										<td>
											<c:if test="${emp.admnYn=='Y'}">
												<span>관리자</span>
											</c:if>
											<c:if test="${emp.admnYn=='N'}">
												<span>일반회원</span>
											</c:if>
										</td>
										<td>${emp.pstn.pstnNm}</td>
										<td>${emp.job.jobNm}</td>
										<td>${emp.dep.depNm}</td>
										<td>${emp.ltstLgnIp}</td>
										<td>${emp.ltstLgnDt}</td>
										<td>${emp.failDt}</td>
										<td>${emp.lgnCnt}</td>
										
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="11" class="no-items">
									등록된 사원이 없습니다.
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
		          </tbody>
		        </table>
		        
		      </div>
			<jsp:include page="./include/footer.jsp"/>
		</div>
	</div>
</body>
</html>