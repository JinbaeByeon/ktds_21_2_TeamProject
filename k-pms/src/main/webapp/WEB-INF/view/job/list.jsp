<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set scope="request" var="selected" value="sys"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		$(".sidebar > ul li a").removeClass("active")
		$("#job_list").addClass("active");
		
		$(".detail_section").hide();
		
		$(".list_table > tbody > tr").click(function() {
			$("#crtr").closest("td").prev().show();
			$("#crtr").closest("td").show();
			
			$("#crtDt").closest("td").prev().show();
			$("#crtDt").closest("td").show();
			
			$("#mdfyr").closest("td").prev().show();
			$("#mdfyr").closest("td").show();

			$("#mdfyDt").closest("tr").show();
			
			$("#isModify").val("true");
			$(".detail_section").show("fast");
	        $(".detail_table").show();
	        
			var data = $(this).data();
			$("#jobId").val(data.jobid);
			$("#crtDt").val(data.crtdt);
			$("#crtr").val(data.crtr);
			$("#mdfyDt").val(data.mdfydt);
			$("#mdfyr").val(data.mdfyr);
			$("#delYn").val(data.delyn);
			$("#jobNm").val(data.jobnm);

			$("#useYn").prop("checked", data.useyn == "Y");
		});

		$("#new_btn").click(function() {
			$("#crtr").closest("td").prev().hide();
			$("#crtr").closest("td").hide();
			
			$("#crtDt").closest("td").prev().hide();
			$("#crtDt").closest("td").hide();
			
			$("#mdfyr").closest("td").prev().hide();
			$("#mdfyr").closest("td").hide();

			$("#mdfyDt").closest("tr").hide();
			
			$("#isModify").val("false");
			$(".detail_section").show("fast");
	        $(".detail_table").show();

			$("#jobId").val("");
			$("#crtDt").val("");
			$("#crtr").val("");
			$("#mdfyDt").val("");
			$("#mdfyr").val("");
			$("#delYn").val("");
			$("#jobNm").val("");

			$("useYn").prop("checked", false);
		});

		$("#delete_btn").click(function() {
			var jobId = $("#jobId").val();
			if (jobId == "") {
				alert("선택된 직무가 없습니다.");
				return;
			}

			if (!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			$.get("${context}/api/job/delete/" + jobId, function(response) {
				if (response.status == "200 OK") {
					location.reload();
				} else {
					alert(response.status == "500");
				}
			});
		});

		$("#save_btn").click(function() {

			if ($("#isModify").val() == "false") {
				// 신규등록
				$.post("${context}/api/job/create", {
					jobNm : $("#jobNm").val(),
					useYn : $("#useYn:checked").val()
				}, function(response) {
					if (response.status == "200 OK") {
						location.reload();
					} else {
						alert(response.status);
					}
				});
			} else {
				$.post("${context}/api/job/update", {
					jobId : $("#jobId").val(),
					jobNm : $("#jobNm").val(),
					useYn : $("#useYn:checked").val()
				}, function(response) {

					if (response.status == "200 OK") {
						location.reload();
					} else {
						alert(response.errorCode + "/" + response.message);
					}
				});
			}
		});
		$("#search-btn").click(function() {
			movePage(0)
		});
		
		$("#all_check").change(function() {
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		function checkIndex(){
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		}
		
		$(".check_idx").change(function(){
			checkIndex();
		});
		
		$(".list_table > tbody > tr > td").not(".check").click(function(){
			var check_idx = $(this).closest("tr").find(".check_idx");
			check_idx.prop("checked",check_idx.prop("checked")==false);
			checkIndex();
		});
		
		$("#delete_all_btn").click(function() {
			var checkLen = $(".check_idx:checked").length;
			if(checkLen == 0) {
				alert("삭제할 직무가 없습니다.");
				return;
			}
			
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function() {
				console.log($(this).val());
				form.append("<input type='hidden' name='jobId' value='"+ $(this).val() +"'>");
			});
			
			$.post("${context}/api/job/delete", form.serialize(), function(response) {
				location.reload(); // 새로고침
			});
		});
	});
	function movePage(pageNo) {
		// 전송
		// 입력 값
		var jobNm=$("#search-keyword").val();
		// URL 요청
		location.href= "${context}/job/list?jobNm=" + jobNm + "&pageNo=" + pageNo;
	}

