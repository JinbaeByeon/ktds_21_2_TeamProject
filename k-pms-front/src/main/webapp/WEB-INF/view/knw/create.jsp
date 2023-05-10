<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set scope="request" var="selected" value="prj"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지식관리 등록</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	var fileCnt = 0;
	var ajaxUtil = new AjaxUtil();
	const Editor = toastui.Editor;
	
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
			
			ajaxUtil.deleteFile([item.data("uuid")], "${context}/api/knw/delfiles", function(response) {
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
	function checkFile() {
		var fileList = $("#file_list");
		console.log(fileCnt);
		if (fileCnt > 0) {
			fileList.closest(".file_attachment").show();
			$(".file_area").find(".file_drag").hide();
		} else {
			fileList.closest(".file_attachment").hide();
			$(".file_area").find(".file_drag").show();
		}
	}
	
	function addPrjFn(data) {
		
		if($("#prjHead").find("table") != null) {
			$("#prjHead").find("table").remove();
		}
		var prjHead = $("#prjHead");
		var table = $("<table class='list_table inner_table'></table>");
		prjHead.append(table);
		table.append("<thead><tr><th>프로젝트명</th><th>고객사</th><th>프로젝트 상태</th></tr></thead>");
		table.append("<tbody><tr><td id='prjNm'></td><td id='cstmr'></td><td id='prjStts'></td></tr></tbody>")
		
		$("#prjId").val("");
		$("#prjNm").empty();
		$("#cstmr").empty();
		$("#prjStts").empty();

		$("#prjId").val(data.prjid);
		$("#prjNm").append(data.prjnm);
		$("#cstmr").append(data.cstmr);
		$("#prjStts").append(data.prjstts);
		
	}
	
	
	$().ready(function() {
		$(".sidebar > ul li a").removeClass("active")
		$("#knw_list").addClass("active");
		
		const editor = new Editor({
			  el: document.querySelector('#cntnt'),
			  height: '650px',
			  initialEditType: 'wysiwyg',
			  previewStyle: 'vertical'
		});
		
		$("#save_btn").click(function() {
			var form = $("#create_form");
			if($("#prjId").val() == "") {
				alert("프로젝트 선택은 필수입니다.");
				return;
			}
			else if ($("#ttl").val() == "") {
				alert("제목 입력은 필수입니다.");
				return;
			}
			else if ($(".toastui-editor-contents").text() == "") {
				alert("내용 입력은 필수입니다.");
				return;
			}
			
			var fileList = $(".file_attachment").find("li");
			
			cnt=0;
			fileList.each(function(){
				
				var fileNm = $(this).data("org");
				var uuidNm = $(this).data("uuid");
				var fileSz = $(this).data("sz");
				var ext = $(this).data("ext");
				
				var inputOrgNm = $("<input type='hidden' name='atchFlList["+ cnt +"].orgFlNm' value='"+fileNm+"'/>");
				form.append(inputOrgNm);
				var inputUuid = $("<input type='hidden' name='atchFlList["+ cnt +"].uuidFlNm' value='"+uuidNm+"'/>");
				form.append(inputUuid);
				var inputSz = $("<input type='hidden' name='atchFlList["+ cnt +"].flSz' value='"+parseInt(fileSz)+"'/>");
				form.append(inputSz);
				var inputExt = $("<input type='hidden' name='atchFlList["+ cnt++ +"].flExt' value='"+ext+"'/>");
				form.append(inputExt);
			});
			
			var cntnt = $("<textarea name='cntnt'></textarea>");
			cntnt.text(editor.getMarkdown());
			form.append(cntnt);
			
			ajaxUtil.upload("#create_form","${context}/api/knw/create",function(response) {
				if (response.status == "200 OK") {
					if($("#prjId").val() == null) {
						location.href = "${context}/knw/list/1";	
					}
					else {
						location.href = "${context}/knw/list/0";
					}
				}
				else {
					alert("지식 등록에 실패하였습니다.");
				}
			});

		});

		$("#cancel_btn").click(function() {
			location.href = "${context}/knw/list"
		});

		$("#addPrj").click(function(event) {
			event.preventDefault();
			gnr = window.open("${context}/prj/search", "프로젝트 검색", "width=800, height=600");
		});
		
		$("#comPrj").click(function(event) {
			event.preventDefault();
			
			if($("#prjHead").find("table") != null) {
				$("#prjHead").find("table").remove();
			}
			$("#prjId").val("");
			
		});

		$("#add_files").click(function(e) {
			e.preventDefault();
			$("#files").click();
		})
		$("#files").change(function(e) {
							var files = $(this)[0].files;
							if (files) {
								ajaxUtil.uploadImmediatly(files, "${context}/api/knw/upload", function(response) {
													for (var i = 0; i < response.data.length; i++) {
														var file = response.data[i];
														addFile(file);
													}
													checkFile();
												});
							}
							$(this).value = '';
						});
		$(".file_drag").on("dragover", function(e) {
			e.preventDefault();
		});
		$(".file_drag").on("drop", function(e) {
							e.preventDefault();

							var files = event.dataTransfer.files;
							if (files) {
								ajaxUtil.uploadImmediatly(files, "${context}/api/knw/upload", function(response) {
													for (var i = 0; i < response.data.length; i++) {
														var file = response.data[i];
														addFile(file);
													}
													checkFile();
												});
							}
						});
		$(".file_attachment").on("dragover", function(e) {
			e.preventDefault();
		});
		$(".file_attachment").on("drop", function(e) {
							e.preventDefault();

							var files = event.dataTransfer.files;
							if (files) {
								ajaxUtil.uploadImmediatly(files, "${context}/api/knw/upload", function(response) {
													for (var i = 0; i < response.data.length; i++) {
														var file = response.data[i];
														addFile(file);
													}
													checkFile();
												});
							}
						});
		$(".file_attachment").find(".remove_all").click(function(e) {
			e.preventDefault();
			var fileList = $(this).closest(".file_attachment").find("ul").children("li");
			console.log(fileList);
			var fileNames = [];
			fileList.each(function() {
				var fileNm = $(this).data("uuid");
				fileNames.push(fileNm);
			});
			ajaxUtil.deleteFile(fileNames, "${context}/api/knw/delfiles",
					function(response) {
						$("#file_list").find("li").remove();
						fileCnt = 0;
						checkFile();
						$("#files").val("");
					});
		});
		
	});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/prjSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<div class="path"> 프로젝트 관리 > 지식 등록</div>
				<form id="create_form">
					<input type="hidden" id="prjId" name="prjId" value="${prjVO.prjId}"/>
					<table class="detail_table">
						<tr>
							<th>프로젝트 선택</th>
							<td id="prjHead">
								<div>
									<button id="addPrj" class="btn regist add">선택</button>
									<button id="comPrj" class="btn delete add">삭제</button>
								</div>
								<c:if test='${prjVO.prjId != null}'>
									<table class="list_table inner_table">
										 <thead>
										 	<tr>
										 		<th>프로젝트명</th>
										 		<th>고객사</th>
										 		<th>프로젝트 상태</th>
										 	</tr>
										 </thead>
										 <tbody>
										 	<tr>
											 	<td id="prjNm">${prjVO.prjNm}</td>
											 	<td id="cstmr">${prjVO.cstmr}</td>
											 	<td id="prjStts">${prjVO.prjStts}</td>
										 	</tr>
										 </tbody>
									</table>
								</c:if>
							</td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input type="text" id="ttl" name="ttl" /></td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<div id="cntnt" name="cntnt"></div>
							</td> 
						</tr>
						<tr>
							<th>파일첨부</th>
							<td>
								<div class="file_area">
									<div class="file_upload">
										<button id="add_files" class="btn regist">+</button>
									</div>
									<div class="align-center">
										<p class="file_drag">파일을 마우스로 끌어 오세요</p>
										<div class="file_attachment" hidden="hidden">
											<div class="fileHead">
												<div class="remove_all">x</div>
												<div class="file_name">파일명</div>
												<div class="file_size">용량</div>
											</div>
											<ul id="file_list"></ul>
										</div>
									</div>
								</div>
								<input type="file" id="files" multiple hidden="true" />
							</td>
						</tr>
					</table>
				</form>
				
			<div class="buttons">
				<button id="save_btn" class="btn regist">등록</button>
				<button id="cancel_btn" class="btn delete">취소</button>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>