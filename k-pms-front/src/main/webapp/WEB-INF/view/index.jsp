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
			$(".prj_detail").hide();
			$(".prj_detail").addClass("hide");
			$("#prj_list > tbody > tr").click(function(){
				
				$("#prj_list td").css("border-bottom", "1px solid #2b2b2b30");
				$(".prj_detail").hide();
				$(".prj_detail").removeClass("show");
				$(".prj_detail").addClass("hide");
				
				
				$(this).children().css("border-bottom", "none");
				$(this).next().show();
				$(this).next().removeClass("hide");
				$(this).next().addClass("show");
				
				
				var startDt = parseInt($(this).data("strtdt").split("-").join(""));
				var endDt = parseInt($(this).data("enddt").split("-").join(""));
				var dDay = (endDt - startDt > 0 ? endDt - startDt : 0)
				
				$(".dDay").attr('value', dDay);
			});
		});
	</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="./include/header.jsp"/>
		<div>
			<jsp:include page="./include/sidemenu.jsp"/>
			<jsp:include page="./include/content.jsp"/>
			
			<h3>나의 부서</h3>
			<table class="detail_page detail_table">
                <tr>
                    <th>부서명</th>
                    <td colspan="3" style="border: none;">${depVO.depNm}</td>

                    <th>부서장명</th>
                    <td colspan="3">${depVO.hdNmEmpVO.lNm}${depVO.hdNmEmpVO.fNm}</td>

                </tr>
            </table>
            <div class="hr" style="margin-bottom: 20px;"></div>
           <h3>나의 팀</h3>
           <div class="list_section">
            <div class="total">
                총 ${depVO.tmList.size() > 0 ? depVO.tmList.size() : 0}건
            </div>
            <div class="view_all">
                <a href="${context}/dep/detail">전체보기</a>
            </div>
                <table class="list_table sub_table">
                    <thead>
                        <tr>
                            <th>순번</th>
							<th>팀명</th>
							<th>팀장ID</th>
							<th>팀장명</th>
                        </tr>
                    </thead>
                    <tbody>
						<c:choose>
							<c:when test="${not empty depVO.tmList}">
								<c:forEach items="${depVO.tmList}"
											var="tm"
											varStatus="index"
											end="3">
										<tr>
											<td>${index.index + 1}</td>
											<td><a href="${context}/tm/detail/${tm.tmId}">${tm.tmNm}</a></td>
											<td>${tm.tmHdId}</td>
											<td>${tm.tmHdEmpVO.lNm}${tm.tmHdEmpVO.fNm}</td>
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
                </div>
                <div class="hr" style="margin-bottom: 20px;"></div>
                <h3>나의 프로젝트</h3>
                <div class="list_section">
		        <div class="total">총 ${prjList.size() > 0 ? prjList.get(0).totalCount : 0}건</div>
		        <div class="view_all">
                <a href="${context}/prj/detail">전체보기</a>
            	</div>
		        <table class="list_table" id="prj_list">
		          <thead>
		            <tr>
		            	<th>순번</th>
						<th>프로젝트명</th>
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
								<tr data-prjid="${prj.prjId}"
									data-prjnm="${prj.prjNm}"
									data-cstmr="${prj.cstmr}"
									data-strtdt="${prj.strtDt}"
									data-enddt="${prj.endDt}"
									data-prjstts="${prj.prjStts}"
									data-useyn="${prj.useYn}" >
									<td>${prj.rnum}</td>
									<td><a href="${context}/prj/detail/${prj.prjId}">${prj.prjNm}</a></td>
									<td>${prj.cstmr}</td>
									<td>${prj.strtDt}</td>
									<td>${prj.endDt}</td>
									<td>${prj.prjStts}</td>
								</tr>
								<tr class="prj_detail">
									<td colspan="6" style="padding-top: 0px;">
									<span class="prj_detail_title">목표현황</span>
			                             <div class="skill_bar">
											 <c:if test="${prj.prjStts == '분석중'}">
											        <div class="skill s_001"></div>
					                         </c:if>
											 <c:if test="${prj.prjStts == '설계중'}">
					                             <div class="skill s_002"></div>
					                         </c:if>
											 <c:if test="${prj.prjStts == '개발중'}">
					                             <div class="skill s_003"></div>
					                         </c:if>
											 <c:if test="${prj.prjStts == '단위 테스트 진행중'}">
					                             <div class="skill s_004"></div>
					                         </c:if>
											 <c:if test="${prj.prjStts == '통합 테스트 진행중'}">
					                             <div class="skill s_005"></div>
					                         </c:if>
											 <c:if test="${prj.prjStts == '오픈 대기중'}">
					                             <div class="skill s_006"></div>
					                         </c:if>
					                         <c:if test="${prj.prjStts == '오픈'}">
					                             <div class="skill s_007"></div>
					                         </c:if>
					                         <c:if test="${prj.prjStts == '하자 보수 진행중'}">
					                             <div class="skill s_008"></div>
					                         </c:if>
					                         <c:if test="${prj.prjStts == '완료'}">
					                             <div class="skill s_009"></div>
					                         </c:if>
									    </div>
			                         
			                         <span class="prj_detail_title">남은기간</span>
			                         <div class=left_day>
			                         	D-<input class="dDay" value="" />
			                         	<span style="color: #2b2b2b80; font-size: 15px">${prj.strtDt} ~ ${prj.endDt}</span>
			                         </div>
			                         
									</td>
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
		      <div style="height:30px;"></div>
			<jsp:include page="./include/footer.jsp"/>
		</div>
	</div>
</body>
</html>