</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp"/>
		<div>
		<jsp:include page="../include/sysSidemenu.jsp"/>
		<jsp:include page="../include/content.jsp"/>
			<div class="path">시스템 관리 > 직무 관리</div>
			      <div class="search_wrapper">
			        <div class="search_box">
			          <select>
			            <option>직무명</option>
			          </select>
			          <div class="search_field">
			          	<input type="text" id="search-keyword" class="input" value="${jobVO.jobNm}" placeholder="Search"/>
			          </div>
			          <div class="search-icon">
			          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
			          </div>
			        </div>
			      </div>
			      <div class="list_section">
			        <div class="total">총 ${jobList.size() > 0 ? jobList.get(0).totalCount : 0}건</div>
			        <table class="list_table">
			          <thead>
						<tr>
						 	<th><input type="checkbox" id="all_check"/></th>
			                <th>순번</th>
			                <th>직무ID</th>
			                <th>직무명</th>
			                <th>사용여부</th>
<!-- 			                <th>등록자</th>
			                <th>등록일</th>
			                <th>수정자</th>
			                <th>수정일</th> -->
						</tr>
			          </thead>
			          <tbody>
			            <c:choose>
			                <c:when test="${not empty jobList}">
			                    <c:forEach items="${jobList}"
			                               var="job">
			                        <tr data-jobid="${job.jobId}"
			                            data-jobnm="${job.jobNm}"
			                            data-useyn="${job.useYn}"
			                            data-crtr="${job.crtr}"
			                            data-crtdt="${job.crtDt}"
			                            data-mdfyr="${job.mdfyr}"
			                            data-mdfydt="${job.mdfyDt}">
			                        <td>
			                            <input type="checkbox" class="check_idx" value="${job.jobId}"/>
			                        </td>
			                        <td>${job.rnum}</td>
			                        <td>${job.jobId}</td>
			                        <td>${job.jobNm}</td>
			                        <td>${job.useYn}</td>
<%-- 			                        <td>${job.crtr}</td>
			                        <td>${job.crtDt}</td>
			                        <td>${job.mdfyr}</td>
			                        <td>${job.mdfyDt}</td> --%>
			                        </tr>
			                    </c:forEach>
			                </c:when>
			                <c:otherwise>
			                    <tr>
			                        <td colspan="9" class="no-items">
			                            등록된 직무가 없습니다.
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
					      <c:param name="path" value="${context}/job"/>
					   </c:import>
			        <div class="buttons">
			        	<button id="new_btn" class="btn new">신규등록</button>
			          <button id="delete_all_btn" class="btn delete">선택삭제</button>
			        </div>
			      </div>
			      
				<div class="detail_section">
			        <div class="hr"></div>
			        <div class="path">상세정보</div>
			        <form id="detail_form">
			        	<input type="hidden" id="isModify" value="false" />
				        <table class="detail_table">
				            <tr>
				              <th>직무ID</th>
				              <td><input type="text" id="jobId" name="jobId" value="" readonly/></td>
				              <th>등록자</th>
				              <td><input type="text" id="crtr" disabled value=""/></td>
				            </tr>
				            <tr>
				              <th>직무명</th>
				              <td><input type="text" id="jobNm" name="jobNm" value=""/></td>
				              <th>등록일</th>
				              <td><input type="text" id="crtDt" disabled value=""/></td>
				            </tr>
				            <tr>
				              <th>사용여부</th>
				              <td><input type="checkBox" id="useYn" name="useYn" value="Y"/></td>
				              <th>수정자</th>
				              <td><input type="text" id="mdfyr" disabled value=""/></td>
				            </tr>
				            <tr>
				              <th></th>
				              <td></td>
				              <th>수정일</th>
				              <td><input type="text" id="mdfyDt" disabled value=""/></td>
				            </tr>
				        </table>
			        </form>
			
			        <div class="buttons">
			          <button id="save_btn" class="btn save">저장</button>
			          <button id="delete_btn" class="btn delete">삭제</button>
			        </div>
			      </div>
		<jsp:include page="../include/footer.jsp"/>
		</div>
	</div>
</body>
</html>