<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		$(".grid > table > tbody > tr").click(function() {
			$("#isModify").val("true"); //수정모드
			
			var data = $(this).data();
			$("#depId").val(data.depid);
			$("#tmId").val(data.tmid);
			$("#tmNm").val(data.tmnm);
			$("#tmHdId").val(data.tmhdid);
			$("#tmCrtDt").val(data.tmcrtdt);
			$("#crtr").val(data.crtr);
			$("#crtDt").val(data.crtdt);
			$("#mdfyr").val(data.mdfyr);
			$("#mdfyDt").val(data.mdfydt);
			
			$("#useYn").prop("checked", data.useyn == "Y");
			
		});
		
			$("#new_btn").click(function() {
			
			$("#isModify").val("false"); //등록모드
			
			$("#depId").val("");
			$("#tmId").val("");
			$("#tmNm").val("");
			$("#tmHdId").val("");
			$("#tmCrtDt").val("");
			$("#crtr").val("");
			$("#crtDt").val("");
			$("#mdfyr").val("");
			$("#mdfyDt").val(0);
			
			$("#useYn").prop("checked", false);
		});
		
		$("#delete_btn").click(function() {
			var tmId =$("#tmId").val()
			if (tmId == "") {
				alert("선택된 부서가 없습니다.");
				return;
			}
			
			if (!confirm("정말 삭제하시겠습니까?")) { <!-- 사용자에게 확인  확인시 예를 누르면 false값이 return으로 온다.-->
				return;
			}
			
			$.get("${context}/api/tm/delete/" + tmId, function(response) {
				if (response.status == "200 OK") {
					location.reload(); //새로고침
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			});
		})
		
		$("#save_btn").click(function() {
			var ajaxUtil = new AjaxUtil();
			if($("#isModify").val() == "false") {
				//신규등록
				ajaxUtil.upload("#detail_form","${context}/api/tm/create",function(response){
					if (response.status == "200 OK") {
						location.reload(); //새로고침
					}
					else {
						alert(response.errorCode + " / " + response.message);
					}
				});
			}
			else {
				//수정
				ajaxUtil.upload("#detail_form","${context}/api/tm/update",function(response){
					if (response.status == "200 OK") {
						location.reload(); //새로고침
					}
					else {
						alert(response.errorCode + " / " + response.message);
					}
				});
			}
		});
		
		$("#search-btn").click(function() {
			var tmNm = $("#search-keyword").val();
			location.href = "${context}/tm?tmNm=" + tmNm;
			 movePage(0) 
		});
		
		$("#all_check").change(function() {
		/* 	console.log($(this).prop("checked")); */
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		$(".check_idx").change(function() {
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("#delete_all_btn").click(function() {
			var checkLen = $(".check_idx:checked").length;
			if (checkLen == 0) {
				alert("삭제할 부서가 없습니다.");
				return;
			}
			
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function() {
				console.log($(this).val());
				form.append("<input type='hidden' name='tmId' value='" + $(this).val() + "'>"); 
			});
			
			$.post("${context}/api/tm/delete", form.serialize(), function(response) {
				if (response.status == "200 OK") {
					location.reload(); //새로고침
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			});
		});
		
		$("#addTmHeadBtn").click(function(event) {
			event.preventDefault(); 
			var tmHd = window.open("${context}/emp/search", "팀장 검색", "width=500,height=500");
		});
		
	});
		 function movePage(pageNo) {
			// 전송
			// 입력 값
			var tmNm = $("#search-keyword").val();
			// URL 요청
			location.href = "${context}/tm/list?tmNm=" + tmNm + "&pageNo=" + pageNo;
		} 
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/depSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
				<div class="path">팀 > 팀관리</div>
				<div class="search-group">
					<label for="search_keyword">팀명</label>
					<input type="text" id="search-keyword" class="search-input" value="${tmVO.tmNm}"/>
					<button class="btn-search" id="search-btn">검색</button>
				</div>
				<div class="grid">
					
					<div class="grid-count align-right">
						 총 ${tmList.size() > 0 ? tmList.get(0).totalCount : 0}건  
					</div>
					<table>
						<thead>
							<tr>
								<th><input type="checkbox" id="all_check" /></th>
								<th>순번</th>
								<th>부서ID</th>
								<th>팀ID</th>
								<th>팀명</th>
								<th>팀장ID</th>
								<th>팀생성일</th>
								<th>사용여부</th>
								<th>등록자</th>
								<th>등록일</th>
								<th>수정자</th>
								<th>수정일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty tmList}">
									<c:forEach items="${tmList}"
												var="tm">
										<tr data-depid="${tm.depId}"
											data-tmid="${tm.tmId}"
											data-tmnm="${tm.tmNm}"
											data-tmhdid="${tm.tmHdId}"
											data-tmcrtdt="${tm.tmCrtDt}"
											data-useyn="${tm.useYn}"
											data-crtr="${tm.crtr}"
											data-crtdt="${tm.crtDt}"
											data-mdfyr="${tm.mdfyr}"
											data-mdfydt="${tm.mdfyDt}">
											<td>
												<input type="checkbox" class="check_idx" value="${tm.tmId}"/>
											</td>
											<td>순번</td>
											<td>${tm.depId}</td>
											<td>${tm.tmId}</td>
											<td>${tm.tmNm}</td>
											<td>${tm.tmHdId}</td>
											<td>${tm.tmCrtDt}</td>
											<td>${tm.useYn}</td>
											<td>${tm.crtr}</td>
											<td>${tm.crtDt}</td>
											<td>${tm.mdfyr}</td>
											<td>${tm.mdfyDt}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="11" class="no-items">
											등록된 팀이 없습니다.
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
                  		<c:param name="path" value="${context}/tm"/>
					</c:import>
					
					<<%-- div class="pagenate">
						<ul>
							<c:set value="${depList.size() > 0 ? depList.get(0).lastPage : 0}" var="lastPage" />
							<c:set value="${depList.size() > 0 ? depList.get(0).lastGroup : 0}" var="lastGroup" />
							
							<fmt:parseNumber var="nowGroup" value="${Math.floor(depVO.pageNo / 10)}" integerOnly="true" />
							<c:set value="${nowGroup * 10}" var="groupStartPageNo" />
							<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo" />
							<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo-1}" var="groupEndPageNo" />
							
							<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />
							<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
							
							<!--lastPage: ${lastPage}
							lastGroup: $lastGroup}
							nowGroup: ${nowGroup}
							groupStartPageNo: ${groupStartPageNo}
							groupEndPageNo: ${groupEndPageNo}
							prevGroupStartPageNo: ${prevGroupStartPageNo}
							nextGroupStartPageNo: ${nextGroupStartPageNo}  -->
							
							<c:if test="${nowGroup > 0}">
								<li><a href="javascript:movePage(0)">처음</a></li>
								<li><a href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
							</c:if>
							
							<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
								<li><a class="${pageNo eq depVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
							</c:forEach>
							
							<c:if test="${lastGroup > nowGroup}">
								<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
								<li><a href="javascript:movePage(${lastPage})">끝</a></li>
							</c:if>
							
						</ul>
					</div> --%>
					
				</div>
				
				<div class="grid-detail">
					<form id="detail_form">
						<!--
						isModify == true => 수정 (update)
						isModify == false => 등록 (insert)	
						-->
						<input type="hidden" id="isModify" value="false" />
						<div class="input-group inline">
							<label for="depId" style="width: 180px;">부서ID</label><input type="text" id="depId" name="depId" readonly value="" />
						</div>
						<div class="input-group inline">
							<label for="tmId" style="width: 180px;">팀ID</label><input type="text" id="tmId" name="tmId" readonly value="" />
						</div>
						<div class="input-group inline">
							<label for="tmNm" style="width: 180px;">팀명</label><input type="text" id="tmNm" name="tmNm" value=""/>
						</div>
						<div class="input-group inline">
							<label for="tmHdId" style="width: 180px;">팀장ID</label>
							<div class="create-head">
								<input type="hidden" name="tmHdId" value="tmpId" /> 
								<button id="addTmHeadBtn" class="btn-t">등록</button>
							</div>
						</div>
						<div class="input-group inline">
							<label for="tmCrtDt" style="width: 180px;">팀생성일</label><input type="date" id="tmCrtDt" name="tmCrtDt" />
						</div>
						<div class="input-group inline">
							<label for="useYn" style="width: 180px;">사용여부</label><input type="checkbox" id="useYn" name="useYn" value="Y"/>
						</div>
						<div class="input-group inline">
							<label for="crtr" style="width: 180px;">등록자</label><input type="text" id="crtr" disabled value=""/>
						</div>
						<div class="input-group inline">
							<label for="crtDt" style="width: 180px;">등록일</label><input type="text" id="crtDt" disabled value=""/>
						</div>
						<div class="input-group inline">
							<label for="mdfyr" style="width: 180px;">수정자</label><input type="text" id="mdfyr" disabled value=""/>
						</div>
						<div class="input-group inline">
							<label for="mdfyDt" style="width: 180px;">수정일</label><input type="text" id="mdfyDt" disabled value=""/>
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