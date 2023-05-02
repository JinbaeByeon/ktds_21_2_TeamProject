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
		// 전송
		// 입력 값
		var empId=$("#search-keyword").val();
		// URL 요청
		location.href= "${context}/emp/log/dep?empId=" + empId + "&pageNo=" + pageNo;
	}

</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../../include/header.jsp"/>
		<div>
		<jsp:include page="../../include/empSidemenu.jsp"/>
		<jsp:include page="../../include/content.jsp"/>
			<div class="path">부서변경이력 ></div>
		      <div class="search_wrapper">
		        <div class="search_box">
		          <select>
		            <option>직원ID</option>
		          </select>
		          <div class="search_field">
		         	 <input type="text" id="search-keyword" class="input" value="${depLogVO.empId}" placeholder="Search"/>
		          </div>
		          <div class="search-icon">
		          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
		          </div>
		        </div>
		      </div>
		      <div class="list_section">
		        <div class="total">총 ${depLogList.size() > 0 ? depLogList.get(0).totalCount : 0}건</div>
		        <table class="list_table">
		          <thead>
						<tr>
							<th>직원ID</th>
							<th>이름</th>
							<th>이전부서ID</th>
							<th>이전부서</th>
							<th>변경된부서ID</th>
							<th>변경된부서</th>
							<th>변경일</th>
							<th>변경사유</th>
							<th>생성일</th>
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
									<td>${depLog.crtDt}</td>
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