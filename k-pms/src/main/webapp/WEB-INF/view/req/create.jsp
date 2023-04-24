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
			$("#tslStts").val(data.tslstts);
			$("#prcsStts").val(data.prcsstts);
			$("#prrty").val(data.prrty);
			$("#reqTtl").val(data.reqttl);
			
			$("#useYn").prop("checked", data.useyn == "Y");
			
		});
		
		$("#new_btn").click(function(){
			$("#isModify").val("false"); //등록모드
			
			$("#reqId").val("");
			$("#dtlReq").val("");
			$("#crtr").val("");
			$("#crtDt").val("");
			$("#mdfyr").val("");
			$("#mdfyDt").val("");
			$("#strtDt").val("");
			$("#expctEndDt").val("");
			$("#attch").val("");
			$("#prjId").val("");
			$("#mnDvlpr").val("");
			$("#tstRslt").val("");
			$("#tslStts").val("");
			$("#prcsStts").val("");
			$("#prrty").val("");
			$("#reqTtl").val("");
			
			
			$("#useYn").prop("checked", false);
		});
		
		$("#delete_btn").click(function(){
			location.href = "${context}/req/list";
		});
					
		$("#save_btn").click(function(){
			var ajaxUtil = new AjaxUtil();
			if($("#isModify").val() == "false"){
				// 신규등록	
				ajaxUtil.upload("#detail_form","${context}/api/req/create",function(response){
					if(response.status == "200 OK"){
						location.reload(); //새로고침
					}	
					else{
						alert(response.errorCode + "/" + response.message);
					}
				});
			}
			else {
				//수정
				ajaxUtil.upload("#detail_form","${context}/api/req/update",function(response){
					if(response.status == "200 OK"){
						location.reload(); //새로고침
					}	
					else{
						alert(response.errorCode + "/" + response.message);
					}
				});
			}
		});
		
		$(".detail_path").click(function(){
			var reqId =$(this).closest("tr").data("reqid");
			location.href = "${context}/req/detail?reqId=" + reqId;
			
		});
		
		$("#search-btn").click(function(){
			var reqId =$("#search-keyword").val();
			location.href = "${context}/req/list?reqId=" + reqId;
			/* movePage(0) */
			
		})
		
		$("#prj_search").click(function(event){
			event.preventDefault();
			window.open("${context}/prj/search",
					"프로젝트 검색", "width=500, height=500");
		});

		$("#prjtmmbr_search").click(function(event){
			event.preventDefault();
			var open = window.open("${context}/prjtmmbr/search?prjId=" + $("#prjId").val(),
					"프로젝트팀원 검색", "width=500, height=500");
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
	
	function addPrjFn(data) {
		
		$("#prjId").val(data.prjid);
		
	}
	
	function movePage(pageNo) {
		// 전송
		// 입력값
		var reqId = $("#search-keyword").val();
		// URL 요청
		location.href = "${context}/req/create?reqId=" + reqId + "&pageNo=" + pageNo;
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/reqSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp" />
				<div class="path"> 요구사항 등록</div>
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
											data-expctEndDt="${req.expctEndDt}"
											data-eqpprc="${req.prjId}"
											data-prchsdt="${req.prrty}"
											data-prcsStts="${req.prcsStts}"
											data-tskStts="${req.tskStts}"
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
											<td>${req.prcsStts}</td>
											<td>${req.tskStts}</td>
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
						<button id="delete_all_btn" class="btn-delete">삭제</button>
					</div>
					<c:import url="../include/pagenate.jsp">
	                  <c:param name="pageNo" value="${pageNo}"/>
	                  <c:param name="pageCnt" value="${pageCnt}"/>
	                  <c:param name="lastPage" value="${lastPage}"/>
	                  <c:param name="path" value="${context}/req"/>
	               	</c:import>
					
				</div>	
				<div class="grid-detail">
					<form id="detail_form" >
						<!-- isModify == true => 수정(update) -->
						<!-- isModify == false => 등록(insert) -->
						<input type="hidden" id="isModify" value="false" />
						<div class="input-group inline">
							<label for="reqId" style="width: 180px;">요구사항 ID</label>
							<input type="text" id="reqId"  name="reqId" value="" readonly />
						</div>
						<div class="input-group inline">
							<label for="reqTtl" style="width: 180px;">제목</label>
							<input type="text" id="reqTtl"  name="reqTtl" value=""/>
						</div>
						<div class="input-group inline">
							<label for="prrty" style="width: 180px;">우선순위</label>
							<select id="prrty"  name="prrty" >
								<option>선택</option>
								<option>1</option>
								<option>2</option>
								<option>3</option>
							</select>
						</div>
						<div class="input-group inline">
							<label for="strtDt" style="width: 180px;">시작일</label>
							<input type="date" id="strtDt"  name="strtDt" value=""/>
						</div>
						<div class="input-group inline">
							<label for="expctEndDt" style="width: 180px;">종료예정일</label>
							<input type="date" id="expctEndDt"  name="expctEndDt" value=""/>
						</div>
						<div class="input-group inline">
							<label for="prjId" style="width: 180px;">프로젝트ID</label>
							<input type="text" id="prjId"  name="prjId" value="${req.prjId}"/>
							<button id="prj_search">검색</button>
						</div>
						<div class="input-group inline">
							<label for="prjId" style="width: 180px;">담당개발자</label>
							<input type="text" id="mnDvlpr"  name="mnDvlpr" value="${req.mnDvlpr}"/>
							<button id="prjtmmbr_search">검색</button>
						</div>
						<div class="input-group inline">
							<label for="reqCnfrNm" style="width: 180px;">확인자</label>
							<input type="text" id="reqCnfrNm"  name="reqCnfrNm" value=""/>
						</div>
						<div class="input-group inline">
							<label for="prcsStts" style="width: 180px;">진행상태</label>
							<select id="prcsStts"  name="prcsStts" >
								<option value="004">선택</option>
								<option value="004_01">접수</option>
								<option value="004_02">분석</option>
								<option value="004_03">처리중</option>
								<option value="004_04">처리완료</option>
							</select>
						</div>
						<div class="input-group inline">
							<label for="tskStts" style="width: 180px;">일정상태</label>
							<select id="tskStts"  name="tskStts" >
								<option value="003">선택</option>
								<option value="003_01">대기중</option>
								<option value="003_02">진행중</option>
								<option value="003_03">연기 필요</option>
							</select>
						</div>
						<div class="input-group inline">
							<label for="tstRslt" style="width: 180px;">테스트 결과</label>
							<select id="tstRslt"  name="tstRslt" >
								<option value="22">선택</option>
								<option value="222">합격</option>
								<option value="2222">불합격</option>
								<option value="22222">보류</option>
							</select>
						</div>
						<div class="input-group inline">
							<label for="lossStts" style="width: 180px;">사용여부</label>
							<input type="checkbox" id="useYn"  name="useYn" value="Y"/>
						</div>
						<div class="input-group inline">
							<label for="dtlReq" style="width: 180px;">내용</label>
							<textarea id="dtlReq" name="dtlReq"></textarea>
						</div>
				
					</form>
				</div>
				<div class="align-right">
					<button id="new_btn" class="btn-primary">초기화</button>
					<button id="save_btn" class="btn-primary">등록</button>
					<button id="delete_btn" class="btn-delete">취소</button>
				</div>		
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>