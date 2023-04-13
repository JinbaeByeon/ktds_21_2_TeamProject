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
				<div class="path"> 프로젝트 > 프로젝트 목록 > ${prjId} | ${prjVO.prjNm}</div>
					<div>
						${prjId}
						${prjVO.prjNm}
						${prjVO.cstmr}
						${prjVO.strtDt}
						${prjVO.endDt}
						${prjVO.prjStts}
						${prjVO.useYn}
						${prjVO.ptmList.get(0).prjTmMbrId}

				<div class="create-group">
								<label for="mvTtl">영화제목</label>
								<input type="text" id="mvTtl" name="mvTtl" value="${mvVO.mvTtl}"/>
							</div>
							<div class="create-group">
								<label for="engTtl">영화제목(영어)</label>
								<input type="text" id="engTtl" name="engTtl" value="${mvVO.engTtl}"/>
							</div>
							<div class="create-group">
								<label for="scrnStt">상영상태</label>
								<select id="scrnStt" name="scrnStt">
									<option>선택</option>
									<option value="상영중" ${mvVO.scrnStt eq '상영중' ? 'selected' : '' }>상영중</option>						
									<option value="상영예정" ${mvVO.scrnStt eq '상영예정' ? 'selected' : '' }>상영예정</option>						
									<option value="상영종료" ${mvVO.scrnStt eq '상영종료' ? 'selected' : '' }>상영종료</option>						
								</select>
							</div>
							<div class="create-group">
								<label for="scrnTm">상영시간</label>
								<input type="number" id="scrnTm" name="scrnTm" value="${mvVO.scrnTm}"/>
							</div>
							<div class="create-group">
								<label for="opngDt">개봉일</label>
								<input type="date" id="opngDt" name="opngDt" value='${mvVO.opngDt}'/>
							</div>
							<div class="create-group">
								<label for="grd">관람등급</label>
								<select id="grd" name="grd">
									<option>선택</option>
									<option value="전체관람가" ${mvVO.grd eq '전체관람가' ? 'selected' : ''}>전체관람가</option>
									<option value="7" ${mvVO.grd eq '7' ? 'selected' : ''}>7세 이상 관람가</option>
									<option value="12" ${mvVO.grd eq '12' ? 'selected' : ''}>12세 이상 관람가</option>
									<option value="15" ${mvVO.grd eq '15' ? 'selected' : ''}>15세 이상 관람가</option>
									<option value="19" ${mvVO.grd eq '19' ? 'selected' : ''}>청소년 관람 불가</option>
								</select>
							</div>
							<div class="create-group">
								<label for="smr">줄거리</label>
								<textarea id="smr" name="smr" >${mvVO.smr}</textarea>
							</div>
							<div class="create-group">
								<label for="useYn">게시여부</label>
								<input type="checkbox" id="useYn" name="useYn" value="Y" ${mvVO.useYn eq 'Y' ? 'checked' : ''}/>
							</div>
							<div class="create-group">
								<label for="addGnrBtn">장르</label>
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