<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />
<c:set scope="request" var="selected" value="prj"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>요구사항 신규등록 페이지</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	var ajaxUtil = new AjaxUtil();
	$().ready(function(){
		var modal = new Modal($);
		
		$(".sidebar > ul li a").removeClass("active")
		$("#req_list").addClass("active");
		
		var empId = '${sessionScope.__USER__.empId}';
		$("#new_btn").click(function(){
			$("#isModify").val("false"); //등록모드
			
			$("#reqId").val("");
			$("#dtlReq").val("");
			$("#crtr").val("");
			$("#crtDt").val("");
			$("#mdfyr").val("");
			$("#mdfyDt").val("");
			$("#strtDt").val("");
			$("#expctEndDt").val("");
			$("#attch").val("");
			$("#prjId").val("");
			$("#mnDvlpr").val("");
			$("#tstRslt").val("");
			$("#tslStts").val("");
			$("#prcsStts").val("");
			$("#prrty").val("");
			$("#reqTtl").val("");
			
			
			$("#useYn").prop("checked", false);
		});
		
		$("#delete_btn").click(function(){
			location.href = "${context}/req/list";
		});
					
		$("#save_btn").click(function(){
			if(!validateForm()){
				return;
			}
			
			var cnt = 0;
			var fileList = $(".file_attachment").find("li");
			console.log(fileList);
			fileList.each(function(){
				var form = $("#detail_form");
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
			
			ajaxUtil.upload("#detail_form","${context}/api/req/create",function(response){
				if(response.status == "200 OK"){
					location.href = "${context}/req/list";
				}	
				else{
					alert(response.errorCode + "/" + response.message);
				}
			});
		
		});
		
		function validateForm() {
			let reqTtl = $("#reqTtl").val();
			let prrty = $("#prrty").val();
			let strtDt = $("#strtDt").val();
			let expctEndDt = $("#expctEndDt").val();
			let prjId = $("#prjId").val();
			let reqCnfrNm = $("#reqCnfrNm").val();
			let originalPrcsStts = $("#original-prcsStts").val();
			let originalTskStts = $("#original-tskStts").val();
			let originalTstRslt = $("#original-tstRslt").val();
			let dtlReq = $("#dtlReq").val();

			if (reqTtl == "") {
			    modal.show("제목을 입력해주세요.","#reqTtl");
			    return false;
			}
			if (prrty == "") {
			    modal.show("우선순위를 입력해주세요.","#prrty");
			    return false;
			}
			if (strtDt == "") {
			    modal.show("시작일을 입력해주세요.","#strtDt");
			    return false;
			}
			if (expctEndDt == "") {
			    modal.show("종료예정일을 입력해주세요.","#expctEndDt");
			    return false;
			}
			if (prjId == "") {
			    modal.show("프로젝트ID를 입력해주세요.","#prjId");
			    return false;
			}
			if (reqCnfrNm == "") {
			    modal.show("확인자를 입력해주세요.","#reqCnfrNm");
			    return false;
			}
			if (originalPrcsStts == "") {
			    modal.show("진행상태 입력해주세요.","#original-prcsStts");
			    return false;
			}
			if (originalTskStts == "") {
			    modal.show("일정상태를 입력해주세요.","#original-tskStts");
			    return false;
			}
			if (originalTstRslt == "") {
			    modal.show("테스트결과를 입력해주세요.","#original-tstRslt");
			    return false;
			}
			if (dtlReq == "") {
			    modal.show("내용을 입력해주세요.","#dtlReq");
			    return false;
			}
			return true;
		}
		
		
		$(".detail_path").click(function(){
			var reqId =$(this).closest("tr").data("reqid");
			location.href = "${context}/req/detail?reqId=" + reqId;
		});
		
		$("#search-btn").click(function(){
			var reqNm =$("#search-keyword").val();
			location.href = "${context}/req/list?reqNm=" + reqNm;
		})
		
		$("#prj_search").click(function(event){
			event.preventDefault();
			window.open("${context}/prj/search",
					"프로젝트 검색", "width=800, height=600");
		});

		$("#prjtmmbr_search").click(function(event){
			event.preventDefault();
			window.open("${context}/prjtmmbr/search?prjId=" + $("#prjId").val(),
					"프로젝트팀원 검색", "width=500, height=600");
		});
		
		
		$("#all_check").change(function(){
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		$(".check_idx").change(function(){
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		
		$("#delete_all_btn").click(function(){
			var checkLen = $(".check_idx:checked").length;
			if(checkLen == 0) {
				alert("삭제할 요구사항이 없습니다.");
				return;
			}
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='reqId' value='" + $(this).val() +"'>");
			});
			
			$.post("${context}/api/req/delete", form.serialize(), function(response){
				if(response.status == "200 OK"){
					location.reload(); //새로고침
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			});
		});	
		
		$("#add_files").click(function(e){
			e.preventDefault();
			$("#files").click();
		});
		$("#files").change(function(e){
			var files = $(this)[0].files;
			if(files){
				ajaxUtil.uploadImmediatly(files, "${context}/api/atchfl/upload", function(response) {
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
				ajaxUtil.uploadImmediatly(files, "${context}/api/atchfl/upload", function(response) {
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
				ajaxUtil.uploadImmediatly(files, "${context}/api/atchfl/upload", function(response) {
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
			ajaxUtil.deleteFile(fileNames, "${context}/api/atchfl/delete", function(response) {
				$("#file_list").find("li").remove();
				fileCnt=0;
				checkFile();
				$("#files").val("");
			});
		});
		
		$.get("${context}/api/cmncd/list/004", function(response) {
			var isSelected
			
			for (var i in response.data) {
				var cdNm = response.data[i].cdNm;
				if ($("#original-prcsStts").val() == response.data[i].cdId) {
					isSelected = "selected";
				}
				else {
					isSelected = "";
				}
				console.log($("#original-prcsStts").val());
				var option = $("<option value='" + response.data[i].cdId + "' " + isSelected + "></option>");
				option.append(cdNm);
				$("#prcsStts-select").append(option)
			}
		
		});
		
		$.get("${context}/api/cmncd/list/003", function(response) {
			var isSelected;
			
			for (var i in response.data) {
				var cdNm = response.data[i].cdNm;
				if ($("#original-tskStts").val() == response.data[i].cdId) {
					isSelected = "selected";
				}
				else {
					isSelected = "";
				}
				var option = $("<option value='" + response.data[i].cdId + "' " + isSelected + "></option>");
				option.append(cdNm);
				$("#tskStts-select").append(option)
			}
		});
		
		$.get("${context}/api/cmncd/list/008", function(response) {
			var isSelected;
			
			for (var i in response.data) {
				var cdNm = response.data[i].cdNm;
				if ($("#original-tstRslt").val() == response.data[i].cdId) {
					isSelected = "selected";
				}
				else {
					isSelected = "";
				}
				var option = $("<option value='" + response.data[i].cdId + "' " + isSelected + "></option>");
				option.append(cdNm);
				$("#tstRslt-select").append(option)
			}
		});
	});
	
	function addPrjFn(data) {
		$("#prjId").val(data.prjid);
	}

	function addPrjTmMbrFn(data) {
		$("#mnDvlpr").val(data.empid);
	}
	var fileCnt=${reqVO.atchFlList.size() > 0 ? reqVO.atchFlList.size() : 0};
	
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
		remove.click(removeFn);
		
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
	
	function removeFn(){
		var item = $(this).closest("li");
		console.log(item);
		ajaxUtil.deleteFile([item.data("uuid")], "${context}/api/atchfl/delete", function(response) {
			item.remove();
			--fileCnt;
			checkFile();
		});
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
	};
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/prjSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp" />
				<div class="path">요구사항 등록</div>
					<form id="detail_form" >
						<table class="detail_table">
			                <tr>
			                    <th>제목</th>
			                    <td><input type="text" id="reqTtl"  name="reqTtl" value=""/></td>
			                </tr>
			                <tr>
			                    <th>우선순위</th>
			                    <td>
			                       <select id="prrty"  name="prrty" >
										<option>선택</option>
										<option>1</option>
										<option>2</option>
										<option>3</option>
									</select>
			                    </td>
			                </tr>
			                <tr>
			                    <th>시작일</th>
			                    <td><input type="date" id="strtDt"  name="strtDt" value=""/></td>
			                </tr>
			                <tr>
			                    <th>종료예정일</th>
			                    <td><input type="date" id="expctEndDt"  name="expctEndDt" value=""/></td>
			                </tr>
			                <tr>
			                    <th>프로젝트ID</th>
			                    <td>
			                    	<input type="text" id="prjId"  name="prjId" value="${reqVO.prjId}"/>
			                    	<button id="prj_search" class="btn regist">검색</button>
			                    </td>
			                </tr>
			                <tr>
			                    <th>담당개발자</th>
			                    <td>
			                    	<input type="text" id="mnDvlpr"  name="mnDvlpr" value="${reqVO.mnDvlpr}"/>
			                    	<button id="prjtmmbr_search" class="btn regist">검색</button>
			                    </td>
			                </tr>
			                <tr>
			                    <th>확인자</th>
			                    <td><input type="text" id="reqCnfrNm"  name="reqCnfrNm" value=""/></td>
			                </tr>
			                <tr>
			                    <th>첨부파일</th>
			                    <td>
							        <button id="add_files" class="btn-add btn">+</button>
			                    	  <div class="file_area input_div">
							            <div class="file_upload">
							            </div>
							            <div class="align-center input_div">
							                <p class="file_drag">파일을 마우스로 끌어 오세요</p>
							                <div class="file_attachment" hidden="hidden">
							                    <div>
							                        <div class="remove_all input_div">x</div>
							                        <div class="file_name input_div">파일명</div>
							                        <div class="file_size input_div">용량</div>
							                    </div>
							                    <ul id="file_list"></ul>
							                </div>
							            </div>
							        </div>
							        <input type="file" id="files" multiple/>
			                    </td>
			                </tr>
			                <tr>
			                    <th>진행상태</th>
			                    <td>
			                    	<input type="hidden" id="original-prcsStts"  name="original-prcsStts" value="${reqVO.prcsStts}"/>
     								<select id="prcsStts-select"  name="prcsStts" ></select>			
			                    </td>
			                </tr>
			                <tr>
			                    <th>일정상태</th>
			                    <td>
			                    	<input type="hidden" id="original-tskStts"  name="original-tskStts" value="${reqVO.tskStts}"/>
      								<select id="tskStts-select"  name="tskStts" ></select>
			                    </td>
			                </tr>
			                <tr>
			                    <th>테스트 결과</th>
			                    <td>
			                    	<input type="hidden" id="original-tstRslt"  name="original-tstRslt" value="${reqVO.tstRslt}"/>
    								<select id="tstRslt-select"  name="tstRslt" ></select>
			                    </td>
			                </tr>
			                <tr>
			                    <th>사용여부</th>
			                    <td><input type="checkbox" id="useYn"  name="useYn" value="Y"/></td>
			                </tr>
			                <tr>
			                    <th>내용</th>
			                    <td><textarea id="dtlReq" name="dtlReq" class="input_div"></textarea></td>
			                </tr>
			            </table>
					</form>
	        <div class="buttons">
				<button id="new_btn" class="btn new">초기화</button>
				<button id="save_btn" class="btn regist">등록</button>
				<button id="delete_btn" class="btn delete">취소</button>
	        </div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>