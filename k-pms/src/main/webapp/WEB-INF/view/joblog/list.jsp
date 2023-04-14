<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {

		$("li.nav-item").children("a").mouseover(function(){
			$(this).closest(".nav").find(".nav-item.active").removeClass("active");
			if($(this).attr("class")!="nav-item sys"){
				$("li.nav-item.sys").removeClass("active");
			}
			$(this).closest("li.nav-item").addClass("active");
		});
		$(".nav").mouseleave(function(){
			$(this).find(".active").removeClass("active");
		});
		$(".sub-item").mouseenter(function(){
			$(this).addClass("active");
		});
		
		$(".grid > table > tbody > tr").click(function() {
			$("#isModify").val("true");
			var data = $(this).data();
			$("#empId").val(data.empid);
			$("#crtDt").val(data.crtdt);
			$("#crtr").val(data.crtr);
			$("#chngDt").val(data.chngDt);
			$("#prvsJobId").val(data.prvsJobId);
			$("#chngJobId").val(data.chngJobId);
			$("#chngRsn").val(data.chngRsn);

			$("#useYn").prop("checked", data.useyn == "Y");
		});

		$("#search-btn").click(function() {
			movePage(0)
		});
		
		$("#all_check").change(function() {
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		$(".check_idx").change(function() {
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		
		});
		
	});
		function movePage(pageNo) {
			// 전송
			// 입력 값
			var jobNm=$("#search-keyword").val();
			// URL 요청
			location.href= "${context}/emp/job/log?jobNm=" + jobNm + "&pageNo=" + pageNo;
		}

</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp"/>
		<div>
		<jsp:include page="../include/sysSidemenu.jsp"/>
		<jsp:include page="../include/content.jsp"/>
			<div class="path">직무변경이력 > </div>
			<div class="search-group">
				<label for="search-keyword">직원명</label>
				<input type="text" id="search-keyword" class="search-input" value="${empVO.fNm}"/>
				<button class="btn-search" id="search-btn">&#128269</button>
			</div>
			<div class="grid">
				<div class="grid-count align-right">
					총 ${jobLogList.size() > 0 ? jobList.get(0).totalCount : 0}건
				</div>
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="all_check"/></th>
							<th>순번</th>
							<th>직원ID</th>
							<th>바뀐날짜</th>
							<th>수정일</th>
							<th>수정자</th>
							<th>첫직무</th>
							<th>바뀐직무</th>
							<th>바꾼이유</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty jobLogList}">
								<c:forEach items="${jobList}"
										   var="jobLog">
									<tr data-empid="${jobLog.empId}"
										data-jobnm="${jobLog.crtDt}"
										data-useyn="${jobLog.crtr}"
										data-crtr="${jobLog.chngDt}"
										data-crtdt="${jobLog.prvsJobId}"
										data-mdfyr="${jobLog.chngJobId}"
										data-mdfydt="${jobLog.chngRsn}">
									<td>
										<input type="checkbox" class="check_idx" value="${jobLog.jobId}"/>
									</td>
									<td>순번</td>
									<td>${jobLog.empId}</td>
									<td>${jobLog.crtDt}</td>
									<td>${jobLog.crtr}</td>
									<td>${jobLog.chngDt}</td>
									<td>${jobLog.prvsJobId}</td>
									<td>${jobLog.chngJobId}</td>
									<td>${jobLog.chngRsn}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="9" class="no-items">
										등록된 직원이 없습니다.
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
                  <c:param name="path" value="${context}/jobLog"/>
               </c:import>
               
			</div>
			<div class="grid-detail">
				<form id="detail_form" >
					<input type="hidden" id="isModify" value="false" />
					<div class="input-group inline">
						<label for="empId" style="width: 180px;">직원ID</label><input type="text" id="empId" name="jobId" value="" readonly/>
					</div>
					<div class="input-group inline">
						<label for="crtDt" style="width: 180px;">수정일</label><input type="text" id="crtDt" disabled value=""/>
					</div>
					<div class="input-group inline">
						<label for="crtr" style="width: 180px;">수정자</label><input type="checkBox" id="crtr" disabled value=""/>
					</div>
					<div class="input-group inline">
						<label for="chngDt" style="width: 180px;">바뀐날짜</label><input type="text" id="chngDt" disabled value=""/>
					</div>
					<div class="input-group inline">
						<label for="prvsJobId" style="width: 180px;">첫직무</label><input type="text" id="prvsJobId" disabled value=""/>
					</div>
					<div class="input-group inline">
						<label for="chngJobId" style="width: 180px;">바뀐직무</label><input type="text" id="chngJobId" disabled value=""/>
					</div>
					<div class="input-group inline">
						<label for="chngRsn" style="width: 180px;">바꾼이유</label><input type="text" id="chngRsn" disabled value=""/>
					</div>
				</form>
			</div>
		<jsp:include page="../include/footer.jsp"/>
		</div>
	</div>
</body>
</html>