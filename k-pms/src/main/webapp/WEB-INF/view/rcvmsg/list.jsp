<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set scope="request" var="selected" value="msg"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	window.onpageshow = function(event){
	    if(event.persisted || (window.performance && window.performance.navigation.type == 2)){
			location.reload();
		}
	}
	$().ready(function() {
		
		$("#delete_btn").click(function() {
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function() {
				console.log($(this).val());
				form.append("<input type='hidden' name='rcvMsgIdList' value='"+ $(this).val() +"'>");
			});
			
			if(!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			$.post("${context}/api/rcvmsg/delete",form.serialize(), function(response) {
				if (response.status == "200 OK") {
					location.reload();
				}
				else {
					alert(response.status == "500");
				}
			});
		});
		
		$("#read_btn").click(function() {
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function() {
				console.log($(this).val());
				form.append("<input type='hidden' name='rcvMsgIdList' value='"+ $(this).val() +"'>");
			});
			
			$.post("${context}/api/rcvmsg/update",form.serialize(), function(response) {
				if (response.status == "200 OK") {
					location.reload();
				} else {
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		
		$("#reply_btn").click(function() {
			// 1. 체크된 VALUE(rcvmsg.msgid)를 가져온다.
			
			var msgId = $(".check_idx:checked").val();
			
			// 1. form에 체크된 메시지의 sndMsgId를 담아서 보낸다. (데이터 중 sndMsgId가 없다면 넣어줘야함)
			// 2. 끝
			location.href = "${context}/sndmsg/send?sndMsgId="+msgId;
		}); 

		$(".list_table > tbody > tr > td").not(".check").click(function() {
			var msgId = $(this).closest("tr").data("msgid");
			location.href="${context}/rcvmsg/detail/"+msgId;
		});
		$("#all_check").change(function() {
			$(".check_idx").prop("checked", $(this).prop("checked"));
			checkBtn();
		});
		
		function checkIndex() {
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
			checkBtn();
		}
		
		function checkBtn(){
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			if(checkCount == 0) {
				$("#read_btn").attr("disabled", true);
				$("#reply_btn").attr("disabled", true);
				$("#delete_btn").attr("disabled", true);
			}
			else if (checkCount == 1) {
				$("#read_btn").attr("disabled", false);
				$("#reply_btn").attr("disabled", false);
				$("#delete_btn").attr("disabled", false);
			}
			else if (checkCount >= 2) {
				$("#read_btn").attr("disabled", false);
				$("#reply_btn").attr("disabled", true);
				$("#delete_btn").attr("disabled", false);
			}
		}
		
		$(".check_idx").change(function() {
			checkIndex();
		});
		
		$(".list_table > tbody > tr > td").not(".check").click(function(){
			var check_idx = $(this).closest("tr").find(".check_idx");
			check_idx.prop("checked",check_idx.prop("checked")==false);
			checkIndex();
		});
		
	});
	function movePage(pageNo) {
		
		var searchType = $("#searchType").val();
		// 전송
		// 입력 값
		
		if(searchType == "id") {
			var empId = $("#searchBar").val();
			location.href= "${context}/rcvmsg/list?searchType=ID&sndEmpId=" + empId + "&pageNo=" + pageNo;
		}
		else if(searchType == "sndrNm") {
			var nm = $("#searchBar").val();
			location.href= "${context}/rcvmsg/list?searchType=발신자명&nm=" + nm + "&pageNo=" + pageNo;
		}
		
		// URL 요청
		
		
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp"/>
		<div>
			<jsp:include page="../include/msgSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp"/>
			<div class="path">쪽지 > 받은쪽지함</div>
		      <div class="search_wrapper">
		      <form>
		      	<div class="msg_buttons">
		      	  <button type="button" id="read_btn" class="btn read msg" disabled>읽음</button>
		          <button type="button" id="reply_btn" class="btn reply msg" disabled>답장</button>
		          <button type="button" id="delete_btn" class="btn delete msg" disabled>삭제</button>
		         </div>
		        <div class="search_box">
		          <select class="search-option" id="searchType" name="searchType">
		            <option value="id" ${searchType eq "id" ? "selected" : ""}>ID</option>
		            <option value="sndrNm" ${searchType eq "sndrNm" ? "selected" : ""}>발신자명</option>
		        </select>
		          <div class="search_field">
		          	<input type="text" id="searchKeyword" name="searchKeyword" class="input" value="${rcvMsgVO.searchKeyword}" placeholder="Search"/>
		          </div>
		          <div class="search-icon">
		          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
		          </div>
		        </div>
		        </form>
		      </div>
		      <div class="list_section">
		        <div class="total">총 ${rcvMsgList.size() > 0 ? rcvMsgList.get(0).totalCount : 0}건</div>
		        <table class="list_table">
		          <thead>
		            <tr>
						<th><input type="checkbox" id="all_check"/></th>
		                <th>조회여부</th>
		                <th>제목</th>
		                <th>발신인</th>
		                <th>발신일</th>
		            </tr>
		          </thead>
		          <tbody>
		            <c:choose>
		                <c:when test="${not empty rcvMsgList}">
		                    <c:forEach items="${rcvMsgList}"
		                               var="rcvMsg">
		                        <tr data-rdyn="${rcvMsg.rdYn}"
		                            data-ttl="${rcvMsg.sndMsgVO.ttl}"
		                            data-crtr="${rcvMsg.crtr}"
		                            data-crtdt="${rcvMsg.crtDt}"
		                            data-msgid="${rcvMsg.msgId}">
		                        <td class="check">
		                            <input type="checkbox" class="check_idx" value="${rcvMsg.msgId}"/>
		                        </td>
		                        <td>
		                            <c:if test="${rcvMsg.rdYn eq 'N'}">
		                                <img src="${context}/img/NR.png" id="previewPrfl" class="profile" />
		                            </c:if>
		                            <c:if test="${rcvMsg.rdYn eq 'Y'}">
		                                <img src="${context}/img/R.png" id="previewPrfl" class="profile" />
		                            </c:if>
		                        </td>
		                        <td>${rcvMsg.sndMsgVO.ttl}</td>
		                        <td>${rcvMsg.crtr} (${rcvMsg.sndMsgVO.sndEmpVO.lNm}${rcvMsg.sndMsgVO.sndEmpVO.fNm})</td>
		                        <td>${rcvMsg.crtDt}</td>
		                        </tr>
		                    </c:forEach>
		                </c:when>
		                <c:otherwise>
		                    <tr>
		                        <td colspan="6" class="no-items">
		                        받은 쪽지가 없습니다.
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
				          <c:param name="path" value="${context}/rcvMsg"/>
				    </c:import>
		      </div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>