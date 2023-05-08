<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set scope="request" var="selected" value="msg"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp"/>
<script type="text/javascript">
	var empWindow;
	var ajaxUtil = new AjaxUtil();
	const Editor = toastui.Editor;
	
	$().ready(function() {
		const editor = new Editor({
			  el: document.querySelector('#msg-cntnt'),
			  height: '500px',
			  initialEditType: 'wysiwyg',
			  previewStyle: 'vertical'
		});
		
		$(".sidebar > ul li a").removeClass("active")
		$("#sndmsg_send").addClass("active");

		createUser($("#rcvr").val().replace(" ",""));
		$("#rcvr").val("");
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
			var form = $("#create-form");
			
			// 수신 사원
			var rcvrList = $("#user_list").children(".user").children(".rcvr");
			var cnt = 0;
			rcvrList.each(function(e){
				var rcvr = $(this).text();
				var input = $("<input type='hidden' name='rcvMsgVO[" + cnt++ + "].rcvr' value = '" + rcvr + "'/>")
				form.append(input);
			});
			
			var fileList = $(".file_attachment").find("li");
			
			cnt=0;
			fileList.each(function(){
				
				var fileNm = $(this).data("org");
				var uuidNm = $(this).data("uuid");
				var fileSz = $(this).data("sz");
				var ext = $(this).data("ext");
				
				var inputOrgNm = $("<input type='hidden' name='atchFlList["+cnt+"].orgFlNm' value='"+fileNm+"'/>");
				form.append(inputOrgNm);
				var inputUuid = $("<input type='hidden' name='atchFlList["+ cnt +"].uuidFlNm' value='"+uuidNm+"'/>");
				form.append(inputUuid);
				var inputSz = $("<input type='hidden' name='atchFlList["+cnt+"].flSz' value='"+parseInt(fileSz)+"'/>");
				form.append(inputSz);
				var inputExt = $("<input type='hidden' name='atchFlList["+ cnt++ +"].flExt' value='"+ext+"'/>");
				form.append(inputExt);
			});
			var cntnt = $("<textarea name='cntnt'></textarea>");
			cntnt.text(editor.getMarkdown());
			form.append(cntnt);
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
			empWindow = window.open("${context}/emp/search","직원 검색","width=600,height=600");
		});
		$("#add_files").click(function(e){
			e.preventDefault();
			$("#files").click();
		})
		$("#files").change(function(e){
			var files = $(this)[0].files;
			if(files){
				ajaxUtil.uploadImmediatly(files, "${context}/api/sndmsg/upload", function(response) {
					for(var i=0;i < response.data.length; i++){
						var file = response.data[i];
						addFile(file);
					}
					checkFile();
				});
			}
			$(this).value='';
		});
		$(".file_drag").on("dragover",function(e){
			e.preventDefault();
		});
		$(".file_drag").on("drop",function(e){
			e.preventDefault();
		 	
			var files = event.dataTransfer.files;
			if(files){
				var ajaxUtil = new AjaxUtil();
				ajaxUtil.uploadImmediatly(files, "${context}/api/sndmsg/upload", function(response) {
					for(var i=0;i < response.data.length; i++){
						var file = response.data[i];
						addFile(file);
					}
					checkFile();
				});
			}
		});
		$(".file_attachment").on("dragover",function(e){
			e.preventDefault();
		});
		$(".file_attachment").on("drop",function(e){
			e.preventDefault();
		 	
			var files = event.dataTransfer.files;
			if(files){
				ajaxUtil.uploadImmediatly(files, "${context}/api/sndmsg/upload", function(response) {
					for(var i=0;i < response.data.length; i++){
						var file = response.data[i];
						addFile(file);
					}
					checkFile();
				});
			}
		});
		$(".file_attachment").find(".remove_all").click(function(e){
			e.preventDefault();
			var fileList = $(this).closest(".file_attachment").find("ul").children("li");
			console.log(fileList);
			var fileNames = [];
			fileList.each(function(){
				var fileNm = $(this).data("uuid");
				fileNames.push(fileNm);
			});
			ajaxUtil.deleteFile(fileNames, "${context}/api/sndmsg/delete/file", function(response) {
				$("#file_list").find("li").remove();
				fileCnt=0;
				checkFile();
				$("#files").val("");
			});
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
	var fileCnt=0;
	function addFile(file){
		var fileList = $("#file_list");
		
		var uuidNm = file.uuidFlNm;
		var fileNm = file.orgFlNm;
		var ext = fileNm.substring(fileNm.lastIndexOf(".")+1);
		var fileSz = file.flSz;
		
		var li = $("<li data-uuid='"+uuidNm +
					 "' data-org='"+fileNm + 
					 "' data-sz='"+fileSz+
					 "' data-ext='"+ext+"'></li>");
		fileList.append(li);
		var div = $("<div></div>");
		li.append(div);
		
		var remove =  $("<span class='remove'>x</span>");
		remove.click(function(e){
			var item = $(this).closest("li");
			
			ajaxUtil.deleteFile([item.data("uuid")], "${context}/api/sndmsg/delete/file", function(response) {
				item.remove();
				--fileCnt;
				checkFile();
			});
		});
		
        var nm = "<span class='file_name'>"+fileNm+"</span>";
        fileSz = (fileSz / 1024).toFixed(2);
        var sz;
        if(fileSz < 1000){
        	sz = "<span class='file_size'>"+fileSz+" KB</span>";
        } else {
        	fileSz = (fileSz/1024).toFixed(2);
        	sz = "<span class='file_size'>"+fileSz+" MB</span>";
        }
        div.append(remove);
        div.append(nm);
        div.append(sz);
        ++fileCnt;
	};
	function checkFile(){
		var fileList = $("#file_list");
		console.log(fileCnt);
		if(fileCnt > 0){
			fileList.closest(".file_attachment").show();
			$(".file_area").find(".file_drag").hide();
		} else {
			fileList.closest(".file_attachment").hide();
			$(".file_area").find(".file_drag").show();
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
					<table class="detail_table">
		                <tr>
		                    <th>받는사람</th>
		                    <td>
		                    	 <div class="input_div">
						            <div id="user_list"></div>
						            <div class="input_div">
						                <input type="text" class="underBar" id="rcvr" name="rcvr" value="${sndMsgVO.crtr}"/>
						                <button id="search-emp" class="btn btn-add">+</button>
						            </div>
						        </div>
		                    </td>
		                </tr>
		                <tr>
		                    <th>제목</th>
		                    <td><input type="text" class="underBar" id="title" name="ttl" value="${sndMsgVO.ttl}"/></td>
		                </tr>
		                <tr>
		                    <th>첨부파일</th>
		                    <td>
						         <button id="add_files" class="btn btn-add">+</button>
		                    	 <div class="file_area input_div">
						            <div class="file_upload">
						            </div>
						            <div class="align-center file_div input_div">
						                <p class="file_drag">파일을 마우스로 끌어 오세요</p>
						                <div class="file_attachment input_div" hidden="hidden">
						                    <div>
						                        <div class="remove_all input_div">x</div>
						                        <div class="file_name input_div">파일명</div>
						                        <div class="file_size input_div">용량</div>
						                    </div>
						                    <ul id="file_list"></ul>
						                </div>
						            </div>
						        </div>
						        <input type="file" id="files" multiple hidden/>
		                    </td>
		                </tr>
		                <tr>
		                    <td colspan="2">
		                    	<div id="msg-cntnt"></div>
							</td>
		                </tr>
		            </table>
				</form>
        <div class="buttons">
   			 <button id="send_btn" class="btn regist3">전송</button>
        </div>
			<jsp:include page="../include/footer.jsp" />			
		</div>
	</div>
</body>
</html>