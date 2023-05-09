<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<c:set scope="request" var="selected" value="home"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>홈페이지</title>
	<jsp:include page="./include/stylescript.jsp"/>
	<script type="text/javascript">
		$().ready(function(){
			
		});
	</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="./include/header.jsp"/>
		<div class="firstPart">
			<jsp:include page="./include/sidemenu.jsp"/>
			<jsp:include page="./include/content.jsp"/>
		      <div class="list_section">
			      <div class="firstPart">
			      	<div class="halfTable leftTable">
						<h3>임직원 목록</h3>
						<div class="view_all">
							<a href="${context}/emp/list">전체보기</a>
		            	</div>
				        <table class="list_table">
				          <thead>
								<tr>
									<th style="width: 8%;">ID</th>
									<th style="width: 9%;">이름</th>
									<th style="width: 7%;">직급</th>
									<th style="width: 7%;">직무</th>
									<th style="width: 7%;">부서</th>
								</tr>
				          </thead>
				          <tbody>
								<c:choose>
									<c:when test="${not empty empList}">
										<c:forEach items="${empList}"
												   var="emp"
												   varStatus="index">
											<tr>
												<td>${emp.empId}</td>
												<td>${emp.lNm}${emp.fNm}</td>
												<td>${emp.pstn.pstnNm}</td>
												<td>${emp.job.jobNm}</td>
												<td>${emp.dep.depNm}</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="11" class="no-items">
											등록된 사원이 없습니다.
											</td>
										</tr>
									</c:otherwise>
								</c:choose>
				          </tbody>
				        </table>
			      	</div>
			      	<div></div>
			      	<div class="halfTable rightTable">
				        <h3>부서 목록</h3>
				        <div class="view_all">
							<a href="${context}/dep/list">전체보기</a>
		            	</div>
				        <table class="list_table">
					          <thead>
					            <tr>
									<th style="width: 12%;">부서명</th>
									<th style="width: 17%;">부서장ID</th>
									<th style="width: 18%;">부서장명</th>
					            </tr>
					          </thead>
					          <tbody>
									<c:choose>
										<c:when test="${not empty depList}">
											<c:forEach items="${depList}"
														var="dep"
														varStatus="index">
												<tr>
													<td><a href="${context}/dep/detail/${dep.depId}">${dep.depNm}</a></td>
													<td>${dep.depHdId}</td>
													<td>${dep.hdNmEmpVO.lNm}${dep.hdNmEmpVO.fNm}</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr>
												<td colspan="11" class="no-items">
													등록된 부서가 없습니다.
												</td>
											</tr>
										</c:otherwise>
									</c:choose>
					          </tbody>
					        </table>
			      	</div>
			      </div>
			    <div class="lastTable">
				    <h3>프로젝트 목록</h3>
			        <div class="view_all">
						<a href="${context}/prj/list">전체보기</a>
	            	</div>
			        <table class="list_table">
			          <thead>
			            <tr>
							<th>프로젝트명</th>
							<th>프로젝트 관리번호</th>
							<th>고객사</th>
							<th>시작일</th>
							<th>종료일</th>
							<th>프로젝트 상태</th>
			            </tr>
			          </thead>
			          <tbody>
			       		<c:choose>
							<c:when test="${not empty prjList}">
								<c:forEach items="${prjList}"
											var="prj">
									<tr>
										<td><a href="${context}/prj/detail/${prj.prjId}">${prj.prjNm}</a></td>
										<td>${prj.prjId}</td>
										<td>${prj.cstmr}</td>
										<td>${prj.strtDt}</td>
										<td>${prj.endDt}</td>
										<td>${prj.prjStts}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="9" class="no-items">
										등록된 프로젝트가 없습니다.
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
			          </tbody>
			        </table>
			    </div>  
		      </div>
			<jsp:include page="./include/footer.jsp"/>
		</div>
	</div>
</body>
</html>