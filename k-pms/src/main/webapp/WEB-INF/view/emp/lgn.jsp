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
			
			
			// Regist
			$("span.register").click(function(e){
				e.preventDefault();
				$('button').addClass('loading');
				doRegist();
			});
			$("#cnfrmPwd").keydown(function(key){
				if(key.keyCode == 13){
					doRegist();
				}	
			});
			
			// Login
			$("#pwd").keydown(function(key){
				if(key.keyCode == 13){
					console.log($(this).))
					/* doLogin(); */
				}	
			});
			$("span.login").click(function(e){
				e.preventDefault();
				$('button').addClass('loading');
				doLogin();
			});
			function doLogin(){
				var data = {
						empId: $("#empId").val(),
						pwd: $("#pwd").val()
					};
					$.post("${context}/api/emp/lgn",data,function(response){
						
						if(response.status !="200 OK"){
							alert(response.errorCode + " / " + response.message);
						}
						if(response.redirectURL){
							location.href="${context}" +response.redirectURL;
						}
					});
			}
			function doRegist(){
				var data = {
						empId: $("#empId").val(),
						pwd: $("#pwd").val(),
						cPwd: $("#cnfrmPwd").val(),
						phn: $("#phn").val(),
						brthdy: $("#brthdy").val(),
						eml: $("#eml").val(),
						lNm: $("#lNm").val(),
						fNm: $("#fNm").val()
					};
					$.post("${context}/api/emp/rgst",data,function(response){
						
						if(response.status !="200 OK"){
							alert(response.errorCode + " / " + response.message);
						}
						if(response.redirectURL){
							location.href="${context}" +response.redirectURL;
						}
					});
				
			};
		});
	</script>
</head>
<body>
	<div class="container">
	  <div class="actions">
	    <a href="/login" data-target="login" class="btn nav login modal">Login</a>
	    <a href="/register" data-target="register" class="btn nav register modal">Register</a>
	  </div>
	</div>
	<div class="modal">
	  <div class="content">
	  	<div>
	      <a class="nav login" data-target="login">Log In</a>
	      <a class="nav register" data-target="register">Register</a>
	  	</div>
	  	<div class="regist-form">
		  <form>
		    <label for="empId">Id</label>
		    <input id="empId" />
		    <div class="regist">
		    	<div class="first-name">
			      <label for="fNm">First Name</label>
			      <input id="fNm" type="text"/>
		    	</div>
		    	<div class="last-name">
			      <label for="lNm">Last Name</label>
			      <input id="lNm" type="text"/>
		    	</div>
		    </div>
		    <div class="regist">
		      <label for="eml">Email</label>
		      <input id="eml" type="email"/>
		    </div>
		    <div class="regist">
		      <label for="phn">Phone</label>
		      <input id="phn" type="tel"/>
		    </div>
		    <div class="regist">
		      <label for="brthdy">Birthday</label>
		      <input id="brthdy" type="date"/>
		    </div>
		    <label for="pwd">Password</label>
		    <input id="pwd" type="password" />
		    <div class="regist">
		      <label for="cnfrmPwd">Confirm Password</label>
		      <input id="cnfrmPwd" type="password"/>
		    </div>
		    <button type="submit">
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