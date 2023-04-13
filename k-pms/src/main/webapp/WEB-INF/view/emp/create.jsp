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
			$("li.nav-item.sys").addClass("active");
			$("li.nav-item").children("a").mouseover(function(){
				$(this).closest(".nav").find(".nav-item.active").removeClass("active");
				if($(this).attr("class")!="nav-item sys"){
					$("li.nav-item.sys").removeClass("active");
				}
				$(this).closest("li.nav-item").addClass("active");
			});
			$(".nav").mouseleave(function(){
				$(this).find(".active").removeClass("active");
				$("li.nav-item.sys").addClass("active");
			});
			$(".sub-item").mouseenter(function(){
				$(this).addClass("active");
			});
		});
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
							<label for="empId">ID</label>
							<input type="text" id="empId" name="empId"/>
						</div>
						<div class="create-group">
							<label for="fNm">이름</label>
							<input type="text" id="fNm" name="fNm"/>
						</div>
						<div class="create-group">
							<label for="lNm">성</label>
							<input type="text" id="lNm" name="lNm"/>
						</div>
						<div class="create-group">
							<label for="eml">이메일</label>
							<input type="email" id="eml" name="eml"/>
						</div>
						<div class="create-group">
							<label for="addrss">주소</label>
							<input type="text" id="addrss" name="addrss"/>
						</div>
						<div class="create-group">
							<label for="brthdy">생년월일</label>
							<input type="date" id="brthdy" name="brthdy"/>
						</div>
						<div class="create-group">
							<label for="emplmntStts">재직상태</label>
							<select id="emplmntStts" name="emplmntStts">
								<option>선택</option>
								<option value="상영중">재직중</option>
								<option value="개봉예정">휴직중</option>
								<option value="상영종료">퇴사예정</option>
								<option value="상영종료">퇴사</option>
							</select>
						</div>
						<div class="create-group">
							<label for="hrDt">입사일</label>
							<input type="date" id="hrDt" name="hrDt"/>
						</div>
						<div class="create-group">
							<label for="addrss">입사연차</label>
							<input type="text" id="addrss" name="addrss"/>
						</div>
						<div class="create-group">
							<label for="pstnPrd">직급연차</label>
							<input type="text" id="pstnPrd" name="pstnPrd"/>
						</div>
						<div class="create-group">
							<label for="admnYn">관리자여부</label>
							<input type="checkbox" id="admnYn" name="admnYn" value= "Y" checked/>
						</div>
						
						<div class="create-group">
							<label for="btn-add-job">직무</label>
							<div>
								<div class="items">
								</div>
								<button id="btn-add-job" class="btn-add">+</button>
							</div>
						</div>
						<div class="create-group">
							<label for="btn-add-pstn">직급</label>
							<div>
								<div class="items">
								</div>
								<button id="btn-add-pstn" class="btn-add">+</button>
							</div>
						</div>
						<div class="create-group">
							<label for="btn-add-dep">부서</label>
							<div>
								<div class="items">
								</div>
								<button id="btn-add-dep" class="btn-add">+</button>
							</div>
						</div>
						<div class="create-group">
							<label for="adminPwd">관리자 비밀번호</label>
							<input type="text" id="adminPwd" name="adminPwd"/>
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