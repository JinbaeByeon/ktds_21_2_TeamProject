<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
$().ready(function(){
	$(".detail_section").hide();
	$("#applSttsType").val("${eqpVO.applStts}").prop("selected",true);
	
	
	$("#search-btn").click(function(){
		var eqpNm =$("#search-keyword").val();
		location.href = "${context}/eqp/rent?eqpNm=" + eqpNm;
		/* movePage(0) */
		
	})
	
	
	$("#all_check").change(function(){
		$(".check_idx").prop("checked", $(this).prop("checked"));
	});
	$(".check_idx").change(function(){
		var count = $(".check_idx").length;
		var checkCount = $(".check_idx:checked").length;
		$("#all_check").prop("checked", count == checkCount);
	});
	
	
	$("#apply_all_btn").click(function(){
		var checkLen = $(".check_idx:checked").length;
		if(checkLen == 0) {
			alert("신청할 비품이 없습니다.");
			return;
		}
		var form = $("<form></form>")
		
		$(".check_idx:checked").each(function(){
			console.log($(this).val());
			form.append("<input type='hidden' name='eqpId' value='" + $(this).val() +"'>");
		});
		
		$.post("${context}/api/eqp/apply", form.serialize(), function(response){
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
	var eqpNm = $("#search-keyword").val();
	// URL 요청
	location.href = "${context}/eqp/apply?eqpNm=" + eqpNm + "&pageNo=" + pageNo;
}
</script>
</head>
<body>
<div class="main-layout">
	<jsp:include page="../include/header.jsp" />
	<div>
		<jsp:include page="../include/eqpSidemenu.jsp"/>
		<jsp:include page="../include/content.jsp" />
			<div class="path"> 비품 대여 신청</div>
			<div class="search_wrapper">
			        <div class="search_box">
			          <select>
			            <option>비품명</option>
			          </select>
			          <div class="search_field">
			          	<input type="text" id="search-keyword" class="input" value="${eqpVO.eqpNm}" placeholder="Search"/>
			          </div>
			          <div class="search-icon">
			          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
			          </div>
			        </div>
			      </div>
			      <div class="list_section">
			        <div class="total">총 ${eqpList.size() > 0 ? eqpList.get(0).totalCount : 0}건  </div>
			        <table class="list_table">
			          <thead>
						<tr>
							<th><input type="checkbox" id="all_check"/></th>
							<th>순번</th>
							<th>비품명</th>
							<th>비품종류</th>
							<th>분실상태</th>
						</tr>
			          </thead>
			          <tbody>
						<c:choose>
							<c:when test="${not empty eqpList}">
								<c:forEach items="${eqpList}"
										   var="eqp"
										   varStatus="index">
									<tr data-eqpid="${eqp.eqpId}"
										data-eqpnm="${eqp.eqpNm}"
										data-eqptp="${eqp.eqpTp}"
										data-applstts="${eqp.applStts}"
										data-appldt="${eqp.applDt}"
										data-eqpprc="${eqp.eqpPrc}"
										data-prchsdt="${eqp.prchsDt}"
										data-lossstts="${eqp.lossStts}"
										data-lossrprtdt="${eqp.lossRprtDt}"
										data-useyn="${eqp.useYn}"
										data-crtr="${eqp.crtr}"
										data-crtdt="${eqp.crtDt}"
										data-mdfyr="${eqp.mdfyr}"
										data-mdfydt="${eqp.mdfyDt}"
										data-delyn="${eqp.delYn}">
										<td>
											<input type="checkbox" class="check_idx" value="${eqp.eqpId}">
										</td>
										<td>${eqp.rnum}</td>
										<td>${eqp.eqpNm}</td>
										<td>${eqp.eqpTp}</td>
										<td>${eqp.lossStts}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="15" class="no-items">
										등록된 비품이 없습니다.
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
		                  <c:param name="path" value="${context}/eqp"/>
		               	</c:import>
			        <div class="buttons">
			          <button id="apply_all_btn" class="btn new">대여신청</button>
			        </div>
			      </div>
		<jsp:include page="../include/footer.jsp" />
	</div>
</div>
</body>
</html>