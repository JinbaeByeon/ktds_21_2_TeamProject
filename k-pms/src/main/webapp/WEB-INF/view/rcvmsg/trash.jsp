<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set scope="request" var="selected" value="msg"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		$(".sidebar > ul li a").removeClass("active")
		$("#msg_trash").addClass("active");
		
		$("#restore_btn").click(function() {
			var form = $("<form></form>")
			var checkIdx = $(".check_idx:checked");
			if(checkIdx.length == 0){
				alert("체크된 쪽지가 없습니다.");
				return;
			}
			var idx = 0;
			checkIdx.each(function() {
				var msgId = $(this).val();
				var type = $(this).closest("tr").data("type");
				form.append("<input type='hidden' name='rcvMsgVOList["+idx+"].msgId' value='"+ msgId +"'>");
				form.append("<input type='hidden' name='rcvMsgVOList["+idx++ +"].type' value='"+ type +"'>");
			});
			if(!confirm("선택된 쪽지를 복원하시겠습니까?")) {
				return;
			}

			$.post("${context}/api/msg/restore",form.serialize(), function(response) {
				if (response.status == "200 OK") {
					location.reload();
				}
				else {
					alert(response.status == "500");
				}
				
				$.post("${context}/api/msg/restore",form.serialize(), function(response) {
					if (response.status == "200 OK") {
						location.reload();
					}
					else {
						alert(response.status == "500");
					}
				});
			})
		});
		
		$("#delete_btn").click(function() {
			var form = $("<form></form>")
			var checkIdx = $(".check_idx:checked");
			if(checkIdx.length == 0){
				alert("체크된 쪽지가 없습니다.");
				return;
			}
			var idx = 0;
			checkIdx.each(function() {
				var msgId = $(this).val();
				var type = $(this).closest("tr").data("type");
				form.append("<input type='hidden' name='rcvMsgVOList["+idx+"].msgId' value='"+ msgId +"'>");
				form.append("<input type='hidden' name='rcvMsgVOList["+idx++ +"].type' value='"+ type +"'>");
			});
			if(!confirm("휴지통의 쪽지를 지우면 지워진 쪽지들은 복구할 수 없습니다.\n쪽지를 삭제하시겠습니까?")) {
				return;
			}

			$.post("${context}/api/msg/delete/trash",form.serialize(), function(response) {
				if (response.status == "200 OK") {
					location.reload();
				}
				else {
					alert(response.status == "500");
				}
			});
		});
		$(".list_table > tbody > tr > td").not(".check").click(function() {
			var data = $(this).closest("tr").data();
			if(data.type){
				if(data.type == 'RM'){
					location.href="${context}/rcvmsg/detail/"+data.msgid;
				} else{
					location.href="${context}/sndmsg/detail/"+data.msgid;
				}
			}
		});
		$("#all_check").change(function() {
			$(".check_idx").prop("checked", $(this).prop("checked"));
			checkBtn();
		});
		function checkIndex(){
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		}
		$(".check_idx").change(function(){
			checkIndex();
		});
			
	});
	function movePage(pageNo) {
		location.href= "${context}/msg/trash?pageNo=" + pageNo;
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/msgSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<div class="path">쪽지 > 휴지통</div>

		      <div class="list_section">
		        <div class="total">총 ${rcvMsgList.size() > 0 ? rcvMsgList.get(0).totalCount : 0}건</div>
		        <table class="list_table">
		          <thead>
		            <tr>
		                <th><input type="checkbox" id="all_check" /></th>
		                <th>제목</th>
		                <th>발신인</th>
		                <th>발신일</th>
		            </tr>
		          </thead>
		          <tbody>
		            <c:choose>
		                <c:when test="${not empty rcvMsgList}">
		                    <c:forEach items="${rcvMsgList}" var="rcvMsg">
		                        <tr data-ttl="${rcvMsg.sndMsgVO.ttl}"
		                            data-crtr="${rcvMsg.crtr}"
		                            data-crtdt="${rcvMsg.crtDt}"
		                            data-type="${rcvMsg.type}"
		                            data-msgid="${rcvMsg.msgId}">
		                            <td class="check">
		                            	<input type="checkbox" class="check_idx" value="${rcvMsg.msgId}" />
		                            </td>
		                            <td>${rcvMsg.sndMsgVO.ttl}</td>
		                            <td>${rcvMsg.crtr}(${rcvMsg.rcvrEmpVO.lNm}${rcvMsg.rcvrEmpVO.fNm})</td>
		                            <td>${rcvMsg.crtDt}</td>
		                        </tr>
		                    </c:forEach>
		                </c:when>
		                <c:otherwise>
		                    <tr>
		                        <td colspan="5" class="no-items">쪽지가 없습니다.</td>
		                    </tr>
		                </c:otherwise>
		            </c:choose>
					
					
		          </tbody>
		        </table>
				    <c:import url="../include/pagenate.jsp">
				        <c:param name="pageNo" value="${pageNo}" />
				        <c:param name="pageCnt" value="${pageCnt}" />
				        <c:param name="lastPage" value="${lastPage}" />
				        <c:param name="path" value="${context}/rcvMsg" />
				    </c:import>

		      </div>
		      
		      	<div class="buttons">
		            <button id="delete_btn" class="btn delete">영구삭제</button>
		            <button id="restore_btn" class="btn restore">복원</button>
		        </div>
		   </div>   		
	</div>
</body>
</html>