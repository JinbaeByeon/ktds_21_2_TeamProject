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
		checkFile();
		var empId = '${sessionScope.__USER__.empId}';
		var data2 = "${reqVO.reqId}";
		console.log(data2);
		$("#isModify").val("true");	
		$("#reqId").val("${reqVO.reqId}");
		$("#dtlReq").val("${reqVO.dtlReq}");
		$("#crtr").val("${reqVO.crtr}");
		$("#crtDt").val("${reqVO.crtDt}");
		$("#mdfyr").val("${reqVO.mdfyr}");
		$("#mdfyDt").val("${reqVO.mdfyDt}");
		$("#strtDt").val("${reqVO.strtDt}");
		$("#expctEndDt").val("${reqVO.expctEndDt}");
		$("#attch").val("${reqVO.attch}");
		$("#prjId").val("${reqVO.prjId}");
		$("#mnDvlpr").val("${reqVO.mnDvlpr}");
		$("#tstRslt").val("${reqVO.tstRslt}");
		$("#tskStts").val("${reqVO.tskStts}");
		$("#prcsStts").val("${reqVO.prcsStts}");
		$("#prrty").val("${reqVO.prrty}");
		$("#reqTtl").val("${reqVO.reqTtl}");
		$("#reqCnfrNm").val("${reqVO.reqCnfrNm}");
		
		$("#useYn").prop("checked", "${reqVO.useYn}" == "Y");
		
		
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
		
		$("#update_btn").click(function(){
			var reqId = $("#reqId").val();
			location.href = "${context}/req/update/" + reqId;
		});
		
		$("#back-btn").click(function(){
			location.href = "${context}/req/list";
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
		$(".remove").click(removeFn);
	});
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
			<jsp:include page="../include/reqSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp" />
				<div class="path"> 상세 정보</div>
				<div class="grid-detail">
					<form id="detail_form" >
						<!-- isModify == true => 수정(update) -->
						<!-- isModify == false => 등록(insert) -->
						<input type="hidden" id="isModify" value="false" />
						<div class="input-group inline">
							<label for="reqId" style="width: 180px;">요구사항 ID</label>
							<input type="text" id="reqId"  name="reqId" value="" readonly />
						</div>
						<div class="input-group inline">
							<label for="reqTtl" style="width: 180px;">제목</label>
							<input type="text" id="reqTtl"  name="reqTtl" value="" readonly />
						</div>
						<div class="input-group inline">
							<label for="prrty" style="width: 180px;">우선순위</label>
							<input type="text" id="prrty"  name="prrty" value="" readonly/>
						</div>
						<div class="input-group inline">
							<label for="strtDt" style="width: 180px;">시작일</label>
							<input type="date" id="strtDt"  name="strtDt" value="" readonly/>
						</div>
						<div class="input-group inline">
							<label for="expctEndDt" style="width: 180px;">종료예정일</label>
							<input type="date" id="expctEndDt"  name="expctEndDt" value="" readonly/>
						</div>
						<div class="input-group inline">
							<label for="prjId" style="width: 180px;">프로젝트ID</label>
							<input type="text" id="prjId"  name="prjId" value="" readonly />
						</div>
						<div class="input-group inline">
							<label for="prjId" style="width: 180px;">담당개발자</label>
							<input type="text" id="mnDvlpr"  name="mnDvlpr" value="" readonly/>
						</div>
						<div class="input-group inline">
							<label for="reqCnfrNm" style="width: 180px;">확인자</label>
							<input type="text" id="reqCnfrNm"  name="reqCnfrNm" value="" readonly/>
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
										<ul id="file_list">
											<c:if test="${not empty reqVO.atchFlList}">
											<c:forEach items="${reqVO.atchFlList}" var="atchFl">
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
						<div class="input-group inline">
							<label for="prcsStts" style="width: 180px;">진행상태</label>
							<input type="hidden" id="original-prcsStts"  name="original-prcsStts" value="${reqVO.prcsStts}" readonly/>
							<select name="option" onFocus="this.initialSelect = this.selectedIndex;" onChange="this.selectedIndex = this.initialSelect;" id="prcsStts-select"  name="prcsStts" ></select>
						</div>
						<div class="input-group inline">
							<label for="tskStts" style="width: 180px;">일정상태</label>
							<input type="hidden" id="original-tskStts"  name="original-tskStts" value="${reqVO.tskStts}" readonly/>
							<select name="option" onFocus="this.initialSelect = this.selectedIndex;" onChange="this.selectedIndex = this.initialSelect;" id="tskStts-select"  name="tskStts" ></select>
						</div>
						<div class="input-group inline">
							<label for="tstRslt" style="width: 180px;">테스트 결과</label>
							<input type="hidden" id="original-tstRslt"  name="original-tstRslt" value="${reqVO.tstRslt}" readonly/>
							<select name="option" onFocus="this.initialSelect = this.selectedIndex;" onChange="this.selectedIndex = this.initialSelect;" id="tstRslt-select"  name="tstRslt" ></select>
						</div>
						<div class="input-group inline">
							<label for="dtlReq" style="width: 180px;">상세요구사항</label>
							<textarea id="dtlReq" name="dtlReq"  readonly>${req.dtlReq}</textarea>
						</div>
					</form>		
				</div>
				<div class="align-right">
					<button id="update_btn" class="btn-primary">수정</button>
					<button id="back-btn" class="btn-delete">뒤로</button>
				</div>	
				<div>
				<div>이슈잇슈
					<button>추가</button>
					<button>삭제</button>
				</div>	
				<table>
					<thead>
						<tr>
							<th>직원ID</th>
							<th>팀</th>
							<th>성</th>
							<th>이름</th>
							<th>권한</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty reqList}">
								<c:forEach items="${reqList}"
										   var="req">
									<tr data-reqid="${req.reqId}"
										data-reqttl="${req.reqTtl}"
										data-rsltcdnm="${req.rsltCdNm}"
										data-useyn="${req.useYn}"
										data-crtr="${req.crtr}"
										data-crtdt="${req.crtDt}"
										data-mdfyr="${req.mdfyr}"
										data-mdfydt="${req.mdfyDt}"
										data-delyn="${req.delYn}">
										<td>
											<input type="checkbox" class="check_idx" value="${req.reqId}">
										</td>
										<td>${req.rnum}</td>
										<td>${req.prcsCdNm}</td>
										<td>${req.tskCdNm}</td>
										<td>${req.strtDt}</td>
										<td>${req.expctEndDt}</td>
										<td>${req.prjId}</td>
										<td>${req.prrty}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="10" class="no-items">
										등록된 이슈가 없습니다.
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>