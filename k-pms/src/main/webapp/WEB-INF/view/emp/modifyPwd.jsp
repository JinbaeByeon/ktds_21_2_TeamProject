<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<c:set scope="request" var="selected" value="emp"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호변경</title>
	<jsp:include page="../include/stylescript.jsp"/>
	<script type="text/javascript">
		
		$().ready(function(){
			
			$(".btn-apply").click(function(e){
				e.preventDefault();
				var ajaxUtil = new AjaxUtil();
				ajaxUtil.upload("#create-form","${context}/api/emp/update/password",function(response){
					if(response.status == "200 OK"){
						alert("변경완료");
						window.close();
					} else{
						alert(response.errorCode + " / " + response.message);
					}
				});
			});
			$(".btn-close").click(function(e){
				window.close();
			});
		});
		
	</script>
</head>
<body>
	<div class="main-layout">
		<div class="item-align-center fullscreen">
			<h1 class="m-10">비밀번호 변경</h1>
			<form id="create-form" enctype="multipart/form-data">
				<div class="create-group mb-5">
					<label for="empId">ID</label>
					<input type="text" id="empId" name="empId" value="${empVO.empId}" disabled/>
				</div>
				<div class="create-group mb-5">
					<label for="pwd" class="required">현재 비밀번호</label>
					<input type="password" id="pwd" name="pwd"/>
				</div>
				<div class="create-group mb-5">	
					<label for="newPwd" class="required">새 비밀번호</label>
					<div class="column">
						<input type="password" id="newPwd" name="newPwd"/>
						<p class="notice-pwd">10자리 이상의 영문자,숫자,특수문자 조합</p>
					</div>
				</div>
				<div class="create-group">
					<label for="newPwdCnfrm" class="required">새 비밀번호 확인</label>
					<input type="password" id="newPwdCnfrm" name="newPwdCnfrm"/>
				</div>
				
			</form>
				<div class="btn-group">
					<div class="btn-apply">
						비밀번호 변경하기
					</div>
					<div class="btn-close">
						다음에 변경하기
					</div>
				</div>
		</div>
	</div>
</body>
</html>