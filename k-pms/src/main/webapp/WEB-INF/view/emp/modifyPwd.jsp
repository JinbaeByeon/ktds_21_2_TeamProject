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
		AjaxUtil.enableSpinner();
		$().ready(function(){
			
			$("#btn-apply").click(function(e){
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
			$("#btn-close").click(function(e){
				window.close();
			});
		});
		
	</script>
</head>
<body>
	<div class="container search_page">
			<h2>비밀번호 변경</h2>
				<form id="create-form" enctype="multipart/form-data">
					<table class="detail_table">
		                <tr>
		                    <th>ID</th>
		                    <td><input type="text" id="empId" name="empId" value="${empVO.empId}" disabled/></td>
		                </tr>
		                <tr>
		                    <th  class="required">현재 비밀번호</th>
		                    <td><input type="password" id="pwd" name="pwd"/></td>
		                </tr>
		                <tr>
		                    <th  class="required">새 비밀번호</th>
		                    <td>
		                    	<div class="column input_div">
									<input type="password" id="newPwd" name="newPwd"/>
									<p class="notice-pwd input_div">10자리 이상의 영문자,숫자,특수문자 조합</p>
								</div>
		                    </td>
		                </tr>
		                <tr>
		                    <th  class="required">새 비밀번호 확인</th>
		                    <td><input type="password" id="newPwdCnfrm" name="newPwdCnfrm"/></td>
		                </tr>
		               
		            </table>
				</form>
        <div class="buttons">
          <button id="btn-apply" class="btn regist">비밀번호 변경하기</button>
			<button id="btn-close" class="btn delete">다음에 변경하기</button>	
		</div>
	</div>
</body>
</html>