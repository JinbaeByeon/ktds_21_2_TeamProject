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
<title>부서 상세조회</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		$("#list-btn").click(function(response) {
			location.href = "${context}/dep/list"
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
				<div class="path">부서관리 > 부서 상세조회</div>
			<table class="detail_page detail_table">
                <tr>
                    <th>부서명</th>
                    <td colspan="3"><input type="text" id="depNm" name="depNm" value="${depVO.depNm}" readonly/></td>
                </tr>
                <tr>
                    <th>부서ID</th>
                    <td colspan="3"><input type="text" id="depId" name="depId" value="${depVO.depId}" readonly/></td>
                </tr>
                <tr>
                    <th>부서장ID</th>
                    <td colspan="3"><input type="text" id="depHdId" name="depHdId" value="${depVO.depHdId}" readonly/></td>
                </tr>
                <tr>
                    <th>부서장명</th>
                    <td colspan="3"><input type="text" id="depHdNm" name="depHdNm" value="${depVO.hdNmEmpVO.lNm}${depVO.hdNmEmpVO.fNm}" readonly/></td>
                </tr>
                <tr>
                    <th>부서 생성일</th>
                    <td colspan="3"><input type="date" id="depCrtDt" name="depCrtDt" value="${depVO.depCrtDt}" readonly/></td>
                </tr>
                <tr>
                    <th>등록자</th>
                    <td><input type="text" id="crtr" name="crtr" value="${depVO.crtr}" readonly/></td>
                    <th>등록일</th>
                    <td><input type="text" id="crtr" name="crtr" value="${depVO.crtDt}" readonly/></td>
                </tr>
                <tr>
                	<th>수정자</th>
                    <td><input type="text" id="crtr" name="crtr" value="${depVO.mdfyr}" readonly/></td>
                    <th>수정일</th>
                    <td><input type="text" id="crtr" name="crtr" value="${depVO.mdfyDt}" readonly/></td>
               </tr>
            </table>
                
            <div class="hr"></div>
            <div class="path">소속 팀</div>
            <div class="total">
                총 ${depVO.tmList.size() > 0 ? depVO.tmList.size() : 0}건
            </div>
            
                <table class="list_table sub_table">
                    <thead>
                        <tr>
                            <th>순번</th>
							<th>팀ID</th>
							<th>팀명</th>
							<th>팀장ID</th>
							<th>팀장 성명</th>
							<th>팀생성일</th>
                        </tr>
                    </thead>
                    <tbody>
						<c:choose>
							<c:when test="${not empty depVO.tmList}">
								<c:forEach items="${depVO.tmList}"
											var="tm"
											varStatus="index">
										<tr>
											<td>${index.index + 1}</td>
											<td>${tm.tmId}</td>
											<td><a href="${context}/tm/detail/${tm.tmId}">${tm.tmNm}</a></td>
											<td>${tm.tmHdId}</td>
											<td>${tm.tmHdEmpVO.lNm}${tm.tmHdEmpVO.fNm}</td>
											<td>${tm.tmCrtDt}</td>
										</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<th>순번</th>
									<th>팀ID</th>
									<th>팀명</th>
									<th>팀장ID</th>
									<th>팀장 성명</th>
									<th>팀생성일</th>
								</tr>
							</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty depVO.tmList}">
									<c:forEach items="${depVO.tmList}"
												var="tm"
												varStatus="index">
											<tr>
												<td>${index.index + 1}</td>
												<td>${tm.tmId}</td>
												<td><a href="${context}/tm/detail/${tm.tmId}">${tm.tmNm}</a></td>
												<td>${tm.tmHdId}</td>
												<td>${tm.tmHdEmpVO.lNm}${tm.tmHdEmpVO.fNm}</td>
												<td>${tm.tmCrtDt}</td>
											</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="6" class="no-items">
											등록된 팀이 없습니다.
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div>소속 부서원</div>
					<div class="grid-count align-right">
						 총 ${depVO.empList.size() > 0 ? depVO.empList.size() : 0}건
					</div>
					<table>
						<thead>
							<tr>
								<th>순번</th>
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
						<c:choose>								
							<c:when test="${not empty depVO.empList}">
								<c:forEach items="${depVO.empList}"
											var="emp"
											varStatus="index">
										<tr>
											<td>${index.index + 1}</td>
											<td>${emp.pstn.pstnNm}</td>
											<td>${emp.empId}</td>
											<td>${emp.lNm}${emp.fNm}</td>
											<td>${emp.job.jobNm}</td>
											<td>${emp.brthdy}</td>
											<td>${emp.eml}</td>
											<td>${emp.phn}</td>
											<td>${emp.pstnPrd}</td>
										</tr>
								</c:forEach>
						    </c:when>
							<c:otherwise>
								<tr>
									<td colspan="9" class="no-items">
										등록된 부서원이 없습니다.
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<div class="align-right">
					<button id="list-btn" class="btn-primary">목록</button>
			</div>
			<jsp:include page="../include/footer.jsp" />			
		</div>
	</div>
</body>
</html>