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
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	var fileCnt = 0;
	function addFile(file) {
		var fileList = $("#file_list");

		var uuidNm = file.uuidFlNm;
		var fileNm = file.orgFlNm;
		var fileSz = file.flSz / 1024;
		fileSz = fileSz.toFixed(2);

		var li = $("<li data-uuid='"+uuidNm+"' data-org='"+fileNm+"'></li>");
		fileList.append(li);
		var div = $("<div></div>");
		li.append(div);

		var remove = $("<span class='remove'>x</span>");
		remove.click(function(e) {
			var item = $(this).closest("li");

			ajaxUtil.deleteFile([ item.data("uuid") ],
					"${context}/api/sndmsg/delete", function(response) {
						item.remove();
						--fileCnt;
						checkFile();
					});
		});

		var nm = "<span class='file_name'>" + fileNm + "</span>";
		var sz;
		if (fileSz < 1000) {
			sz = "<span class='file_size'>" + fileSz + " KB</span>";
		} else {
			fileSz = (fileSz / 1024).toFixed(2);
			sz = "<span class='file_size'>" + fileSz + " MB</span>";
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

	$().ready(function() {
		$(".sidebar > ul li a").removeClass("active")
		$("#knw_list").addClass("active");
		
		$("#save_btn").click(
			function() {
				if ($("#ttl").val() == "") {
					alert("제목 입력은 필수입니다.");
					return;
				} else if ($("#cntnt").val() == "") {
					alert("내용 입력은 필수입니다.");
					return;
				} else if ($("#prjId").val() == "") {
					alert("프로젝트 선택은 필수입니다.");
					return;
				} else {
					var ajaxUtil = new AjaxUtil();
					ajaxUtil.upload("#create-form", "${context}/api/knw/update", function(response) {
						if (response.status == "200 OK") {
							location.href = "${context}/knw/list";
						}
						else {
							alert("지식 등록에 실패하였습니다.");
							}
						},{"upload-file" : "uploadFile"});
					}

			});

		$("#cancel_btn").click(function() {
				location.href = "${context}/knw/list"
			});
	
		$("#addPrj").click(function(event) {
			event.preventDefault();
			gnr = window.open(
					"${context}/prj/search",
					"프로젝트 검색",
					"width=800, height=600");
			});

		$("#deletePrj").click(function(event) {
			event.preventDefault();
			$("#prjId").val("");
			$("#prjNm").empty();
			$("#cstmr").empty();
			$("#prjStts").empty();
		});

		
		$("#add_files").click(function(e){
			e.preventDefault();
			$("#files").click();
		});
		
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
		
	});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/prjSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />

			<h1>지식 관리 등록</h1>
			<div>
				<form id="create-form">
					<input type="hidden" name="knwId" value="${knwVO.knwId}" />
					<div class="create-group">
						<label for="">프로젝트명</label>
						<div>
							<div class="grid">
								<input type="hidden" id="prjId" name="prjId"
									value="${prjVO.prjId}" />
								<table>
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
							</div>
							<button id="addPrj" class="btn-primary">등록</button>
							<button id="deletePrj" class="btn-primary">삭제</button>
						</div>
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
										<div class="remove_all">x</div>
										<div class="file_name">파일명</div>
										<div class="file_size">용량</div>
									</div>
									<ul id="file_list"></ul>
								</div>
							</div>
						</div>
						<input type="file" id="files" multiple />
					</div>
					<div class="create-group">
						<label for="ttl">제목</label> <input type="text" id="ttl" name="ttl"
							value="${knwVO.ttl}" />
					</div>
					<div class="create-group">
						<label for="cntnt">내용</label>
						<textarea id="cntnt" name="cntnt" class="input_div">${knwVO.cntnt}</textarea>
					</div>
				</form>
			</div>

			<div class="align-right">
				<button id="save_btn" class="btn-primary">등록</button>
				<button id="cancel_btn" class="btn-delete">취소</button>
			</div>

			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>