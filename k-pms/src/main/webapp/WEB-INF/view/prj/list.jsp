<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<c:set scope="request" var="selected" value="prj"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
$().ready(function() {
	
	$("table > tbody > tr").click(function() {
		var data = $(this).data();
		$("#prjId").val(data.prjid);
		$("#prjNm").val(data.prjnm);
		$("#cstmr").val(data.cstmr);
		$("#strtDt").val(data.strtdt);
		$("#endDt").val(data.enddt);
		$("#prjStts").val(data.prjstts);
		$("#useYn").prop("checked", data.useyn == "Y");
	});
	
	$("#search-btn").click(function() {
		movePage(0);
	});
	
	$("#new-btn").click(function() {
		location.href = "${context}/prj/create"
	});
	
	$("#delete-btn").click(function() {
		var checkLen = $(".check-idx:checked").length;
		if (checkLen == 0) {
			alert("삭제할 프로젝트를 선택해주세요");
			return;
		}
		
		var form = $("<form></form>")
		$(".check-idx:checked").each(function() {
			form.append("<input type='hidden' name='prjId' value='" + $(this).val() + "'>");
		});
		
		if(!confirm("정말 삭제하시겠습니까?")) {
			return;
		}
		
		$.post("${context}/api/prj/delete", form.serialize(), function(response) {});
		location.reload(); // 새로고침
		
	});
		
	$("#all_check").change(function() {
		$(".check-idx").prop("checked", $(this).prop("checked"));
	});
	
	$(".check-idx").change(function() {
		var count = $(".check-idx").length;
		var checkCount = $(".check-idx:checked").length;
		$("#all_check").prop("checked", count == checkCount);
	});
	
});
	function movePage(pageNo) {
		var prjnm = $("#search-keyword-prjnm").val();
		var cstmr = $("#search-keyword-cstmr").val();
		
		var queryString = "prjNm=" + prjnm;
		queryString += "&cstmr=" + cstmr;
		queryString += "&pageNo=" + pageNo;
		
		location.href = "${context}/prj/list?" + queryString;
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/prjSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />		
				<div class="path"> 프로젝트관리 > 프로젝트 목록</div>
				<div class="search-row-group">
					<div class="search-group">
						<label for="search-keyword-nm">프로젝트명</label>
						<input type="text" id="search-keyword-prjnm" class="search-input" value="${prjVO.prjNm}" />
						<label for="search-keyword-rlnm">고객사명</label>
						<input type="text" id="search-keyword-cstmr" class="search-input" value="${prjVO.cstmr}" />
						<button class="btn-search" id="search-btn">&#128269</button>	
					</div>
				</div>
				<div class="grid">
					<div class="grid-count align-right">
						총 ${prjList.size() > 0 ? prjList.get(0).totalCount : 0}건
					</div>
					<table>
							<thead>
									<tr>
										<th><input type="checkbox" id="all_check" /></th>
										<th>프로젝트ID</th>
										<th>프로젝트명</th>
										<th>고객사</th>
										<th>시작일</th>
										<th>종료일</th>
										<th>상태</th>
										<th>사용여부</th>
									</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty prjList}">
										<c:forEach items="${prjList}"
													var="prj">
											<tr data-prjid="${prj.prjId}"
												data-prjnm="${prj.prjNm}"
												data-cstmr="${prj.cstmr}"
												data-strtdt="${prj.strtDt}"
												data-enddt="${prj.endDt}"
												data-prjstts="${prj.prjStts}"
												data-useyn="${prj.useYn}" >
												<td>
													<input type="checkbox" class="check-idx" value="${prj.prjId}" />
												</td>
												<td>${prj.prjId}</td>
												<td><a href="${context}/prj/detail/${prj.prjId}">${prj.prjNm}</a></td>
												<td>${prj.cstmr}</td>
												<td>${prj.strtDt}</td>
												<td>${prj.endDt}</td>
												<td>${prj.prjStts}</td>
												<td>${prj.useYn}</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="9" class="no-items">
												등록된 프로젝트가 없습니다.
											</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
					</table>
					<div class="align-right mt-10">
					</div>
						<c:import url="../include/pagenate.jsp">
		                  <c:param name="pageNo" value="${pageNo}"/>
		                  <c:param name="pageCnt" value="${pageCnt}"/>
		                  <c:param name="lastPage" value="${lastPage}"/>
		                  <c:param name="path" value="${context}/gnr"/>
		               </c:import>
				</div>
				<div class="align-right">
					<button id="new-btn" class="btn-primary">신규</button>
					<button id="delete-btn" class="btn-delete">삭제</button>
				</div>
			<jsp:include page="../include/footer.jsp" />			
		</div>
	</div>
</body>
</html>