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
			$("#prvsPstnId").val(data.prvspstnid);
			$("#prvsPstnId").val(data.prvspstnid);
			$("#chngPstnId").val(data.chngpstnid);
			$("#chngDt").val(data.chngdt);
			$("#chngPstnNm").val(data.chngpstnnm);
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
			var jobNm=$("#search-keyword").val();
			// URL 요청
			location.href= "${context}/emp/log/pstn?pstnNm=" + pstnNm + "&pageNo=" + pageNo;
		}

</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../../include/header.jsp"/>
		<div>
		<jsp:include page="../../include/sysSidemenu.jsp"/>
		<jsp:include page="../../include/content.jsp"/>
			<div class="path">직급변경이력 > </div>
			<div class="search-group">
				<label for="search-keyword">직원ID</label>
				<input type="text" id="search-keyword" class="search-input" value="${pstnLogVO.empId}"/>
				<button class="btn-search" id="search-btn">&#128269</button>
			</div>
			<div class="grid">
				<div class="grid-count align-right">
					총 ${pstnLogList.size() > 0 ? pstnList.get(0).totalCount : 0}건
				</div>
				<table>
					<thead>
						<tr>
							<th>직원ID</th>
							<th>이름</th>
							<th>이전직급ID</th>
							<th>이전직급</th>
							<th>변경된직급ID</th>
							<th>변경된직급</th>
							<th>변경일</th>
							<th>변경사유</th>
							<th>생성일</th>
							<th>생성자</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty pstnLogList}">
								<c:forEach items="${jobList}"
										   var="pstnLog">
									<tr data-empid="${pstnLog.empId}"
										data-fnm="${pstnLog.empVO.fNm}"
										data-lnm="${pstnLog.empVO.lNm}"
										data-prvspstnid="${pstnLog.prvsPstnId}"
										data-prvspstnnm="${pstnLog.prvsPstnNmVO.pstnNm}"
										data-chngpstnid="${pstnLog.chngPstnId}"
										data-chngpstnnm="${pstnLog.chngPstnNmVO.pstnNm}"
										data-chngDt="${pstnLog.chngDt}"
										data-chngrsn="${pstnLog.chngRsn}"
										data-crtdt="${pstnLog.crtDt}"
										data-crtr="${pstnLog.crtr}">
									<td>${pstnLog.empId}</td>
									<td>${pstnLog.empVO.fNm} ${pstnLog.empVO.lNm}</td>
									<td>${pstnLog.prvsPstnId}</td>
									<td>${pstnLog.prvsPstnNmVO.pstnNm}</td>
									<td>${pstnLog.chngPstnId}</td>
									<td>${pstnLog.chngPstnNmVO.pstnNm}</td>
									<td>${pstnLog.chngDt}</td>
									<td>${pstnLog.chngRsn}</td>
									<td>${pstnLog.crtDt}</td>
									<td>${pstnLog.crtr}</td>
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
                  <c:param name="path" value="${context}/pstnLog"/>
               </c:import>
            
			</div>
		<jsp:include page="../../include/footer.jsp"/>
		</div>
	</div>
</body>
</html>