<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {

		$(".grid > table > tbody > tr").click(function() {
			$("#isModify").val("true");
			var data = $(this).data();
			$("#empId").val(data.empid);
			$("#fNm").val(data.fnm);
			$("#lNm").val(data.lnm);
			$("#prvsJobId").val(data.prvsjobid);
			$("#prvsJobNm").val(data.prvsjobnm);
			$("#chngJobId").val(data.chngjobid);
			$("#chngDt").val(data.chngdt);
			$("#chngJobNm").val(data.chngjobnm);
			$("#chngRsn").val(data.chngrsn);
			$("#crtDt").val(data.crtdt);
			$("#crtr").val(data.crtr);

			$("#useYn").prop("checked", data.useyn == "Y");
		});
		
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
			var empId =$("#search-keyword").val();
			// URL 요청
			location.href= "${context}/emp/log/job?empId=" + empId + "&pageNo=" + pageNo;
		}

</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../../include/header.jsp"/>
		<div>
		<jsp:include page="../../include/sysSidemenu.jsp"/>
		<jsp:include page="../../include/content.jsp"/>
			<div class="path">직무변경이력 > </div>
			<div class="search-group">
				<label for="search-keyword">직원ID</label>
				<input type="text" id="search-keyword" class="search-input" value="${jobLogVO.empId}"/>
				<button class="btn-search" id="search-btn">&#128269</button>
			</div>
			<div class="grid">
				<div class="grid-count align-right">
					총 ${jobLogList.size() > 0 ? jobList.get(0).totalCount : 0}건
				</div>
				<table>
					<thead>
						<tr>
							<th>직원ID</th>
							<th>이름</th>
							<th>이전직무ID</th>
							<th>이전직무명</th>
							<th>변경직무ID</th>
							<th>변경직무명</th>
							<th>변경일</th>
							<th>변경사유</th>
							<th>생성일</th>
							<th>생성자</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty jobLogList}">
								<c:forEach items="${jobLogList}"
										   var="jobLog">
									<tr data-empid="${jobLog.empId}"
										data-fnm="${jobLog.empVO.fNm}"
										data-lnm="${jobLog.empVO.lNm}"
										data-prvsjobid="${jobLog.prvsJobId}"
										data-prvsjobnm="${jobLog.prvsJobNmVO.jobNm}"
										data-chngjobid="${jobLog.chngJobId}"
										data-chngjobnm="${jobLog.chngJobNmVO.jobNm}"
										data-chngDt="${jobLog.chngDt}"
										data-chngrsn="${jobLog.chngRsn}"
										data-crtdt="${jobLog.crtDt}"
										data-crtr="${jobLog.crtr}">
									<td>${jobLog.empId}</td>
									<td>${jobLog.empVO.fNm} ${jobLog.empVO.lNm}</td>
									<td>${jobLog.prvsJobId}</td>
									<td>${jobLog.prvsJobNmVO.jobNm}</td>
									<td>${jobLog.chngJobId}</td>
									<td>${jobLog.chngJobNmVO.jobNm}</td>
									<td>${jobLog.chngDt}</td>
									<td>${jobLog.chngRsn}</td>
									<td>${jobLog.crtDt}</td>
									<td>${jobLog.crtr}</td>
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
                  <c:param name="path" value="${context}/jobLog"/>
               </c:import>
               
			</div>
		<jsp:include page="../../include/footer.jsp"/>
		</div>
	</div>
</body>
</html>