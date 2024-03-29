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
<title>팀 관리</title>
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
		
		var pageNo = "${pageNo}";
		if (${empty tmList} && pageNo > 0) {
			movePage(pageNo -1);
		}
		
		$("#new_btn").click(function() {
			location.href = "${context}/tm/create"
		});
		
		$("#search-keyword").keydown(function(e){
			if(e.keyCode == '13'){
				movePage(0);
			}
		});
		
		$("#search-btn").click(function() {
			movePage(0);
		});
		
		$("#all_check").change(function() {
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		$(".check_idx").change(function() {
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("#delete_all_btn").click(function() {
			var checkLen = $(".check_idx:checked").length;
			if (checkLen == 0) {
				alert("삭제할 팀이 없습니다.");
				return;
			}
			
			if (!confirm("정말 삭제하시겠습니까?")) {
			return;
			}
			
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function() {
				console.log($(this).val());
				form.append("<input type='hidden' name='tmId' value='" + $(this).val() + "'>"); 
			});
			
			$.post("${context}/api/tm/delete", form.serialize(), function(response) {
				if (response.status == "200 OK") {
					location.reload();
				}
				else {
					alert(response.message);
				}
			});
		});
		
		$("#addTmHeadBtn").click(function(event) {
			event.preventDefault(); 
			var tmHd = window.open("${context}/emp/search", "팀장 검색", "width=600,height=700");
		});
		
		$("#addDepIdBtn").click(function(event) {
			event.preventDefault();
			depId = window.open("${context}/dep/search", "부서 검색", "width=500,height=600");
		});
		
		$(".tm-tbody > tr > td").not(".check").click(function() {
			var tmId = $(this).closest("tr").data("tmid");
			location.href = "${context}/tm/detail/"+ tmId;
		});
		
	});
	
	function movePage(pageNo) {
		var searchOption = $("#search-option").val();
		var searchKeyword = $("#search-keyword").val();
		var queryString = "?pageNo=" + pageNo;
		queryString += "&searchOption=" + searchOption;
		queryString += "&searchKeyword=" + searchKeyword;

		var viewCnt = $("#view_cnt").val();
		queryString += "&viewCnt=" + viewCnt;
		
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
				<div class="path">부서 > 팀 관리</div>
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
				<jsp:include page="../include/viewCnt.jsp" />
		        <div class="total"> 총 ${tmList.size() > 0 ? tmList.get(0).totalCount : 0}건</div>
		        <table class="list_table">
		          <thead>
		            <tr>
						<th><input type="checkbox" id="all_check" /></th>
			              <th>순번</th>
			              <th>팀명</th>
			              <th>팀 관리번호</th>
			              <th>팀장ID</th>
			              <th>팀장명</th>
			              <th>부서명</th>
			              <th>부서 관리번호</th>
			              <th>팀생성일</th>
			              <th>사용여부</th>
		            </tr>
		          </thead>
		          <tbody class="tm-tbody">
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
		                            <td class="check">
		                                <input type="checkbox" class="check_idx" value="${tm.tmId}"/>
		                            </td>
		                            <td>${tm.rnum}</td>
		                            <td>${tm.tmNm}</td>
		                            <td>${tm.tmId}</td>
		                            <td>${tm.tmHdId}</td>
		                            <td>${tm.tmHdEmpVO.lNm}${tm.tmHdEmpVO.fNm}</td>
		                            <td>${tm.depIdDepVO.depNm}</td>
		                            <td>${tm.depId}</td>
		                            <td>${tm.tmCrtDt}</td>
		                            <td>${tm.useYn}</td>
		                        </tr>
		                    </c:forEach>
		                </c:when>
		                <c:otherwise>
		                    <tr>
		                        <td colspan="9" class="no-items">
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
		        <div class="buttons">
		          <button id="new_btn" class="btn new">신규등록</button>
		          <button id="delete_all_btn" class="btn delete">선택삭제</button>
		        </div>
		      </div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>