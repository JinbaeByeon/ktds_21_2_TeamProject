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
	
  $('.list_table th').each(function (column) {
	   var sortdir
	    $(this).click(function() {
	      if($(this).is('.asc')) {
	        $(this).removeClass('asc');
	        $(this).addClass('desc');
	        sortdir=-1;

	      } else {
	        $(this).addClass('asc');
	        $(this).removeClass('desc'); sortdir=1;
	      }

	      $(this).siblings().removeClass('asc');
	      $(this).siblings().removeClass('desc');

	      var rec = $('.list_table').find('tbody>tr').get();
		
	      console.log(rec);
	      rec.sort(function (a, b) {
	        var val1 = $(a).children('td').eq(column).text().toUpperCase();
	        var val2 = $(b).children('td').eq(column).text().toUpperCase();
	        return (val1 < val2)?-sortdir:(val1>val2)?sortdir:0;
	      });

	      $.each(rec, function(index, row) {
	          $('.list_table tbody').append(row);
	      });
	    });
	 });

	
});
	function movePage(pageNo) {
		var searchOption = $("#search-option").val();
		var searchKeyword = $("#search-keyword").val();
		
		var queryString = "pageNo=" + pageNo;
		queryString += "&searchOption=" + searchOption;
		queryString += "&searchKeyword=" + searchKeyword;
		
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
		        <div class="total">총 ${prjList.size() > 0 ? prjList.get(0).totalCount : 0}건</div>
		        <table class="list_table">
		          <thead>
		            <tr>
		            	<th>순번</th>
						<th>프로젝트명</th>
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
									<td>${prj.rnum}</td>
									<td><a href="${context}/prj/detail/${prj.prjId}">${prj.prjNm}</a></td>
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
		      </div>

			<jsp:include page="../include/footer.jsp" />			
		</div>
	</div>
</body>
</html>