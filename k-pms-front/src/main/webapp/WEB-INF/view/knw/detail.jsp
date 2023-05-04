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
	var ajaxUtil = new AjaxUtil();
	
	$().ready(function() {
		$(".sidebar > ul li a").removeClass("active")
		$("#knw_list").addClass("active");

		(function(){
			var frgnId = "${knwVO.knwId}";
			
			$.getJSON("${context}/knw/detail/getAttachList", {frgnId: frgnId}, function(files){
				
				for(var i = 0; i < files.length; i++){
					var file = files[i];
					var fileList = $("#file_list");
				
					var li = $("<li data-uuid='"+file.uuidFlNm +
								 "' data-org='"+file.orgFlNm + 
								 "' data-sz='"+file.flSz+
								 "' data-ext='"+file.flExt+"'></li>");
					fileList.append(li);
					var div = $("<div></div>");
					li.append(div);
					
					var nm = "<span class='file_name'>"+file.orgFlNm+"</span>";
			        var fileSz = (file.flSz / 1024).toFixed(2);
			        var sz;
			        if(fileSz < 1000){
			        	sz = "<span class='file_size'>"+"("+fileSz+" KB)</span>";
			        } else {
			        	fileSz = (fileSz/1024).toFixed(2);
			        	sz = "<span class='file_size'>"+"("+fileSz+" MB)</span>";
			        }
			        div.append(nm);
			        div.append(sz);
				}
		        
		    });
		})();
		
			
		$(".listBtn").click(function() {
			if($("#commonMode").val() != "") {
				location.href = "${context}/knw/list/0";
			}
			else {
				location.href = "${context}/knw/list/1";	
			}
		});
		
		$(".updateBtn").click(function() {
			location.href = "${context}/knw/update/${knwVO.knwId}"
		});
		
		$(".deleteBtn").click(function() {
			event.preventDefault();
			var result = confirm("정말 삭제하시겠습니까?");	
			
			if (result) {
				$.get("${context}/api/knw/delete/${knwVO.knwId}", function(response) {
					console.log(response);
					if (response.status == "200 OK") {
						location.href = "${context}/knw/list";
					}
					else {
						alert(response.errorCode + " / " + response.message);
					}
				});
			}
		});

		$(".commentSubmitBtn").click(function(event) {
			event.preventDefault();
			var commentForm = $(this).closest(".commentForm");
			$.post("${context}/api/knwrpl/create", commentForm.serialize(),function(response) {
				console.log(response);
				if (response.status == "200 OK") {
					location.reload();
				} else {
					alert(response.errorCode + " / " + response.message);
				}
			});
		});

		$(".replyBtn").click(function() {
			event.preventDefault();
			var that = $(this).closest(".cntArea").closest(".comment").find(".commentBoxArea");
			
			if (that.attr("style").includes("display: block")) {
				that.hide();
			} else {
				that.show();
				that.find(".cnt").focus();
			}
		});

		$(".commentUpdateBtn").click(function() {
			var cntArea = $(this).closest(".commentBtns").closest(".comment").find(".cntArea");
			
			if($(this).val() == "update") {
				cntArea.find("p").remove();
				var cnt = cntArea.find(".cnt").val();
				cntArea.find(".cnt").remove();
				cntArea.append("<input type='text' name='cnt' class='cnt'/>");
				cntArea.find(".cnt").focus();
				cntArea.find(".cnt").val(cnt);	
				$(this).empty();
				$(this).append("완료");
				$(this).val("complete")
			}
			else if($(this).val() == "complete") {
				event.preventDefault();
				var result = confirm("정말 수정하시겠습니까?");	
				
				if (result) {
					var form = $("<form></form>");
					form.append(cntArea);
					ajaxUtil.upload(form, "${context}/api/knwrpl/update", function(response) {
						console.log(response);
						if (response.status == "200 OK") {
							location.reload();
						}
						else {
							alert(response.errorCode + " / " + response.message);
						}
					});
				}
			}
		});

		$(".commentDeleteBtn").click(function() {
			var result = confirm("정말 삭제하시겠습니까?")
			if (result) {
				var replyId = $(this).closest(".commentBtns").closest(".comment").find(".cntArea").find(".rplId").val();
				$(this).closest(".commentBtns").closest(".comment").hide();
				
				$.post("${context}/api/knwrpl/delete/"+ replyId, function(response) {
					if (response.status == "200 OK") {
						alert("삭제되었습니다.")
						location.reload();
					} 
					else {
						alert(response.errorCode + " / " + response.message);
					}
				});
			}
		});
		
		$(document).on("click", "span.file_name", function(){
			console.log("!!");
        	var data =$(this).closest("li").data();
        	var form = $("<form></form>");
        	form.append("<input type='hidden' name='orgFlNm' value='" + data.org + "'/>");
        	form.append("<input type='hidden' name='uuidFlNm' value='" + data.uuid + "'/>");
        	$("body").append(form);
        	form.attr({
        		"action" : "${context}/api/knw/file",
        		"method" : "post"
        	}).submit();
        	
        	form.remove();
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
			<c:if test="${knwVO.prjId ne null}">
				<div class="path">프로젝트 > 관련 프로젝트: <a href="${context}/knw/list/0?prjId=${prjVO.prjId}">${prjVO.prjNm}</a></div>
			</c:if>
			<c:if test="${knwVO.prjId eq null}">
				<div class="path">사내지식관리 > 사내지식</div>
			</c:if>
			<div class="articleBox">
				<div class="articleHead">
					<input type="hidden" name="knwId" value="${knwVO.knwId}" />
					<input type="hidden" id="commonMode" value="${knwVO.prjId}" />
					<div class="articleInfo">
						<p class="articleTitle">${knwVO.ttl}</p>
						<div class="writerInfo">
							<p class="writerId">${knwVO.crtr}</p>
							<span class="date">${knwVO.crtDt}</span>
						</div>
					</div>
				</div>
				<div class="articleBody">
					${knwVO.cntnt}
				</div>
				
				<c:if test="${atchFlList.get(0).frgnId ne null}">
					<div class="fileAttachmentArea">
						<div class="fileAttachment">
							<p>첨부파일 <span class="fileSize">${atchFlList.size()}</span></p>
							<ul id="file_list"></ul>
						</div>
					</div>	
				</c:if>
				
				<div class="articleBtnsArea">
					<div class="articleBtns">
						<c:if test="${(rplVO.crtr eq sessionScope.__USER__.empId) or (sessionScope.__USER__.admnYn eq 'Y')}">
							<button class="updateBtn btn save size">수정</button>
							<button class="deleteBtn btn delete size">삭제</button>
						</c:if>
						<button class="listBtn btn regist size">목록</button>
					</div>
				</div>
				
				<div class="commentBox">
					<div class="commentBoxArea">
						<form class="commentForm">
							<input type="hidden" name="knwId" value="${knwVO.knwId}" />
							<input type="text" class="cnt" name="cnt" placeholder="댓글을 입력해 주세요." />
							<button class="commentSubmitBtn btn regist2 size">등록</button>
						</form>
					</div>
				</div>
				<div class="commentsTop">
					<div class="commentCount"><p>전체 댓글 ${knwVO.rplList.get(0).knwId ne null ? knwVO.rplList.size() : 0}개</p></div>
					<div class="commentsArea">
						<div id="comments">
							<c:if test="${not empty knwVO.rplList}">
								<c:forEach items="${knwVO.rplList}" var="rplVO">
									<c:if test="${rplVO.knwId ne null}">
										<div class="commentArea" style="width: ">
											<c:if test="${rplVO.depth > 0}"><div class="lowerCommentSign" style="padding-left:${(rplVO.depth - 1) * 30}px;">></div></c:if>
											<div class="comment" style="padding-left: ${rplVO.depth * 30}px;">
												<input class="rplId" type="hidden" name="rplId" value="${rplVO.rplId}" />
												<div class="replyInfo">
													<p class="crtrInfo">${rplVO.crtr}</p>
													<span class="crtDtInfo">${rplVO.crtDt}</span>
												</div>
												<div class="cntArea">
													<input type="hidden" class="rplId" name="rplId" value="${rplVO.rplId}" />
													<input type="hidden" class="cnt" name="cnt" value="${rplVO.cnt}" />
													<p class="replyBtn">${rplVO.cnt}</p>
												</div>
												<div class="commentBtns">
													<c:if test="${rplVO.crtr eq sessionScope.__USER__.empId or sessionScope.__USER__.admnYn eq 'Y'}">
														<button class="commentUpdateBtn btn sedit" value="update">수정</button>
													</c:if>
													<c:if test="${rplVO.crtr eq sessionScope.__USER__.empId or sessionScope.__USER__.admnYn eq 'Y'}">
														<button class="commentDeleteBtn btn sdelete">삭제</button>
													</c:if>
												</div>
												<div class="commentBoxArea" style="width: ${920 - rplVO.depth * 30}px" hidden>
													<form class="commentForm">
														<input type="hidden" name="knwId" value="${knwVO.knwId}" />
														<input type="hidden" name="prcdncRplId" value="${rplVO.rplId}" />
														<input type="text" class="cnt" name="cnt" placeholder="답글을 입력해 주세요." />
														<button class="commentSubmitBtn btn regist2 size">등록</button>
													</form>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</c:if>
						</div>
					</div>
				</div>
				
			</div>
			

			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>