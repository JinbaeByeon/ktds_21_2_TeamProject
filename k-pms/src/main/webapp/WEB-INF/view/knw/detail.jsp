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

	$()
			.ready(
					function() {

						$("#save_btn")
								.click(
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
												var fileList = $(".file_attachment").find("li");
												
												cnt=0;
												fileList.each(function(){
													var form = $("#create-form");
													
													var fileNm = $(this).data("org");
													var uuidNm = $(this).data("uuid");
													
													var inputOrgNm = $("<input type='hidden' name='atchFlList["+cnt+"].orgFlNm' value='"+fileNm+"'/>");
													form.append(inputOrgNm);
													var inputUuid = $("<input type='hidden' name='atchFlList["+ cnt++ +"].uuidFlNm' value='"+uuidNm+"'/>");
													form.append(inputUuid);
												});

												var ajaxUtil = new AjaxUtil();
												ajaxUtil
														.upload(
																"#create-form",
																"${context}/api/knw/update",
																function(
																		response) {
																	if (response.status == "200 OK") {
																		location.href = "${context}/knw/list";
																	} else {
																		alert("지식 등록에 실패하였습니다.");
																	}
																},
																{
																	"upload-file" : "uploadFile"
																});
											}

										});

						$("#cancel_btn").click(function() {
							location.href = "${context}/knw/list"
						});

						$("#addPrj")
								.click(
										function(event) {
											event.preventDefault();
											gnr = window.open(
													"${context}/prj/search",
													"프로젝트 검색",
													"width=500, height=500");
										});

						$("#deletePrj").click(function(event) {
							event.preventDefault();
							$("#prjId").val("");
							$("#prjNm").empty();
							$("#cstmr").empty();
							$("#prjStts").empty();
						});

						$(".submit")
								.click(
										function(event) {
											event.preventDefault();
											var commentForm = $(this).closest(
													".form-commentInfo");
											$
													.post(
															"${context}/api/knwrpl/create",
															commentForm
																	.serialize(),
															function(response) {
																console
																		.log(response);
																if (response.status == "200 OK") {
																	location
																			.reload();
																} else {
																	alert(response.errorCode
																			+ " / "
																			+ response.message);
																}
															});
										});

						$(".reply-btn")
								.click(
										function() {
											event.preventDefault();
											var that = $(this).closest(".btns")
													.closest(".comment")
													.find(".form-commentInfo");
											console.log(that.attr("style"));
											if (that.attr("style") == "display: block;") {
												that.hide();
											} else {
												that.show();
											}
										});

						$(".update-btn").click(
								function() {
									var updateForm = $(this).closest(".btns")
											.closest(".comment").find(".cnt")
											.find("form");
									updateForm.find("input.cnt").attr("type",
											"text");
									updateForm.find("button").attr("hidden",
											false);
									updateForm.find("p").remove();
								});

						$(".update-submit")
								.click(
										function() {
											event.preventDefault();
											var result = confirm("정말 수정하시겠습니까?")
											if (result) {
												var commentForm = $(this)
														.closest(
																".form-updateComment");
												$
														.post(
																"${context}/api/knwrpl/update",
																commentForm
																		.serialize(),
																function(
																		response) {
																	console
																			.log(response);
																	if (response.status == "200 OK") {
																		location
																				.reload();
																	} else {
																		alert(response.errorCode
																				+ " / "
																				+ response.message);
																	}
																});
											}
										});

						$(".delete-btn").click(
								function() {
									var result = confirm("정말 삭제하시겠습니까?")
									if (result) {
										var replyId = $(this).closest(".btns")
												.closest(".comment").find(
														".rplId").val();
										$(this).closest(".btns").closest(
												".comment").hide();
										$.post("${context}/api/knwrpl/delete/"
												+ replyId, function(response) {
											if (response.status == "200 OK") {
											} else {
												alert(response.errorCode
														+ " / "
														+ response.message);
											}
										});
									}
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

					});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/prjSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />

			<h1></h1>
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
						<textarea id="cntnt" name="cntnt">${knwVO.cntnt}</textarea>
					</div>
				</form>
			</div>

			<div class="align-right">
				<button id="save_btn" class="btn-primary">등록</button>
				<button id="cancel_btn" class="btn-delete">취소</button>
			</div>

			<form class="form-commentInfo">
				<input type="hidden" name="knwId" value="${knwVO.knwId}" /> <input
					type="text" class="cnt" name="cnt" placeholder="댓글을 입력해 주세요." />
				<button class="submit">등록</button>
				<hr>
			</form>

			<div id="comments">
				<c:if test="${not empty knwVO.rplList}">
					<c:forEach items="${knwVO.rplList}" var="rplVO">
						<c:if test="${rplVO.knwId ne null}">
							<div class="comment" style="margin-left: ${rplVO.depth * 30}px;">
								<input class="rplId" type="hidden" name="rplId"
									value="${rplVO.rplId}" />
								<div class="reply-info">
									<p class="crtr-info">${rplVO.crtr}</p>
									<p class="crtDt-info">${rplVO.crtDt}</p>
								</div>
								<div class="cnt">
									<form class="form-updateComment">
										<input class="cnt" type="hidden" name="cnt"
											value="${rplVO.cnt}" /> <input type="hidden" name="rplId"
											value="${rplVO.rplId}" />
										<p class="cnt">${rplVO.cnt}</p>
										<button class="update-submit" hidden="true">완료</button>
									</form>
								</div>
								<div class="btns">
									<button class="reply-btn">답글</button>
									<c:if test="${rplVO.crtr eq sessionScope.__USER__.empId}">
										<button class="update-btn">수정</button>
									</c:if>
									<c:if test="${rplVO.crtr eq sessionScope.__USER__.empId}">
										<button class="delete-btn">삭제</button>
									</c:if>
								</div>
								<form class="form-commentInfo" hidden="true">
									<input type="hidden" name="knwId" value="${knwVO.knwId}" /> <input
										type="hidden" name="prcdncRplId" value="${rplVO.rplId}" /> <input
										type="text" class="cnt" name="cnt" placeholder="답글을 입력해 주세요." />
									<button class="submit">등록</button>
								</form>
								<hr />
							</div>
						</c:if>
					</c:forEach>
				</c:if>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>