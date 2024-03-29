<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set scope="request" var="selected" value="msg"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보낸 쪽지함</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		$("#sndmsg_list").addClass("active");
		
		$("#new_btn").click(function() {
			$("#msgId").val("");
			$("#ttl").val("");
			$("#cntnt").val("");
			
			$("useYn").prop("checked", false);
		});
		
		$("#delete_btn").click(function() {
			var form = $("<form></form>")
			var checkIdx = $(".check_idx:checked");
			if(checkIdx.length == 0){
				alert("체크된 쪽지가 없습니다.");
				return;
			}
			checkIdx.each(function() {
				console.log($(this).val());
				form.append("<input type='hidden' name='sndMsgIdList' value='"+ $(this).val() +"'>");
			});
			
			if(!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			$.post("${context}/api/sndmsg/delete",form.serialize(), function(response) {
				if (response.status == "200 OK") {
					location.reload();
				}
				else {
					alert(response.status == "500");
				}
			});
		});
		$(".list_table > tbody > tr > td").not(".check").click(function() {
			var msgId = $(this).closest("tr").data("msgid");
			if(msgId){
				location.href="${context}/sndmsg/detail/"+msgId;
			}
		});
		$("#all_check").change(function() {
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		function checkIndex() {
			var count = $(".check_idx").length;
			var checkCount = $(".chck_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		}
		
		$(".check_idx").change(function() {
			checkIndex(); 
		});
		$(".check_idx").click(function(e){
			$(this).prop("checked",$(this).prop("checked")==false);
		});
		
		$(".list_table > tbody > tr > td.check").click(function(){
			var check_idx = $(this).closest("tr").find(".check_idx");
			check_idx.prop("checked",check_idx.prop("checked")==false);
			checkIndex();
		});

		$("#search-keyword").keydown(function(e){
			if(e.keyCode == '13'){
				movePage(0);
			}
		});
		$("#search-btn").click(function() {
			movePage(0)
		});
		
	});
	function movePage(pageNo) {
		var searchType = $("#searchType").val();
		var viewCnt = $("#view_cnt").val();
		var search = $("#search-keyword").val();
		
		var qryStr = "?pageNo=" + pageNo;
		qryStr += "&viewCnt=" + viewCnt;
		qryStr += "&searchKeyword=" + search;
		qryStr += "&searchType="+searchType;
		
		location.href = "${context}/sndmsg/list" + qryStr;
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp"/>
		<div>
			<jsp:include page="../include/msgSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp"/>
			<div class="path">쪽지 > 보낸쪽지함</div>
		      <div class="search_wrapper">
		      	<div class="msg_buttons">
		          <button type="button" id="delete_btn" class="btn delete msg" >삭제</button>
		         </div>
		        <div class="search_box">
		          <select id="searchType">
					<option value="ID" ${searchType eq "ID" ? "selected" : ""}>사원 ID</option>
					<option value="rcvrNm" ${searchType eq "rcvrNm" ? "selected": ""}>수신자명</option>
		          </select>
		          <div class="search_field">
		          	<input type="text" id="search-keyword" class="input" value="${sndMsgVO.searchKeyword}" placeholder="Search"/>
		          </div>
		          <div class="search-icon">
		          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
		          </div>
		        </div>
		      </div>
		      <div class="list_section">
				<jsp:include page="../include/viewCnt.jsp" />
		        <div class="total">총 ${sndMsgList.size() > 0 ? sndMsgList.get(0).totalCount : 0}건</div>
		        <table class="list_table">
		          <thead>
		            <tr>
		                <th><input type="checkbox" id="all_check"/></th>
		                <th>제목</th>
		                <th>수신자</th>
		                <th>발신일</th>
		            </tr>
		          </thead>
		          <tbody>
		            <c:choose>
		                <c:when test="${not empty sndMsgList}">
		                    <c:forEach items="${sndMsgList}"
		                               var="sndMsg">
		                        <tr data-rcvr="${sndMsg.rcvMsgVO.get(0).rcvr}"
		                            data-ttl="${sndMsg.ttl}"
		                            data-crtdt="${sndMsg.crtDt}"
		                            data-msgid="${sndMsg.msgId}">
		                            <td class="check">
		                                <input type="checkbox" class="check_idx" value="${sndMsg.msgId}"/>
		                            </td>
		                            <td>${sndMsg.ttl}</td>
		                            <td>${sndMsg.rcvMsgVO.get(0).rcvr} (${sndMsg.rcvMsgVO.get(0).rcvrEmpVO.lNm}${sndMsg.rcvMsgVO.get(0).rcvrEmpVO.fNm})</td>
		                            <td>${sndMsg.crtDt}</td>
		                        </tr>
		                    </c:forEach>
		                </c:when>
		                <c:otherwise>
		                    <tr>
		                        <td colspan="6" class="no-items">
		                        보낸 쪽지가 없습니다.
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
				          <c:param name="path" value="${context}/sndMsg"/>
				    </c:import>

		      </div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>