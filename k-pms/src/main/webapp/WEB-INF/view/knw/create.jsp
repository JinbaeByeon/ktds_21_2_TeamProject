<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">

	function addPrjFn(data) {
		
		$("#prjId").val("");
		$("#prjNm").empty();
		$("#cstmr").empty();
		$("#prjStts").empty();
		
		$("#prjId").val(data.prjid);
		$("#prjNm").append(data.prjnm);
		$("#cstmr").append(data.cstmr);
		$("#prjStts").append(data.prjstts);
		
	}
	
	function fileUpload(){
		var fileInput = document.getElementsByName("upload-file");
		
		for( var i=0; i<fileInput.length; i++ ){
			if( fileInput[i].files.length > 0 ){
				for( var j = 0; j < fileInput[i].files.length; j++ ){
					console.log(fileInput[i].files[j].name);
				}
			}
		}
	}
	

	$().ready(
			function() {

				$("#save_btn").click(
						function() {
							if($("#ttl").val() == "") {
								alert("제목 입력은 필수입니다.");
								return;
							}
							else if($("#cntnt").val() == "") {
								alert("내용 입력은 필수입니다.");
								return;
							}
							else if($("#prjId").val() == "") {
								alert("프로젝트 선택은 필수입니다.");
								return;
							}
							else {
								var ajaxUtil = new AjaxUtil();
								ajaxUtil.upload("#create-form", "${context}/api/knw/create", function(response) {
									if(response.status == "200 OK") {
										location.href = "${context}/knw/list";
									}
									else {
										alert("지식 등록에 실패하였습니다.");
									}
								},{"upload-file": "uploadFile"});
							}
							
						});
				
				$("#cancel_btn").click(function() {
					location.href = "${context}/knw/list"
				});

				$("#addPrj").click(
						function(event) {
							event.preventDefault();
							gnr = window.open("${context}/prj/search", "프로젝트 검색", "width=500, height=500");
						});
				
				$("#file-btn").click(function(event) {
					event.preventDefault();
					$("#upload-file").click();
					
				});
				
				
				$("#upload-file").change(function() {
					var fileInput = $(this);
					var fileSize = 0;
					for( var i=0; i<fileInput.length; i++ ){
						if( fileInput[i].files.length > 0 ){
							for( var j = 0; j < fileInput[i].files.length; j++ ){
								fileSize += fileInput[i].files[j].size;
								$("#file-list").append("<li>" + fileInput[i].files[j].name 
										+ "(" + Math.round(fileInput[i].files[j].size / 1_000) / 1_000 + " MB)" + "</li>");
							}
						}
					}
					fileSize = Math.round(fileSize / 1_000) / 1_000;
					$("#file-size").empty();
					$("#file-size").append("파일 용량:"+ fileSize +" / 40MB");
					
				});
				 
				$(".file-remove").click(function(event) {
					event.preventDefault();
				});
				
				
			});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/cmnCdSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />

			<h1>지식 관리 등록</h1>
			<div>
				<form id="create-form">
					<input type="hidden" name="knwId" value="${knwVO.knwId}" />
					<div class="create-group">
						<label for="">프로젝트 선택</label>
						<div>
							<div class="grid">
								<input type="hidden" id="prjId" name="prjId" />
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
											<td id="prjNm"></td>
											<td id="cstmr"></td>
											<td id="prjStts"></td>
										</tr>
									</tbody>
								</table>
							</div>
							<button id="addPrj" class="btn-primary">선택</button>
						</div>
					</div>
					<div class="create-group">
						<input type="hidden" id="create-group-file" />
						<label for="upload-file">파일첨부<button id="file-btn">등록</button></label>
						<input type='file' id='upload-file' name='upload-file' multiple />
						<ul id="file-list">
							<li id="file-size">파일 용량: 0 / 40MB</li>
						</ul>
					</div>
					<div class="create-group">
						<label for="ttl">제목</label> <input type="text" id="ttl" name="ttl" />
					</div>
					<div class="create-group"> 	
						<label for="cntnt">내용</label>
						<textarea id="cntnt" name="cntnt"></textarea>
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