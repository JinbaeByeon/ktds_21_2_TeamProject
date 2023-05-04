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
		AjaxUtil.disableSpinner();
		$(".sidebar > ul li a").removeClass("active")
		$("#prj_list").addClass("active");
		
		$.get("${context}/api/cmncd/list/002", function(response) {
			var prjStts = $("#prjStts");
			var sttsNm
			
			for (var i in response.data) {
				if ($("#prjStts").val() == response.data[i].cdId) {
					sttsNm = response.data[i].cdNm;
				}
			}
			
			var sttsInput = $("<input type='text' id='prjStts' name='prjStts' value='" + sttsNm + "' readonly/>");
			prjStts.after(sttsInput);
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
        	<div class="path">${prjId} | ${prjVO.prjNm}</div>
			<table class="detail_page detail_table">
                <input type="hidden" id="prjId" name="prjId" value="${prjId}" readonly/>
                <tr>
                    <th>프로젝트명</th>
                    <td colspan="3">${prjVO.prjNm}</td>
                </tr>
                <tr>
                    <th>고객사</th>
                    <td colspan="3">${prjVO.cstmr}</td>
                </tr>
                <tr>
                    <th>시작일</th>
                    <td colspan="3">${prjVO.strtDt}</td>
                </tr>
                <tr>
                    <th>종료일</th>
                    <td colspan="3">${prjVO.endDt}</td>
                </tr>
                <tr>
                    <th>프로젝트 상태</th>
                    <td colspan="3">${prjVO.prjStts}</td>
                </tr>
                <tr>
                    <th>팀</th>
                    <td colspan="3">
                	<c:choose>
						<c:when test="${not empty tmList}">
							<c:forEach items="${tmList}" var="tm">
									${tm.getValue()} (${tm.getKey()})<br/>
							</c:forEach>
						</c:when>
						<c:otherwise>
								등록된 팀이 없습니다.
						</c:otherwise>
					</c:choose>
					</td>
                </tr>
                <tr>
                    <th>팀원</th>
                    <td colspan="3">
                        <table class="list_table inner_table">
                        <thead>
                            <tr>
                                <th>직원ID</th>
                                <th>팀</th>
                                <th>이름</th>
                                <th>권한</th>
                            </tr>
                        </thead>
                        <tbody>
							<c:choose>
								<c:when test="${not empty prjVO.ptmList}">
									<c:forEach items="${prjVO.ptmList}" var="ptm">
										<c:if test="${ptm.prjPstn=='PM'}">
											<tr>
												<td>${ptm.tmMbrVO.empVO.empId}</td>
												<td>${ptm.tmMbrVO.tmVO.tmNm}</td>
												<td>${ptm.tmMbrVO.empVO.lNm} ${ptm.tmMbrVO.empVO.fNm}</td>
												<td>총잭임자</td>	
											</tr>									
										</c:if>
									</c:forEach>
									<c:forEach items="${prjVO.ptmList}" var="ptm">
										<c:if test="${ptm.prjPstn=='PL'}">
											<tr>
												<td>${ptm.tmMbrVO.empVO.empId}</td>
												<td>${ptm.tmMbrVO.tmVO.tmNm}</td>
												<td>${ptm.tmMbrVO.empVO.lNm} ${ptm.tmMbrVO.empVO.fNm}</td>
												<td>부책임자</td>	
											</tr>									
										</c:if>
									</c:forEach>
									<c:forEach items="${prjVO.ptmList}" var="ptm">
										<c:if test="${ptm.prjPstn=='TM'}">
											<tr>
												<td>${ptm.tmMbrVO.empVO.empId}</td>
												<td>${ptm.tmMbrVO.tmVO.tmNm}</td>
												<td>${ptm.tmMbrVO.empVO.lNm} ${ptm.tmMbrVO.empVO.fNm}</td>
												<td>팀원</td>	
											</tr>									
										</c:if>
									</c:forEach>
				<%-- 						<tr>
											<td>
												<c:if test="${ptm.prjPstn=='PM'}">
													총책임자
												</c:if>
												<c:if test="${ptm.prjPstn=='PL'}">
													부책임자
												</c:if>
												<c:if test="${ptm.prjPstn=='TM'}">
													팀원
												</c:if>
											</td>
										</tr> --%>
								</c:when>
								<c:otherwise>
									<td colspan="4" class="no-items">
										등록된 팀원이 없습니다.
									</td>
								</c:otherwise>
							</c:choose>
                        </tbody>
                    </table>
                    </td>
                </tr>                
                
            </table>
                
            <div class="hr"></div>
            <div class="req path">요구사항</div>
            <div class="view_all">
                <a href="${context}/req/list?prjId=${prjId}&prjNm=${prjVO.prjNm}">전체보기</a>
            </div>
            
                <table class="list_table sub_table">
                    <thead>
                        <tr>
                            <th>우선순위</th>
                            <th>제목</th>
                            <th>담당자</th>
                            <th>일정</th>
                            <th>진행상태</th>
                            <th>시작일</th>
							<th>종료예정일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty prjVO.reqList.get(0).reqId}">
                                <c:forEach items="${prjVO.reqList}" var="req" end="5">
                                    <tr>
                                        <td>${req.prrty}</td>
                                        <td><a href="${context}/req/detail/${req.reqId}">${req.reqTtl}</a></td>
                                        <td>${req.mnDvlpr}</td>
                                        <td>${req.tskStts}</td>
                                        <td>${req.prcsStts}</td>
                                        <td>${req.strtDt}</td>
										<td>${req.expctEndDt}</td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                        <c:otherwise>
                            <td colspan="8" class="no-items">
                                등록된 요구사항이 없습니다.
                            </td>
                        </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
        
        <div class="hr"></div>
            <div class="req path">지식관리</div>
            <div class="view_all">
                <a href="${context}/knw/list/prj?ttl=&prjId=${prjId}&prjVO.prjNm=${prjVO.prjNm}&pageNo=0">전체보기</a>
            </div>
            
                <table class="list_table sub_table">
                    <thead>
                        <tr>
                            <th>제목</th>
                            <th>등록자</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty prjVO.knwList.get(0).knwId}">
                                <c:forEach items="${prjVO.knwList}" var="knw" end="5">
                                    <tr>
                                        <td><a href="${context}/knw/detail/${knw.knwId}">${knw.ttl}</a></td>
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

        <div class="buttons">
          <button id="modify-btn" class="btn regist">수정</button>
          <button id="delete-btn" class="btn delete">삭제</button>
        </div>
			<jsp:include page="../include/footer.jsp" />			
		</div>
	</div>
</body>
</html>