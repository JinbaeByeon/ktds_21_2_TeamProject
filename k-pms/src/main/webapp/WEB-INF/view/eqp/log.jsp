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
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		$(".grid > table > tbody > tr").click(function(){
			
			$("#isModify").val("true"); //수정모드
			
			var data = $(this).data();
			
			$("#eqpId").val(data.eqpid);
			$("#eqpNm").val(data.eqpnm);
			$("#crtr").val(data.crtr);
			$("#crtDt").val(data.crtdt);
			$("#mdfyr").val(data.mdfyr);
			$("#mdfyDt").val(data.mdfydt);
			$("#eqpTp").val(data.eqptp);
			$("#applStts").val(data.applstts);
			$("#eqpPrc").val(data.eqpprc);
			$("#prchsDt").val(data.prchsdt);
			$("#lossStts").val(data.lossstts);
			$("#lossRprtDt").val(data.lossrprtdt);
			$("#applDt").val(data.appldt);
			
			$("#useYn").prop("checked", data.useyn == "Y");
			
		});
		
		$("#search-btn").click(function(){
			var eqpNm =$("#search-keyword").val();
			location.href = "${context}/eqp/log?eqpId=" + eqpId;
			/* movePage(0) */
			
		})
		
	});
	
	function movePage(pageNo) {
		// 전송
		// 입력값
		var eqpId = $("#search-keyword").val();
		// URL 요청
		location.href = "${context}/eqp/log?eqpId=" + eqpId + "&pageNo=" + pageNo;
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/eqpSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp" />
				<div class="path"> 비품내역 관리</div>
				<div class="search-group">
					
				</div>
				
				<div class="grid">
					<div class="grid-count align-right">
						총 ${eqpLogList.size() > 0 ? eqpLogList.get(0).totalCount : 0}건
					</div>
					<table>
						<thead>
							<tr>
								<th>순번</th>
								<th>로그ID</th>
								<th>비품ID</th>
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
											<td>${eqpLog.crtr}(${eqpLog.crtrEmpVO.fNm} ${eqpLog.crtrEmpVO.lNm})</td>
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
					<div class="align-right mt-10">
						<button id="delete_all_btn" class="btn-delete">삭제</button>
					</div>
					<c:import url="../include/pagenate.jsp">
	                  <c:param name="pageNo" value="${pageNo}"/>
	                  <c:param name="pageCnt" value="${pageCnt}"/>
	                  <c:param name="lastPage" value="${lastPage}"/>
	                  <c:param name="path" value="${context}/eqp"/>
	               	</c:import>
					
				</div>	
				<div class="grid-detail">
					
				</div>
				<div class="align-right">
					
				</div>		
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>>