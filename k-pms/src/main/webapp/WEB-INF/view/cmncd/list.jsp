<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set scope="request" var="selected" value="sys"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(
			function() {
				$(".sidebar > ul li a").removeClass("active")
				$("#cmncd_list").addClass("active");
				
				$(".detail_section").hide();
				
				$("#all_check").change(function() {
					$(".check_idx").prop("checked", $(this).prop("checked"));
				});
				
				$(".check_idx").change(function() {
					var count = $(".check_idx").length;
					var checkCount = $(".check_idx:checked").legnth;
					$("#all_check").prop("checked", count == checkCount);
				});
				
				$(".check_idx").change(function() {
					var count = $(".check_idx").length;
					var checkCount = $(".check_idx:checked").legnth;
					$("#all_check").prop("checked", count == checkCount);
				});
								
				$(".list_table > tbody > tr").click(function() {
					$("#crtr").closest("td").prev().show();
					$("#crtr").closest("td").show();
					
					$("#crtDt").closest("td").prev().show();
					$("#crtDt").closest("td").show();
					
					$("#mdfyr").closest("td").prev().show();
					$("#mdfyr").closest("td").show();

					$("#mdfyDt").closest("td").prev().show();
					$("#mdfyDt").closest("td").show();
					$("#isModify").val("true"); // 수정모드
					$(".detail_section").show("fast");
			        $(".detail_table").show();
					var data = $(this).data();
					console.log(data);

					$("#cdId").val(data.cdid);
					$("#cdNm").val(data.cdnm);
					$("#prcdncCdId").val(data.prcdnccdid);
					$("#crtr").val(data.crtr);
					$("#crtDt").val(data.crtdt);
					$("#mdfyr").val(data.mdfyr);
					$("#mdfyDt").val(data.mdfydt);

					$("#useYn").prop("checked", data.useyn == "Y");
				});

				$("#new_btn").click(function() {
					$("#crtr").closest("td").prev().hide();
					$("#crtr").closest("td").hide();
					
					$("#crtDt").closest("td").prev().hide();
					$("#crtDt").closest("td").hide();
					
					$("#mdfyr").closest("td").prev().hide();
					$("#mdfyr").closest("td").hide();

					$("#mdfyDt").closest("td").prev().hide();
					$("#mdfyDt").closest("td").hide();
			 
					$(".detail_section").show("fast");
			        $(".detail_table").show();
			        
					$("#isModify").val("false"); // 등록모드
					$(".detail_section").show("fast");
			        $(".detail_table").show();
			        
					$("#cdId").val("");
					$("#cdNm").val("");
					$("#prcdncCdId").val("");
					$("#crtr").val("");
					$("#crtDt").val("");
					$("#mdfyr").val("");
					$("#mdfyDt").val("");

					$("#useYn").prop("checked", false);
				});
				
				$("#sel_del_btn").click(function() {
					var checkLen = $(".check_idx:checked").length;
					if(checkLen == 0) {
						alert("삭제할 코드가 없습니다.");
						return;
					}
					
					var form = $("<form></form>");
					
					
					$(".check_idx:checked").each(function() {
						console.log($(this).val());
						
						form.append("<input type='hidden' name='cdId' value='" + $(this).val() + "'>");
					});
					
					$.post("${context}/api/cmncd/delete", form.serialize(), function(response) {});
					
					location.reload();
				});

				$("#save_btn").click(
						function() {

							if ($("#isModify").val() == "false") {
								// 신규 등록
								$.post("${context}/api/cmncd/create", $(
										"#detail_form").serialize(), function(
										response) {
									if (response.status == "200 OK") {
										location.reload(); //새로고침
									} else {
										alert(response.errorCode + " / "
												+ response.message);
									}
								});
							} else {
								// 수정
								$.post("${context}/api/cmncd/update", $(
										"#detail_form").serialize(), function(
										response) {
									if (response.status == "200 OK") {
										location.reload(); //새로고침
									} else {
										alert(response.errorCode + " / "
												+ response.message);
									}
								});
							}

						});

				$("#delete_btn").click(
						function() {
							var cdId = $("#cdId").val();
							if (cdId == "") {
								alert("선택된 공통코드가 없습니다.");
								return;
							}

							if (!confirm("정말 삭제하시겠습니까?")) {
								return;
							}

							$.get("${context}/api/cmncd/delete/" + cdId,	
									function(response) {
										if (response.status == "200 OK") {
											location.reload(); //새로고침
										} else {
											alert(response.errorCode + " / "
													+ response.message);
										}
									});
						});

				$("#search-btn").click(function() {
					movePage(0);
				});

			});

	function movePage(pageNo) {
		// 전송
		// 입력값
		var searchOption = $("#cdTypes").val();
		var searchKeyword = $("#cdName").val();
		var queryString = "?searchOption=" + searchOption;
		queryString += "&searchKeyword=" + searchKeyword;
		queryString += "&pageNo=" + pageNo;
		
		// URL 요청
		location.href = "${context}/cmncd/list" + queryString;
	}
