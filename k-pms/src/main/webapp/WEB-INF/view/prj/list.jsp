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
	$(".sidebar > ul li a").removeClass("active")
	$("#prj_list").addClass("active");
	
	
	$("#search-btn").click(function() {
		movePage(0);
	});
	
	$("#prjSttsType").change(function(){
		var prjStts = $("#prjSttsType").val();
		console.log(prjStts);
		location.href = "${context}/prj/list?prjStts=" + prjStts;
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
			form.append("<input type='hidden' name='prjId' value='" + $(this).val() + "'/>");
		});
		
		if(!confirm("정말 삭제하시겠습니까?")) {
			return;
		}
		
		$.post("${context}/api/prj/delete", form.serialize(), function(response) {
			if (response.status == "200 OK") {
				location.reload();
			}
			else {
				alert(response.errorCode + " / " + response.message);
			}
		});
		
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
		var searchOption = $("#search-option").val();
		var searchKeyword = $("#search-keyword").val();
		
		var queryString = "pageNo=" + pageNo;
		queryString += "&searchOption=" + searchOption;
		queryString += "&searchKeyword=" + searchKeyword;
		var viewCnt = $("#view_cnt").val();
		queryString += "&viewCnt=" + viewCnt;
		
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
			  <div class="path">프로젝트 목록</div>
		      <div class="search_wrapper">
		        <div class="search_box">
		          <select id="search-option">
			        <option value="prjNm" ${prjVO.searchOption eq "prjNm" ? "selected": ""}>프로젝트명</option>
			        <option value="cstmr" ${prjVO.searchOption eq "cstmr" ? "selected": ""}>고객사명</option>
		          </select>
		          <div class="search_field">
		            <input type="text" id="search-keyword" class="input" placeholder="Search">
		          </div>
		          <div class="search-icon">
		          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
		          </div>
		        </div>
		      </div>
		      <div class="list_section">
				<jsp:include page="../include/viewCnt.jsp" />
		        <div class="total">총 ${prjList.size() > 0 ? prjList.get(0).totalCount : 0}건</div>
		        <table class="list_table">
		          <thead>
		            <tr>
						<th><input type="checkbox" id="all_check" /></th>
						<th>순번</th>
						<th>프로젝트명</th>
						<th>프로젝트 관리번호</th>
						<th>고객사</th>
						<th>시작일</th>
						<th>종료일</th>
						<th>
							<select id="prjSttsType" name="prjSttsType">
								<option value="">프로젝트 상태</option>
								<option value="002_01">분석중</option>
								<option value="002_02">설계중</option>
								<option value="002_03">개발중</option>
								<option value="002_04">단위 테스트 진행중</option>
								<option value="002_05">통합 테스트 진행중</option>
								<option value="002_06">오픈 대기중</option>
								<option value="002_07">오픈</option>
								<option value="002_08">하자 보수 진행중</option>
								<option value="002_09">완료</option>
							</select>
						</th>
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
									<td>${prj.rnum}</td>
									<td><a href="${context}/prj/detail/${prj.prjId}">${prj.prjNm}</a></td>
									<td>${prj.prjId}</td>
									<td>${prj.cstmr}</td>
									<td>${prj.strtDt}</td>
									<td>${prj.endDt}</td>
									<td>${prj.prjStts}</td>
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
					<c:import url="../include/pagenate.jsp">
	                  <c:param name="pageNo" value="${pageNo}"/>
	                  <c:param name="pageCnt" value="${pageCnt}"/>
	                  <c:param name="lastPage" value="${lastPage}"/>
	                  <c:param name="path" value="${context}/prj"/>
	               </c:import>
		        <div class="buttons">
		          <button id="new-btn" class="btn new">신규등록</button>
		          <button id="delete-btn" class="btn delete">선택삭제</button>
		        </div>
		      </div>

			<jsp:include page="../include/footer.jsp" />			
		</div>
	</div>
</body>
</html>