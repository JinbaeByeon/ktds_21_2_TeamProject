<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<c:set scope="request" var="selected" value="prj"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 수정</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	var tm;
	
	function addTmFn(message) {
		
		var tmItems = $(document).find(".tmAddTbody");
		if (tmItems.find("." + message.tmid).length > 0) {
			tm.alert(message.tmnm + "은(는) 이미 추가된 팀입니다.");
			return;
		}
		
		var tmTr = $("<tr class='tm-tr " + message.tmid + "'><td>" + message.tmid + "</td><td>" + message.tmnm + "</td><td><button class='trRemoveBtn'>X</button></td></tr>");
	
		
		$(".trRemoveBtn").click(function() {
			console.log($(this).closest("." + message.tmid))
			$(this).closest('tr').remove();
		});
		
		tmItems.append(tmTr);
	}
	
	$().ready(function() {
		$.get("${context}/api/cmncd/list/002", function(response) {
			var isSelected
			
			for (var i in response.data) {
				var cdNm = response.data[i].cdNm;
				if ($("#original-prjStts").val() == response.data[i].cdId) {
					isSelected = "selected";
				}
				else {
					isSelected = "";
				}
				var option = $("<option value='" + response.data[i].cdId + "' " + isSelected + "></option>");
				option.append(cdNm);
				$("#prjStts-select").append(option)
			}
		});
		
		$("#addTmBtn").click(function(event) {
			event.preventDefault();
			tm = window.open("${context}/tm/search", "팀검색", "width=500, height=500")
		});
		
		$("#addTmMbrBtn").click(function(event) {
			event.preventDefault();
			tmMbr = window.open("${context}/tmmbr/search", "팀원검색", "width=500, height=500")
		});
		
		$("#save-btn").click(function() {
			$.post("${context}/api/prj/update", $("#create_form").serialize(), function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}" + response.redirectURL;
				}
				else {
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		
		
		$("#delete-btn").click(function() {
			var prjId = $("#prjId").val();
			if(!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			$.get("${context}/api/prj/delete/" + prjId, function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}/prj/list"
				}
				else {
					alert(response.errorCode + "/" + response.message);
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
				<div class="path"> 수정수정 ${prjId} | ${prjVO.prjNm}</div>
				<form id="create_form" enctype="multipart/form-data">
					<div class="create-group">
						<input type="hidden" id="prjId" name="prjId" value="${prjVO.prjId}"/>
					</div>
					<div class="create-group">
						<label for="prjNm">프로젝트명</label>
						<input type="text" id="prjNm" name="prjNm" value="${prjVO.prjNm}"/>
					</div>
					<div class="create-group">
						<label for="cstmr">고객사</label>
						<input type="text" id="cstmr" name="cstmr" value="${prjVO.cstmr}"/>
					</div>
					<div class="create-group">
						<label for="strtDt">시작일</label>
						<input type="date" id="strtDt" name="strtDt" value="${prjVO.strtDt}"/>
					</div>
					<div class="create-group">
						<label for="endDt">종료일</label>
						<input type="date" id="endDt" name="endDt" value="${prjVO.endDt}"/>
					</div>
					<div class="create-group">
						<label for="prjStts">프로젝트 상태</label>
						<input type="hidden" id="original-prjStts" name="original-prjStts" value="${prjVO.prjStts}"/>
						<select id="prjStts-select" name="prjStts"></select>
					</div>
					<div class="create-group">
						<label for="useYn">사용여부</label>
						<input type="checkbox" id="useYn" name="useYn" value="Y" ${prjVO.useYn eq 'Y' ? 'checked' : ''}/>
					</div>
					
					<div class="create-group">
						<label for="tm">팀</label>
						<div>
							<button id="addTmBtn" class="btn-primary">추가</button>
						</div>
						<div class="grid">
							<table>
								<thead>
									<tr>
										<th>팀ID</th>
										<th>팀</th>
										<th></th>
									</tr>
								</thead>
								<tbody class="tmAddTbody">
									<c:choose>
										<c:when test="${not empty tmList}">
											<c:forEach items="${tmList}" var="tm">
												<tr>
													<td>${tm.getKey()}</td>
													<td>${tm.getValue()}</td>
													<td><button class='trRemoveBtn'>X</button></td>
												</tr>
											</c:forEach>
										</c:when>
									<c:otherwise>
										<td colspan="3" class="no-items">
											등록된 팀이 없습니다.
										</td>
									</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
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
										<td colspan="5" class="no-items">
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
					<button id="save-btn" class="btn-primary">저장</button>
					<button id="delete-btn" class="btn-delete">삭제</button>
				</div>
			<jsp:include page="../include/footer.jsp" />			
		</div>
	</div>
</body>
</html>