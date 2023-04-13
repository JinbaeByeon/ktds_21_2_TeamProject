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
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
		$().ready(function(){
			// header 서브메뉴 ui 구현 코드
			$("li.nav-item.emp").addClass("active");
			$("li.nav-item").children("a").mouseover(function(){
				$(this).closest(".nav").find(".nav-item.active").removeClass("active");
				if($(this).attr("class")!="nav-item emp"){
					$("li.nav-item.emp").removeClass("active");
				}
				$(this).closest("li.nav-item").addClass("active");
			});
			$(".nav").mouseleave(function(){
				$(this).find(".active").removeClass("active");
				$("li.nav-item.emp").addClass("active");
			});
			$(".sub-item").mouseenter(function(){
				$(this).addClass("active");
			});
			
			// 카카오 주소 검색 api
			$(".addrss-group").find("button").click(function(e){
				e.preventDefault();
				new daum.Postcode({
				       oncomplete: function(data) {
				           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
				           // 예제를 참고하여 다양한 활용법을 확인해 보세요.
				           $("#pstCd").val(data.zonecode);
				           $("#addrss").val(data.roadAddress);
				           $("#dtlAddrss").focus();
				       }
				   }).open();
			});
			
			// 연차 2글자 이상 입력 제한
			$("input[type=number]").keyup(function(event){
				if(event.keyCode != 8 && $(this).val().length >= 2){
					event.preventDefault();
				}
			});
			$("input[type=number]").keydown(function(event){
				if(event.keyCode != 8 && $(this).val().length > 1){
					event.preventDefault();
				}
			});
			
			// 사원 등록
			$("#new_btn").click(function(e){
				e.preventDefault();
				var ajaxUtil = new AjaxUtil();
				ajaxUtil.upload("#create-form","${context}/api/emp/rgst",function(response){
					if(response.status == "200 OK"){
						if(response.redirectURL){
							location.href="${context}"+response.redirectURL;
						}
					} else{
						alert(response.errorCode + " / " + response.message);
					}
				});
			});
			
		});
		function addPstnFn(pstn){
			
		}
		
		function addJobFn(job){
			
		}
		
		function addDepFn(dep){
			
		}
	</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/empSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp"/>
				<div class="path"> 임직원관리 > 임직원등록</div>
				
				<h1>임직원 등록</h1>
				<div>
					<form id="create-form" enctype="multipart/form-data">
						<div class="create-group">
							<label for="prflPht">프로필 사진</label>
							<img class="profile" src=""/>
							<input type="file" id="prflPht" name="prflPht"/>
						</div>
						<div class="create-group">
							<label for="empId" class="required">ID</label>
							<input type="text" id="empId" name="empId"/>
						</div>
						<div class="create-group">
							<div class="mr-10p">
								<label for="fNm" class="required">이름</label>
								<input type="text" id="fNm" name="fNm"/>
							</div>
							<div class="right-item">
								<label for="lNm">성</label>
								<input type="text" id="lNm" name="lNm"/>
							</div>
						</div>
						<div class="create-group">
							<label for="eml" class="required">이메일</label>
							<input type="email" id="eml" name="eml"/>
						</div>
						<div class="create-group">
							<label for="phn" class="required">휴대폰 번호</label>
							<input type="text" id="phn" name="phn"/>
						</div>
						<div class="create-group">
							<label for="pstCd" class="required">주소</label>
							<div class="addrss-group">
								<div class="grow-1">
									<input type="text" id="pstCd" name="pstCd" readonly="readonly"/>
									<button class='fs-12'>우편번호</button>
								</div>
								<div class="grow-1">
									<input type="text" id="addrss" name="addrss" readonly="readonly"/>
								</div>
								<div class="grow-1">
									<input type="text" id="dtlAddrss" name="dtlAddrss"/>
								</div>
							</div>
						</div>
						<div class="create-group">
							<label for="brthdy" class="required">생년월일</label>
							<input type="date" id="brthdy" name="brthdy"/>
						</div>
						<div class="create-group">
							<label for="emplmntStts" class="required">재직상태</label>
							<select id="emplmntStts" name="emplmntStts">
								<option>선택</option>
								<option value="재직중">재직중</option>
								<option value="휴직중">휴직중</option>
								<option value="퇴사예정">퇴사예정</option>
								<option value="퇴사">퇴사</option>
							</select>
						</div>
						<div class="create-group">
							<div class="mr-10p">
								<label for="hrDt" class="required">입사일</label>
								<input type="date" id="hrDt" name="hrDt"/>
							</div>
							<div class="right-item">
								<label for="hrPrd">입사연차</label>
								<input type="number" id="hrPrd" name="hrPrd" min="0" max="99" value="0"/>
							</div>
						</div>
						
						<div class="create-group">
							<label for="btn-add-pstn" class="required">직급</label>
							<div class="mr-10p">
								<div class="items">
								</div>
								<button id="btn-add-pstn" class="btn-add">+</button>
							</div>
							<div class="right-item">
								<label for="pstnPrd">직급연차</label>
								<input type="number" id="pstnPrd" value="0" name="pstnPrd" min="0" max="99"/>
							</div>
						</div>
						<div class="create-group">
							<label for="btn-add-job" class="required">직무</label>
							<div>
								<div class="items">
								</div>
								<button id="btn-add-job" class="btn-add">+</button>
							</div>
						</div>
						<div class="create-group">
							<label for="btn-add-dep" class="required">부서</label>
							<div>
								<div class="items">
								</div>
								<button id="btn-add-dep" class="btn-add">+</button>
							</div>
						</div>
						<div class="create-group">
							<label for="admnYn">관리자여부</label>
							<input type="checkbox" id="admnYn" name="admnYn" value= "Y" checked/>
						</div>
						<div class="create-group">
							<label for="admnPwd" class="required">관리자 비밀번호</label>
							<input type="password" id="admnPwd" name="admnPwd"/>
						</div>
						
					</form>
				</div>
				<div class="align-right">
					<button id="new_btn" class="btn-primary">등록</button>
					<button id="delete_btn" class="btn-delete">삭제</button>
				</div>
			<jsp:include page="../include/footer.jsp"/>
		</div>
	</div>
</body>
</html>