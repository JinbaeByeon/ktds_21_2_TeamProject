<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
	
		$(".grid > table > tbody > tr").click(function() {
			var data = $(this).data();
			$("#msgId").val(data.msgId);
			$("#sndMsgId").val(data.sndMsgId);
			$("#rcvr").val(data.rcvr);
			$("#rdYn").val(data.rdYn);
			
			$("#useYn").prop("checked", data.useyn == "Y");
		});
		
		$("#new_btn").click(function() {
			$("#msgId").val("");
			$("#sndMsgId").val("");
			$("#rcvr").val("");
			$("#rdYn").val("");
			
			$("useYn").prop("checked", false);
		});
		
		$("#delete_btn").click(function() {
			var msgId = $("#msgId").val();
			if (msgId == "") {
				alert("선택된 쪽지가 없습니다.");
				return;
			}
			
			if(!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			$.get("${context}/api/msg/delete" + msgId, function(response) {
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
			
			$.post("${context}/api/rcvmsg/update/",form.serialize(), function(response) {
				if (response.status == "200 OK") {
					location.reload();
				} else {
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		
		$("#reply_btn").click(function() {
			
		});
		
		$("#search-btn").click(function() {
			movePage(0)
		});
		$("#all_check").change(function() {
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		function checkIndex() {
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		}
		
		$(".check_idx").change(function() {
			checkIndex();
		});
		
		$(".grid > table > tbody > tr > td").not(".check").click(function(){
			var check_idx = $(this).closest("tr").find(".check_idx");
			check_idx.prop("checked",check_idx.prop("checked")==false);
			checkIndex();
		});
		
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
		function movePage(pageNo) {
			// 전송
			// 입력 값
			var fNm=$("#search-keyword").val();
			// URL 요청
			location.href= "${context}/rcvmsg/list?fNm=" + fNm + "&pageNo=" + pageNo;
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
			<div class="search-group">
				<label for="search-keyword">발신자명</label>
				<input type="text" id="search-keyword" class="search-input" value="${rcvMsgVO.fNm}"/>
				<button class="btn-search" id="search-btn">&#128269</button>
			</div>
			<div class="grid">
				<div class="grid-count">
					<div class="align-left left">
						<button id="read_btn" class="btn-delete">읽음</button>
						<button id="reply_btn" class="btn-delete">답장</button>
						<button id="delete_btn" class="btn-delete">삭제</button>
					</div>
					<div class="align-right right">
						총 ${rcvList.size() > 0 ? rcvMsgList.get(0).totalCount : 0}건
					</div>
				</div>
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="all_check"/></th>
							<th>조회여부</th>
							<th>제목</th>
							<th>첨부파일</th>
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
										data-attch="${rcvMsg.sndMsgVO.attch}"
										data-crtr="${rcvMsg.crtr}"
										data-crtdt="${rcvMsg.crtDt}">
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
									<td>${rcvMsg.sndMsgVO.attch}</td>
									<td>${rcvMsg.crtr}</td>
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
		</div>
	</div>
</body>
</html>