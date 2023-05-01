<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />
<c:set scope="request" var="selected" value="eqp"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		$("#applSttsType").val("${eqpVO.applStts}").prop("selected", true);
	     $(".detail_section").hide();
	     
		$(".list_table > tbody > tr").click(function(){
			
			$("#crtr").closest("td").prev().prev().attr("colspan", 0);
			$("#crtr").closest("td").prev().show();
			$("#crtr").closest("td").show();
			
			$("#crtDt").closest("td").prev().prev().attr("colspan", 0);
			$("#crtDt").closest("td").prev().show();
			$("#crtDt").closest("td").show();
			
			$("#mdfyr").closest("td").prev().prev().attr("colspan", 0);
			$("#mdfyr").closest("td").prev().show();
			$("#mdfyr").closest("td").show();

			$("#mdfyDt").closest("td").prev().prev().attr("colspan", 0);
			$("#mdfyDt").closest("td").prev().show();
			$("#mdfyDt").closest("td").show();
			
			$("#prchsDt").closest("td").attr("colspan", 0);
	 		$("#prchsDt").closest("td").next().show();
	 		$("#prchsDt").closest("td").next().next().show();
			
			$("#useYn").closest("td").attr("colspan", 0);
	 		$("#useYn").closest("td").next().show();
	 		$("#useYn").closest("td").next().next().show();
			
			$("#isModify").val("true"); //수정모드
	        $(".detail_section").show("fast");
	        $(".detail_table").show();
			
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
			$("#lossStts").prop("checked", data.lossstts == "Y");
			$("#lossRprtDt").val(data.lossrprtdt);
			$("#applDt").val(data.appldt);
			
			$("#useYn").prop("checked", data.useyn == "Y");
			
		});
		
		$("#new_btn").click(function(){
			$("#crtr").closest("td").prev().prev().attr("colspan", 3);
			$("#crtr").closest("td").prev().hide();
			$("#crtr").closest("td").hide();
			
			$("#crtDt").closest("td").prev().prev().attr("colspan", 3);
			$("#crtDt").closest("td").prev().hide();
			$("#crtDt").closest("td").hide();
			
			$("#mdfyr").closest("td").prev().prev().attr("colspan", 3);
			$("#mdfyr").closest("td").prev().hide();
			$("#mdfyr").closest("td").hide();
			
			$("#mdfyDt").closest("td").prev().prev().attr("colspan", 3);
			$("#mdfyDt").closest("td").prev().hide();
			$("#mdfyDt").closest("td").hide();
			
			$("#isModify").val("false"); //등록모드
	        $(".detail_section").show("fast");
	        $(".detail_table").show();
			
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
				ajaxUtil.upload("#detail_form","${context}/eqp/create",function(response){
					if(response.status == "200 OK"){
						location.reload(); //새로고침
					}	
					else{
						alert(response.errorCode + "/" + response.message);
					}
				});
			}
			else {
				
				if($("#applDt").val() != "" && $("#applDt").val() != null && $("#applDt").val() < $("#prchsDt").val()){
					alert("신청일은 구매일 이후로 선택해야합니다.");
					return;
				}
				else if($("#lossRprtDt").val() != "" && $("#lossRprtDt").val() != null && $("#lossRprtDt").val() < $("#prchsDt").val()){
					alert("분실신고일은 구매일 이후로 선택해야합니다.")
					return;
				}
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
			location.href = "${context}/eqp/rent?eqpNm=" + eqpNm;
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
		
		$("#applSttsType").change(function(){
			
			var applStts = $("#applSttsType").val();
			console.log(applStts);
			location.href = "${context}/eqp/rent?applStts=" + applStts;
		});
		
		$("#apply_all_btn").click(function(){
			var checkLen = $(".check_idx:checked").length;
			if(checkLen == 0) {
				alert("신청할 비품이 없습니다.");
				return;
			}
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='eqpId' value='" + $(this).val() +"'>");
			});
			
			$.post("${context}/api/eqp/apply", form.serialize(), function(response){
				if(response.status == "200 OK"){
					location.reload(); //새로고침
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		
		$("#refuse_all_btn").click(function(){
			var checkLen = $(".check_idx:checked").length;
			if(checkLen == 0) {
				alert("신청할 비품이 없습니다.");
				return;
			}
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='eqpId' value='" + $(this).val() +"'>");
			});
			
			$.post("${context}/api/eqp/refuse", form.serialize(), function(response){
				if(response.status == "200 OK"){
					location.reload(); //새로고침
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		
		$("#return_all_btn").click(function(){
			var checkLen = $(".check_idx:checked").length;
			if(checkLen == 0) {
				alert("신청할 비품이 없습니다.");
				return;
			}
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='eqpId' value='" + $(this).val() +"'>");
			});
			
			$.post("${context}/api/eqp/return", form.serialize(), function(response){
				if(response.status == "200 OK"){
					location.reload(); //새로고침
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		$("#no_return_all_btn").click(function(){
			var checkLen = $(".check_idx:checked").length;
			if(checkLen == 0) {
				alert("신청할 비품이 없습니다.");
				return;
			}
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='eqpId' value='" + $(this).val() +"'>");
			});
			
			$.post("${context}/api/eqp/noreturn", form.serialize(), function(response){
				if(response.status == "200 OK"){
					location.reload(); //새로고침
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		$("#no_apply_all_btn").click(function(){
			var checkLen = $(".check_idx:checked").length;
			if(checkLen == 0) {
				alert("신청할 비품이 없습니다.");
				return;
			}
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='eqpId' value='" + $(this).val() +"'>");
			});
			
			$.post("${context}/api/eqp/noapply", form.serialize(), function(response){
				if(response.status == "200 OK"){
					location.reload(); //새로고침
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		
		$("#lost_all_btn").click(function(){
			var checkLen = $(".check_idx:checked").length;
			if(checkLen == 0) {
				alert("신청할 비품이 없습니다.");
				return;
			}
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='eqpId' value='" + $(this).val() +"'>");
			});
			
			$.post("${context}/api/eqp/lost", form.serialize(), function(response){
				if(response.status == "200 OK"){
					location.reload(); //새로고침
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		
		$("#no_lost_all_btn").click(function(){
			var checkLen = $(".check_idx:checked").length;
			if(checkLen == 0) {
				alert("신청할 비품이 없습니다.");
				return;
			}
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='eqpId' value='" + $(this).val() +"'>");
			});
			
			$.post("${context}/api/eqp/nolost", form.serialize(), function(response){
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
		location.href = "${context}/eqp/rent?eqpNm=" + eqpNm + "&pageNo=" + pageNo;
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/eqpSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp" />
				<div class="path">비품관리 > 대여 관리</div>
			      <div class="search_wrapper">
			        <div class="search_box">
			          <select>
			            <option>비품명</option>
			          </select>
			          <div class="search_field">
			          	<input type="text" id="search-keyword" class="input" value="${eqpVO.eqpNm}" placeholder="Search"/>
			          </div>
			          <div class="search-icon">
			          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
			          </div>
			        </div>
			      </div>
			      <div class="list_section">
			        <div class="total">총 ${eqpList.size() > 0 ? eqpList.get(0).totalCount : 0}건  </div>
			        <table class="list_table">
			          <thead>
						<tr>
								<th><input type="checkbox" id="all_check"/></th>
								<th>순번</th>
								<th>비품ID</th>
								<th>비품명</th>
								<th>비품종류</th>
								<th>
									<select id="applSttsType" name="applSttsType">
										<option value="">선택</option>
										<option value="대여신청">대여신청</option>
										<option value="대여중">대여중</option>
										<option value="반납신청">반납신청</option>
										<option value="분실신청">분실신청</option>
									</select>
								</th>
								<th>신청자명</th>
								<th>신청일</th>
								<th>분실상태</th>
								<th>분실신고일</th>
								<th>비품가격</th>
								<th>구매일</th>
<!-- 								<th>등록자</th>
								<th>등록일</th>
								<th>수정자</th>
								<th>수정일</th> -->
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
											data-applid="${eqp.applId}"
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
											<td>${eqp.applStts}</td>
											<td>${eqp.applId}</td>
											<td>${eqp.applDt}</td>
											<td>${eqp.lossStts}</td>
											<td>${eqp.lossRprtDt}</td>
											<td>${eqp.eqpPrc}</td>
											<td>${eqp.prchsDt}</td>
<%-- 											<td>${eqp.crtr}(${eqp.crtrEmpVO.fNm}${eqp.crtrEmpVO.lNm})</td>
											<td>${eqp.crtDt}</td>
											<td>${eqp.mdfyr}(${eqp.mdfyrEmpVO.fNm}${eqp.mdfyrEmpVO.lNm})</td>
											<td>${eqp.mdfyDt}</td> --%>
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
					<c:import url="../include/pagenate.jsp">
	                  <c:param name="pageNo" value="${pageNo}"/>
	                  <c:param name="pageCnt" value="${pageCnt}"/>
	                  <c:param name="lastPage" value="${lastPage}"/>
	                  <c:param name="path" value="${context}/eqp"/>
	               	</c:import>
	               	
			        <div class="buttons">
			        	<c:if test="${applStts eq '분실신청'}">
							<button id="no_lost_all_btn" class="btn applStts">분실신청취소</button>
						</c:if>
						<c:if test="${applStts eq '대여신청'}">
							<button id="no_apply_all_btn" class="btn applStts">대여신청취소</button>
						</c:if>
						<c:if test="${applStts eq '반납신청'}">
							<button id="no_return_all_btn" class="btn applStts">반납취소</button>
						</c:if>
						<c:if test="${applStts eq '대여중'}">
							<button id="lost_all_btn" class="btn applStts">분실신청</button>
							<button id="return_all_btn" class="btn applStts">반납신청</button>
						</c:if>
			          <button id="apply_all_btn" class="btn apply">신청</button>
			          <button id="refuse_all_btn" class="btn refuse">반려</button>
			          <button id="delete_all_btn" class="btn delete">선택삭제</button>
			        </div>
			      </div>
			      
				<div class="detail_section">
			        <div class="hr"></div>
			        <div class="path">상세정보</div>
			        <form id="detail_form">
			        	<input type="hidden" id="isModify" value="false" />
				        <table class="detail_table">
				            <tr>
				              <th>비품 ID</th>
				              <td><input type="text" id="eqpId"  name="eqpId" value="" readonly /></td>
				              <th>사용여부</th>
				              <td><input type="checkbox" id="useYn"  name="useYn" value="Y"/></td>
				            </tr>
				            <tr>
				              <th>비품명</th>
				              <td><input type="text" id="eqpNm"  name="eqpNm" value=""/></td>
				              <th>분실상태</th>
				              <td><input type="checkbox" id="lossStts"  name="lossStts" value="Y"/></td>
				            </tr>
				            <tr>
				              <th>비품종류</th>
				              <td>
				              <select id="eqpTp"  name="eqpTp" >
								<option>선택</option>
								<option>공기구</option>
								<option>사무용품</option>
								<option>소모품</option>
							</select>
							</td>
				              <th>분실신고일</th>
				              <td><input type="date" id="lossRprtDt"  name="lossRprtDt" value=""/></td>
				            </tr>
				            <tr>
				              <th>신청상태</th>
				              <td><input type="text" id="applStts"  name="applStts" value="" /></td>
				              <th>등록자</th>
				              <td><input type="text" id="crtr"  disabled value=""/></td>
				            </tr>
				            <tr>
				              <th>신청일</th>
				              <td><input type="date" id="applDt"  name="applDt" value=""/></td>
				              <th>등록일</th>
				              <td><input type="text" id="crtDt"  disabled value=""/></td>
				            </tr>
				            <tr>
				              <th>비품가격</th>
				              <td><input type="text" id="eqpPrc"  name="eqpPrc" value=""/></td>
				              <th>수정자</th>
				              <td><input type="text" id="mdfyr"  disabled value=""/></td>
				            </tr>
				            <tr>
				              <th>구매일</th>
				              <td><input type="date" id="prchsDt"  name="prchsDt" value=""/></td>
				              <th>수정일</th>
				              <td><input type="text" id="mdfyDt"  disabled value=""/></td>
				            </tr>
				        </table>
			        </form>
			
			        <div class="buttons">
			          <button id="save_btn" class="btn regist">저장</button>
			          <button id="delete_btn" class="btn delete">삭제</button>
			        </div>
			      </div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>