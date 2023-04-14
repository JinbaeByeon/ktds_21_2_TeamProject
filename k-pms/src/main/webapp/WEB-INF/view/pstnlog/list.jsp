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
			location.href= "${context}/emp/job/log?pstnNm=" + pstnNm + "&pageNo=" + pageNo;
		}

</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp"/>
		<div>
		<jsp:include page="../include/sysSidemenu.jsp"/>
		<jsp:include page="../include/content.jsp"/>
			<div class="path">직급변경이력 > </div>
			<div class="search-group">
				<label for="search-keyword">직원명</label>
				<input type="text" id="search-keyword" class="search-input" value="${empVO.fNm}"/>
				<button class="btn-search" id="search-btn">&#128269</button>
			</div>
			<div class="grid">
				<div class="grid-count align-right">
					총 ${pstnLogList.size() > 0 ? pstnList.get(0).totalCount : 0}건
				</div>
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="all_check"/></th>
							<th>순번</th>
							<th>직원ID</th>
							<th>이름</th>
							<th>첫직급ID</th>
							<th>첫직급</th>
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
										data-fnm="${pstnLog.fNm}"
										data-lnm="${pstnLog.lNm}"
										data-prvspstnid="${pstnLog.prvsPstnId}"
										data-prvspstnnm="${pstnLog.prvsPstnNm}"
										data-chngpstnid="${pstnLog.chngPstnId}"
										data-chngpstnnm="${pstnLog.chngPstnNm}"
										data-chngDt="${pstnLog.chngDt}"
										data-chngrsn="${pstnLog.chngRsn}"
										data-crtdt="${pstnLog.crtDt}"
										data-crtr="${pstnLog.crtr}">
									<td>
										<input type="checkbox" class="check_idx" value="${pstnLog.jobId}"/>
									</td>
									<td>순번</td>
									<td>${pstnLog.empId}</td>
									<td>${pstnLog.fNm} ${pstnLog.lNm}</td>
									<td>${pstnLog.prvsPstnId}</td>
									<td>${pstnLog.prvsPstnNm}</td>
									<td>${pstnLog.chngPstnId}</td>
									<td>${pstnLog.chngPstnNm}</td>
									<td>${pstnLog.chngDt}</td>
									<td>${pstnLog.chngRsn}</td>
									<td>${pstnLog.crtDt}</td>
									<td>${pstnLog.crtr}</td>
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
                  <c:param name="path" value="${context}/pstnLog"/>
               </c:import>
               
			</div>
			<div class="grid-detail">
				<form id="detail_form" >
					<input type="hidden" id="isModify" value="false" />
					<div class="input-group inline">
						<label for="empId" style="width: 180px;">직원ID</label><input type="text" id="empId" name="jobId" value="" readonly/>
					</div>
					<div class="input-group inline">
						<label for="fNm" style="width: 180px;">이름</label><input type="text" id="fNm" disabled value=""/>
					</div>
					<div class="input-group inline">
						<label for="lNm" style="width: 180px;">성</label><input type="text" id="lNm" disabled value=""/>
					</div>
					<div class="input-group inline">
						<label for="prvsPstnId" style="width: 180px;">첫직급ID</label><input type="text" id="prvsPstnId" disabled value=""/>
					</div>
					<div class="input-group inline">
						<label for="prvsPstnNm" style="width: 180px;">첫직급</label><input type="text" id="prvsPstnNm" disabled value=""/>
					</div>
					<div class="input-group inline">
						<label for="chngPstnId" style="width: 180px;">변경된직급ID</label><input type="text" id="chngPstnId" disabled value=""/>
					</div>
					<div class="input-group inline">
						<label for="chngPstnNm" style="width: 180px;">변경직급</label><input type="text" id="chngPstnNm" disabled value=""/>
					</div>
					<div class="input-group inline">
						<label for="chngDt" style="width: 180px;">변경일</label><input type="text" id="chngDt" disabled value=""/>
					</div>
					<div class="input-group inline">
						<label for="chngRsn" style="width: 180px;">변경사유</label><input type="text" id="chngRsn" disabled value=""/>
					</div>
					<div class="input-group inline">
						<label for="crtDt" style="width: 180px;">생성일</label><input type="text" id="crtDt" disabled value=""/>
					</div>
					<div class="input-group inline">
						<label for="crtr" style="width: 180px;">생성자</label><input type="text" id="crtr" disabled value=""/>
					</div>
				</form>
			</div>
		<jsp:include page="../include/footer.jsp"/>
		</div>
	</div>
</body>
</html>