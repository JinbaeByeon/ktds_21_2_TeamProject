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
<title>프로젝트 상세정보 조회</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">	
	$().ready(function() {
	});
	
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/prjSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />		
				<div class="path"> ${prjId} | ${prjVO.prjNm}</div>
					<div class="create-group">
						<label for="mvTtl">프로젝트ID</label>
						<h3>${prjId}</h3>
					</div>
					<div class="create-group">
						<label for="prjNm">프로젝트명</label>
						<input type="text" id="prjNm" name="prjNm" value="${prjVO.prjNm}"/>
					</div>
					<div class="create-group">
						<label for="cstmr">고객사</label>
						<input type="text" id="prjNm" name="prjNm" value="${prjVO.cstmr}"/>
					</div>
					<div class="create-group">
						<label for="strtDt">시작일</label>
						<input type="date" id="strtDt" name="strtDt" value="${prjVO.strtDt}"/>
					</div>
					<div class="create-group">
						<label for="endDt">종료일</label>
						<input type="date" id="endDt" name="endDt" value='${prjVO.endDt}'/>
					</div>
					<div class="create-group">
						<label for="prjStts">프로젝트 상태</label>
						<input type="text" id="prjStts" name="prjStts" value='${prjVO.prjStts}'/>
					</div>
					<div class="create-group">
						<label for="useYn">사용여부</label>
						<input type="checkbox" id="useYn" name="useYn" value="Y" ${prjVO.useYn eq 'Y' ? 'checked' : ''}/>
					</div>
						<div class="create-group">
							<label for="tm">팀원</label>
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
						<div class="create-group">
							<label for="req">요구사항</label>
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
						</div>
						<div class="create-group">
							<label for="req">지식관리</label>
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
						</div>
				<div class="align-right">
					<button id="new-btn" class="btn-primary">등록</button>
					<button id="delete-btn" class="btn-delete">삭제</button>
				</div>
			<jsp:include page="../include/footer.jsp" />			
		</div>
	</div>
</body>
</html>