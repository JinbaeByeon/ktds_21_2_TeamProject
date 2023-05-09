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
		<div>
			<jsp:include page="./include/sidemenu.jsp"/>
			<jsp:include page="./include/content.jsp"/>
		      <div class="list_section">
				<h3>임직원 목록</h3>
				<div class="view_all">
					<a href="${context}/emp/list">전체보기</a>
            	</div>
		        <table class="list_table">
		          <thead>
						<tr>
							<th style="width: 8%;">ID</th>
							<th style="width: 9%;">이름</th>
							<th style="width: 10%;">생성일</th>
							<th style="width: 8%;">재직상태</th>
							<th style="width: 8%;">관리자여부</th>
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
									<tr data-empid="${emp.empId}" 
									    data-fnm="${emp.fNm}"
									    data-lnm="${emp.lNm}"
									    data-crtdt="${emp.crtDt}"
									    data-emplmntstts="${emp.emplmntStts}"
									    data-admnyn="${emp.admnYn}"
									    data-pstnid="${emp.pstnId}"
									    data-jobid="${emp.jobId}"
									    data-depid="${emp.depId}"
									    data-lgncnt="${emp.lgnCnt}">
										<td>${emp.empId}</td>
										<td>${emp.lNm}${emp.fNm}</td>
										<td>${emp.crtDt}</td>
										<td>${emp.emplmntSttsVO.cdNm}</td>
										<td>
											<c:if test="${emp.admnYn=='Y'}">
												<span>관리자</span>
											</c:if>
											<c:if test="${emp.admnYn=='N'}">
												<span>일반회원</span>
											</c:if>
										</td>
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
		        <div class="hr" style="margin-bottom: 20px;"></div>
		        <h3>부서 목록</h3>
		        <div class="view_all">
					<a href="${context}/dep/list">전체보기</a>
            	</div>
		        <table class="list_table">
			          <thead>
			            <tr>
							<th style="width: 2px;">순번</th>
							<th style="width: 12%;">부서명</th>
							<th style="width: 17%;">부서장ID</th>
							<th style="width: 18%;">부서장명</th>
							<th style="width: 21%;">부서 관리번호</th>
							<th style="width: 15%;">부서생성일</th>
							<th style="width: 80px;">사용여부</th>
			            </tr>
			          </thead>
			          <tbody>
							<c:choose>
								<c:when test="${not empty depList}">
									<c:forEach items="${depList}"
												var="dep"
												varStatus="index">
										<tr data-depid="${dep.depId}"
											data-depnm="${dep.depNm}"
											data-dephdid="${dep.depHdId}"
											data-dephdnm="${dep.hdNmEmpVO.lNm}${dep.hdNmEmpVO.fNm}"
											data-depcrtdt="${dep.depCrtDt}"
											data-useyn="${dep.useYn}"
											data-crtr="${dep.crtr}"
											data-crtdt="${dep.crtDt}"
											data-mdfyr="${dep.mdfyr}"
											data-mdfydt="${dep.mdfyDt}">
											<td style="padding-left: 27px; padding-right: 0px;">${dep.rnum}</td>
											<td><a href="${context}/dep/detail/${dep.depId}">${dep.depNm}</a></td>
											<td>${dep.depHdId}</td>
											<td>${dep.hdNmEmpVO.lNm}${dep.hdNmEmpVO.fNm}</td>
											<td>${dep.depId}</td>
											<td>${dep.depCrtDt}</td>
											<td style="padding-left: 40px; padding-right: 0px;">${dep.useYn}</td>
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
			        <div class="hr" style="margin-bottom: 20px;"></div>
			        <h3>프로젝트 목록</h3>
		        <div class="view_all">
					<a href="${context}/prj/list">전체보기</a>
            	</div>
		        <table class="list_table">
		          <thead>
		            <tr>
						<th>순번</th>
						<th>프로젝트명</th>
						<th>프로젝트 관리번호</th>
						<th>고객사</th>
						<th>시작일</th>
						<th>종료일</th>
						<th>
							<select id="prjSttsType" name="prjSttsType">
								<option value="">프로젝트 상태</option>
								<option value="002_01">분석중</option>
								<option value="002_02">설계중</option>
								<option value="002_03">개발중</option>
								<option value="002_04">단위 테스트 진행중</option>
								<option value="002_05">통합 테스트 진행중</option>
								<option value="002_06">오픈 대기중</option>
								<option value="002_07">오픈</option>
								<option value="002_08">하자 보수 진행중</option>
								<option value="002_09">완료</option>
							</select>
						</th>
		            </tr>
		          </thead>
		          <tbody>
		       		<c:choose>
						<c:when test="${not empty prjList}">
							<c:forEach items="${prjList}"
										var="prj">
								<tr data-prjid="${prj.prjId}"
									data-prjnm="${prj.prjNm}"
									data-cstmr="${prj.cstmr}"
									data-strtdt="${prj.strtDt}"
									data-enddt="${prj.endDt}"
									data-prjstts="${prj.prjStts}"
									data-useyn="${prj.useYn}" >
									<td>${prj.rnum}</td>
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
			<jsp:include page="./include/footer.jsp"/>
		</div>
	</div>
</body>
</html>