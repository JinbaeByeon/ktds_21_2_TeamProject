<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />
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
			
			$("#pstnId").val(data.pstnid);
			$("#pstnNm").val(data.pstnnm);
			$("#crtr").val(data.crtr);
			$("#crtDt").val(data.crtdt);
			$("#mdfyr").val(data.mdfyr);
			$("#mdfyDt").val(data.mdfydt);
			
			$("#useYn").prop("checked", data.useyn == "Y");
			
		});
		
		$("#new_btn").click(function(){
			$("#isModify").val("false"); //등록모드
			
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
			
			$.get("${context}/api/gnr/delete/" + pstnId, function(response){
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
				$.post("${context}/pstn/create", {pstnNm: $("#pstnNm").val(), useYn: $("#useYn:checked").val()}, function(response){
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
	
/* 	function movePage(pageNo) {
		// 전송
		// 입력값
		var gnrNm = $("#search-keyword").val();
		// URL 요청
		location.href = "${context}/pstn/list?pstnNm=" + pstnNm + "&pageNo=" + pageNo;
	} */

</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/content.jsp" />
				<div class="path"> 직급관리</div>
				<div class="search-group">
					<label for="search-keyword">직급명</label>
					<input type="text" id="search-keyword" class="search-input"  value="${pstnVO.pstnNm}"/>
					<button class="btn-search" id="search-btn">검색</button>
				</div>
				
				<div class="grid">
					<div class="grid-count align-right">
					</div>
					<table>
						<thead>
							<tr>
								<th><input type="checkbox" id="all_check"/></th>
								<th>직급ID</th>
								<th>직급명</th>
								<th>사용여부</th>
								<th>등록자</th>
								<th>등록일</th>
								<th>수정자</th>
								<th>수정일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty pstnList}">
									<c:forEach items="${pstnList}"
											   var="pstn">
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
											<td>${pstn.pstnId}</td>
											<td>${pstn.pstnNm}</td>
											<td>${pstn.useYn}</td>
											<td>${pstn.crtr}</td>
											<td>${pstn.crtDt}</td>
											<td>${pstn.mdfyr}</td>
											<td>${pstn.mdfyDt}</td>
											<td>${pstn.delYn}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="9" class="no-items">
											등록된 장르가 없습니다.
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					
					<div class="align-right mt-10">
						<button id="delete_all_btn" class="btn_delete">삭제</button>
					</div>
					
					<%-- <div class="pagenate">
						<ul>
							<c:set value="${pstnList.size() > 0 ? pstnList.get(0).lastPage : 0}" var="lastPage" />
							<c:set value="${pstnList.size() > 0 ? pstnList.get(0).lastGroup : 0}" var="lastGroup" />
							
							<fmt:parseNumber var="nowGroup" value="${Math.floor(pstnVO.pageNo / 10)}" integerOnly="true" />
							<c:set value="${nowGroup * 10}" var="groupStartPageNo" />
							<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo" />
							<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo - 1}" var="groupEndPageNo" />
							
							<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />
							<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />

							
							<c:if test="${nowGroup > 0}">
								<li><a href="javascript:movePage(0)">처음</a></li>
								<li><a href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
							</c:if>
							
							<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
								<li><a class="${pageNo eq gnrVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
							</c:forEach>	
							
							<c:if test="${lastGroup > nowGroup}">
								<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
								<li><a href="javascript:movePage(${lastPage})">끝</a></li>
							</c:if>			
						</ul>
					</div> --%>
					
				</div>	
				<div class="grid-detail">
					<form id="detail_form" >
						<!-- isModify == true => 수정(update) -->
						<!-- isModify == false => 등록(insert) -->
						<input type="hidden" id="isModify" value="false" />
						<div class="input-group inline">
							<label for="gnrId" style="width: 180px;">직급 ID</label><input type="text" id="pstnId"  name="pstnId" value="" readonly />
						</div>
						<div class="input-group inline">
							<label for="gnrNm" style="width: 180px;">직급명</label><input type="text" id="pstnNm"  name="pstnNm" value=""/>
						</div>
						<div class="input-group inline">
							<label for="useYn" style="width: 180px;">사용여부</label><input type="checkbox" id="useYn" name="useYn" value="Y"/>
						</div>
						<div class="input-group inline">
							<label for="crtr" style="width: 180px;">등록자</label><input type="text" id="crtr"  disabled value=""/>
						</div>
						<div class="input-group inline">
							<label for="crtDt" style="width: 180px;">등록일</label><input type="text" id="crtDt"  disabled value=""/>
						</div>
						<div class="input-group inline">
							<label for="mdfyr" style="width: 180px;">수정자</label><input type="text" id="mdfyr"  disabled value=""/>
						</div>
						<div class="input-group inline">
							<label for="mdfyDt" style="width: 180px;">수정일</label><input type="text" id="mdfyDt"  disabled value=""/>
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