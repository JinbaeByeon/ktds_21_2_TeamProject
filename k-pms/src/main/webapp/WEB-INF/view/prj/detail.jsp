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
						${prjId}
						${prjVO.prjNm}
						${prjVO.cstmr}
						${prjVO.strtDt}
						${prjVO.endDt}
						${prjVO.prjStts}
						${prjVO.useYn}
						${prjVO.ptmList.get(0).tmMbrVO.empId}
						${prjVO.ptmList.get(0).tmMbrVO.empVO.fNm}

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
											<th>직원ID</th>
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
						
						
						
						<div class=items>
							<c:forEach items="${prjVO.ptmList}" var="ptm">
								${ptm.prjTmMbrId}
							</c:forEach>
						<div>
						<div class=items>
							<c:forEach items="${prjVO.ptmList}" var="ptm">
								${ptm.prjTmMbrId}
							</c:forEach>
						<div>
						<button id="addGnrBtn" class="btn-primary">등록</button>
						<div class="items">
							<c:forEach items="${mvVO.gnrList}" var="gnr" varStatus="index" >
								<div class="gnr-item ${gnr.gnrId}">
												<input type='hidden' name='gnrList[${index.index}].gnrId' value="${gnr.gnrId}"/>
												<span>${gnr.gnrVO.gnrNm}</span>
												<button class="del-gnr-item-btn" data-index="${index.index}" data-gnrid="${gnr.gnrId}">X</button>
											</div>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="create-group">
								<label for="addDirectorBtn">감독</label>
								<div>
									<button id="addDirectorBtn" class="btn-primary">등록</button>
									<div class="items">
										<c:forEach items="${mvVO.pplList}" var="mvppl" varStatus="index">
											<c:if test="${mvppl.rol eq 'DRCTR'}" >
											<div class="mvppl-item ${mvppl.mvPplId}">
												<input type='hidden' name='pplList[${index.index}].mvPplId' value="${mvppl.mvPplId}"/>
												<input type='hidden' name='pplList[${index.index}].rol' value="${mvppl.rol}"/>
												<input type='text' data-index="${index.index}" data-org-name="${mvppl.dtlRol}" name='pplList[${index.index}].dtlRol' class="dtlRol" placeholder='배역명' value="${mvppl.dtlRol}"/>	
												<span>${mvppl.mvPplVO.nm}</span>
												<button class="del-ppl-item-btn" data-index="${index.index}" data-prdcprtcptnid="${mvppl.prdcPrtcptnId}">X</button>						
											</div>
											</c:if>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="create-group">
								<label for="addWriterBtn">각본</label>
								<div>
									<button id="addWriterBtn" class="btn-primary">등록</button>
									<div class="items">
										<c:forEach items="${mvVO.pplList}" var="mvppl" varStatus="index">
											<c:if test="${mvppl.rol eq 'WRTR'}" >
											<div class="mvppl-item ${mvppl.mvPplId}">
												<input type='hidden' name='pplList[${index.index}].mvPplId' value="${mvppl.mvPplId}"/>
												<input type='hidden' name='pplList[${index.index}].rol' value="${mvppl.rol}"/>
												<input type='text' data-index="${index.index}" data-org-name="${mvppl.dtlRol}" name='pplList[${index.index}].dtlRol' class="dtlRol" placeholder='배역명' value="${mvppl.dtlRol}"/>	
												<span>${mvppl.mvPplVO.nm}</span>
												<button class="del-ppl-item-btn" data-index="${index.index}" data-prdcprtcptnid="${mvppl.prdcPrtcptnId}">X</button>						
											</div>
											</c:if>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="create-group">
								<label for="addProducerBtn">연출</label>
								<div>
									<button id="addProducerBtn" class="btn-primary">등록</button>
									<div class="items">
										<c:forEach items="${mvVO.pplList}" var="mvppl" varStatus="index">
											<c:if test="${mvppl.rol eq 'PRDCR'}" >
											<div class="mvppl-item ${mvppl.mvPplId}">
												<input type='hidden' name='pplList[${index.index}].mvPplId' value="${mvppl.mvPplId}"/>
												<input type='hidden' name='pplList[${index.index}].rol' value="${mvppl.rol}"/>
												<input type='text' data-index="${index.index}" data-org-name="${mvppl.dtlRol}" name='pplList[${index.index}].dtlRol' class="dtlRol" placeholder='배역명' value="${mvppl.dtlRol}"/>	
												<span>${mvppl.mvPplVO.nm}</span>
												<button class="del-ppl-item-btn" data-index="${index.index}" data-prdcprtcptnid="${mvppl.prdcPrtcptnId}">X</button>						
											</div>
											</c:if>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="create-group">
								<label for="addMainActorBtn">주연</label>
								<div>
									<button id="addMainActorBtn" class="btn-primary">등록</button>
									<div class="items">
										<c:forEach items="${mvVO.pplList}" var="mvppl" varStatus="index">
											<c:if test="${mvppl.rol eq 'MNACTR'}" >
											<div class="mvppl-item ${mvppl.mvPplId}">
												<input type='hidden' name='pplList[${index.index}].mvPplId' value="${mvppl.mvPplId}"/>
												<input type='hidden' name='pplList[${index.index}].rol' value="${mvppl.rol}"/>
												<input type='text' data-index="${index.index}" data-org-name="${mvppl.dtlRol}" name='pplList[${index.index}].dtlRol' class="dtlRol" placeholder='배역명' value="${mvppl.dtlRol}"/>	
												<span>${mvppl.mvPplVO.nm}</span>
												<button class="del-ppl-item-btn" data-index="${index.index}" data-prdcprtcptnid="${mvppl.prdcPrtcptnId}">X</button>						
											</div>
											</c:if>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="create-group">
								<label for="addSupportActorBtn">조연</label>
								<div>
									<button id="addSupportActorBtn" class="btn-primary">등록</button>
									<div class="items">
										<c:forEach items="${mvVO.pplList}" var="mvppl" varStatus="index">
											<c:if test="${mvppl.rol eq 'SPRTACTR'}" >
											<div class="mvppl-item ${mvppl.mvPplId}">
												<input type='hidden' name='pplList[${index.index}].mvPplId' value="${mvppl.mvPplId}"/>
												<input type='hidden' name='pplList[${index.index}].rol' value="${mvppl.rol}"/>
												<input type='text' data-index="${index.index}" data-org-name="${mvppl.dtlRol}" name='pplList[${index.index}].dtlRol' class="dtlRol" placeholder='배역명' value="${mvppl.dtlRol}"/>	
												<span>${mvppl.mvPplVO.nm}</span>
												<button class="del-ppl-item-btn" data-index="${index.index}" data-prdcprtcptnid="${mvppl.prdcPrtcptnId}">X</button>						
											</div>
											</c:if>
										</c:forEach>
									</div>
								</div>
							</div>
							<div class="create-group">
								<label for="addEtcBtn">기타</label>
								<div>
									<button id="addEtcBtn" class="btn-primary">등록</button>
									<div class="items">
										<c:forEach items="${mvVO.pplList}" var="mvppl" varStatus="index">
											<c:if test="${mvppl.rol eq 'ECT'}" >
											<div class="mvppl-item ${mvppl.mvPplId}">
												<input type='hidden' name='pplList[${index.index}].mvPplId' value="${mvppl.mvPplId}"/>
												<input type='hidden' name='pplList[${index.index}].rol' value="${mvppl.rol}"/>
												<input type='text' data-index="${index.index}" data-org-name="${mvppl.dtlRol}" name='pplList[${index.index}].dtlRol' class="dtlRol" placeholder='배역명' value="${mvppl.dtlRol}"/>	
												<span>${mvppl.mvPplVO.nm}</span>
												<button class="del-ppl-item-btn" data-index="${index.index}" data-prdcprtcptnid="${mvppl.prdcPrtcptnId}">X</button>						
											</div>
											</c:if>
										</c:forEach>
									</div>
								</div>
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