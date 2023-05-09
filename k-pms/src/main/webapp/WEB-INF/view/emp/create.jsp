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
	<title>홈페이지</title>
	<jsp:include page="../include/stylescript.jsp"/>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
		var depWindow;
		var jobWindow;
		var pstnWindow;
		$().ready(function(){
			var modal = new Modal($);
			
			$(".sidebar > ul li a").removeClass("active")
			$("#emp_create").addClass("active");
			
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
			$("#new_btn").click(function(e){
				e.preventDefault();
				if(!validateForm()){
					return;
				}
				AjaxUtil.enableSpinner();
				var ajaxUtil = new AjaxUtil();
				ajaxUtil.upload("#create_form","${context}/api/emp/rgst",function(response){
					if(response.status == "200 OK"){
						if(response.redirectURL){
							location.href="${context}"+response.redirectURL;
						}
					} else{
						AjaxUtil.disableSpinner();
						modal.show(response.message);
					}
				},{"prflPht":"uploadFile"});
			});
			$(".btn-add").click(function(e){
				e.preventDefault();
				var id = $(this).attr("id");
				if(id == "btn-add-pstn"){
					pstnWindow = window.open("${context}/pstn/search","직급검색","width=400,height=600");
				}
				if(id == "btn-add-job"){
					jobWindow = window.open("${context}/job/search","직무검색","width=400,height=600");
				}
				if(id == "btn-add-dep"){
					depWindow = window.open("${context}/dep/search","부서검색","width=500,height=600");
				}
			});
			
			function validateForm() {
				let id = $("#empId").val();
				let name = $("#fNm").val();
				let email = $("#eml").val();
				let phone = $("#phn").val();
				let address = $("#addrss").val();
				let dob = $("#brthdy").val();
				let status = $("#emplmntStts").val();
				let hireDate = $("#hrDt").val();
				console.log(status);

				if (id == "") {
				    modal.show("ID를 입력해주세요.","#empId");
				    return false;
				}

				if (name == "") {
				    modal.show("이름을 입력해주세요.","#fNm");
				    return false;
				}

				if (email == "") {
				    modal.show("이메일을 입력해주세요.","#eml");
				    return false;
				}

				if (phone == "") {
				    modal.show("휴대폰 번호를 입력해주세요.","#phn");
				    return false;
				}

				if (address == "") {
				    modal.show("주소를 입력해주세요.","#addrss");
				    return false;
				}

				if (dob == "") {
				    modal.show("생년월일을 입력해주세요.","#brthdy");
				    return false;
				}

				if (!status) {
				    modal.show("재직상태를 입력해주세요.","#emplmntStts");
				    return false;
				}

				if (hireDate == "") {
				    modal.show("입사일을 입력해주세요.","#hrDt");
				    return false;
				}
				return true;
			}
			
		});
		function addPstnFn(pstnData){
			$("#btn-add-pstn").hide();
			var pstnDiv = $("#btn-add-pstn").closest("div");
			var itemDiv = $("<div class='pstn-item input_div'></div>");
			pstnDiv.append(itemDiv);
			
			var itemId = $("<input type='hidden' name='pstnId'/>");
			itemId.val(pstnData.pstnid);
			itemDiv.append(itemId);
			
			var itemSpan = $("<span></span>");
			itemSpan.text(pstnData.pstnnm);
			itemDiv.append(itemSpan);
			
			var itemRemoveBtn = $("<button class='trRemoveBtn'><span class='material-symbols-outlined'>delete</span></button>");
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
			var itemDiv = $("<div class='job-item input_div'></div>");
			jobDiv.append(itemDiv);
			
			var itemId = $("<input type='hidden' name='jobId'/>");
			itemId.val(jobData.jobid);
			itemDiv.append(itemId);
			
			var itemSpan = $("<span></span>");
			itemSpan.text(jobData.jobnm);
			itemDiv.append(itemSpan);
			
			var itemRemoveBtn = $("<button class='trRemoveBtn'><span class='material-symbols-outlined'>delete</span></button>");
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
			var itemDiv = $("<div class='dep-item input_div'></div>");
			depDiv.append(itemDiv);
			
			var itemId = $("<input type='hidden' name='depId'/>");
			itemId.val(depData.depid);
			itemDiv.append(itemId);
			
			var itemSpan = $("<span></span>");
			itemSpan.text(depData.depnm);
			itemDiv.append(itemSpan);
			
			var itemRemoveBtn = $("<button class='trRemoveBtn'><span class='material-symbols-outlined'>delete</span></button>");
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
				<div class="path">임직원 관리 > 임직원 등록</div>
				<form id="create_form" enctype="multipart/form-data">
					<table class="detail_table">
		                <tr>
		                    <th>프로필 사진</th>
		                    <td colspan=3>
                                <img class="profile" src="${context}/img/base_profile.png"/>
                                <div class="input_div">
	         						<input type="file" id="prflPht" name="prflPht"/>
                                </div>
		                    </td>
		                </tr>
		                <tr>
		                    <th class="required">ID</th>
		                    <td colspan=3><input type="text" id="empId" name="empId"/></td>
		                </tr>
		                <tr>
		                    <th class="required">이름</th>
		                    <td colspan=3><input type="text" id="fNm" name="fNm"/></td>
		                </tr>
		                <tr>
		                    <th>성</th>
		                    <td colspan=3><input type="text" id="lNm" name="lNm"/></td>
		                </tr>
		                <tr>
		                    <th class="required">이메일</th>
		                    <td colspan=3><input type="email" id="eml" name="eml"/></td>
		                </tr>
		                <tr>
		                    <th class="required">휴대폰 번호</th>
		                    <td colspan=3><input type="text" id="phn" name="phn"/></td>
		                </tr>
		                <tr>
		                    <th class="required">주소</th>
		                    <td colspan=3>
							  	<div class="addrss-group">
					                <div class="input_div">
					                    <input type="text" id="pstCd" name="pstCd" readonly="readonly"/>
					                    <button class='btn addrss'>우편번호</button>
					                </div>
					                <div class="input_div">
					                    <input type="text" id="addrss" name="addrss" readonly="readonly" style="width: 200px;"/>
					                </div>
					                <div class="input_div">
					                    <input type="text" id="dtlAddrss" name="dtlAddrss"/>
					                </div>
					            </div>
				            </td>
		                </tr>
		                <tr>
		                    <th class="required">생년월일</th>
		                    <td colspan=3><input type="date" id="brthdy" name="brthdy"/></td>
		                </tr>
		                <tr>
		                    <th class="required">재직상태</th>
		                    <td colspan=3>            
							     <select id="emplmntStts" name="emplmntStts">
					                <option>선택</option>
					                <option value="001_01">재직중</option>
					                <option value="001_02">휴직중</option>
					                <option value="001_03">퇴사예정</option>
					                <option value="001-04">퇴사</option>
					            </select>
				            </td>
		                </tr>
		                <tr>
		                    <th class="required">입사일</th>
		                    <td><input type="date" id="hrDt" name="hrDt"/></td>
		                    <th>입사연차</th>
		                    <td><input type="number" id="hrPrd" name="hrPrd" min="0" max="99" value="0"/></td>
		                </tr>
		                <tr>
		                    <th class="required">직급</th>
		                    <td>
		                    	<div class="input_div">
		                    		<button id="btn-add-pstn" class="btn-add btn">+</button>
		                    	</div>
		                    </td>
		                    <th>직급연차</th>
		                    <td><input type="number" id="pstnPrd" value="0" name="pstnPrd" min="0" max="99"/></td>
		                </tr>
		                <tr>
		                    <th class="required">직무</th>
		                    <td colspan=3>
		                        <div class="input_div">
					                <button id="btn-add-job" class="btn-add btn">+</button>
					            </div>
		                    </td>
		                </tr>
		                <tr>
		                    <th class="required">부서</th>
		                    <td colspan=3>
		                    	<div class="input_div">
					                <button id="btn-add-dep" class="btn-add btn">+</button>
					            </div>
		                    </td>
		                </tr>
		                <tr>
		                    <th>관리자여부</th>
		                    <td colspan=3><input type="checkbox" id="admnYn" name="admnYn" value= "Y" checked/></td>
		                </tr>
		                <tr>
		                    <th class="required">관리자 비밀번호</th>
		                    <td colspan=3><input type="password" id="admnPwd" name="admnPwd"/></td>
		                </tr>
		            </table>
				</form>
        <div class="buttons">
          <button id="new_btn" class="btn regist2">등록</button>
        </div>
			<jsp:include page="../include/footer.jsp"/>
		</div>
	</div>
</body>
</html>