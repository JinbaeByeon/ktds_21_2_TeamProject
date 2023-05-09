<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	
	<title>Login</title>
	<script type="text/javascript" src="${context}/js/jquery-3.6.4.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<link rel="icon" href="${context}/img/kpms_favicon.png">
	<link rel ="stylesheet" href="${context}/css/lgn.css"/>
	<script type="text/javascript">
		$().ready(function(){
			$('a.modal').click(function(e) {
			  	e.stopPropagation();
			  	$('body').addClass('modal-active');
			});
			$('div.modal').click(function(e) {
			  	e.stopPropagation();
			});
			/* $('body').click(function () {
				$(this).removeClass('modal-active');
				window.clearTimeout(window.t);
				$('button').removeClass('loading');
				$('.modal').removeClass('success');
			}); */
			
			$('a.nav').click(function() {
				$('div.modal').attr('class','modal '+$(this).data('target'));
				$('div.modal a.nav').removeClass('active');
				$('div.modal a.nav.'+$(this).data('target')).addClass('active');
				/* Without pulling in my jquery parent visiblility thing, I'm just going to hard code it */
				
				//$('div.modal input'+($(this).data('target') == 'login' ? '#username' : '#email')).focus();
			});
			 
			/* $('form').submit(function(e) {
				e.preventDefault;
				$('button').addClass('loading');
				
				window.t = setTimeout(function() {
					$('.modal').addClass('success');
					window.t = setTimeout(function() {
						$('body').click();
						$('button').removeClass('loading');
						$('.modal').removeClass('success');
					},5000);
				},1000+Math.random()*2000);
				return false;
			}); */

			/* Don't look at the man behind the curtain! */
			$('a').click(function(e){e.preventDefault();});
			$('a.nav').first().click();
			
			// 엔터 submit 방지
			$('input').keydown(function(event) {
				  if (event.keyCode === 13) {
				    event.preventDefault();
				  };
			});
			$('button').click(function(e){
				e.preventDefault();
			})
			
			// Login
			$("#pwd").keyup(function(key){
				if(key.keyCode == 13){
					if($(this).closest("div.content").find(".nav.login.active").length == 1){
						$("#empId").focus();
						doLogin();
					}
				}
			});
			$("span.login").click(function(e){
				e.preventDefault();
				doLogin();
			});
			function doLogin(){
				if($("#empId").val() == null || $("#empId").val() == ''){
					alert("Id를 입력하세요");
					$("#empId").focus();
					return;
				}
				if($("#pwd").val() == null || $("#pwd").val() == ''){
					alert("비밀번호를 입력하세요");
					$("#pwd").focus();
					return;
				}
				$('button').addClass('loading');
				var data = {
						empId: $("#empId").val(),
						pwd: $("#pwd").val()
					};
				$.post("${context}/api/emp/lgn",data,function(response){
					console.log(response);
					if(response.status == "200 OK"){
						if(response.message=="pwdChng"){
							alert("비밀번호를 변경한지 90일이 경과하였습니다. 비밀번호를 변경해주세요.");
						}
						if(response.redirectURL){
							location.href="${context}"+response.redirectURL;
						}
					} else{
						$('button').removeClass('loading');
						alert(response.errorCode + " / " + response.message);
					}
				});
			}
		});
	</script>
</head>
<body>
	<div class="container">
	  <div class="actions">
	    <a href="/login" data-target="login" class="btn nav login modal">Login</a>
	  </div>
	</div>
	<div class="modal">
	  <div class="content">
	  	<div>
	      <a class="nav login" data-target="login">Log In</a>
	  	</div>
	  	<div class="regist-form">
		  <form>
		    <label for="empId">Id</label>
		    <input id="empId" />
		    <label for="pwd">Password</label>
		    <input id="pwd" type="password" />
		    <button>
		      <span class="login">Log In</span>
		      <span class="register">Register</span>
		      <span class="loading">Loading</span>
		    </button>
		    <div class="text-center">
		      <a href="/forgot">Forgot Password?</a>
		    </div>
		  </form>
	  	</div>
	  </div>
	  <div class="success-check"></div>
	</div>
	
</body>
</html>