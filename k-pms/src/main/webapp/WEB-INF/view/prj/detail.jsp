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
<title>프로젝트 상세정보 조회</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">	
	$().ready(function() {
		
		$.get("${context}/api/cmncd/list/002", function(response) {
			var prjSttsInput = $(document).find("#prjStts");
			var sttsNm
			
			for (var i in response.data) {
				if ($("#prjStts").val() == response.data[i].cdId) {
					sttsNm = response.data[i].cdNm;
				}
			}
			
			var sttsInput = $("<input type='text' id='prjStts' name='prjStts' value='" + sttsNm + "' readonly/>");
			prjSttsInput.after(sttsInput);
		});
		
		$("#modify-btn").click(function() {
			location.href = "${context}/prj/update/" + $("#prjId").val();
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
				<div class="path"> 상세보기 ${prjId} | ${prjVO.prjNm}</div>
					<div class="create-group">
						<input type="hidden" id="prjId" name="prjId" value="${prjId}" readonly/>
					</div>
					<div class="create-group">
						<label for="prjNm">프로젝트명</label>
						<input type="text" id="prjNm" name="prjNm" value="${prjVO.prjNm}" readonly/>
					</div>
					<div class="create-group">
						<label for="cstmr">고객사</label>
						<input type="text" id="prjNm" name="prjNm" value="${prjVO.cstmr}" readonly/>
					</div>
					<div class="create-group">
						<label for="strtDt">시작일</label>
						<input type="date" id="strtDt" name="strtDt" value="${prjVO.strtDt}" readonly/>
					</div>
					<div class="create-group">
						<label for="endDt">종료일</label>
						<input type="date" id="endDt" name="endDt" value="${prjVO.endDt}" readonly/>
					</div>
					<div class="create-group">
						<label for="prjStts">프로젝트 상태</label>
						<input type="hidden" id="prjStts" name="prjStts" value="${prjVO.prjStts}" readonly/>
						
					</div>
					<div class="create-group">
						<label for="useYn">사용여부</label>
						<input type="checkbox" id="useYn" name="useYn" value="Y" ${prjVO.useYn eq 'Y' ? 'checked' : ''} onClick="return false" />
					</div>
					
					<div class="create-group">
						<label for="tm">팀</label>
						<div class="grid">
							<table>
								<thead>
									<tr>
										<th>팀ID</th>
										<th>팀</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty prjVO.ptmList}">
											<c:forEach items="${prjVO.ptmList}" var="ptm">
												<tr>
													<td>${ptm.tmMbrVO.tmVO.tmId}</td>
													<td>${ptm.tmMbrVO.tmVO.tmNm}</td>
												</tr>
											</c:forEach>
										</c:when>
									<c:otherwise>
										<td colspan="2" class="no-items">
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
						
						
							<label for="req">요구사항</label>
							<div class="grid-count align-right">
								전체보기
							</div>
							<div class="grid">
								<table>
									<thead>
										<tr>
											<th>우선순위</th>
											<th>제목</th>
											<th>담당자</th>
											<th>일정</th>
											<th>진행상태</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${not empty prjVO.reqList}">
												<c:forEach items="${prjVO.reqList}" var="req">
													<tr>
														<td>${req.prrty}</td>
														<td>${req.reqTtl}</td>
														<td>${req.mnDvlpr}</td>
														<td>${req.tskStts}</td>
														<td>${req.prcsStts}</td>
													</tr>
												</c:forEach>
											</c:when>
										<c:otherwise>
											<td colspan="5" class="no-items">
												등록된 요구사항이 없습니다.
											</td>
										</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						
						
							<label for="req">지식관리</label>
							<div class="grid-count align-right">
								<a href="${context}/knw/list?ttl=&prjId=${prjId}&prjVO.prjNm=&pageNo=0">전체보기</a>
							</div>
							<div class="grid">
								<table>
									<thead>
										<tr>
											<th>제목</th>
											<th>등록자</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${not empty prjVO.knwList}">
												<c:forEach items="${prjVO.knwList}" var="knw">
													<tr>
														<td>${knw.ttl}</td>
														<td>${knw.crtr}</td>
													</tr>
												</c:forEach>
											</c:when>
										<c:otherwise>
											<td colspan="2" class="no-items">
												등록된 지식사항이 없습니다.
											</td>
										</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						
				<div class="align-right">
					<button id="modify-btn" class="btn-primary">수정</button>
					<button id="delete-btn" class="btn-delete">삭제</button>
				</div>
			<jsp:include page="../include/footer.jsp" />			
		</div>
	</div>
</body>
</html>