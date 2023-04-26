<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />
<c:set scope="request" var="selected" value="prj"/>
<c:set var="admnYn" value="${sessionScope.__USER__.admnYn}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		$(".grid > table > tbody > tr").click(function(){
			
			$("#isModify").val("true"); //수정모드
			
			var data = $(this).data();
			
			$("#reqId").val(data.reqid);
			$("#dtlReq").val(data.dtlreq);
			$("#crtr").val(data.crtr);
			$("#crtDt").val(data.crtdt);
			$("#mdfyr").val(data.mdfyr);
			$("#mdfyDt").val(data.mdfydt);
			$("#strtDt").val(data.strtdt);
			$("#expctEndDt").val(data.expctenddt);
			$("#attch").val(data.attch);
			$("#prjId").val(data.prjid);
			$("#mnDvlpr").val(data.mndvlpr);
			$("#tstRslt").val(data.tstrslt);
			$("#tskStts").val(data.tskstts);
			$("#prcsStts").val(data.prcsstts);
			$("#prrty").val(data.prrty);
			$("#reqTtl").val(data.reqttl);
			
			$("#useYn").prop("checked", data.useyn == "Y");
			
		});
		
		$("#delete_btn").click(function(){
			var reqId = $("#reqId").val();
			if(reqId == ""){
				alert("선택된 요구사항이 없습니다.");
				return;
			}
			
			if(!confirm("정말 삭제하시겠습니까?")){
				return;
			}
			
			$.get("${context}/api/req/delete/" + reqId, function(response){
				if(response.status == "200 OK"){
					location.reload(); //새로고침
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			})
		});
					
		$("#create_btn").click(function(){
			location.href = "${context}/req/create" 
		});
		
		$("#search-btn").click(function(){
			var reqId =$("#search-keyword").val();
			location.href = "${context}/req/list?reqId=" + reqId;
			
		})
		
		$(".detail_path").click(function(){
			var reqId =$(this).closest("tr").data("reqid");
			location.href = "${context}/req/detail/" + reqId;
			
		});
		
		$("#all_check").change(function(){
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		$(".check_idx").change(function(){
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		
		$("#delete_all_btn").click(function(){
			var checkLen = $(".check_idx:checked").length;
			if(checkLen == 0) {
				alert("삭제할 요구사항이 없습니다.");
				return;
			}
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='reqId' value='" + $(this).val() +"'>");
			});
			
			$.post("${context}/api/req/delete", form.serialize(), function(response){
				if(response.status == "200 OK"){
					location.reload(); //새로고침
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
	});
	
	function movePage(pageNo) {
		// 전송
		// 입력값
		var reqId = $("#search-keyword").val();
		// URL 요청
		location.href = "${context}/req/list?reqId=" + reqId + "&pageNo=" + pageNo;
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/reqSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp" />
				<div class="path"> 요구사항</div>
				<div class="search-group">
					<label for="search-keyword">요구사항ID</label>
					<input type="text" id="search-keyword" class="search-input"  value="${reqVO.reqId}"/>
					<button class="btn-search" id="search-btn">검색</button>
				</div>
				
				<div class="grid">
					<div class="grid-count align-right">
						총 ${reqList.size() > 0 ? reqList.get(0).totalCount : 0}건
					</div>
					<table>
						<thead>
							<tr>
								<th><input type="checkbox" id="all_check"/></th>
								<th>순번</th>
								<th>요구사항ID</th>
								<th>요구사항제목</th>
								<th>진행상태</th>
								<th>일정상태</th>
								<th>시작일</th>
								<th>종료예정일</th>
								<th>프로젝트ID</th>
								<th>우선순위</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty reqList}">
									<c:forEach items="${reqList}"
											   var="req"
											   varStatus="index">
										<tr data-reqid="${req.reqId}"
											data-reqttl="${req.reqTtl}"
											data-strtdt="${req.strtDt}"
											data-expctenddt="${req.expctEndDt}"
											data-eqpprc="${req.prjId}"
											data-prchsdt="${req.prrty}"
											data-prcsstts="${req.prcsStts}"
											data-tskstts="${req.tskStts}"
											data-tskcdnm="${req.tskCdNm}"
											data-prcscdnm="${req.prcsCdNm}"
											data-rsltcdnm="${req.rsltCdNm}"
											data-useyn="${req.useYn}"
											data-crtr="${req.crtr}"
											data-crtdt="${req.crtDt}"
											data-mdfyr="${req.mdfyr}"
											data-mdfydt="${req.mdfyDt}"
											data-delyn="${req.delYn}">
											<td>
												<input type="checkbox" class="check_idx" value="${req.reqId}">
											</td>
											<td>${req.rnum}</td>
											<td class="detail_value">${req.reqId}</td>
											<td class="detail_path">${req.reqTtl}</td>
											<td>${req.prcsCdNm}</td>
											<td>${req.tskCdNm}</td>
											<td>${req.strtDt}</td>
											<td>${req.expctEndDt}</td>
											<td>${req.prjId}</td>
											<td>${req.prrty}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="10" class="no-items">
											등록된 요구사항이 없습니다.
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div class="align-right mt-10">
						<button id="create_btn" class="btn-primary">추가</button>
						<button id="delete_all_btn" class="btn-delete">삭제</button>
					</div>
					<c:import url="../include/pagenate.jsp">
	                  <c:param name="pageNo" value="${pageNo}"/>
	                  <c:param name="pageCnt" value="${pageCnt}"/>
	                  <c:param name="lastPage" value="${lastPage}"/>
	                  <c:param name="path" value="${context}/req"/>
	               	</c:import>
				</div>	
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>