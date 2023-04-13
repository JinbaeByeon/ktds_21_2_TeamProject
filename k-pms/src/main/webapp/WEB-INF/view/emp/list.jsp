<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>홈페이지</title>
	<jsp:include page="../include/stylescript.jsp"/>
	<script type="text/javascript">
		$().ready(function(){
			$("li.nav-item.emp").addClass("active");
			$("li.nav-item").children("a").mouseover(function(){
				$(this).closest(".nav").find(".nav-item.active").removeClass("active");
				if($(this).attr("class")!="nav-item emp"){
					$("li.nav-item.emp").removeClass("active");
				}
				$(this).closest("li.nav-item").addClass("active");
			});
			$(".nav").mouseleave(function(){
				$(this).find(".active").removeClass("active");
				$("li.nav-item.emp").addClass("active");
			});
			$(".sub-item").mouseenter(function(){
				$(this).addClass("active");
			});
		});
	</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp"/>
		<div>
			<jsp:include page="../include/empSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp"/>
			
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
							<th>로그인실패횟수</th>
							<th>차단날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty empList}">
								<c:forEach items="${empList}"
										   var="emp"
										   varStatus="index">
									<tr data-mbrId="${emp.empId}" 
									    data-fNm="${emp.fNm}"
									    data-lNm="${emp.lNm}"
									    data-crtDt="${emp.crtDt}"
									    data-emplmntstts="${emp.emplmntStts}"
									    data-admnYn="${emp.admnYn}"
									    data-pstnid="${emp.pstnId}"
									    data-jobid="${emp.jobId}"
									    data-depid="${emp.depId}"
									    data-lgncnt="${emp.lgnCnt}">
										<td>${index.index}</td>
										<td>${emp.empId}</td>
										<td>${emp.fNm} ${emp.lNm}</td>
										<td>${emp.crtDt}</td>
										<td>${emp.emplmntStts}</td>
										<td>${emp.admnYn}</td>
										<td>${emp.pstnId}</td>
										<td>${emp.jobId}</td>
										<td>${emp.depId}</td>
										<td>${emp.lgnCnt}</td>
										<td>${emp.failDt}</td>
										
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
			<jsp:include page="../include/footer.jsp"/>
		</div>
	</div>
</body>
</html>