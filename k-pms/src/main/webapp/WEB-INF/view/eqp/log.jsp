<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />
<c:set scope="request" var="selected" value="eqp"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비품 변경 이력</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		
		$(".sidebar > ul li a").removeClass("active")
		$("#eqp_log").addClass("active");
		
	});

	function movePage(pageNo) {
		// 전송
		// 입력값
		var eqpNm = $("#search-keyword").val();
		var viewCnt = $("#view_cnt").val();
		location.href = "${context}/eqp/log?&pageNo=" + pageNo + "&viewCnt=" + viewCnt;
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/eqpSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp" />
			<div class="path">비품 > 비품 변경 이력</div>
		      <div class="list_section">
				<jsp:include page="../include/viewCnt.jsp" />
		        <div class="total">총 ${eqpLogList.size() > 0 ? eqpLogList.get(0).totalCount : 0}건</div>
		        <table class="list_table">
		          <thead>
		            <tr>
						<th>순번</th>
						<th>로그 관리번호</th>
						<th>비품 관리번호</th>
						<th>신청자명</th>
						<th>신청내용</th>
						<th>등록자명</th>
						<th>등록일</th>
		            </tr>
		          </thead>
		          <tbody>
					<c:choose>
						<c:when test="${not empty eqpLogList}">
							<c:forEach items="${eqpLogList}"
									   var="eqpLog"
									   varStatus="index">
								<tr data-logid="${eqpLog.logId}"
									data-eqpid="${eqpLog.eqpId}"
									data-empid="${eqpLog.empId}"
									data-stts="${eqpLog.stts}"
									data-crtr="${eqpLog.crtr}"
									data-crtdt="${eqpLog.crtDt}">
									<td>${eqpLog.rnum}</td>
									<td>${eqpLog.logId}</td>
									<td>${eqpLog.eqpId}</td>
									<td>${eqpLog.empId}</td>
									<td>${eqpLog.stts}</td>
									<td>${eqpLog.crtr}(${eqpLog.crtrEmpVO.fNm}${eqpLog.crtrEmpVO.lNm})</td>
									<td>${eqpLog.crtDt}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="7" class="no-items">
									등록된 로그이력이 없습니다.
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
	                  <c:param name="path" value="${context}/eqp"/>
	               	</c:import>

		      </div>	
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>>