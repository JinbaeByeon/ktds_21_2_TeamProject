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
	<title>회원정보수정</title>
	<jsp:include page="../include/stylescript.jsp"/>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
		var depWindow;
		var jobWindow;
		var pstnWindow;
		
		$().ready(function(){
			
			$(".sidebar > ul li a").removeClass("active")
			$("#emp_create").addClass("active");
			
			$(".remove-btn").click(function(e){
				e.preventDefault();
				var div = $(this).closest("div");
				div.siblings(".btn-add").show();
				div.remove();
			});
				
			$("img.profile").click(function(e){
				$("#prflPht").click();
			});
			$("#prflPht").change(function(){
				var file = $(this)[0].files;

				var fileReader = new FileReader();
				console.log(file);
				if(file.length > 0 && file[0].size > 0){
					fileReader.onload = function(data){
						$('img.profile').attr("src",data.target.result);
					}
					fileReader.readAsDataURL(file[0]);
				} else{
					$('img.profile').attr("src","${context}/img/base_profile.png");
				}
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
			$("#save_btn").click(function(e){
				e.preventDefault();
				var ajaxUtil = new AjaxUtil();
				ajaxUtil.upload("#create-form","${context}/api/emp/update",function(response){
					if(response.status == "200 OK"){
						if(response.redirectURL){
							location.href="${context}"+response.redirectURL;
						}
					} else{
						alert(response.errorCode + " / " + response.message);
					}
				},{"prflPht":"uploadFile"});
			});
			$(".btn-add").click(function(e){
				e.preventDefault();
				var id = $(this).attr("id");
				if(id == "btn-add-pstn"){
					pstnWindow = window.open("${context}/pstn/search","직급검색","width=500,height=500");
				}
				if(id == "btn-add-job"){
					jobWindow = window.open("${context}/job/search","직무검색","width=500,height=500");
				}
				if(id == "btn-add-dep"){
					depWindow = window.open("${context}/dep/search","부서검색","width=500,height=500");
				}
			});
		});
		function addPstnFn(pstnData){
			$("#btn-add-pstn").hide();
			var pstnDiv = $("#btn-add-pstn").closest("div");
			var itemDiv = $("<div class='pstn-item ml-10'></div>");
			pstnDiv.append(itemDiv);
			
			var itemId = $("<input type='hidden' name='pstnId'/>");
			itemId.val(pstnData.pstnid);
			itemDiv.append(itemId);
			
			var itemSpan = $("<span></span>");
			itemSpan.text(pstnData.pstnnm);
			itemDiv.append(itemSpan);
			
			var itemRemoveBtn = $("<button>X</button>");
			itemRemoveBtn.click(function(){
				$(this).closest("div").remove();
				$("#btn-add-pstn").show();
			});
			itemDiv.append(itemRemoveBtn);
			pstnWindow.close();
		}
		
		function addJobFn(jobData){
			$("#btn-add-job").hide();
			var jobDiv = $("#btn-add-job").closest("div");
			var itemDiv = $("<div class='job-item ml-10'></div>");
			jobDiv.append(itemDiv);
			
			var itemId = $("<input type='hidden' name='jobId'/>");
			itemId.val(jobData.jobid);
			itemDiv.append(itemId);
			
			var itemSpan = $("<span></span>");
			itemSpan.text(jobData.jobnm);
			itemDiv.append(itemSpan);
			
			var itemRemoveBtn = $("<button>X</button>");
			itemRemoveBtn.click(function(){
				$(this).closest("div").remove();
				$("#btn-add-job").show();
			});
			itemDiv.append(itemRemoveBtn);
			jobWindow.close();
		}
		
		function addDepFn(depData){
			$("#btn-add-dep").hide();
			var depDiv = $("#btn-add-dep").closest("div");
			var itemDiv = $("<div class='dep-item ml-10'></div>");
			depDiv.append(itemDiv);
			
			var itemId = $("<input type='hidden' name='depId'/>");
			itemId.val(depData.depid);
			itemDiv.append(itemId);
			
			var itemSpan = $("<span></span>");
			itemSpan.text(depData.depnm);
			itemDiv.append(itemSpan);
			
			var itemRemoveBtn = $("<button>X</button>");
			itemRemoveBtn.click(function(){
				$(this).closest("div").remove();
				$("#btn-add-dep").show();
			});
			itemDiv.append(itemRemoveBtn);
			depWindow.close();
		}
	</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/empSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp"/>
				<div class="path">사원 관리 > 사원 정보 수정</div>
				<h2>임직원 등록</h2>
				<form id="create-form" enctype="multipart/form-data">
					<table class="detail_table">
		                <tr>
		                    <th>프로필 사진</th>
		                    <td>
			                    <c:if test="${not empty empVO.prflPht}">
									<img src="${context}/emp/prfl/${empVO.prflPht}/" class="profile"/>
								</c:if>
								<c:if test="${empty empVO.prflPht}">
									<img src="${context}/img/base_profile.png" class="profile"/>
								</c:if>
								<div class="input_div">
	         						<input type="file" id="prflPht" name="prflPht"/>
                                </div>
		                    </td>
		                </tr>
		                <tr>
		                    <th class="required">ID</th>
		                    <td><input type="text" id="empId" name="empId" value="${empVO.empId}" disabled/></td>
		                </tr>
		                <tr>
		                    <th class="required">이름</th>
		                    <td><input type="text" id="fNm" name="fNm" value="${empVO.fNm}"/></td>
		                </tr>
		                <tr>
		                    <th>성</th>
		                    <td><input type="text" id="lNm" name="lNm" value="${empVO.lNm}"/></td>
		                </tr>
		                <tr>
		                    <th class="required">이메일</th>
		                    <td><input type="email" id="eml" name="eml" value="${empVO.eml}"/></td>
		                </tr>
		                <tr>
		                    <th class="required">휴대폰 번호</th>
		                    <td><input type="text" id="phn" name="phn" value="${empVO.phn}"/></td>
		                </tr>
		                <tr>
		                    <th class="required">주소</th>
		                    <td>
		                    	<div class="addrss-group">
									<div class="input_div">
										<input type="text" id="pstCd" name="pstCd" readonly value="${empVO.pstCd}" />
										<button class='btn addrss'>우편번호</button>
									</div>
									<div class="input_div">
										<input type="text" id="addrss" name="addrss" readonly value="${empVO.addrss}" style="width: 200px;"/>
									</div>
									<div class="input_div">
										<input type="text" id="dtlAddrss" name="dtlAddrss" value="${empVO.dtlAddrss}"/>
									</div>
								</div>
							</td>
		                </tr>
		                <tr>
		                    <th class="required">생년월일</th>
		                    <td><input type="date" id="brthdy" name="brthdy" value="${empVO.brthdy}"/></td>
		                </tr>
		                <tr>
		                    <th class="required">관리자 비밀번호</th>
		                    <td><input type="password" id="admnPwd" name="admnPwd"/></td>
		                </tr>
		            </table>
				</form>
        <div class="buttons">
          <button id="save_btn" class="btn regist">저장</button>
        </div>
			<jsp:include page="../include/footer.jsp" />			
		</div>
	</div>
</body>
</html>