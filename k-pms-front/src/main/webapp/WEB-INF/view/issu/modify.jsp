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
<title>이슈 수정 - ${issuVO.issuTtl}</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	var ajaxUtil = new AjaxUtil();
	$().ready(function(){
		var modal = new Modal($);
		
		$(".sidebar > ul li a").removeClass("active")
		$("#issu_list").addClass("active");
		
		checkFile();
		var empId = '${sessionScope.__USER__.empId}';

		$("#delete_btn").click(function(){
			location.href = "${context}/issu/list";
		});
		
		$("#all_check").change(function(){
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		$(".check_idx").change(function(){
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("#save_btn").click(function(){
			var form = $("#create-form");
			
			var fileList = $(".file_attachment").find("li");
			
			cnt=0;
			fileList.each(function(){
				if(!validateForm()){
					return;
				}
				var form = $("#create-form");
				
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
			
			ajaxUtil.upload("#create-form","${context}/api/issu/update",function(response){
				if (response.status != "200 OK") {
					alert(response.errorCode + " / " + response.message);
				}
				if(response.redirectURL){
					location.href = "${context}" + response.redirectURL;
				}
			});
		});
		
		$("#add_files").click(function(e){
			e.preventDefault();
			$("#files").click();
		})
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
				var ajaxUtil = new AjaxUtil();
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
		$(".remove").click(removeFn);
		function validateForm() {
			let issuTtl = $("#issuTtl").val();
			let issuCntnt = $("#issuCntnt").val();
			let reqId = $("#reqId").val();

			if (issuTtl == "") {
			    modal.show("제목을 입력해주세요.","#issuTtl");
			    return false;
			}
			if (issuCntnt == "") {
			    modal.show("설명을 입력해주세요.","#issuCntnt");
			    return false;
			}
			if (reqId == "") {
			    modal.show("요구사항을 선택해주세요.","#req_search");
			    return false;
			}
			return true;
		}
	});
	var fileCnt=${issuVO.atchFlList.size() > 0 ? (issuVO.atchFlList.get(0).flSz != 0 ? issuVO.atchFlList.size() : 0)  : 0};
	
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
	}
	
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/prjSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp" />
				<div class="path"> 이슈 등록</div>
				<form id="create-form">
				<input type="hidden" name="issuId" value="${issuVO.issuId}"/>
				<input type="hidden" name="mdfyr" value="${sessionScope.__USER__.empId}"/>
					<div class="create-group">
						<label for="issuTtl">제목</label> 
						<input type="text" id="issuTtl" name="issuTtl" class="grow-1" value="${issuVO.issuTtl}"/>
					</div>
					<div class="create-group">
						<label for="issuCntnt">설명</label>
						<input type="text" id="issuCntnt" name="issuCntnt" class="grow-1" value="${issuVO.issuCntnt}"/>
					</div>
					<div class="create-group">
						<label for="reqId">요구사항ID</label>
						<input type="text" id="reqId" name="reqId" value="${issuVO.reqId}" disabled/>
						<span id="reqTtl">${issuVO.reqVO.reqTtl}</span>
					</div>
					<div class="create-group">
						<label for="dffclty">난이도</label> 
						<select id="dffclty" name="dffclty">
							<option ${issuVO.dffclty == "상" ? "selected" : ""}>상</option>
							<option ${issuVO.dffclty == "중" ? "selected" : ""}>중</option>
							<option ${issuVO.dffclty == "하" ? "selected" : ""}>하</option>
						</select>
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
									<ul id="file_list">
										<c:if test="${not empty issuVO.atchFlList and issuVO.atchFlList.get(0).flSz != 0}">
											<c:forEach items="${issuVO.atchFlList}" var="atchFl">
												<li data-uuid='${atchFl.uuidFlNm}'
													data-org='${atchFl.orgFlNm}'
													data-sz='${atchFl.flSz}'
													data-ext='${atchFl.flExt}'>
													<div>
														<span class='remove'>x</span>
														<span class='file_name'>${atchFl.orgFlNm}</span>
														<c:if test="${atchFl.flSz < 1024*1024}">
															<span class='file_size'>${String.format("%.2f",atchFl.flSz/1024)} KB</span>
														</c:if>
														<c:if test="${atchFl.flSz >= 1024*1024}">
															<span class='file_size'>${String.format("%.2f",atchFl.flSz/1024/1024)} MB</span>
														</c:if>
													</div>
												</li>
											</c:forEach>
										</c:if>
									</ul>
								</div>
							</div>
						</div>
						<input type="file" id="files" multiple/>
					</div>
					<div class="create-group">
						<label for="dtlCntnt">상세내용</label>
						<textarea name="dtlCntnt" id="dtlCntnt">${issuVO.dtlCntnt}</textarea>
					</div>
				</form>
					
				<div class="align-right">
					<button id="save_btn" class="btn-primary">저장</button>
					<button id="delete_btn" class="btn-delete">취소</button>
				</div>		
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>