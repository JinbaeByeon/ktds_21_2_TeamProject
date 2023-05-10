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
			$("#modify_btn").click(function(e){
				opener.location.href= "${context}/emp/modify/${empVO.empId}";
				window.close();
			});
			$("#modify_pwd_btn").click(function(e){
				location.href = "${context}/emp/modify/password/${empVO.empId}";
				window.resizeTo(550, 450);
			})
		});
	
	</script>
</head>
<body>
	
	<div class="container emp_page">
		<h2>${empVO.empId}(${empVO.lNm}${empVO.fNm})님의 회원정보입니다.</h2>
			<h3>기본정보</h3>
				<table class="detail_table">
	                <tr>
	                    <th>프로필사진</th>
	                    <td>
	                 	      <c:if test="${not empty empVO.prflPht}">
	                             <img src="${context}/emp/prfl/${empVO.prflPht}/" class="profile"/>
	                         </c:if>
	                         <c:if test="${empty empVO.prflPht}">
	                             <img src="${context}/img/base_profile.png" class="profile"/>
	                         </c:if>
	                    </td>
	                </tr>
	                <tr>
	                    <th>아이디</th>
	                    <td>${empVO.empId}</td>
	                </tr>
	                <tr>
	                    <th>이름</th>
	                    <td>${empVO.lNm}${empVO.fNm}</td>
	                </tr>
	                <tr>
	                    <th>이메일</th>
	                    <td>${empVO.eml}</td>
	                </tr>
	                <tr>
	                    <th>전화번호</th>
	                    <td>${empVO.phn}</td>
	                </tr>
	                <tr>
	                    <th>회원등급</th>
	                    <td>${empVO.admnYn.equals("Y")? "관리자" : "일반회원"}</td>
	                </tr>
	                <tr>
	                    <th>생년월일</th>
	                    <td>${empVO.brthdy}</td>
	                </tr>
	                <tr>
	                    <th>주소</th>
	                    <td>${empVO.addrss} ${empVO.dtlAddrss}</td>
	                </tr>
	                <tr>
	                    <th>가입일</th>
	                    <td>${empVO.crtDt}</td>
	                </tr>
	                <tr>
	                    <th>최근접속일</th>
	                    <td>${empVO.ltstLgnDt}</td>
	                </tr>
	                <tr>
	                    <th>최근접속IP</th>
	                    <td>${empVO.ltstLgnIp}</td>
	                </tr>
	                <tr>
	                    <th>비밀번호 변경일</th>
	                    <td>${empVO.pwdChngDt}</td>
	                </tr>
	            </table>
	            
	            <div class="hr"></div>
	            
	            <h3>사원정보</h3>
				<table class="detail_table">
	                <tr>
	                    <th>입사일</th>
	                    <td>${empVO.hrDt}</td>
	                </tr>
	                <tr>
	                    <th>입사연차</th>
	                    <td>${empVO.hrPrd}</td>
	                </tr>
	                <tr>
	                    <th>재직상태</th>
	                    <td>${empVO.emplmntSttsVO.cdNm}</td>
	                </tr>
	                <tr>
	                    <th>부서</th>
	                    <td>${empVO.dep.depNm}</td>
	                </tr>
	                <tr>
	                    <th>직무</th>
	                    <td>${empVO.job.jobNm}</td>
	                </tr>
	                <tr>
	                    <th>직급</th>
	                    <td>${empVO.pstn.pstnNm}</td>
	                </tr>
	                <tr>
	                    <th>직급연차</th>
	                    <td>${empVO.pstnPrd}</td>
	                </tr>
	            </table>
               
      <div class="buttons">
        <button id="modify_pwd_btn" class="btn regist">비밀번호 변경</button>
        <button id="modify_btn" class="btn edit">수정</button>
      </div>			
</div>
	
</body>
</html>