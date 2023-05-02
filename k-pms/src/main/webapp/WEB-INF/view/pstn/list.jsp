<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />
<c:set scope="request" var="selected" value="sys"/>
<c:set var="admnYn" value="${sessionScope.__USER__.admnYn}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		$(".detail_section").hide();
	
		$(".list_table > tbody > tr").click(function(){
			$("#crtr").closest("td").prev().show();
			$("#crtr").closest("td").show();
			
			$("#crtDt").closest("td").prev().show();
			$("#crtDt").closest("td").show();
			
			$("#mdfyr").closest("td").prev().show();
			$("#mdfyr").closest("td").show();

			$("#mdfyDt").closest("tr").show();
			
			$("#isModify").val("true"); //수정모드
	        $(".detail_section").show("fast");
	        $(".detail_table").show();
			
			var data = $(this).data();
			
			$("#pstnId").val(data.pstnid);
			$("#pstnNm").val(data.pstnnm);
			$("#crtr").val(data.crtr);
			$("#crtDt").val(data.crtdt);
			$("#mdfyr").val(data.mdfyr);
			$("#mdfyDt").val(data.mdfydt);
			
			$("#useYn").prop("checked", data.useyn == "Y");
			
		});
		
		$("#new_btn").click(function(){
			$("#crtr").closest("td").prev().hide();
			$("#crtr").closest("td").hide();
			
			$("#crtDt").closest("td").prev().hide();
			$("#crtDt").closest("td").hide();
			
			$("#mdfyr").closest("td").prev().hide();
			$("#mdfyr").closest("td").hide();

			$("#mdfyDt").closest("tr").hide();
			
			$("#isModify").val("false"); //등록모드
	        $(".detail_section").show("fast");
	        $(".detail_table").show();
			
			$("#pstnId").val("");
			$("#pstnNm").val("");
			$("#crtr").val("");
			$("#crtDt").val("");
			$("#mdfyr").val("");
			$("#mdfyDt").val("");
			
			$("#useYn").prop("checked", false);
		});
		
		$("#delete_btn").click(function(){
			var pstnId = $("#pstnId").val();
			if(pstnId == ""){
				alert("선택된 직급이 없습니다.");
				return;
			}
			
			if(!confirm("정말 삭제하시겠습니까?")){
				return;
			}
			
			$.get("${context}/api/pstn/delete/" + pstnId, function(response){
				if(response.status == "200 OK"){
					location.reload(); //새로고침
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			})
		});
					
		$("#save_btn").click(function(){
			if($("#isModify").val() == "false"){
				// 신규등록	
				$.post("${context}/api/pstn/create", {pstnNm: $("#pstnNm").val(), useYn: $("#useYn:checked").val()}, function(response){
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
				$.post("${context}/api/pstn/update", {pstnId: $("#pstnId").val(), 
													  pstnNm: $("#pstnNm").val(), 
													  useYn: $("#useYn:checked").val()}, function(response){
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
			var pstnNm =$("#search-keyword").val();
			location.href = "${context}/pstn?pstnNm=" + pstnNm;
			movePage(0) 
			
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
				alert("삭제할 장르가 없습니다.");
				return;
			}
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='pstnId' value='" + $(this).val() +"'>");
			});
			
			$.post("${context}/api/pstn/delete", form.serialize(), function(response){
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
		var pstnNm = $("#search-keyword").val();
		// URL 요청
		location.href = "${context}/pstn/list?pstnNm=" + pstnNm + "&pageNo=" + pageNo;
	}
	
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sysSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp" />
				<div class="path">시스템 관리 > 직급 관리</div>
			      <div class="search_wrapper">
			        <div class="search_box">
			          <select>
			            <option>직급명</option>
			          </select>
			          <div class="search_field">
			          	<input type="text" id="search-keyword" class="input" value="${pstnVO.pstnNm}" placeholder="Search"/>
			          </div>
			          <div class="search-icon">
			          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
			          </div>
			        </div>
			      </div>
			      <div class="list_section">
			        <div class="total">총 ${pstnList.size() > 0 ? pstnList.get(0).totalCount : 0}건</div>
			        <table class="list_table">
			          <thead>
							<tr>
								<th><input type="checkbox" id="all_check"/></th>
								<th>순번</th>
								<th>직급ID</th>
								<th>직급명</th>
								<th>사용여부</th>
<!-- 								<th>등록자</th>
								<th>등록일</th>
								<th>수정자</th>
								<th>수정일</th> -->
								<th>삭제여부</th>
							</tr>
			          </thead>
			          <tbody>
							<c:choose>
								<c:when test="${not empty pstnList}">
									<c:forEach items="${pstnList}"
											   var="pstn"
											   varStatus="index">
										<tr data-pstnid="${pstn.pstnId}"
											data-pstnnm="${pstn.pstnNm}"
											data-useyn="${pstn.useYn}"
											data-crtr="${pstn.crtr}"
											data-crtdt="${pstn.crtDt}"
											data-mdfyr="${pstn.mdfyr}"
											data-mdfydt="${pstn.mdfyDt}"
											data-delyn="${pstn.delYn}">
											<td>
												<input type="checkbox" class="check_idx" value="${pstn.pstnId}">
											</td>
											<td>${pstn.rnum}</td>
											<td>${pstn.pstnId}</td>
											<td>${pstn.pstnNm}</td>
											<td>${pstn.useYn}</td>
<%-- 											<td>${pstn.crtr}</td>
											<td>${pstn.crtDt}</td>
											<td>${pstn.mdfyr}</td>
											<td>${pstn.mdfyDt}</td> --%>
											<td>${pstn.delYn}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="9" class="no-items">
											등록된 직급이 없습니다.
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
		                  <c:param name="path" value="${context}/pstn"/>
		               	</c:import>
			        <div class="buttons">
			          <button id="new_btn" class="btn new">신규등록</button>
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
				              <th>직급 ID</th>
				              <td><input type="text" id="pstnId"  name="pstnId" value="" readonly /></td>
				              <th>등록자</th>
				              <td><input type="text" id="crtr"  disabled value=""/></td>
				            </tr>
				            <tr>
				              <th>직급명</th>
				              <td><input type="text" id="pstnNm"  name="pstnNm" value=""/></td>
				              <th>등록일</th>
				              <td><input type="text" id="crtDt"  disabled value=""/></td>
				            </tr>
				            <tr>
				              <th>사용여부</th>
				              <td><input type="checkbox" id="useYn" name="useYn" value="Y"/></td>
				              <th>수정자</th>
				              <td><input type="text" id="mdfyr"  disabled value=""/></td>
				            </tr>
				            <tr>
				              <th></th>
				              <td></td>
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