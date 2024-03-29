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
<title>팀 목록</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	
	var depId;
	
	function addDepFn(message) {
		
		var depItems = $("#addDepIdBtn").closest(".create-group").find(".items");
		if (depItems.find("." + message.depid).length > 0) {
			alert(message.depnm + "은(는) 이미 추가된 부서입니다.");
			return;
		}
		
		var itemDiv = depItems.find(".dep-item");
			
		var itemId = itemDiv.find("#depId")
		itemId.val(message.depid);
		itemDiv.append(itemId);
		
		var itemSpan = itemDiv.find("span");
		itemSpan.text(message.depnm);
		itemDiv.append(itemSpan);
		
		var itemRemoveBtn = $("<button>X</button>");
		itemRemoveBtn.click(function() {
			$(this).closest("." + message.depid).remove();
		});
		itemDiv.append(itemRemoveBtn);
		
		depItems.append(itemDiv);
		
		depId.close();
		
	} 
	
	$().ready(function() {
		$(".sidebar > ul li a").removeClass("active")
		$("#tm_list").addClass("active");
		
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
		
		location.href = "${context}/tm/list" + queryString;
		 
	} 
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/depSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
				<div class="path">부서 > 팀 조회</div>
		      <div class="search_wrapper">
		        <div class="search_box">
		          <select id="search-option" class="search-input">
					    <option value="tmNm" ${tmVO.searchOption eq "tmNm" ? "selected": ""}>팀명</option>
					    <option value="depNm" ${tmVO.searchOption eq "depNm" ? "selected": ""}>부서명</option>
					    <option value="hdNm" ${tmVO.searchOption eq "hdNm" ? "selected": ""}>팀장명</option>
					    <option value="mbrNm" ${tmVO.searchOption eq "mbrNm" ? "selected": ""}>팀원명</option>
					</select> 
		          <div class="search_field">
		          	<input type="text" id="search-keyword" class="input" value="${tmVO.searchKeyword}" />
		          </div>
		          <div class="search-icon">
		          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
		          </div>
		        </div>
		      </div>
		      <div class="list_section">
		        <div class="total"> 총 ${tmList.size() > 0 ? tmList.get(0).totalCount : 0}건</div>
		        <table class="list_table">
		          <thead>
		            <tr>
			              <th>순번</th>
			              <th>부서명</th>
			              <th>팀명</th>
			              <th>팀장명</th>
			              <th>팀생성일</th>
<!-- 			              <th>등록자</th>
			              <th>등록일</th>
			              <th>수정자</th>
			              <th>수정일</th> -->
		            </tr>
		          </thead>
		          <tbody>
		            <c:choose>
		                <c:when test="${not empty tmList}">
		                    <c:forEach items="${tmList}"
		                                var="tm"
		                                varStatus="index">
		                        <tr data-depid="${tm.depId}"
		                            data-depnm="${tm.depIdDepVO.depNm}"
		                            data-tmid="${tm.tmId}"
		                            data-tmnm="${tm.tmNm}"
		                            data-tmhdid="${tm.tmHdId}"
		                            data-tmcrtdt="${tm.tmCrtDt}"
		                            data-useyn="${tm.useYn}"
		                            data-crtr="${tm.crtr}" 
		                            data-crtdt="${tm.crtDt}"
		                            data-mdfyr="${tm.mdfyr}"
		                            data-mdfydt="${tm.mdfyDt}">
		                            <td>${tm.rnum}</td>
		                            <td>${tm.depIdDepVO.depNm}</td>
		                            <td><a href="${context}/tm/detail/${tm.tmId}">${tm.tmNm}</a></td>
		                            <td>${tm.tmHdEmpVO.lNm}${tm.tmHdEmpVO.fNm}</td>
		                            <td>${tm.tmCrtDt}</td>
<%-- 		                            <td>${tm.crtr}</td>
		                            <td>${tm.crtDt}</td>
		                            <td>${tm.mdfyr}</td>
		                            <td>${tm.mdfyDt}</td> --%>
		                        </tr>
		                    </c:forEach>
		                </c:when>
		                <c:otherwise>
		                    <tr>
		                        <td colspan="12" class="no-items">
		                            등록된 팀이 없습니다.
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
			          <c:param name="path" value="${context}/tm"/>
			    </c:import>
		      </div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>