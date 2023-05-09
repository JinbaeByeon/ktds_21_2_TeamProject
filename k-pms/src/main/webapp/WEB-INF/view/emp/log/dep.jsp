<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set scope="request" var="selected" value="emp"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		$(".sidebar > ul li a").removeClass("active")
		$("#emp_log_dep").addClass("active");

		$("#search-keyword").keydown(function(e){
			if(e.keyCode == '13'){
				movePage(0);
			}
		})
		
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
			qryStr += "&empId=" + searchKeyword;
		} else if (searchType=="이름"){
			qryStr += "&empVO.fNm=" + searchKeyword;
		}
		qryStr += "&startDt=" + startDt;
		qryStr += "&endDt=" + endDt;
		qryStr +=  "&pageNo=" + pageNo;
		var viewCnt = $("#view_cnt").val();
		qryStr += "&viewCnt=" + viewCnt;
		
		location.href= "${context}/emp/log/dep" + qryStr;
	}

</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../../include/header.jsp"/>
		<div>
		<jsp:include page="../../include/empSidemenu.jsp"/>
		<jsp:include page="../../include/content.jsp"/>
			<div class="path">임직원 관리 > 부서 변경 이력</div>
		      <div class="search_wrapper">
		        <div class="search_box">
					<select class="search-option" name="searchType">
						<option ${searchType== "ID" ? "selected" : ""}>ID</option>
						<option ${searchType== "이름" ? "selected" : ""}>이름</option>
					</select>
		          <div class="search_field">
					<input type="text" id="search-keyword" class="input" value="${searchKeyword}" placeholder="Search"/>
					<label for="search-keyword-startdt">조회기간</label>
					<input type="date" id="search-keyword-startdt" class="search-input" value="${depLogVO.startDt}"/>
					<input type="date" id="search-keyword-enddt" class="search-input" value="${depLogVO.endDt}"/>
		          </div>
		          <div class="search-icon">
		          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
		          </div>
						
		        </div>
		      </div>
		      <div class="list_section">
				<jsp:include page="../../include/viewCnt.jsp" />
			        <div class="total">총 ${depLogList.size() > 0 ? depLogList.get(0).totalCount : 0}건</div>
		        <table class="list_table">
		          <thead>
						<tr>
							<th>직원ID</th>
							<th>이름</th>
							<th>이전 부서 관리번호</th>
							<th>이전부서</th>
							<th>변경 부서 관리번호</th>
							<th>변경 부서</th>
							<th>변경일</th>
							<th>변경사유</th>
							<th>생성자</th>
						</tr>
		          </thead>
		          <tbody>
						<c:choose>
							<c:when test="${not empty depLogList}">
								<c:forEach items="${depLogList}"
										   var="depLog">
									<tr data-empid="${depLog.empId}"
										data-fnm="${depLog.empVO.fNm}"
										data-lnm="${depLog.empVO.lNm}"
										data-prvsdepid="${depLog.prvsDepId}"
										data-prvsdepnm="${depLog.prvsDepNmVO.depNm}"
										data-chngdepid="${depLog.chngDepId}"
										data-chngdepnm="${depLog.chngDepNmVO.depNm}"
										data-chngDt="${depLog.chngDt}"
										data-chngrsn="${depLog.chngRsn}"
										data-crtdt="${depLog.crtDt}"
										data-crtr="${depLog.crtr}">
									<td>${depLog.empId}</td>
									<td>${depLog.empVO.lNm}${depLog.empVO.fNm}</td>
									<td>${depLog.prvsDepId}</td>
									<td>${depLog.prvsDepNmVO.depNm}</td>
									<td>${depLog.chngDepId}</td>
									<td>${depLog.chngDepNmVO.depNm}</td>
									<td>${depLog.chngDt}</td>
									<td>${depLog.chngRsn}</td>
									<td>${depLog.crtr}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="10" class="no-items">
										등록된 직원이 없습니다.
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
	                  <c:param name="path" value="${context}/depLog"/>
	               </c:import>

		      </div>
		<jsp:include page="../../include/footer.jsp"/>
		</div>
	</div>
</body>
</html>