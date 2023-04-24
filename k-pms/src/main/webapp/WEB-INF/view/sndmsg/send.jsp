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
			var rcvrList = $("#user_list").children(".user").children(".rcvr");
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
		$("#add_files").click(function(e){
			e.preventDefault();
			$("#files").click();
		})
		$("#files").change(function(e){
			var files = $(this)[0].files;
			if(files != null && files != undefined){
				for(var i=0;i<files.length;++i){
					var file = files[i];
					addFile(file);
				}
			}
			checkFile();
		});
		$(".file_drag").on("dragover",function(e){
			e.preventDefault();
		});
		$(".file_drag").on("drop",function(e){
			e.preventDefault();
		 	
			var files = event.dataTransfer.files;
			if(files != null && files != undefined){
				for(var i=0;i<files.length;i++){
					var file = files[i];
					addFile(file);
				}
			}
			checkFile();
		});
		$(".file_attachment").on("dragover",function(e){
			e.preventDefault();
		});
		$(".file_attachment").on("drop",function(e){
			e.preventDefault();
		 	
			var files = event.dataTransfer.files;
			if(files != null && files != undefined){
				for(var i=0;i<files.length;i++){
					var file = files[i];
					addFile(file);
				}
			}
			checkFile();
		});
		$(".file_attachment").find(".remove_all").click(function(e){
			e.preventDefault();
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
		$("#user_list").append(userDiv);
		
		var rcvr = $("<div class='rcvr'>"+empId+"</div>");
		userDiv.append(rcvr);
		var btnDelete = $("<button class='btn-delete'>x</button>");
		btnDelete.click(function(e){
			e.preventDefault();
			$(this).closest(".user").remove();
		});
		userDiv.append(btnDelete);
		
	};
	function addFile(file){
		var fileList = $("#file_list");
		
		var fileNm = file.name;
		var fileSz = file.size / 1024;
		fileSz = fileSz.toFixed(2);
		
		var li = $("<li></li>");
		fileList.append(li);
		var div = $("<div></div>");
		li.append(div);
		var item =  "<span class='remove'>x</span>" +
        "<span class='fileName'>"+fileNm+"</span>" +
        "<span class='fileSize'>"+fileSz+" KB</span>";
        div.append(item);
		
	};
	function checkFile(){
		var fileList = $("#file_list");
		if(fileList.length > 0){
			fileList.closest(".file_attachment").show();
			$(".file_area").find(".file_drag").hide();
		}
	}
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
						<div id="user_list"></div>
						<div>
							<input type="text" class="underBar" id="rcvr" name="rcvr" value="${sndMsgVO.crtr}"/>
							<button id="search-emp">+</button>
						</div>
					</div>
				</div>
				<div class="create-group">
					<label for="title">제목</label> 
					<input type="text" class="underBar" id="title" name="ttl" value="${sndMsgVO.ttl}"/>
				</div>
				<div class="create-group">
					<label for="files">첨부파일</label>
					<div class="file_area">
						<div class="file_upload">
							<button id="add_files">+</button>
						</div>
						<div class="align-center">
							<p class="file_drag">파일을 마우스로 끌어 오세요</p>
							<div class="file_attachment" hidden="hidden">
								<div>
									<button class="remove_all">x</button>
									<div class="file_name">파일명</div>
									<div class="file_size">용량</div>
								</div>
								<ul id="file_list"></ul>
							</div>
						</div>
					</div>
					<input type="file" id="files" name="attch" multiple/>
				</div>
				<div class="create-group">
					<textarea name="cntnt" class="msg-cntnt"></textarea>
				</div>
			</form>
			<div class="align-right">
				<button id="send_btn" class="btn-primary">전송</button>
			</div>
		</div>
	</div>
</body>
</html>