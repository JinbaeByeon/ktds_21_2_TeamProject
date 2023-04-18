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
	<jsp:include page="../include/stylescript.jsp"/>
	<script type="text/javascript">
		var detailWindow;
		
		$().ready(function(){
			$(".grid > table > tbody > tr").click(function() {
				var empId = $(this).data("empid");
				detailWindow = window.open("${context}/emp/detail/"+ empId,"사원 정보","width=500,height=500");
			});
		});
		function movePage(pageNo) {
			var empId = $("#empId").val();
			var qryStr = "crtr=" + empId;
			qryStr +=  "&pageNo=" + pageNo;
			location.href = "${context}/emp/list?"  + qryStr;
		}
	</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp"/>
		<div>
			<jsp:include page="../include/empSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp"/>
			<div class="path"> 사원 관리 > 사원 조회</div>
			<form>
				<div class="search-group">
					<label for="">ID</label>
					<input type="text" id="empId" name="crtr" class="grow-1 mr-10" value="${empId}"/>
					<button class="btn-search" id="search-btn">검색</button>
				</div>
			</form>
			<div class="grid">
				<div class="grid-count align-right">
					총 ${empList.size()}건
				</div>
				<table>
					<thead>
						<tr>
							<th>순번</th>
							<th>ID</th>
							<th>이름</th>
							<th>생성일</th>
							<th>재직상태</th>
							<th>관리자여부</th>
							<th>직급</th>
							<th>직무</th>
							<th>부서</th>
							<th>최근로그인IP</th>
							<th>최근로그인날짜</th>
							<th>최근로그인실패날짜</th>
							<th>로그인실패횟수</th>
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
										<td>${index.index}</td>
										<td>${emp.empId}</td>
										<td>${emp.fNm} ${emp.lNm}</td>
										<td>${emp.crtDt}</td>
										<td>${emp.emplmntStts}</td>
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
				<c:import url="../include/pagenate.jsp">
                  <c:param name="pageNo" value="${pageNo}"/>
                  <c:param name="pageCnt" value="${pageCnt}"/>
                  <c:param name="lastPage" value="${lastPage}"/>
               	</c:import>
			</div>
			<jsp:include page="../include/footer.jsp"/>
		</div>
	</div>
</body>
</html>