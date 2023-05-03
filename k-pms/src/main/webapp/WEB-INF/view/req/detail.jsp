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
		
		var remove =  $("<span class='remove input_div'>x</span>");
		remove.click(removeFn);
		
        var nm = "<span class='file_name input_div'>"+fileNm+"</span>";
        fileSz = (fileSz / 1024).toFixed(2);
        var sz;
        if(fileSz < 1000){
        	sz = "<span class='file_size input_div'>"+fileSz+" KB</span>";
        } else {
        	fileSz = (fileSz/1024).toFixed(2);
        	sz = "<span class='file_size input_div'>"+fileSz+" MB</span>";
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
			<div class="path">${reqVO.reqTtl}</div>
				<table class="detail_page detail_table">
                <tr>
                    <th>요구사항 ID</th>
                    <td colspan="3">${reqVO.reqId}</td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td colspan="3">${reqVO.reqTtl}</td>
                </tr>
                <tr>
                    <th>우선순위</th>
                    <td colspan="3">${reqVO.prrty}</td>
                </tr>
                <tr>
                    <th>시작일</th>
                    <td colspan="3">${reqVO.strtDt}</td>
                </tr>
                <tr>
                    <th>종료예정일</th>
                    <td colspan="3">${reqVO.expctEndDt}</td>
                </tr>
                <tr>
                    <th>프로젝트ID</th>
                    <td colspan="3">${reqVO.prjId}</td>
                </tr>
                <tr>
                    <th>프로젝트명</th>
                    <td colspan="3">${reqVO.reqPrjVO.prjNm}</td>
                </tr>
                <tr>
                    <th>담당개발자</th>
                    <td colspan="3">${reqVO.mnDvlpr}</td>
                </tr>
                <tr>
                    <th>확인자</th>
                    <td colspan="3">${reqVO.reqCnfrNm}</td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="3">
                    		<div class="file_attachment input_div">
								<div class="file_attachment_summary input_div">
									<span class="total_count input_div">첨부 개</span>
									<span class="total_volume input_div">전체용량</span>
									<button class="save_all btn save">모두저장</button>
								</div>
								<div class="file_attachments_inner input_div">
									<ul id="file_list">
										<c:if test="${not empty reqVO.atchFlList}">
										<c:forEach items="${reqVO.atchFlList}" var="atchFl">
											<li class="file_item input_div"
												data-uuid='${atchFl.uuidFlNm}'
												data-org='${atchFl.orgFlNm}'
												data-sz='${atchFl.flSz}'
												data-ext='${atchFl.flExt}'>
												<span class='file_name input_div'>${atchFl.orgFlNm}</span>
												<c:if test="${atchFl.flSz < 1024*1024}">
													<span class='file_size input_div'>${String.format("%.2f",atchFl.flSz/1024)} KB</span>
												</c:if>
												<c:if test="${atchFl.flSz >= 1024*1024}">
													<span class='file_size input_div'>${String.format("%.2f",atchFl.flSz/1024/1024)} MB</span>
												</c:if>
											</li>
										</c:forEach>
										</c:if>
									</ul>
								</div>
							</div>
						<input type="file" id="files" multiple/>
                    </td>
                </tr>
                <tr>
                    <th>진행상태</th>
                    <td colspan="3">${reqVO.prcsCdNm}</td>
                </tr>
                <tr>
                    <th>일정상태</th>
                    <td colspan="3">${reqVO.tskCdNm}</td>
                </tr>
                <tr>
                    <th>테스트 결과</th>
                    <td colspan="3">${reqVO.rsltCdNm}</td>
                </tr>
                <tr>
                    <th>상세요구사항</th>
                    <td colspan="3">${reqVO.dtlReq}</td>
                </tr>
                <tr>
                    <th>사용여부</th>
                    <td colspan="3">${reqVO.useYn}</td>
                </tr>
                <tr>
                    <th>등록자</th>
                    <td>${reqVO.crtr}</td>
                    <th>등록일</th>
                    <td>${reqVO.crtDt}</td>
                </tr>
                <tr>
                	<th>수정자</th>
                    <td>${reqVO.mdfyr}</td>
                    <th>수정일</th>
                    <td>${reqVO.mdfyDt}</td>
                  </tr>
            </table>
                
        <div class="hr"></div>
            <div class="req path">이슈</div>
            <div class="total">총 ${issuList.size() > 0 ? issuList.get(0).totalCount : 0}건</div>
            <div class="view_all">
                <a href="${context}/issu/list?reqId=${reqVO.reqId}">[전체보기]</a>
            </div>
            
                <table class="list_table sub_table">
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
										   var="issu">
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

        <div class="buttons">
			<button id="update_btn" class="btn edit">수정</button>
			<button id="issu_delete_btn" class="btn delete">삭제</button>
        </div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>