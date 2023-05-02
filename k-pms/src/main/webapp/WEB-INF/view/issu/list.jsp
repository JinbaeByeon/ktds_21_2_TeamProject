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
		$(".sidebar > ul li a").removeClass("active")
		$("#issu_list").addClass("active");

		$(".list_table > tbody > tr > td").not(".check").click(function() {
			var issuId = $(this).closest("tr").data("issuid");
			if(issuId){
				location.href="${context}/issu/detail/"+issuId;
			}
		});
		
		$("#delete_btn").click(function(){
			var issuId = $("#issuId").val();
			if(issuId == ""){
				alert("선택된 이슈가 없습니다.");
				return;
			}
			
			if(!confirm("정말 삭제하시겠습니까?")){
				return;
			}
			
			$.get("${context}/api/issu/delete/" + issuId, function(response){
				if(response.status == "200 OK"){
					location.reload(); //새로고침
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			})
		});
		
		$("#search-btn").click(function() {
			movePage(0);
		});
					
		$("#create_btn").click(function(){
			location.href = "${context}/issu/create" 
		});
		
		$("#all_check").change(function(){
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});

		function checkIndex(){
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		}

		$(".list_table > tbody > tr > td.check").click(function(){
			var check_idx = $(this).closest("tr").find(".check_idx");
			check_idx.prop("checked",check_idx.prop("checked")==false);
			checkIndex();
		});
		$(".check_idx").change(function(){
			checkIndex();
		});
		$(".check_idx").click(function(e){
			$(this).prop("checked",$(this).prop("checked")==false);
		});
		
		
		$("#delete_all_btn").click(function(){
			var checkLen = $(".check_idx:checked").length;
			if(checkLen == 0) {
				alert("삭제할 이슈가 없습니다.");
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
	
	function movePage(pageNo) {
		// 전송
		// 입력값
		var issuId = $("#search-keyword").val();
		// URL 요청
		location.href = "${context}/issu/list?issuId=" + issuId + "&pageNo=" + pageNo;
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/prjSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp" />
				<div class="path">이슈</div>
		      <div class="search_wrapper">
		        <div class="search_box">
		          <select>
		            <option>이슈제목</option>
		            <option>요구사항제목</option>
		          </select>
		          <div class="search_field">
		            <input type="text" id="search-keyword" class="input" name="issuId" value="${issuVO.issuId}" placeholder="Search"/>
		          </div>
		          <div class="search-icon">
		          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
		          </div>
		        </div>
		      </div>
		      <div class="list_section">
		        <div class="total">총 ${issuList.size() > 0 ? issuList.get(0).totalCount : 0}건</div>
		        <table class="list_table">
		          <thead>
		            <tr>
						<th><input type="checkbox" id="all_check"/></th>
						<th>순번</th>
						<th>이슈ID</th>
						<th>이슈제목</th>
						<th>이슈내용</th>
						<th>조회수</th>
						<th>난이도</th>
						<th>담당팀원</th>
						<th>관리상태</th>
						<th>요구사항명</th>
						<th>등록자</th>
						<th>등록일</th>
		            </tr>
		          </thead>
		          <tbody>
		       		<c:choose>
								<c:when test="${not empty issuList}">
									<c:forEach items="${issuList}"
											   var="issu"
											   varStatus="index">
										<tr data-issuid="${issu.issuId}"
											data-issuttl="${issu.issuTtl}"
											data-crtr="${issu.crtr}"
											data-issucntnt="${issu.issuCntnt}"
											data-vwcnt="${issu.vwCnt}"
											data-dffclty="${issu.dffclty}"
											data-mntmmbrid="${issu.mnTmMbrId}"
											data-stts="${issu.stts}"
											data-crtdt="${issu.crtDt}">
											<td class="check">
												<input type="checkbox" class="check_idx" value="${issu.issuId}">
											</td>
											<td>${issu.rnum}</td>
											<td>${issu.issuId}</td>
											<td>${issu.issuTtl}</td>
											<td>${issu.issuCntnt}</td>
											<td>${issu.vwCnt}</td>
											<td>${issu.dffclty}</td>
											<td>${issu.mnTmMbrId}</td>
											<td>${issu.stts}</td>
											<td>${issu.reqVO.reqTtl} (${issu.reqId})</td>
											<td>${issu.crtEmp.lNm}${issu.crtEmp.fNm} (${issu.crtr})</td>
											<td>${issu.crtDt}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="12" class="no-items">
											등록된 이슈가 없습니다.
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
		          </tbody>
		        </table>
					<c:import url="../include/pagenate.jsp">
	                  <c:param name="pageNo" value="${pageNo}"/>
	                  <c:param name="pageCnt" value="${pageCnt}"/>
	                  <c:param name="lastPage" value="${lastPage}"/>
	               	</c:import>
		        <div class="buttons">
					<button id="delete_all_btn" class="btn delte">삭제</button>
					<button id="create_btn" class="btn regist">추가</button>
		        </div>
		      </div>
		      		
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>