</script>
</head>
<body>

	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sysSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			<div class="path">시스템 관리 > 공통코드 관리</div>
		      <div class="search_wrapper">
		        <div class="search_box">
		          <select id="cdTypes">
		            <option value="">전체</option>
		            <c:forEach items="${cmnCdTypeList}" var="cmnCdType">
            			<option value="${cmnCdType.cdId}" ${cmnCdType.cdId eq cmnCdSearchVO.searchOption ? "selected" : ""} >${cmnCdType.cdNm}</option>
        			</c:forEach>
		          </select>
		          <div class="search_field">
		          	<input type="text" id="cdName" class="input" name="cdName" value="${cmnCdSearchVO.searchKeyword}" placeholder="코드명"/>
		          </div>
		          <div class="search-icon">
		          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
		          </div>
		        </div>
		      </div>
		      <div class="list_section">
		        <div class="total">총 ${cmnCdList.size() > 0 ? cmnCdList.get(0).getTotalCount() : 0} 건</div>
		        <table class="list_table">
		          <thead>
		            <tr>
		            	<th style="width: 2.4%; text-align:center;"><input type="checkbox" id="all_check" /></th>
		                <th style="width: 15%;">코드ID</th>
		                <th style="width: 15%;">코드명</th>
		                <th style="width: 15%;">코드유형</th>
<!-- 		                <th>등록자</th>
		                <th>등록일</th>
		                <th>수정자</th>
		                <th>수정일</th> -->
		                <th style="width: 8%;">사용여부</th>
		            </tr>
		          </thead>
		          <tbody>
		            <c:choose>
		                <c:when test="${not empty cmnCdList}">
		                    <c:forEach items="${cmnCdList}" var="cmnCd">
		                        <tr data-cdid="${cmnCd.cdId}" data-cdNm="${cmnCd.cdNm}"
		                            data-prcdnccdid="${cmnCd.prcdncCdId}" data-crtr="${cmnCd.crtr}"
		                            data-crtdt="${cmnCd.crtDt}" data-mdfyr="${cmnCd.mdfyr}"
		                            data-mdfydt="${cmnCd.mdfyDt}" data-useyn="${cmnCd.useYn}"
		                            data-prcdnccdNm="${cmnCd.prcdCmnCdVO.cdNm}">
		                            <td style="text-align:center;">
										<input type="checkbox" class="check_idx" value="${cmnCd.cdId}" />
									</td>
		                            <td>${cmnCd.cdId}</td>
		                            <td>${cmnCd.cdNm}</td>
		                            <td>${cmnCd.prcdCmnCdVO.cdNm}</td>
<%-- 		                            <td>${cmnCd.crtr}</td>
		                            <td>${cmnCd.crtDt}</td>
		                            <td>${cmnCd.mdfyr}</td>
		                            <td>${cmnCd.mdfyDt}</td> --%>
		                            <td style="padding-left: 40px; padding-right: 0px;">${cmnCd.useYn}</td>
		                        </tr>
		                    </c:forEach>
		                </c:when>
		                <c:otherwise>
		                    <tr>
		                        <td colspan="10" class="no-items">등록된 공통코드가 없습니다.</td>
		                    </tr>
		                </c:otherwise>
		            </c:choose>
		          </tbody>
		        </table>
					<c:import url="../include/pagenate.jsp">
	                  <c:param name="pageNo" value="${pageNo}"/>
	                  <c:param name="pageCnt" value="${pageCnt}"/>
	                  <c:param name="lastPage" value="${lastPage}"/>
	                  <c:param name="path" value="${context}/cmncd"/>
	               </c:import>
		        <div class="buttons">
		          <button id="new_btn" class="btn new">신규등록</button>
		          <button id="sel_del_btn" class="btn delete">선택삭제</button>
		        </div>
		      </div>
		      
			<div class="detail_section">
		        <div class="hr"></div>
		        <div class="path">상세정보</div>
		        <form id="detail_form">
		        	<input type="hidden" id="isModify" value="false" />
			        <table class="detail_table">
			            <tr>
			              <th>코드ID</th>
			              <td><input type="text" id="cdId" name="cdId" value="" placeholder="상위코드ID_코드ID"></td>
			              <th>등록자</th>
			              <td><input type="text" id="crtr" name="crtr" disabled value=""></td>
			            </tr>
			            <tr>
			              <th>코드명</th>
			              <td><input type="text" id="cdNm" name="cdNm"></td>
			              <th>등록일</th>
			              <td><input type="text" id="crtDt" disabled value=""></td>
			            </tr>
			            <tr>
			              <th>상위코드ID</th>
			              <td><input type="text" id="prcdncCdId" name="prcdncCdId"></td>
			              <th>수정자</th>
			              <td><input type="text" id="mdfyr" disabled value=""></td>
			            </tr>
			            <tr>
			              <th>사용여부</th>
			              <td><input  type="checkbox" id="useYn" name="useYn" value="Y" checked></td>
			              <th>수정일</th>
			              <td><input type="text" id="mdfyDt" disabled value=""></td>
			            </tr>
			        </table>
		        </form>
		
		        <div class="buttons">
		          <button id="save_btn" class="btn save">저장</button>
		          <button id="delete_btn" class="btn delete">삭제</button>
		        </div>
		      </div>
		      		
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>