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
	var reqWindow;
	function addReqFn(req){
		var reqId = $("#reqId");
		reqId.val(req.reqid);
		var reqTtl = $("#reqTtl");
		reqTtl.text(req.reqttl);
	}
	$().ready(function(){
		$(".sidebar > ul li a").removeClass("active")
		$("#issu_list").addClass("active");
		
		var empId = '${sessionScope.__USER__.empId}';
		$("#req_search").click(function(e){
			e.preventDefault();
			reqWindow = window.open("${context}/req/search/req","요구사항 검색","width=800,height=600");
		});
		
		
		$("#reqId").val("${reqId}");
		
		
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
		
		$("#new_btn").click(function(){
			var form = $("#create-form");
			
			var fileList = $(".file_attachment").find("li");
			
			cnt=0;
			fileList.each(function(){
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
			
			ajaxUtil.upload("#create-form","${context}/api/issu/create",function(response){
				if (response.status != "200 OK") {
					alert(response.errorCode + " / " + response.message);
				}
				if(response.redirectURL){
					if(${reqId != null && reqId != ''}){
						location.href = "${context}/req/detail/${reqId}";
					}
					else {
						location.href = "${context}" + response.redirectURL;
					}
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
	});
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
			
			ajaxUtil.deleteFile([item.data("uuid")], "${context}/api/atchfl/delete", function(response) {
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
	
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/prjSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp" />
				<div class="path">이슈 등록</div>
				<form id="create-form">
					<input type="hidden" name="crtr" value="${sessionScope.__USER__.empId}"/>
					<table class="detail_table">
		                <tr>
		                    <th>제목</th>
		                    <td><input type="text" id="issuTtl" name="issuTtl" /></td>
		                </tr>
		                <tr>
		                    <th>설명</th>
		                    <td><input type="text" id="issuCntnt" name="issuCntnt" /></td>
		                </tr>
		                <tr>
		                    <th>요구사항</th>
		                    <td>
		                    	<input type="text" id="reqId" name="reqId" readonly/>
		                    	<span id="reqTtl"></span>
		                    	<button id="req_search" class="btn regist">검색</button>
		                    </td>
		                </tr>
		                <tr>
		                    <th>난이도</th>
		                    <td>
				                <select id="dffclty" name="dffclty">
									<option>상</option>
									<option>중</option>
									<option>하</option>
								</select>
		                    </td>
		                </tr>
		                <tr>
		                    <th>첨부파일</th>
		                    <td>
								<button id="add_files" class="btn-add btn">+</button>
								<div class="file_area input_div">
									<div class="file_upload input_div">
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
		                    <th>상세내용</th>
		                    <td><textarea name="dtlCntnt" id="dtlCntnt"></textarea></td>
		                </tr>
		            </table>
				</form>
        <div class="buttons">
	       	<button id="new_btn" class="btn regist">등록</button>
			<button id="delete_btn" class="btn delete">취소</button>
        </div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>