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

			$("#search-keyword").keydown(function(e){
				if(e.keyCode == '13'){
					movePage(0);
				}
			});
			
			$("#search-btn").click(function() {
				movePage(0)
			});
		});
		
		function movePage(pageNo) {
			var searchType = $(".search-option").val();
			var searchKeyword = $("#search-keyword").val();
			var startDt = $("#search-keyword-startdt").val();
			var endDt = $("#search-keyword-enddt").val();
			
			var intstartDt = parseInt(startDt.split("-").join(""));
			var intEndDt = parseInt(endDt.split("-").join(""));
			
			if (intstartDt > intEndDt) {
				alert("시작일자를 확인해 주세요")
				return;
			}
			var qryStr = "?searchType=" + searchType;
			if (searchType=="ID"){
				qryStr += "&crtr=" + searchKeyword;
			} else if (searchType=="이름"){
				qryStr += "&emp.fNm=" + searchKeyword;
			}
			qryStr += "&startDt=" + startDt;
			qryStr += "&endDt=" + endDt;
			qryStr +=  "&pageNo=" + pageNo;
			var viewCnt = $("#view_cnt").val();
			qryStr += "&viewCnt=" + viewCnt;
			
			location.href = "${context}/emp/log/lgn"  + qryStr;
		}
	</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../../include/header.jsp"/>
		<div>
			<jsp:include page="../../include/empSidemenu.jsp"/>
			<jsp:include page="../../include/content.jsp"/>
				<div class="path">임직원 관리 > 로그인 이력</div>
		      <div class="search_wrapper">
		          <div class="search_field">
		            <label for="search-keyword-startdt">조회기간</label>
					<input type="date" id="search-keyword-startdt" class="search-input" value="${lgnHstVO.startDt}"/>
					<input type="date" id="search-keyword-enddt" class="search-input" value="${lgnHstVO.endDt}"/>
		          </div>
		        <div class="search_box">
					<select class="search-option" name="searchType">
						<option ${searchType== "ID" ? "selected" : ""}>ID</option>
						<option ${searchType== "이름" ? "selected" : ""}>이름</option>
					</select>
					<div class="search_field">
						<input type="text" id="search-keyword" class="input" value="${searchKeyword}" placeholder="Search"/>
		          	</div>
		          <div class="search-icon">
		          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
		          </div>
		        </div>
		      </div>
		      <div class="list_section">
				<jsp:include page="../../include/viewCnt.jsp" />
		        <div class="total">총 ${lgnHstList.size() > 0 ? lgnHstList.get(0).totalCount : 0} 건</div>
		        <table class="list_table">
		          <thead>
						<tr>
							<th style="width: 15%;">순번</th>
							<th style="width: 15%;">직원ID</th>
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
										<td>${lgnHst.rnum}</td>
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
									등록된 기록이 없습니다.
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