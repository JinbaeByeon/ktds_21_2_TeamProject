<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<c:set scope="request" var="selected" value="dep"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 수정</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">	
	window.onpageshow = function(event) {
	    if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
	        location.reload();
	    }
	}
	
	var tmHd;
	var tmMbr;
	var empId;
	var tmHdId;
	var tmMbrList=[];
	var mbrIdx=0;
	
	function addHdEmpFn(message) {
		
		tmHdId = message.empid;
		
		var tmHdIdItems = $("#addTmHeadBtn").closest("tr").find(".head-item");
		if (tmHdIdItems.find("." + tmHdId).length > 0) {
			tmHd.alert(message.lnm + message.fnm + "은(는) 이미 추가된 팀장입니다.");
			return;
		}
		
		$("#tmHdId").attr("value", tmHdId);
		
		var itemDiv = tmHdIdItems.find(".head-item");
		
		var itemId = itemDiv.find("#tmHdId");
		var empIdList = $(".tmMbr-tbody").children("tr").not(".tmHd-tr");
		empIdList.each(function(){
			if($(this).data("empid") == tmHdId){
				$(this).remove();
				$(".tmMbr-tbody").find(".emp-tr").each(function(i, tr) {
		            $(tr).data("index", i);
		            $(tr).find(".emp-item").attr("name", "tmMbrList[" + i + "].empId");
		        });
				if($(this).find("input[type=hidden]").length > 0){
					--mbrIdx;
				}
				return;
			}
		});
		
		itemId.val(tmHdId);
		itemDiv.append(itemId);
			
		var itemSpan = itemDiv.find("span");
		itemSpan.text(message.lnm + message.fnm);
		itemDiv.append(itemSpan);
			
		var hdTr = $(".tmHd-tr");
		
		var itemEmpId = hdTr.find(".emp-hd-item");
		console.log(itemEmpId.length);
		if(itemEmpId.length == 0){
			itemEmpId = $("<input type='hidden' name='tmMbrList[" + mbrIdx++ + "].empId' class='emp-hd-item'/>");
		}
		itemEmpId.val(tmHdId);
		
		var td = hdTr.find("td");
		hdTr.attr("class", "tmHd-tr " + tmHdId);
        td.eq(0).text();
        td.eq(1).text("팀장");
        td.eq(2).text(message.pstnnm);
        td.eq(3).text(tmHdId);
        td.eq(4).text(message.lnm + message.fnm);
        td.eq(5).text(message.jobnm);
        td.eq(6).text(message.brthdy);
        td.eq(7).text(message.eml);
        td.eq(8).text(message.phn);
        td.eq(9).text(message.pstnprd);
		
		$("#tmHdId").attr("class", tmHdId);
		$("#tmHdId").val(tmHdId);
		$("#tmHdNm").text(message.lnm + message.fnm);
		
		hdTr.prepend(itemEmpId);
		
		tmHdIdItems.append(itemDiv);
		tmHd.close();
	}
	
	function addEmpFn(message) {

	    var empItems = $(".tmMbr-tbody");
	    empId = message.empid;
	    if (empItems.find("tr." + empId).length > 0) {
	        tmMbr.alert(message.lnm + message.fnm + "은(는) 이미 추가된 팀원입니다.");
	        return;
	    }

	    var itemId = $("<input type='hidden' name='tmMbrList[" + mbrIdx + "].empId' class='emp-item'/>");
	    itemId.val(empId);
	    
	    var empTr = $("<tr class='emp-tr " + empId + "' data-empid='" + empId + "' data-index='" + mbrIdx++ + "'></tr>");
		
	    var td = "<td></td>"
	    td += "<td>" + "팀원" + "</td>"
	    td += "<td>" + message.pstnnm + "</td>"
	    td += "<td>" + empId + "</td>"
	    td += "<td>" + message.lnm  + message.fnm + "</td>"
	    td += "<td>" + message.jobnm + "</td>"
	    td += "<td>" + message.brthdy + "</td>"
	    td += "<td>" + message.eml + "</td>"
	    td += "<td>" + message.phn + "</td>"
	    td += "<td>" + message.pstnprd + "</td>"

	    var rmbtn = $("<td><button class='trRemoveBtn'>X</button></td>")

	    rmbtn.click(function() {
	        var empTrToRemove = $(this).closest(".emp-tr");
	        var empIndexToRemove = empTrToRemove.data("index");
	        empTrToRemove.remove();
	        var cnt = 0;
	        $(".emp-tr").each(function(i, tr) {
	            $(tr).data("index", i);
	            $(tr).find(".emp-item").attr("name", "tmMbrList[" + i + "].empId");
	            ++cnt;
	        });
	        
	        $(".tmHd-tr").find(".emp-hd-item").attr("name", "tmMbrList[" + cnt + "].empId");
	        
	        --mbrIdx;
	    });

	    empItems.append(empTr);
	    empTr.append(itemId);
	    empTr.append(td);
	    empTr.append(rmbtn);

	}
	
	$().ready(function() {
		$(".sidebar > ul li a").removeClass("active")
		$("#tm_list").addClass("active");
		
		$("#addTmHeadBtn").click(function(event) {
			event.preventDefault(); 
			var depId = $("#depId").val();
			tmHd = window.open("${context}/emp/search/head?depId=" + depId, "팀장 검색", "width=600,height=700");
		});
		
		$("#addTmMbrBtn").click(function(event) {
			event.preventDefault();
			var depId = $("#depId").val();
			tmMbr = window.open("${context}/emp/search?depId=" + depId, "팀원검색", "width=600, height=700")
		});
		
		$("#list-btn").click(function(response) {
			location.href = "${context}/tm/list"
		});
		
		$("#save-btn").click(function() {
			var tmId = $("#tmId").val();
			var tmHdId = $("#tmHdId").val();
			
			$.post("${context}/api/tm/update/" + tmId, $("#create_form").serialize(), function(response) {
				if (response.status == "200 OK") {
					
					location.href = "${context}" + response.redirectURL;
				}
				else {
					alert(response.message);
				}
			});
		});
		
		$("#all_check").change(function() {
			
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		$(".check_idx").change(function() {
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("#delete_all_btn").click(function() {
			var checkLen = $(".check_idx:checked").length;
			if (checkLen == 0) {
				alert("팀원이 선택되지 않았습니다.");
				return;
			}
			if (!confirm("정말 삭제하시겠습니까?")) { 
			return;
			}
			
			var form = $("<form></form>");
			
			$(".check_idx:checked").each(function() {
				console.log($(this).val());
				form.append("<input type='hidden' name='tmMbrId' value='" + $(this).val() + "'>");
				
			});
			
			$.post("${context}/api/tmmbr/delete", form.serialize(), function(response) {
				if (response.status == "200 OK") {
					location.reload();
				}
				else {
					alert(response.message);
				}
			});
		});
		
		$("#delete-btn").click(function() {
			var tmId = $("#tmId").val();
			if(!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			$.get("${context}/api/tm/delete/" + tmId, function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}/tm/list"
				}
				else {
					alert(response.message);
				}
			});
		});
		
		$(document).on("click", ".tmMbr-tbody .emp-tr", function() {
			var empId = $(this).closest("tr").data("empid");
			detailWindow = window.open("${context}/emp/detail/"+ empId,"사원 정보","width=600, height= 700, top= 100, left = 500");
		});
		
		$(".tmMbr-tbody > tr > td").not(".check").click(function() {
			var empId = $(this).closest("tr").data("empid");
			detailWindow = window.open("${context}/emp/detail/"+ empId,"사원 정보","width=600, height=700, top= 100, left = 500");
		});
	});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/depSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />		
				<div class="path">팀관리 > 팀 수정</div>
				<form id="create_form" enctype="multipart/form-data">
					<table class="detail_page detail_table">
		                <tr>
		                    <th>부서명</th>
		                    <td><input type="text" id="depNm" name="depNm" value="${tmVO.depIdDepVO.depNm}" readonly/></td>
		                </tr>
		                <tr>
		                    <th>부서 관리번호</th>
		                    <td><input type="text" id="depId" name="depId" value="${tmVO.depIdDepVO.depId}" readonly/></td>
		                </tr>
		                <tr>
		                    <th>팀명</th>
		                    <td><input type="text" id="tmNm" name="tmNm" value="${tmVO.tmNm}"/></td>
		                </tr>
		                <tr>
		                    <th>팀 관리번호</th>
		                    <td><input type="text" id="tmId" name="tmId" value="${tmVO.tmId}" readonly/></td>
		                </tr>
		                <tr>
		                    <th>팀장ID</th>
		                    <td>
		                    	<button id="addTmHeadBtn" class="btn regist">등록</button>
									<div class="items">
										<div class='head-item'>
											<input type="text" class="" id="tmHdId" name="tmHdId" readonly value="${tmVO.tmHdId}" />
											<span id="tmHdNm">${tmVO.tmHdEmpVO.lNm}${tmVO.tmHdEmpVO.fNm}</span>			
										</div>
									</div>
		                    </td>
		                </tr>
		                <tr>
		                    <th>팀 생성일</th>
		                    <td><input type="date" id="tmCrtDt" name="tmCrtDt" value="${tmVO.tmCrtDt}"/></td>
		                </tr>
		                <tr>
		                    <th>사용여부</th>
		                    <td><input type="checkbox" id="useYn" name="useYn" value="Y" ${tmVO.useYn eq 'Y' ? 'checked' : ''}/></td>
		                </tr>
		                <tr>
		                    <th>소속 팀원</th>
		                    <td>
		                      	<div>
									<button id="addTmMbrBtn" class="btn regist add">추가</button>
								</div>
		                        <table class="list_table inner_table">
			                        <thead>
			                            <tr>
											<th><input type="checkbox" id="all_check" /></th>
											<th>팀 직책</th>
											<th>직급</th>
											<th>직원ID</th>
											<th>이름</th>
											<th>직무</th>
											<th>생년월일</th>
											<th>이메일</th>
											<th>전화번호</th>
											<th>직급연차</th>
			                            </tr>
			                        </thead>
			                        <tbody class="tmMbr-tbody">
										<tr class="tmHd-tr ${tmHdEmpVO.empId}" data-empid="${tmHdEmpVO.empId}">
											<td></td>
											<td>팀장</td>
											<td>${tmHdEmpVO.pstn.pstnNm}</td>
											<td>${tmHdEmpVO.empId}</td>
											<td>${tmHdEmpVO.lNm}${tmHdEmpVO.fNm}</td>
											<td>${tmHdEmpVO.job.jobNm}</td>
											<td>${tmHdEmpVO.brthdy}</td>
											<td>${tmHdEmpVO.eml}</td>
											<td>${tmHdEmpVO.phn}</td>
											<td>${tmHdEmpVO.pstnPrd}</td>
										</tr>
										<c:choose>
											<c:when test="${not empty tmVO.tmMbrList}">
												<c:forEach items="${tmVO.tmMbrList}" 
															var="tmMbr">
													<c:if test="${tmMbr.empId != tmVO.tmHdId}">
														<tr class="${tmMbr.empId}" data-empid="${tmMbr.empId}">
															<td class="check">
																<input type="checkbox" class="check_idx" value="${tmMbr.tmMbrId}"/>
															</td>
															<td>팀원</td>
															<td>${tmMbr.empVO.pstn.pstnNm}</td>
															<td>${tmMbr.empId}</td>
															<td>${tmMbr.empVO.lNm}${tmMbr.empVO.fNm}</td>
															<td>${tmMbr.empVO.job.jobNm}</td>
															<td>${tmMbr.empVO.brthdy}</td>
															<td>${tmMbr.empVO.eml}</td>
															<td>${tmMbr.empVO.phn}</td>
															<td>${tmMbr.empVO.pstnPrd}</td>
														</tr>
													</c:if>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<td colspan="10" class="no-items">
													등록된 팀원이 없습니다.
												</td>
											</c:otherwise>
										</c:choose>
			                        </tbody>
			                    </table>
				                <div class="buttons">
									<button id="delete_all_btn" class="btn delete">팀원 삭제</button>
								</div>              
							</td>
						</tr>
		            </table>
        		</form>	
		        <div class="buttons">
					<button id="list-btn" class="btn new">목록</button>
					<button id="save-btn" class="btn save">저장</button>
					<button id="delete-btn" class="btn delete">삭제</button>
		        </div>
			<jsp:include page="../include/footer.jsp" />			
		</div>
	</div>
</body>
</html>