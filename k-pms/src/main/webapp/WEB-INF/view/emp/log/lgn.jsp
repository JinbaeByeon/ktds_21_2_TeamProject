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
			$(".sidebar > ul li a").removeClass("active")
			$("#emp_log_lgn").addClass("active");
			
		});
		
		function movePage(pageNo) {
			var empId = $("#empId").val();
			var qryStr = "&crtr=" + empId;
			qryStr += "&pageNo=" + pageNo;
			location.href = "${context}/emp/log/lgn?"  + qryStr;
		}
	</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../../include/header.jsp"/>
		<div>
			<jsp:include page="../../include/empSidemenu.jsp"/>
			<jsp:include page="../../include/content.jsp"/>
				<div class="path">임직원관리 > 로그인 이력 조회</div>
		      <div class="search_wrapper">
		      <form>
		        <div class="search_box">
		          <select>
		            <option>ID</option>
		          </select>
		          <div class="search_field">
		          <input type="text" id="empId" name="crtr" class="input" value="${empId}" placeholder="Search"/>
		          </div>
		          <div class="search-icon">
		          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
		          </div>
		        </div>
		      </form>
		      </div>
		      <div class="list_section">
		        <div class="total">총 ${lgnHstList.size() > 0 ? lgnHstList.get(0).totalCount : 0} 건</div>
		        <table class="list_table">
		          <thead>
						<tr>
							<th style="width: 15%;">사원 ID</th>
							<th style="width: 15%;">사원명</th>
							<th style="width: 10%;">로그인/로그아웃</th>
							<th style="width: 25%;">날짜</th>
							<th style="width: 25%;">IP</th>
						</tr>
		          </thead>
		          <tbody>
						<c:choose>
							<c:when test="${not empty lgnHstList}">
								<c:forEach items="${lgnHstList}"
										   var="lgnHst">
									<tr data-crtr="${lgnHst.crtr}"
									    data-act="${lgnHst.act}"
									    data-crtDt="${lgnHst.crtDt}"
									    data-ip="${lgnHst.ip}">
										<td>${lgnHst.crtr}</td>
										<td>${lgnHst.emp.lNm}${lgnHst.emp.fNm}</td>
										<td>${lgnHst.act}</td>
										<td>${lgnHst.crtDt}</td>
										<td>${lgnHst.ip}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5" class="no-items">
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