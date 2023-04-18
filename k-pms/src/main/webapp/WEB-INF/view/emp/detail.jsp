<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사원 상세페이지</title>
	<jsp:include page="../include/stylescript.jsp"/>
	<script type="text/javascript">
		$().ready(function(){
			
		});
	
	</script>
</head>
<body>
	<div class="main-layout">
		<div class="detail">
			<div class="header">
				<h1 class="ml-10">${empVO.empId}(${empVO.fNm} ${empVO.lNm})님의 회원정보입니다.</h1>
			</div>
			<div class="basic info ml-10">
				<h1 class="">기본정보</h1>
				<ul>
					<li>
						<div class="column profile">
							<div class="left">프로필사진</div>
							<div class="right">
								<c:if test="${not empty empVO.prflPht}">
									<img src="${context}/emp/prfl/${empVO.prflPht}/" class="profile"/>
								</c:if>
								<c:if test="${empty empVO.prflPht}">
									<img src="${context}/img/base_profile.png" class="profile"/>
								</c:if>
							</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">아이디</div>
							<div class="right">${empVO.empId}</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">이름</div>
							<div class="right">${empVO.fNm} ${empVO.lNm}</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">이메일</div>
							<div class="right">${empVO.eml}</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">전화번호</div>
							<div class="right">${empVO.phn}</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">회원등급</div>
							<div class="right">${empVO.admnYn.equals("Y")? "관리자" : "일반회원"}</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">생년월일</div>
							<div class="right">${empVO.brthdy}</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">주소</div>
							<div class="right">${empVO.addrss} ${empVO.dtlAddrss}</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">가입일</div>
							<div class="right">${empVO.crtDt}</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">최근접속일</div>
							<div class="right">${empVO.ltstLgnDt}</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">최근접속IP</div>
							<div class="right">${empVO.ltstLgnIp}</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">비밀번호 변경일</div>
							<div class="right">${empVO.pwdChngDt}</div>
						</div>
					</li>
				</ul>
			</div>
			<div class="emp info ml-10">
				<h1 class="">사원정보</h1>
				<ul>
					<li>
						<div class="column">
							<div class="left">입사일</div>
							<div class="right">${empVO.hrDt}</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">입사연차</div>
							<div class="right">${empVO.hrPrd}</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">재직상태</div>
							<div class="right">${empVO.emplmntStts}</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">부서</div>
							<div class="right">${empVO.dep.depNm}</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">직무</div>
							<div class="right">${empVO.job.jobNm}</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">직급</div>
							<div class="right">${empVO.pstn.pstnNm}</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">직급연차</div>
							<div class="right">${empVO.pstnPrd}</div>
						</div>
					</li>
				</ul>
			</div>
			
			<div class="align-right mt-5 mb-5 mr-5">
				<button id="new_btn" class="btn-primary">수정</button>
			</div>
			<jsp:include page="../include/footer.jsp"/>
		</div>
	</div>
	
</body>
</html>