<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />
<c:set scope="request" var="selected" value="prj"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 변경 이력</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		
		$(".sidebar > ul li a").removeClass("active")
		$("#prj_log").addClass("active");
		
	});

	function movePage(pageNo) {
		var queryString = "pageNo=" + pageNo;
		var viewCnt = $("#view_cnt").val();
		queryString += "&viewCnt=" + viewCnt;
		
		location.href = "${context}/prj/log?" + queryString;
	}
	
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/prjSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp" />
			<div class="path">프로젝트 > 프로젝트 변경 이력</div>

		      <div class="list_section">
				<jsp:include page="../include/viewCnt.jsp" />
		        <div class="total">총 ${prjLogList.size() > 0 ? prjLogList.get(0).totalCount : 0}건</div>
		        <table class="list_table">
		          <thead>
		            <tr>
						<th>로그 관리번호</th>
						<th>프로젝트 관리번호</th>
						<th>프로젝트 상태</th>
						<th>등록자</th>
						<th>등록일</th>
		            </tr>
		          </thead>
		          <tbody>
					<c:choose>
						<c:when test="${not empty prjLogList}">
							<c:forEach items="${prjLogList}"
									   var="prjLog">
								<tr data-logid="${prjLog.logId}"
									data-prjid="${prjLog.prjId}"
									data-stts="${prjLog.stts}"
									data-crtr="${prjLog.crtr}"
									data-crtdt="${prjLog.crtDt}">
									<td>${prjLog.logId}</td>
									<td>${prjLog.prjId}</td>
									<td>${prjLog.stts}</td>
									<td>${prjLog.crtr}</td>
									<td>${prjLog.crtDt}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="5" class="no-items">
									등록된 프로젝트 로그이력이 없습니다.
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
	                  <c:param name="path" value="${context}/prj"/>
	               	</c:import>

		      </div>	
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>>