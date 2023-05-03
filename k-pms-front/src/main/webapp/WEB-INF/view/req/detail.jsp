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
		$(".sidebar > ul li a").removeClass("active")
		$("#req_list").addClass("active");
		
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
			var reqId = data2;
			location.href = "${context}/req/update/" + reqId;
		});
		
		$("#back-btn").click(function(){
			location.href = "${context}/req/list";
		});
		
		$("#file_list").find(".file_name").click(function(e){
			var data = $(this).closest(".file_item").data();
			location.href= "${context}/api/file/download?uuidFlNm="+data.uuid+"&orgFlNm="+data.org;
		});
		
		$(".file_attachment").find(".save_all").click(function(e){
			e.preventDefault();
			var fileList = $("#file_list").find(".file_item");
			var form = $("<form></form>");
			form.append("<input type='hidden' name='fileNm' value='${rcvMsgVO.sndMsgVO.ttl}'>");
			var idx =0;
			fileList.each(function(){
				var data = $(this).data();
				form.append("<input type='hidden' name='atchFlVOList["+idx+"].uuidFlNm' value='"+ data.uuid +"'>");
				form.append("<input type='hidden' name='atchFlVOList["+idx++ +"].orgFlNm' value='"+ data.org +"'>");
				$("body").append(form);
			});
			form.attr({
				"action": "${context}/api/files/download",
				"method": "post"
			}).submit();
			form.remove();
		});
		
		
		$("#issu_create_btn").click(function(){
			var reqId = data2;
			location.href="${context}/issu/create/"+reqId;
		});
		$("#issu_delete_btn").click(function(){
			var checkLen = $(".check_idx:checked").length;
			if(checkLen == 0) {
				alert("삭제할 요구사항이 없습니다.");
				return;
			}
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function(){
				console.log($(this).val());
				form.append("<input type='hidden' name='issuId' value='" + $(this).val() +"'>");
			});
			
			$.post("${context}/api/issu/delete", form.serialize(), function(response){
				if(response.status == "200 OK"){
					location.reload(); //새로고침
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		
		
		
		
		
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
			<jsp:include page="../include/prjSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp" />
				<div class="path"> 상세 정보</div>
				<div class="grid-detail">
					<form id="detail_form" >
						<div class="create-group">
							<label for="reqTtl" style="width: 180px;">제목</label>
							<div>${reqVO.reqTtl}</div>
						</div>
						<div class="create-group">
							<label for="prrty" style="width: 180px;">우선순위</label>
							<div>${reqVO.prrty}</div>
						</div>
						<div class="create-group">
							<label for="strtDt" style="width: 180px;">시작일</label>
							<div>${reqVO.strtDt}</div>
						</div>
						<div class="create-group">
							<label for="expctEndDt" style="width: 180px;">종료예정일</label>
							<div>${reqVO.expctEndDt}</div>
						</div>
						<div class="create-group">
							<label for="prjNm" style="width: 180px;">프로젝트명</label>
							<div>${reqVO.reqPrjVO.prjNm}</div>
						</div>
						<div class="create-group">
							<label for="mnDvlpr" style="width: 180px;">담당개발자</label>
							<div>${reqVO.mnDvlpr}</div>
						</div>
						<div class="create-group">
							<label for="reqCnfrNm" style="width: 180px;">확인자</label>
							<div>${reqVO.reqCnfrNm}</div>
						</div>
						<div class="create-group">
							<label for="files" style="width: 180px;">첨부파일</label>
							<div class="file_attachment">
								<div class="file_attachment_summary">
									<span class="total_count">첨부 개</span>
									<span class="total_volume">전체용량</span>
									<button class="save_all">모두저장</button>
								</div>
								<div class="file_attachments_inner">
									<ul id="file_list">
										<c:if test="${not empty reqVO.atchFlList}">
										<c:forEach items="${reqVO.atchFlList}" var="atchFl">
											<li class="file_item"
												data-uuid='${atchFl.uuidFlNm}'
												data-org='${atchFl.orgFlNm}'
												data-sz='${atchFl.flSz}'
												data-ext='${atchFl.flExt}'>
												<span class='file_name'>${atchFl.orgFlNm}</span>
												<c:if test="${atchFl.flSz < 1024*1024}">
													<span class='file_size'>${String.format("%.2f",atchFl.flSz/1024)} KB</span>
												</c:if>
												<c:if test="${atchFl.flSz >= 1024*1024}">
													<span class='file_size'>${String.format("%.2f",atchFl.flSz/1024/1024)} MB</span>
												</c:if>
											</li>
										</c:forEach>
										</c:if>
									</ul>
								</div>
							</div>
						<input type="file" id="files" multiple/>
						</div>
						<div class="create-group">
							<label for="prcsStts" style="width: 180px;">진행상태</label>
							<div>${reqVO.prcsCdNm}</div>
						</div>
						<div class="create-group">
							<label for="tskStts" style="width: 180px;">일정상태</label>
							<div>${reqVO.tskCdNm}</div>
						</div>
						<div class="create-group">
							<label for="tstRslt" style="width: 180px;">테스트 결과</label>
							<div>${reqVO.rsltCdNm}</div>
						</div>
						<div class="create-group">
							<label for="dtlReq" style="width: 180px;">상세요구사항</label>
							<div>${reqVO.dtlReq}</div>
						</div>
					</form>		
				</div>
				<div class="align-right">
					<button id="update_btn" class="btn-primary">수정</button>
					<button id="back-btn" class="btn-delete">뒤로</button>
				</div>	
				<div class="create-group">
				<label for="issue" style="width: 180px;">이슈</label>
				</div>	
				<div class="grid">
					<div class="grid-count align-right">
						총 ${issuList.size() > 0 ? issuList.get(0).totalCount : 0}건
						<a href="${context}/issu/list?reqId=${reqVO.reqId}&reqVO.reqTtl=${reqVO.reqTtl}&reqVO.prjId=${reqVO.prjId}&prjNm=${reqVO.reqPrjVO.prjNm}">[전체보기]</a>
					</div>
					<table>
						<thead>
							<tr>
								<th><input type="checkbox" id="all_issu_check"/></th>
								<th>순번</th>
								<th>이슈제목</th>
								<th>등록팀원</th>
								<th>이슈내용</th>
								<th>조회수</th>
								<th>난이도</th>
								<th>담당팀원</th>
								<th>관리상태</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty issuList}">
									<c:forEach items="${issuList}"
											   var="issu"
											   begin="0"
											   end="4">
										<tr data-issuid="${issu.issuId}"
											data-issuttl="${issu.issuTtl}"
											data-crtr="${issu.crtr}"
											data-vwcnt="${issu.vwCnt}"
											data-issucntnt="${issu.issuCntnt}"
											data-dffclty="${issu.dffclty}"
											data-mntmmbrid="${issu.mnTmMbrId}"
											data-stts="${issu.stts}"
											data-crtdt="${issu.crtDt}"
											data-mdfyr="${issu.mdfyr}"
											data-mdfydt="${issu.mdfyDt}"
											data-useyn="${issu.useYn}"
											data-delyn="${issu.delYn}">
											<td>
												<input type="checkbox" class="check_idx" value="${issu.issuId}">
											</td>
											<td>${issu.rnum}</td>
											<td>${issu.issuTtl}</td>
											<td>${issu.crtr}</td>
											<td>${issu.issuCntnt}</td>
											<td>${issu.vwCnt}</td>
											<td>${issu.dffclty}</td>
											<td>${issu.mnTmMbrId}</td>
											<td>${issu.stts}</td>
											<td>${issu.crtDt}</td>
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
					<button id="issu_create_btn">추가</button>
					<button id="issu_delete_btn">삭제</button>
				</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>