<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp"/>
<script type="text/javascript">
	var empWindow;
	
	$().ready(function() {
		$("#my_pc").click(function() {
			
		});
		
		$("#rcvr").keydown(function(e){
			if(e.keyCode == 13){
				e.preventDefault();
			}
		})
		$("#rcvr").keyup(function(e){
			if(e.keyCode == 32 || e.keyCode == 13){
				e.preventDefault();
				createUser($(this).val().replace(" ",""));
				$(this).val("");
				return;
			}
			if(!(e.keyCode >= 37 && e.keyCode <= 40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^a-zA-Z0-9]/gi,''));
			}
		})
		$("#send_btn").click(function(){
			var ajaxUtil = new AjaxUtil();
			var form = $("#create-form");
			var rcvrList = $("#userList").children(".user").children(".rcvr");
			var cnt = 0;
			rcvrList.each(function(e){
				var rcvr = $(this).text();
				var input = $("<input type='hidden' name='rcvMsgVO[" + cnt++ + "].rcvr' value = '" + rcvr + "'/>")
				form.append(input);
			});
			
			ajaxUtil.upload("#create-form","${context}/api/sndmsg/snd",function(response){
				if (response.status != "200 OK") {
					alert(response.errorCode + " / " + response.message);
				}
				if(response.redirectURL){
					location.href = "${context}" + response.redirectURL;
				}
			});
		});
		
		$("#search-emp").click(function(e){
			e.preventDefault();
			empWindow = window.open("${context}/emp/search","직원 검색","width=500,height=500");
		});
	});
	function addEmpFn(emp){
		createUser(emp.empid);
	};
	function createUser(empId){
		if(empId ==null || empId == ''){
			return;
		}
		var userDiv = $("<div class='user'></div>");
		$("#userList").append(userDiv);
		
		var rcvr = $("<div class='rcvr'>"+empId+"</div>");
		userDiv.append(rcvr);
		var btnDelete = $("<button class='btn-delete'>x</button>");
		btnDelete.click(function(e){
			e.preventDefault();
			$(this).closest(".user").remove();
		});
		userDiv.append(btnDelete);
		
	};
	
	 //내피씨연동ㅇㄹㅇ널ㄷㄴㄷㄹㄴ두래너리나ㅢㅡㄱㄴ르힏
	 
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp"/>
		<div>
			<jsp:include page="../include/msgSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp"/>
			<div class="path">쪽지 > 쪽지보내기</div>
			<form id="create-form">
				<input type="hidden" name="crtr" value="${sessionScope.__USER__.empId}"/>
				<div class="create-group">
					<label for="rcvr">받는사람</label>
					<div>
						<div id="userList"></div>
						<div>
							<input type="text" id="rcvr" name="rcvr" value="${sndMsgVO.crtr}"/>
							<button id="search-emp">+</button>
						</div>
					</div>
				</div>
				<div class="create-group">
					<label for="title">제목</label> 
					<input type="text" id="title" name="ttl" value="${sndMsgVO.ttl}"/>
				</div>
				<div class="create-group">
					<label for="file">첨부파일</label> 
					<input type="file" id="file" name="attch" value="${sndMsg.attch}"/><!-- 이게머지 -->
				</div>
				<div class="create-group">
					<textarea name="cntnt"></textarea>
				</div>
			</form>
			<div class="align-right">
				<button id="send_btn" class="btn-primary">전송</button>
			</div>
		</div>
	</div>
</body>
</html>