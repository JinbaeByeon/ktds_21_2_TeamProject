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
			$("#ttl").val(data.ttl);
			$("#cntnt").val(data.cntnt);
			$("#attch").val(data.attch);
			
			$("#useYn").prop("checked", data.useyn == "Y");
		});
		
		$("#new_btn").click(function() {
			$("#msgId").val("");
			$("#ttl").val("");
			$("#cntnt").val("");
			$("#attch").val("");
			
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
		
		$("#search-btn").click(function() {
			movePage(0)
		});
		$("#all_check").change(function() {
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		function checkIndex() {
			var count = $(".check_idx").length;
			var checkCount = $(".chck_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		}
		
		$(".check_idx").chang(function() {
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
				form.append("<input type='hidden' name='msgId' value='"+ $(this).val() +"'>");
			});
			
			$.post("${context}/api/job/delete", form.serialize(), function(response) {
				location.reload(); // 새로고침
			});
		});
	});
		function movePage(pageNo) {
			// 전송
			// 입력 값
			var searchRcvr=$("#search-keyword").val();
			// URL 요청
			location.href= "${context}/msg/list?searchRcvr=" + searchRcvr + "&pageNo=" + pageNo;
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
			<div class="search-group">
				<label for="search-keyword">수신자명</label>					
				<input type="text" id="search-keyword" class="search-input" value="${searchRcvr}"/>
				<button class="btn-search" id="search-btn">&#128269</button>
			</div>
			<div class="grid">
				<div class="grid-count">
					<div class="align-left left">
						<button id="delete_btn" class="btn-delete">삭제</button>
					</div>
					<div class="align-right right">
						총 ${sndList.size() > 0 ? sndMsgList.get(0).totalCount : 0}건
					</div>
				</div>
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="all_check"/></th>
							<th>조회여부</th>
							<th>수신자</th>
							<th>제목</th>
							<th>내용</th>
							<th>첨부파일</th>
							<th>발신일</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty sndMsgList}">
								<c:forEach items="${sndMsgList}"
										   var="sndMsg">
									<tr data-rdyn="${sndMsg.rdYn}"
										data-crtr="${sndMsg.crtr}"
										data-ttl="${sndMsg.ttl}"
										data-crtr="${sndMsg.cntnt}"
										data-attch="${sndMsg.attch}"
										data-crtdt="${sndMsg.crtDt}">
										<td>
											<input type="checkbox" class="check_idx" value="${rcvMsg.msgId}"/>
										</td>
										<td>${sndMsg.rdYn}</td>
										<td>${sndMsg.crtr}</td>
										<td>${sndMsg.ttl}</td>
										<td>${sndMsg.cntnt}</td>
										<td>${sndMsg.attch}</td>
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
		</div>
	</div>
</body>
</html>ml>