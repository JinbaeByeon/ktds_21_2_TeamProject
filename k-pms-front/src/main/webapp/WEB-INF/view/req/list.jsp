<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />
<c:set scope="request" var="selected" value="prj"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		$(".sidebar > ul li a").removeClass("active")
		$("#req_list").addClass("active");
		
		$("#tskSttsType").val("${reqVO.tskCdNm}").prop("selected", true);
		$("#tskSttsType").change(function(){
			var tskCdNm = $("#tskSttsType").val();
			console.log(tskCdNm);
			location.href = "${context}/req/list?tskCdNm=" + tskCdNm;
		});
		$("#prcsSttsType").val("${reqVO.prcsCdNm}").prop("selected", true);
		$("#prcsSttsType").change(function(){
			
			var prcsCdNm = $("#prcsSttsType").val();
			console.log(prcsCdNm);
			location.href = "${context}/req/list?prcsCdNm=" + prcsCdNm;
		});
		$("#create_btn").click(function(){
			location.href = "${context}/req/create" 
		});
		
		$("#search-btn").click(function(){
			if($("#search-option").val() == "요구사항제목"){
				var reqTtl = $("#search-keyword").val();
				location.href = "${context}/req/list?selectOption=요구사항제목&reqTtl=" + reqTtl;
			}
			if($("#search-option").val() == "프로젝트명"){
				var prjNm = $("#search-keyword").val();
				location.href = "${context}/req/list?selectOption=프로젝트명&reqPrjVO.prjNm=" + prjNm;
			}
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
		$('.detail_value').attr('style', "display:none;");
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
			<jsp:include page="../include/prjSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp" />
				<div class="path"> 요구사항</div>
				<div class="search-group">
					<label for="search-option">검색옵션</label>
					<select id="search-option" class="search-input">
						<option value="요구사항제목" ${reqVO.selectOption eq "요구사항제목" ? "selected" : ""}>요구사항제목</option>
						<option value="프로젝트명"  ${reqVO.selectOption eq "프로젝트명" ? "selected" : ""}>프로젝트명</option>
					</select>
					<label for="search-keyword">검색어</label>
					<input type="text" id="search-keyword" class="search-input"  value="${reqVO.reqTtl}${reqVO.reqPrjVO.prjNm}"/>
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
								<th>요구사항제목</th>
								<th>
									<select id="prcsSttsType" name="prcsSttsType">
										<option value="">진행상태</option>
										<option value="접수">접수</option>
										<option value="분석">분석</option>
										<option value="처리중">처리중</option>
										<option value="처리 완료">처리완료</option>
									</select>
								</th>
								<th>
									<select id="tskSttsType" name="tskSttsType">
										<option value="">일정상태</option>
										<option value="대기중">대기중</option>
										<option value="진행중">진행중</option>
										<option value="연기 필요">연기필요</option>
									</select>
								</th>
								<th>시작일</th>
								<th>종료예정일</th>
								<th>프로젝트명</th>
								<th>우선순위</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty reqList}">
									<c:forEach items="${reqList}"
											   var="req">
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
											<td>${req.reqPrjVO.prjNm}</td>
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