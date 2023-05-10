<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />
<c:set scope="request" var="selected" value="eqp"/>
<c:set var="admnYn" value="${sessionScope.__USER__.admnYn}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대여 관리</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		$(".grid > table > tbody > tr").click(function(){
			
			$("#isModify").val("true"); //수정모드
			
			var data = $(this).data();
			
			$("#eqpId").val(data.eqpid);
			$("#eqpNm").val(data.eqpnm);
			$("#crtr").val(data.crtr);
			$("#crtDt").val(data.crtdt);
			$("#mdfyr").val(data.mdfyr);
			$("#mdfyDt").val(data.mdfydt);
			$("#eqpTp").val(data.eqptp);
			$("#applStts").val(data.applstts);
			$("#eqpPrc").val(data.eqpprc);
			$("#prchsDt").val(data.prchsdt);
			$("#lossStts").val(data.lossstts);
			$("#lossRprtDt").val(data.lossrprtdt);
			$("#applDt").val(data.appldt);
			
			$("#useYn").prop("checked", data.useyn == "Y");
			
		});
		
		$("#new_btn").click(function(){
			$("#isModify").val("false"); //등록모드
			
			$("#eqpId").val("");
			$("#eqpNm").val("");
			$("#crtr").val("");
			$("#crtDt").val("");
			$("#mdfyr").val("");
			$("#mdfyDt").val("");
			$("#eqpTp").val("");
			$("#applStts").val("");
			$("#eqpPrc").val("");
			$("#prchsDt").val("");
			$("#lossStts").val("");
			$("#lossRprtDt").val("");
			$("#applDt").val("");
			
			$("#useYn").prop("checked", false);
		});
		
		$("#delete_btn").click(function(){
			var eqpId = $("#eqpId").val();
			if(eqpId == ""){
				alert("선택된 비품이 없습니다.");
				return;
			}
			
			if(!confirm("정말 삭제하시겠습니까?")){
				return;
			}
			
			$.get("${context}/api/eqp/delete/" + eqpId, function(response){
				if(response.status == "200 OK"){
					location.reload(); //새로고침
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			})
		});
					
		$("#save_btn").click(function(){
			var ajaxUtil = new AjaxUtil();
			if($("#isModify").val() == "false"){
				// 신규등록	
				ajaxUtil.upload("#detail_form","${context}/api/eqp/create",function(response){
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
				ajaxUtil.upload("#detail_form","${context}/api/eqp/update",function(response){
					if(response.status == "200 OK"){
						location.reload(); //새로고침
					}	
					else{
						alert(response.errorCode + "/" + response.message);
					}
				});
			}
		});
		
		$("#search-btn").click(function(){
			var eqpNm =$("#search-keyword").val();
			location.href = "${context}/eqp/list?eqpNm=" + eqpNm;
			/* movePage(0) */
			
		})
		
		
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
				alert("삭제할 비품이 없습니다.");
				return;
			}
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='eqpId' value='" + $(this).val() +"'>");
			});
			
			$.post("${context}/api/eqp/delete", form.serialize(), function(response){
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
		var eqpNm = $("#search-keyword").val();
		// URL 요청
		location.href = "${context}/eqp/list?eqpNm=" + eqpNm + "&pageNo=" + pageNo;
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/eqpSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp" />
				<div class="path"> 비품관리</div>
				<div class="search-group">
					<label for="search-keyword">비품명</label>
					<input type="text" id="search-keyword" class="search-input"  value="${eqpVO.eqpNm}"/>
					<button class="btn-search" id="search-btn">검색</button>
				</div>
				
				<div class="grid">
					<div class="grid-count align-right">
						총 ${eqpList.size() > 0 ? eqpList.get(0).totalCount : 0}건
					</div>
					<table>
						<thead>
							<tr>
								<th><input type="checkbox" id="all_check"/></th>
								<th>순번</th>
								<th>비품ID</th>
								<th>비품명</th>
								<th>비품종류</th>
								<th>비품가격</th>
								<th>구매일</th>
								<th>신청상태</th>
								<th>분실상태</th>
								<th>등록자</th>
								<th>등록일</th>
								<th>수정자</th>
								<th>수정일</th>
								<th>사용여부</th>
								<th>삭제여부</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty eqpList}">
									<c:forEach items="${eqpList}"
											   var="eqp"
											   varStatus="index">
										<tr data-eqpid="${eqp.eqpId}"
											data-eqpnm="${eqp.eqpNm}"
											data-eqptp="${eqp.eqpTp}"
											data-applstts="${eqp.applStts}"
											data-appldt="${eqp.applDt}"
											data-eqpprc="${eqp.eqpPrc}"
											data-prchsdt="${eqp.prchsDt}"
											data-lossstts="${eqp.lossStts}"
											data-lossrprtdt="${eqp.lossRprtDt}"
											data-useyn="${eqp.useYn}"
											data-crtr="${eqp.crtr}"
											data-crtdt="${eqp.crtDt}"
											data-mdfyr="${eqp.mdfyr}"
											data-mdfydt="${eqp.mdfyDt}"
											data-delyn="${eqp.delYn}">
											<td>
												<input type="checkbox" class="check_idx" value="${eqp.eqpId}">
											</td>
											<td>${eqp.rnum}</td>
											<td>${eqp.eqpId}</td>
											<td>${eqp.eqpNm}</td>
											<td>${eqp.eqpTp}</td>
											<td><fmt:formatNumber>${eqp.eqpPrc}</fmt:formatNumber></td>
											<td>${eqp.prchsDt}</td>
											<td>${eqp.applStts}</td>
											<td>${eqp.lossStts}</td>
											<td>${eqp.crtr}(${eqp.crtrEmpVO.fNm}${eqp.crtrEmpVO.lNm})</td>
											<td>${eqp.crtDt}</td>
											<td>${eqp.mdfyr}(${eqp.mdfyrEmpVO.fNm}${eqp.mdfyrEmpVO.lNm})</td>
											<td>${eqp.mdfyDt}</td>
											<td>${eqp.useYn}</td>
											<td>${eqp.delYn}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="15" class="no-items">
											등록된 비품이 없습니다.
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
	                  <c:param name="path" value="${context}/eqp"/>
	               	</c:import>
					
				</div>	
				<div class="grid-detail">
					<form id="detail_form" >
						<!-- isModify == true => 수정(update) -->
						<!-- isModify == false => 등록(insert) -->
						<input type="hidden" id="isModify" value="false" />
						<div class="input-group inline">
							<label for="eqpId" style="width: 180px;">비품 ID</label>
							<input type="text" id="eqpId"  name="eqpId" value="" readonly />
						</div>
						<div class="input-group inline">
							<label for="eqpNm" style="width: 180px;">비품명</label>
							<input type="text" id="eqpNm"  name="eqpNm" value=""/>
						</div>
						<div class="input-group inline">
							<label for="eqpTp" style="width: 180px;">비품종류</label>
							<select id="eqpTp"  name="eqpTp" >
								<option>선택</option>
								<option>공기구</option>
								<option>사무용품</option>
								<option>소모품</option>
							</select>
						</div>
						<div class="input-group inline">
							<label for="eqpPrc" style="width: 180px;">비품가격</label>
							<input type="text" id="eqpPrc"  name="eqpPrc" value=""/>
						</div>
						<div class="input-group inline">
							<label for="prchsDt" style="width: 180px;">구매일</label>
							<input type="date" id="prchsDt"  name="prchsDt" value=""/>
						</div>
						<div class="input-group inline">
							<label for="lossStts" style="width: 180px;">사용여부</label>
							<input type="checkbox" id="useYn"  name="useYn" value="Y"/>
						</div>
						
						<div class="input-group inline">
							<label for="crtr" style="width: 180px;">등록자</label>
							<input type="text" id="crtr"  disabled value=""/>
						</div>
						<div class="input-group inline">
							<label for="crtDt" style="width: 180px;">등록일</label>
							<input type="text" id="crtDt"  disabled value=""/>
						</div>
						<div class="input-group inline">
							<label for="mdfyr" style="width: 180px;">수정자</label>
							<input type="text" id="mdfyr"  disabled value=""/>
						</div>
						<div class="input-group inline">
							<label for="mdfyDt" style="width: 180px;">수정일</label>
							<input type="text" id="mdfyDt"  disabled value=""/>
						</div>
						
					</form>
				</div>
				<div class="align-right">
					<button id="new_btn" class="btn-primary">신규</button>
					<button id="save_btn" class="btn-primary">저장</button>
					<button id="delete_btn" class="btn-delete">삭제</button>
				</div>		
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>