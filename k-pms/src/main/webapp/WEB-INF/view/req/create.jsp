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
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	var ajaxUtil = new AjaxUtil();
	$().ready(function(){
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
					"프로젝트 검색", "width=500, height=500");
		});

		$("#prjtmmbr_search").click(function(event){
			event.preventDefault();
			window.open("${context}/prjtmmbr/search?prjId=" + $("#prjId").val(),
					"프로젝트팀원 검색", "width=500, height=500");
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
				<div class="path"> 요구사항 등록</div>
				<div class="grid-detail">
					<form id="detail_form" >
						<!-- isModify == true => 수정(update) -->
						<!-- isModify == false => 등록(insert) -->
						<input type="hidden" id="isModify" value="false" />
						<div class="create-group">
							<label for="reqId" style="width: 180px;">요구사항 ID</label>
							<input type="text" id="reqId"  name="reqId" value="" readonly />
						</div>
						<div class="create-group">
							<label for="reqTtl" style="width: 180px;">제목</label>
							<input type="text" id="reqTtl"  name="reqTtl" value=""/>
						</div>
						<div class="create-group">
							<label for="prrty" style="width: 180px;">우선순위</label>
							<select id="prrty"  name="prrty" >
								<option>선택</option>
								<option>1</option>
								<option>2</option>
								<option>3</option>
							</select>
						</div>
						<div class="create-group">
							<label for="strtDt" style="width: 180px;">시작일</label>
							<input type="date" id="strtDt"  name="strtDt" value=""/>
						</div>
						<div class="create-group">
							<label for="expctEndDt" style="width: 180px;">종료예정일</label>
							<input type="date" id="expctEndDt"  name="expctEndDt" value=""/>
						</div>
						<div class="create-group">
							<label for="prjId" style="width: 180px;">프로젝트ID</label>
							<input type="text" id="prjId"  name="prjId" value="${reqVO.prjId}"/>
							<button id="prj_search">검색</button>
						</div>
						<div class="create-group">
							<label for="prjId" style="width: 180px;">담당개발자</label>
							<input type="text" id="mnDvlpr"  name="mnDvlpr" value="${reqVO.mnDvlpr}"/>
							<button id="prjtmmbr_search">검색</button>
						</div>
						<div class="create-group">
							<label for="reqCnfrNm" style="width: 180px;">확인자</label>
							<input type="text" id="reqCnfrNm"  name="reqCnfrNm" value=""/>
						</div>
						<div class="create-group">
							<label for="files" >첨부파일</label>
							<div class="file_area">
								<div class="file_upload">
									<button id="add_files">+</button>
								</div>
								<div class="align-center">
									<p class="file_drag">파일을 마우스로 끌어 오세요</p>
									<div class="file_attachment" hidden="hidden">
										<div>
											<div class="remove_all">x</div>
											<div class="file_name">파일명</div>
											<div class="file_size">용량</div>
										</div>
										<ul id="file_list"></ul>
									</div>
								</div>
							</div>
							<input type="file" id="files" multiple/>
						</div>
						<div class="create-group">
							<label for="prcsStts" style="width: 180px;">진행상태</label>
							<input type="hidden" id="original-prcsStts"  name="original-prcsStts" value="${reqVO.prcsStts}"/>
							<select id="prcsStts-select"  name="prcsStts" ></select>
						</div>
						<div class="create-group">
							<label for="tskStts" style="width: 180px;">일정상태</label>
							<input type="hidden" id="original-tskStts"  name="original-tskStts" value="${reqVO.tskStts}"/>
							<select id="tskStts-select"  name="tskStts" ></select>
						</div>
						<div class="create-group">
							<label for="tstRslt" style="width: 180px;">테스트 결과</label>
							<input type="hidden" id="original-tstRslt"  name="original-tstRslt" value="${reqVO.tstRslt}"/>
							<select id="tstRslt-select"  name="tstRslt" ></select>
						</div>
						<div class="create-group">
							<label for="lossStts" style="width: 180px;">사용여부</label>
							<input type="checkbox" id="useYn"  name="useYn" value="Y"/>
						</div>
						<div class="create-group">
							<label for="dtlReq" style="width: 180px;">내용</label>
							<textarea id="dtlReq" name="dtlReq"></textarea>
						</div>
				
					</form>
				</div>
				<div class="align-right">
					<button id="new_btn" class="btn-primary">초기화</button>
					<button id="save_btn" class="btn-primary">등록</button>
					<button id="delete_btn" class="btn-delete">취소</button>
				</div>		
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>