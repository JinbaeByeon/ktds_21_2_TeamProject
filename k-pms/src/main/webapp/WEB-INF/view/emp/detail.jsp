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
		var gnrWindow;
		var pplWindow;
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
				<p>기본정보</p>
				<ul>
					<li>
						<div class="column">
							<div class="left">프로필사진</div>
							<div class="right">프로필사진</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">아이디</div>
							<div class="right">아이디</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">이름</div>
							<div class="right">이름</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">이메일</div>
							<div class="right">이메일</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">전화번호</div>
							<div class="right">전화번호</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">회원등급</div>
							<div class="right">회원등급</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">생년월일</div>
							<div class="right">생년월일</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">주소</div>
							<div class="right">주소</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">가입일</div>
							<div class="right">가입일</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">접속일</div>
							<div class="right">접속일</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">비밀번호 변경일</div>
							<div class="right">비밀번호 변경일</div>
						</div>
					</li>
				</ul>
			</div>
			<div class="emp info ml-10">
				<p>사원정보</p>
				<ul>
					<li>
						<div class="column">
							<div class="left">입사일</div>
							<div class="right">입사일</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">입사연차</div>
							<div class="right">입사연차</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">재직상태</div>
							<div class="right">재직상태</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">부서</div>
							<div class="right">부서</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">직무</div>
							<div class="right">직무</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">직급</div>
							<div class="right">직급</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">직급연차</div>
							<div class="right">직급연차</div>
						</div>
					</li>
					<li>
						<div class="column">
							<div class="left">실패횟수</div>
							<div class="right">실패횟수</div>
						</div>
					</li>
				</ul>
			</div>
			<jsp:include page="../include/footer.jsp"/>
		</div>
	</div>
	
</body>
</html>