<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 생성</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">	
	
	var depId;
	var tmHd;
	
	function addDepFn(message) {
		
		var depItems = $("#addDepIdBtn").closest(".create-group").find(".items");
		if (depItems.find("." + message.depid).length > 0) {
			alert(message.depnm + "은(는) 이미 추가된 부서입니다."); 
			return;
		}
		
		var itemDiv = depItems.find(".dep-item");
			
		var itemId = itemDiv.find("#depId")
		itemId.val(message.depid);
		itemDiv.append(itemId);
		
		var itemSpan = itemDiv.find("span");
		itemSpan.text(message.depnm);
		itemDiv.append(itemSpan);
		
		var itemRemoveBtn = $("<button>X</button>");
		itemRemoveBtn.click(function() {
			$(this).closest("." + message.depid).remove();
		});
		itemDiv.append(itemRemoveBtn);
		
		depItems.append(itemDiv);
		
		depId.close();
		
	}
	
	function addHdEmpFn(message) {
			
			var tmHdIdItems = $("#addTmHeadBtn").closest(".create-group").find(".items");
			if (tmHdIdItems.find("." + message.empid).length > 0) {
				alert(message.lnm + message.fnm + "은(는) 이미 추가된 팀장입니다.");
				return;
			}
			
			var itemDiv = tmHdIdItems.find(".head-item");
			
			var itemId = itemDiv.find("#tmHdId")
			console.log(message.empid);
			itemId.val(message.empid);
			itemDiv.append(itemId);
			
			var itemSpan = itemDiv.find("span");
			itemSpan.text(message.lnm + message.fnm);
			itemDiv.append(itemSpan);
			
			$("#tmHdId").val(message.empid);
			console.log(message.lnm + message.fnm);
			$("#tmHdNm").text(message.lnm + message.fnm);
			
			tmHdIdItems.append(itemDiv);
			
			tmHd.close();
		}
	
	$().ready(function() {
		
		$("#addTmHeadBtn").click(function(event) {
			event.preventDefault(); 
			var tmHd = window.open("${context}/emp/search/head", "팀장 검색", "width=500,height=500");
		});
		
		$("#addDepIdBtn").click(function(event) {
			event.preventDefault();
			depId = window.open("${context}/dep/search", "부서 검색", "width=500,height=500");
		});
		
		$("#addTmMbrBtn").click(function(event) {
			event.preventDefault();
			gnr = window.open("${context}/emp/search", "팀원검색", "width=500, height=500")
		});
		
		$("#list-btn").click(function() {
			location.href = "${context}/tm/list"
		});
		
		$("#save-btn").click(function() {
			var ajaxUtil = new AjaxUtil();
			ajaxUtil.upload("#create_form","${context}/api/tm/create",function(response){
				if (response.status == "200 OK") {
					location.reload(); //새로고침
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			});
		});
	});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/prjSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
				<div class="path"> 팀 생성</div>
				<form id="create_form" enctype="multipart/form-data">
					<div class="create-group">
						<label for="addDepIdBtn" style="width: 180px;">부서ID</label> 
						<button id="addDepIdBtn" class="btn-dep">등록</button>
						<div class="items">
							<div class='dep-item'>
								<input type='text' name='depId' id= "depId" readonly="readonly"/>
								<span id="depNm"></span>
							</div>
						</div>
					</div>
						<div class="create-group">
							<label for="tmId" style="width: 180px;">팀ID</label><input type="text" id="tmId" name="tmId" readonly value="" />
						</div>
						<div class="create-group">
							<label for="tmNm" style="width: 180px;">팀명</label><input type="text" id="tmNm" name="tmNm" value=""/>
						</div>
							<div class="create-group">
								<label for="addTmHeadBtn" style="width: 180px;">팀장ID</label>
								<button id="addTmHeadBtn" class="btn-tm">등록</button>
								<div class="items">
									<div class='head-item'>
										<input type="text" id="tmHdId" name="tmHdId" readonly value=" " />
										<span id="tmHdNm"></span>						
									</div>
								</div>
							</div>
						<div class="create-group">
							<label for="tmCrtDt" style="width: 180px;">팀생성일</label><input type="date" id="tmCrtDt" name="tmCrtDt" />
						</div>
						<div class="create-group">
							<label for="useYn" style="width: 180px;">사용여부</label><input type="checkbox" id="useYn" name="useYn" value="Y"/>
						</div>
					
						<div class="create-group">
							<label for="tmMbr">팀원</label>
							<div>
								<button id="addTmMbrBtn" class="btn-primary">추가</button>
								<div class="items"></div>
							</div>
							<div class="grid">
								<table>
									<thead>
										<tr>
											<th>직원ID</th>
											<th>팀</th>
											<th>성</th>
											<th>이름</th>
											<th>권한</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${not empty prjVO.ptmList}">
												<c:forEach items="${prjVO.ptmList}" var="ptm">
													<tr>
														<td>${ptm.tmMbrVO.empVO.empId}</td>
														<td>${ptm.tmMbrVO.tmVO.tmNm}</td>
														<td>${ptm.tmMbrVO.empVO.fNm}</td>
														<td>${ptm.tmMbrVO.empVO.lNm}</td>
														<td>${ptm.prjPstn}</td>
													</tr>
												</c:forEach>
											</c:when>
										<c:otherwise>
											<td colspan="4" class="no-items">
												등록된 팀원이 없습니다.
											</td>
										</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
					</form>	
				<div class="align-right">
					<button id="list-btn" class="btn-primary">목록</button>
					<button id="save-btn" class="btn-primary">저장</button>
					<button id="delete-btn" class="btn-delete">삭제</button>
				</div>
			<jsp:include page="../include/footer.jsp" />			
		</div>
	</div>
</body>
</html>