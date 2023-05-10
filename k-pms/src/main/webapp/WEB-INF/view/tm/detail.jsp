<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />
<c:set scope="request" var="selected" value="dep"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 상세 - ${tmVO.tmNm}</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	
	var detailWindow

	$().ready(function() {
		$(".sidebar > ul li a").removeClass("active")
		$("#tm_list").addClass("active");
		
		$("#modify-btn").click(function() {
			location.href = "${context}/tm/update/" + $("#tmId").val();
		});
		
		$("#list-btn").click(function(response) {
			location.href = "${context}/tm/list"
		});
		
		$("#delete-btn").click(function() {
			if(!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			$.get("${context}/api/tm/delete/" + $("#tmId").val(), function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}/tm/list"
				}
				else {
					alert(response.message);
				}
			});
		});
		
		$(".list_table.inner_table tbody > tr > td").click(function() {
			var empId = $(this).closest("tr").data("empid");
			detailWindow = window.open("${context}/emp/detail/"+ empId,"사원 정보","width=600, height= 700, top= 100, left = 500");
		});
		
	});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/depSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<div class="path">팀관리 > 팀 상세조회</div>
			<table class="detail_page detail_table">
				<tr>
					<th>부서명</th>
					<td colspan="3"><input type="text" id="depNm" name="depNm"
						value="${tmVO.depIdDepVO.depNm}" readonly /></td>
				</tr>
				<tr>
					<th>부서 관리번호</th>
					<td colspan="3"><input type="text" id="depId" name="depId"
						value="${tmVO.depId}" readonly /></td>
				</tr>
				<tr>
					<th>팀명</th>
					<td colspan="3"><input type="text" id="tmNm" name="tmNm"
						value="${tmVO.tmNm}" readonly /></td>
				</tr>
				<tr>
					<th>팀 관리번호</th>
					<td colspan="3"><input type="text" id="tmId" name="tmId"
						value="${tmVO.tmId}" readonly /></td>
				</tr>
				<tr>
					<th>팀장ID</th>
					<td colspan="3"><input type="text" id="tmHdId" name="tmHdId"
						value="${tmVO.tmHdId}" readonly /></td>
				</tr>
				<tr>
					<th>팀장명</th>
					<td colspan="3"><input type="text" id="tmHdNm" name="tmHdNm"
						value="${tmVO.tmHdEmpVO.lNm}${tmVO.tmHdEmpVO.fNm}" readonly /></td>
				</tr>
				<tr>
					<th>팀 생성일</th>
					<td colspan="3"><input type="date" id="tmCrtDt" name="tmCrtDt"
						value="${tmVO.tmCrtDt}" readonly /></td>
				</tr>
				<tr>
					<th>사용여부</th>
					<td colspan="3"><input type="checkbox" id="useYn" name="useYn"
						value="Y" ${tmVO.useYn eq 'Y' ? 'checked' : ''}
						onClick="return false" /></td>
				</tr>
				<tr>
					<th>소속 팀원</th>
					<td colspan="3">
						<div class="total">총 ${tmVO.tmMbrList.size() > 0 ? tmVO.tmMbrList.size() : 0}건</div>
						<table class="list_table inner_table">
							<thead>
								<tr>
									<th>팀 직책</th>
									<th>직급</th>
									<th>직원ID</th>
									<th>이름</th>
									<th>직무</th>
									<th>생년월일</th>
									<th>이메일</th>
									<th>전화번호</th>
									<th>직급연차</th>
								</tr>
							</thead>
							<tbody>
								<tr data-empid="${tmHdEmpVO.empId}">
									<td>팀장</td>
									<td>${tmHdEmpVO.pstn.pstnNm}</td>
									<td>${tmHdEmpVO.empId}</td>
									<td>${tmHdEmpVO.lNm}${tmHdEmpVO.fNm}</td>
									<td>${tmHdEmpVO.job.jobNm}</td>
									<td>${tmHdEmpVO.brthdy}</td>
									<td>${tmHdEmpVO.eml}</td>
									<td>${tmHdEmpVO.phn}</td>
									<td>${tmHdEmpVO.pstnPrd}</td>
								</tr>
								<c:choose>
									<c:when test="${not empty tmVO.tmMbrList}">
										<c:forEach items="${tmVO.tmMbrList}" var="tmMbr"
											varStatus="index">
											<c:if test="${tmMbr.empId != tmVO.tmHdId}">
												<tr data-empid="${tmMbr.empId}">
													<td>팀원</td>
													<td>${tmMbr.empVO.pstn.pstnNm}</td>
													<td>${tmMbr.empId}</td>
													<td>${tmMbr.empVO.lNm}${tmMbr.empVO.fNm}</td>
													<td>${tmMbr.empVO.job.jobNm}</td>
													<td>${tmMbr.empVO.brthdy}</td>
													<td>${tmMbr.empVO.eml}</td>
													<td>${tmMbr.empVO.phn}</td>
													<td>${tmMbr.empVO.pstnPrd}</td>
												</tr>
											</c:if>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="9" class="no-items">등록된 팀원이 없습니다.</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
			</table>
			<div class="buttons">
				<button id="list-btn" class="btn new">목록</button>
				<button id="modify-btn" class="btn regist">수정</button>
				<button id="delete-btn" class="btn delete">삭제</button>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>