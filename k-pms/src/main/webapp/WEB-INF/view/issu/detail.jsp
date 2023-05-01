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
	$().ready(function(){
		var empId = '${sessionScope.__USER__.empId}';
		var issuId = '${issuVO.issuId}';
		
		$("#modify_btn").click(function(){
			location.href="${context}/issu/modify/"+issuId;
		});

		$("#delete_btn").click(function(){
			$.get("${context}/api/issu/delete/"+issuId,function(response){
				if (response.status != "200 OK") {
					alert(response.errorCode + " / " + response.message);
				}
				if(response.redirectURL){
					location.href = "${context}" + response.redirectURL;
				}
			})
		});
		$("#file_list").find(".file_name").click(function(e){
			var data = $(this).closest("li").data();
			location.href= "${context}/api/file/download?uuidFlNm="+data.uuid+"&orgFlNm="+data.org;
			/* var form = $("<form></form>");
			form.append("<input type='hidden' name='uuidFlNm' value='"+ data.uuid +"'>");
			form.append("<input type='hidden' name='orgFlNm' value='"+ data.org +"'>");
			$("body").append(form);
			
			form.attr({
				"action": "${context}/api/issu/download",
				"method": "post"
			}).submit();
			
			form.remove(); */
		});
	});
	
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/prjSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp" />
				<div class="path">${issuVO.reqVO.reqTtl} (${issuVO.reqId})</div>
			<table class="detail_page detail_table">
                <input type="hidden" name="issuId" value="${issuVO.issuId}"/>
				<input type="hidden" name="mdfyr" value="${sessionScope.__USER__.empId}"/>
                <tr>
                    <th>제목</th>
                    <td colspan="3" id="issuTtl">${issuVO.issuTtl}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td colspan="3" id="crtr">${issuVO.crtr}</td>
                </tr>
                <tr>
                    <th>요구사항</th>
                    <td colspan="3" id="reqTtl">${issuVO.reqVO.reqTtl} (${issuVO.reqId})</td>
                </tr>
                <tr>
                    <th>난이도</th>
                    <td colspan="3" id="dffclty">${issuVO.dffclty}</td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="3">
                    	<div class="file_area">
							<ul id="file_list">
								<c:if test="${not empty issuVO.atchFlList and issuVO.atchFlList.get(0).flSz != 0}">
									<c:forEach items="${issuVO.atchFlList}" var="atchFl">
										<li data-uuid='${atchFl.uuidFlNm}'
											data-org='${atchFl.orgFlNm}'
											data-sz='${atchFl.flSz}'
											data-ext='${atchFl.flExt}'>
											<span class='file_name mr-10'>${atchFl.orgFlNm}</span>
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
                    </td>
                </tr>
                <tr>
                    <th>상세내용</th>
                    <td colspan="3"  id="dtlCntnt">${issuVO.dtlCntnt}</td>
                </tr>
                 <tr>
                    <th>등록자</th>
                    <td>${issuVO.crtr}</td>
                    <th>등록일</th>
                    <td>${issuVO.crtDt}</td>
                </tr>
                <tr>
                	<th>수정자</th>
                    <td>${issuVO.mdfyr}</td>
                    <th>수정일</th>
                    <td>${issuVO.mdfyDt}</td>
                  </tr>
              </table>

        <div class="buttons">
	       	<c:if test="${issuVO.crtr == sessionScope.__USER__.empId}">
				<button id="modify_btn" class="btn new">수정</button>
				<button id="delete_btn" class="btn delete">삭제</button>
			</c:if>
        </div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>