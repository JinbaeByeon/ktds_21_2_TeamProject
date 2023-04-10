<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="SignUp, Login, Register">
	<meta name="keywords" content="Sign up, Sign in">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Login</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	
	<!--Font-aweome-->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
		
	<!-- Popper JS -->
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
	
	<jsp:include page="../include/stylescript.jsp"/>
	<script type="text/javascript">
		$().ready(function(){
			// Regist
			$("#btn-rgst").click(function(e){
				e.preventDefault();
				doRegist();
			});
			
			// Login
			$("#pwd").keydown(function(key){
				if(key.keyCode == 13){
					doLogin();
				}	
			});
			$("#btn-lgn").click(function(e){
				e.preventDefault();
				doLogin();
			});
			function doLogin(){
				var data = {
						empId: $("#empId").val(),
						pwd: $("#login_pwd").val()
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
						pwd: $("#signup_pwd").val(),
						cPwd: $("#cnfrm_pwd").val(),
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
  <section class="login_section">
    <div class="container outer_container accounts_container">
      <div class="row h-100">
        <div class="col col-sm-12 col-md-12 col-lg-8 m-0 p-0 w-100 h-100 accounts_col">
          <div class="accounts_image w-100 h-100">
            <img src="https://img.freepik.com/free-photo/social-media-instagram-digital-marketing-concept-3d-rendering_106244-1717.jpg?t=st=1647414398~exp=1647414998~hmac=2c478ef6affd973ccd71ea4d394d9283db4a0c6c4c686ba0b9f6091c8a56e5a1&w=1480" alt="accounts_image" class="img-fluid w-100 h-100" />
          </div>
          <!--accounts_image-->
        </div>
        <!--account_col-->
        <div class="col col-sm-12 col-md-12 col-lg-4 m-0 p-0 accounts_col">
          <div class="accounts_forms signup_form w-100 h-100" id="signup">
            <div class="title mt-4 p-4 w-100">
              <h1>Sign Up</h1>
              <!-- <p class="mt-3">  </p> -->
            </div>
            <!--title-->
            <div>
	            <form method="post" name="form" class="form w-100 p-4" id="form">
	              <div class="row">
	                <div class="col col-sm-12 col-md-12 col-lg-6 m-0">
	                  <div class="form-group">
	                    <label for="fNm">Firstname</label>
	                    <input type="text" name="fNm" class="form-control" id="fNm" onfocus="labelUp(this)" onblur="labelDown(this)" required />
	                  </div>
	                </div>
	                <div class="col col-sm-12 col-md-12 col-lg-6 m-0">
	                  <div class="form-group">
	                    <label for="lNm">Lastname</label>
	                    <input type="text" name="lNm" class="form-control" id="lNm" onfocus="labelUp(this)" onblur="labelDown(this)" required />
	                  </div>
	                </div>
	              </div>
	              <!--form-row-->
	              <div class="form-group">
	                <label for="empId">Id</label>
	                <input type="text" name="empId" class="form-control" id="empId" onfocus="labelUp(this)" onblur="labelDown(this)" required />
	              </div>
	              <div class="form-group">
	                <label for="eml">Email</label>
	                <input type="email" name="eml" class="form-control" id="eml" onfocus="labelUp(this)" onblur="labelDown(this)" required />
	              </div>
	              <div class="form-group">
	                <label for="phn">Phone</label>
	                <input type="tel" name="phn" class="form-control" id="phn" onfocus="labelUp(this)" onblur="labelDown(this)" required />
	              </div>
	              <div class="form-group">
	                <label for="brthdy" class="change_label">Birthday</label>
	                <input type="date" name="brthdy" class="form-control" id="brthdy" required />
	              </div>
	              <div class="form-group">
	                <label for="signup_password">Password</label>
	                <i class="fa fa-eye-slash" id="eye_icon_signup"></i>
	                <input type="password" name="pwd" class="form-control" id="signup_pwd" onfocus="labelUp(this)" onblur="labelDown(this)" required />
	              </div>
	              <div class="form-group">
	                <label for="cPwd">Confirm Password</label>
	                <input type="password" name="cPwd" class="form-control" id="cnfrm_pwd" onfocus="labelUp(this)" onblur="labelDown(this)" required />
	              </div>
	              <div class="form-group">
	                <button id="btn-rgst" class="btn btn-primary register_btn w-100">Sign Up</button>
	              </div>
	            </form>
	            <div class="already_member_box">
	              <p class="text-center" id="to_login">I am already member</p>
	            </div>
            </div>
          </div>
          <!--accounts_forms-->
          <div class="accounts_forms  w-100 h-100" id="login">
            <div class="title  mt-4 p-4 w-100">
              <h1>Sign In</h1>
              <!-- <p class="mt-3"> 2222222 </p> -->
            </div>
            <!--title-->
            <form method="post" name="form" class="form  w-100 p-4" id="form">
              <div class="form-group">
                <label for="empId">Id</label>
                <input type="text" name="empId" class="form-control" id="empId" onfocus="labelUp(this)" onblur="labelDown(this)" required />
              </div>
              <div class="form-group">
                <label for="login_password">Password</label>
                <i class="fa fa-eye-slash" id="eye_icon_login"></i>
                <input type="password" name="pwd" class="form-control" id="login_pwd" onfocus="labelUp(this)" onblur="labelDown(this)" required />
              </div>
              <div class="form-group mb-0">
                <button id="btn-lgn" class="btn btn-primary register_btn w-100">Sign In</button>
              </div>
            </form>

            <div class="already_member_box d-flex justify-content-between px-4">
              <span class="text-center" id="to_signup">Create an account?</span>
              <span class="text-center">Forgot password</span>
            </div>
          </div>
          <!--accounts_forms-->
        </div>
        <!--account_col-->
      </div>
      <!--row-->
    </div>
    <!--accounts_container-->
  </section>
  <!--login_section-->
  
  <!--Custom Js-->
  <script type="text/javascript" src="${context}/js/lgn.js"></script>
</body>
</html>