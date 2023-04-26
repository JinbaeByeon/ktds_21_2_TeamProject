<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		$("#restore_btn").click(function() {
			var form = $("<form></form>")
		})
		
		$("#delete_btn").click(function() {
			var form = $("<form></form>")
			var checkIdx = $(".check_idx:checked");
			if(checkIdx.length == 0){
				alert("체크된 메시지가 없습니다.");
				return;
			}
			
			checkIdx.each(function() {
				console.log($(this).val());
				form.append("<input type='hidden' name='rcvMsgIdList' value='"+ $(this).val() +"'>");
			});
			if(!confirm("휴지통의 쪽지를 지우면 지워진 쪽지들은 복구할 수 없습니다.\n쪽지를 삭제하시겠습니까?")) {
				return;
			}
			//snd와 rcv같이 삭제할수있는건 어떻게해야하느닞
			$.post("${context}/api/msg/delete/trash",form.serialize(), function(response) {
				if (response.status == "200 OK") {
					location.reload();
				}
				else {
					alert(response.status == "500");
				}
			});
		});
		
		function checkIndex() {
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
			checkBtn();
		}
			
			
		$("#delete_all_btn").click(function() {
			var checkLen = $(".check_idx:checked").length;
			if(checkLen == 0) {
				alert("삭제할 쪽지가 없습니다.");
				return;
			}
					
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function() {
				console.log($(this).val());
				form.append("<input type='hidden' name='rcvMsgIdList' value='"+ $(this).val() +"'>");
			});
			
			$.post("${context}/api/rcvmsg/delete", form.serialize(), function(response) {
				location.reload(); // 새로고침
			});
		});
	});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/msgSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<div class="path">쪽지 > 휴지통</div>
			<div class="grid">
				<div class="grid-count">
					<div class="align-left left">
						<button id="delete_btn" class="btn-delete">영구삭제</button>
						<button id="restore_btn" class="btn-restore">복원</button>
					</div>
					<div class="align-right right">총 ${msgList.size() > 0 ? msgList.get(0).totalCount : 0}건
					</div>
				</div>
				<table>
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
										data-crtr="${rcvMsg.crtr}" data-crtdt="${rcvMsg.crtDt}">
										<td class="check"><input type="checkbox"
											class="check_idx" value="${rcvMsg.msgId}" /></td>
										<td>${rcvMsg.sndMsgVO.ttl}</td>
										<td>${rcvMsg.crtr}(${rcvMsg.rcvrEmpVO.lNm}
											${rcvMsg.rcvrEmpVO.fNm})</td>
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
		</div>
	</div>
</body>
</html>