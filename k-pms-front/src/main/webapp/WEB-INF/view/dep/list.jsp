<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />
<c:set scope="request" var="selected" value="dep"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	
var depHd;

function addHdEmpFn(message) {
	
	var depHdIdItems = $("#addDepHeadBtn").find(".items");
	if (depHdIdItems.find("." + message.empid).length > 0) {
		alert(message.lnm + message.fnm + "은(는) 이미 추가된 부서장입니다.");
		return;
	}
	
	var itemDiv = depHdIdItems.find(".head-item");
	
	var itemId = itemDiv.find("#depHdId")
	console.log(message.empid);
	itemId.val(message.empid);
	itemDiv.append(itemId);
	
	var itemSpan = itemDiv.find("span");
	itemSpan.text(message.lnm + message.fnm);
	itemDiv.append(itemSpan);
	
	$("#depHdId").val(message.empid);
	$("#depHdId").attr("class", message.empid);
	console.log(message.lnm + message.fnm);
	$("#depHdNm").text(message.lnm + message.fnm);
	
	depHdIdItems.append(itemDiv);
	
	depHd.close();
}

$().ready(function() {
	$(".sidebar > ul li a").removeClass("active")
	$("#dep_list").addClass("active");
	
	$("#search-btn").click(function() {
		movePage(0);
	});
	
	
});
	 function movePage(pageNo) {
		var searchOption = $("#search-option").val();
		var searchKeyword = $("#search-keyword").val();
		var queryString = "?pageNo=" + pageNo;
		queryString += "&searchOption=" + searchOption;
		queryString += "&searchKeyword=" + searchKeyword;
		
		location.href = "${context}/dep/list" + queryString;
	}
		 
		 
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/depSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
				<div class="path">부서 > 부서 목록</div>
			      <div class="search_wrapper">
			        <div class="search_box">
			          <select id="search-option">
			            <option value="depNm" ${depVO.searchOption eq "depNm" ? "selected": ""}>부서명</option>
						<option value="tmNm" ${depVO.searchOption eq "tmNm" ? "selected": ""}>팀명</option>
						<option value="hdNm" ${depVO.searchOption eq "hdNm" ? "selected": ""}>부서장명</option>
						<option value="tmHdNm" ${depVO.searchOption eq "tmHdNm" ? "selected": ""}>팀장명</option>
			          </select>
			          <div class="search_field">
			          	<input type="text" id="search-keyword" class="input" placeholder="Search"/>
			          </div>
			          <div class="search-icon">
			          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
			          </div>
			        </div>
			      </div>
			      <div class="list_section">
			        <div class="total">총 ${depList.size() > 0 ? depList.get(0).totalCount : 0}건  </div>
			        <table class="list_table">
			          <thead>
			            <tr>
							<th>순번</th>
							<th>부서명</th>
							<th>부서장명</th>
							<th>부서생성일</th>
<!-- 							<th>등록자</th>
							<th>등록일</th>
							<th>수정자</th>
							<th>수정일</th> -->
			            </tr>
			          </thead>
			          <tbody>
							<c:choose>
								<c:when test="${not empty depList}">
									<c:forEach items="${depList}"
												var="dep"
												varStatus="index">
										<tr data-depid="${dep.depId}"
											data-depnm="${dep.depNm}"
											data-dephdid="${dep.depHdId}"
											data-depcrtdt="${dep.depCrtDt}"
											data-useyn="${dep.useYn}"
											data-crtr="${dep.crtr}"
											data-crtdt="${dep.crtDt}"
											data-mdfyr="${dep.mdfyr}"
											data-mdfydt="${dep.mdfyDt}">
											<td>${dep.rnum}</td>
											<td><a href="${context}/dep/detail/${dep.depId}">${dep.depNm}</a></td>
											<td>${dep.hdNmEmpVO.lNm}${dep.hdNmEmpVO.fNm}</td>
											<td>${dep.depCrtDt}</td>
<%-- 											<td>${dep.crtr}(${dep.crtrEmpVO.lNm}${dep.crtrEmpVO.fNm})</td>
											<td>${dep.crtDt}</td>
											<td>${dep.mdfyr}(${dep.mdfyrEmpVO.lNm}${dep.mdfyrEmpVO.fNm})</td>
											<td>${dep.mdfyDt}</td> --%>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="4" class="no-items">
											등록된 부서가 없습니다.
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
	                  		<c:param name="path" value="${context}/dep"/>
						</c:import>
			      </div>
			      
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>