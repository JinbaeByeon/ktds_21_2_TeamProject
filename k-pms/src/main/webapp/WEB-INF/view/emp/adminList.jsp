<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>홈페이지</title>
	<jsp:include page="../include/stylescript.jsp"/>
	<script type="text/javascript">
		$().ready(function(){

		});
	</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sysSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp"/>
				<div class="path"> 시스템관리 > 관리자관리</div>
				
				<div class="grid">
					<div class="grid-count align-right">
						총 ${empList.size()}건
					</div>
					<table>
						<thead>
							<tr>
								<th>순번</th>
								<th>ID</th>
								<th>이름</th>
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
											data-brthdy="${emp.brthdy}"
											data-eml="${emp.eml}"
											data-phn="${emp.phn}"
											data-pstnprd="${emp.pstnPrd}"
											data-prflpht="${emp.prflPht}"
											data-hrdt="${emp.hrDt}"
											data-hrprd="${emp.hrPrd}"
											data-addrss="${emp.addrss}"
											data-emplmntstts="${emp.emplmntStts}"
											data-admnyn="${emp.admnYn}"
											data-pwdchngdt="${emp.pwdChngDt}"
											data-ltstlgnip="${emp.ltstLgnIp}"
											data-ltstlgndt="${emp.ltstLgnDt}"
											data-pstnid="${emp.pstnId}"
											data-jobid="${emp.jobId}"
											data-depid="${emp.depId}"
											data-lnm="${emp.lNm}"
											data-lgncnt="${emp.lgnCnt}"
											data-faildt="${emp.failDt}">
											<td>${index.index}</td>
											<td>${emp.empId}</td>
											<td>${emp.fNm}</td>
											<td>${emp.lNm}</td>
											<td>${emp.brthdy}</td>
											<td>${emp.eml}</td>
											<td>${emp.phn}</td>
											<td>${emp.pstnPrd}</td>
											<td>${emp.prflPht}</td>
											<td>${emp.hrDt}</td>
											<td>${emp.hrPrd}</td>
											<td>${emp.addrss}</td>
											<td>${emp.emplmntStts}</td>
											<td>${emp.admnYn}</td>
											<td>${emp.pwdChngDt}</td>
											<td>${emp.ltstLgnIp}</td>
											<td>${emp.ltstLgnDt}</td>
											<td>${emp.pstnId}</td>
											<td>${emp.jobId}</td>
											<td>${emp.depId}</td>
											<td>${emp.lgnCnt}</td>
											<td>${emp.failDt}</td>
											
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="22" class="no-items">
										등록된 관리자가 없습니다.
										</td>
									
									</tr>
								</c:otherwise>
							</c:choose>
						
						</tbody>
					</table>
					
				</div>
				
				<div class="grid-detail" >
					<form id="detail_form" >
						<!-- 
						isModify ==true => 수정(update)
						isModify == false => 등록(insert)
						 -->
						<input type="hidden" id="isModify" value="false" />
						<input type="hidden" id="admnYn" name="admnYn" value="Y"/>
						
						<div class="input-group inline">
							<label for="empId" style=" width:180px;">ID</label>
							<input type="text" id="empId" name="empId" value=""/>
						</div>	
						
						<div class="input-group inline">
							<label for="fNm" style=" width:180px;">이름</label>
							<input type="text" id="fNm"  name="fNm" value=""/>
						</div>	
						<div class="input-group inline">
							<label for="lNm" style=" width:180px;">성</label>
							<input type="text" id="lNm"  name="lNm" value=""/>
						</div>	
						<div class="input-group inline">
							<label for="brthdy" style=" width:180px;">생년월일</label>
							<input type="text" id="brthdy"  name="brthdy" value=""/>
						</div>	
						<div class="input-group inline">
							<label for="eml" style=" width:180px;">이메일</label>
							<input type="text" id="eml"  name="eml" value=""/>
						</div>	
						<div class="input-group inline">
							<label for="phn" style=" width:180px;">휴대폰 번호</label>
							<input type="text" id="phn"  name="phn" value=""/>
						</div>	
						<div class="input-group inline">
							<label for="pstnPrd" style=" width:180px;">직무연차</label>
							<input type="text" id="pstnPrd"  name="pstnPrd" value=""/>
						</div>	
						<div class="input-group inline">
							<label for="prflPht" style=" width:180px;">프로필 사진</label>
							<input type="text" id="prflPht"  name="prflPht" value=""/>
						</div>	
						<div class="input-group inline">
							<label for="hrDt" style=" width:180px;">입사일</label>
							<input type="text" id="hrDt"  name="hrDt" value=""/>
						</div>	
						<div class="input-group inline">
							<label for="hrPrd" style=" width:180px;">입사연차</label>
							<input type="text" id="hrPrd"  name="hrPrd" value=""/>
						</div>	
						<div class="input-group inline">
							<label for="addrss" style=" width:180px;">주소</label>
							<input type="text" id="addrss"  name="addrss" value=""/>
						</div>	
						<div class="input-group inline">
							<label for="emplmntStts" style=" width:180px;">재직상태</label>
							<input type="text" id="emplmntStts"  name="emplmntStts" value=""/>
						</div>
						<div class="input-group inline">
							<label for="pwdChngDt" style=" width:180px;">비밀번호 변경일</label>
							<input type="text" id="pwdChngDt"  name="pwdChngDt" value=""/>
						</div>	
						<div class="input-group inline">
							<label for="ltstLgnIp" style=" width:180px;">최근 로그인 IP</label>
							<input type="text" id="ltstLgnIp"  name="ltstLgnIp" value=""/>
						</div>	
						<div class="input-group inline">
							<label for="ltstLgnDt" style=" width:180px;">최근 로그인 날짜</label>
							<input type="text" id="ltstLgnDt"  name="ltstLgnDt" value=""/>
						</div>	
						<div class="input-group inline">
							<label for="pstnId" style=" width:180px;">직급</label>
							<input type="text" id="pstnId"  name="pstnId" value=""/>
						</div>	
						<div class="input-group inline">
							<label for="jobId" style=" width:180px;">직무</label>
							<input type="text" id="jobId"  name="jobId" value=""/>
						</div>	
						<div class="input-group inline">
							<label for="depId" style=" width:180px;">부서</label>
							<input type="text" id="depId"  name="depId" value=""/>
						</div>	
						<div class="input-group inline">
							<label for="lgnCnt" style=" width:180px;">로그인 실패 횟수</label>
							<input type="text" id="lgnCnt"  name="lgnCnt" value=""/>
						</div>	
						<div class="input-group inline">
							<label for="failDt" style=" width:180px;">로그인 실패 날짜</label>
							<input type="text" id="failDt"  name="failDt" value=""/>
						</div>	
						
							
							
							
							
							
							
							
							
						
							
					</form>
					
					
				</div>
				<div class="align-right">
					<button id="new_btn" class="btn-primary">신규</button>
					<button id="save_btn" class="btn-primary">저장</button>
					<button id="delete_btn" class="btn-delete">삭제</button>
				</div>
			<jsp:include page="../include/footer.jsp"/>
		</div>
	</div>
</body>
</html>