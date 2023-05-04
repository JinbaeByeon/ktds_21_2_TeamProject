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
<title>팀 생성</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">	
	window.onpageshow = function(event) {
	    if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
	        location.reload();
	    }
	}
	
	var depId;
	var tmHd;
	var tmMbr;
	var empId;
	var tmHdId;
	var empIds = [];
	
	function addDepFn(message) {
		
		var depItems = $("#addDepIdBtn").closest("tr").find(".items");
		if (depItems.find("." + message.depid).length > 0) {
			depId.alert(message.depnm + "은(는) 이미 추가된 부서입니다."); 
			return;
		}
		
		var itemDiv = depItems.find(".dep-item");
			
		var itemId = itemDiv.find("#depId");
		itemId.val(message.depid);
		itemDiv.append(itemId);
		
		var itemSpan = itemDiv.find("span");
		itemSpan.text(message.depnm);
		itemDiv.append(itemSpan);
		
		$("#depId").attr("class", message.depid);
		
		depItems.append(itemDiv);
		
		depId.close();
		$(".hide").removeClass("hide");
		
		$(".detail_table tr:gt(0)").show("fast");
	}
	
	function addHdEmpFn(message) {
		
	
		empIds = [];
		$(".emp-tr").remove();
		
		tmHdId = message.empid;
		
		var tmHdIdItems = $("#addTmHeadBtn").closest("tr").find(".items");
		if (tmHdIdItems.find("." + tmHdId).length > 0) {
			tmHd.alert(message.lnm + message.fnm + "은(는) 이미 추가된 팀장입니다.");
			return;
		}
			
		var itemDiv = tmHdIdItems.find(".head-item");
			
		var itemId = itemDiv.find("#tmHdId");
		itemId.val(tmHdId);
		itemDiv.append(itemId);
			
		var itemSpan = itemDiv.find("span");
		itemSpan.text(message.lnm + message.fnm);
		itemDiv.append(itemSpan);
		
		var empTr = $(".emp-hd-tr");  
	    if (empTr.length > 0) {
	    	
	        var td = empTr.find("td");
	        empTr.attr("class", "emp-hd-tr " + tmHdId);
	        td.eq(0).text("팀장");
	        td.eq(1).text(message.pstnnm);
	        td.eq(2).text(tmHdId);
	        td.eq(3).text(message.lnm + message.fnm);
	        td.eq(4).text(message.jobnm);
	        td.eq(5).text(message.brthdy);
	        td.eq(6).text(message.eml);
	        td.eq(7).text(message.phn);
	        td.eq(8).text(message.pstnprd);
	    } else {
	    	var empTr = $("<tr class='emp-hd-tr " + tmHdId + "'></tr>");
	        var td = "<td>" + "팀장" + "</td>"
	        td += "<td>" + message.pstnnm + "</td>"
		    td += "<td>" + tmHdId + "</td>"
		    td += "<td>" + message.lnm  + message.fnm + "</td>"
		    td += "<td>" + message.jobnm + "</td>"
		    td += "<td>" + message.brthdy + "</td>"
		    td += "<td>" + message.eml + "</td>"
		    td += "<td>" + message.phn + "</td>"
		    td += "<td>" + message.pstnprd + "</td>"

	        empTr.append(td);
	        $(".tmMbr-tbody").append(empTr);
	    }
			
		$("#tmHdId").attr("class", tmHdId);
			
		tmHdIdItems.append(itemDiv);
			
		tmHd.close();
		empIds.push(tmHdId);
		

	}
	
	function addMbrFn(message) {
		
	    var empItems = $(document).find(".tmMbr-tbody");
	    empId = message.empid;

	    if (empItems.find("." + empId).length > 0) {
	        tmMbr.alert(message.lnm + message.fnm + "은(는) 이미 추가된 팀원입니다.");
	        return;
	    }

	    var nextIndex = empIds.length;
	    var itemId = $("<input type='hidden' name='tmMbrList[" + nextIndex + "].tmMbrId' class='emp-item'/>");
	    itemId.val(empId);

	    var empTr = $("<tr class='emp-tr " + empId + "' data-index='" + nextIndex + "'></tr>");

	    var td = "<td>" + "팀원" + "</td>"
	    td += "<td>" + message.pstnnm + "</td>"
	    td += "<td>" + empId + "</td>"
	    td += "<td>" + message.lnm  + message.fnm + "</td>"
	    td += "<td>" + message.jobnm + "</td>"
	    td += "<td>" + message.brthdy + "</td>"
	    td += "<td>" + message.eml + "</td>"
	    td += "<td>" + message.phn + "</td>"
	    td += "<td>" + message.pstnprd + "</td>"

	    var rmbtn = $("<td><button class='trRemoveBtn'><span class='material-symbols-outlined'>delete</span></button></td>")

	    rmbtn.click(function() {
	        var empTrToRemove = $(this).closest(".emp-tr");
	        var empIndexToRemove = empTrToRemove.data("index");
	        empIds.splice(empIndexToRemove, 1);
	        empTrToRemove.remove();
	        $(".emp-tr[data-index]").each(function(i, tr) {
	            $(tr).data("index", i);
	            $(tr).find(".emp-item").attr("name", "tmMbrList[" + i + "].tmMbrId");
	        });
	    });
		
	    empItems.append(empTr);
	    empTr.append(itemId);
	    empTr.append(td);
	    empTr.append(rmbtn);

	    empIds.push(empId);

	}

	
	function createTmmbr(tmId, empId) {
	    $.ajax({
	        url: "${context}/api/tmmbr/create",
	        type: "POST",
	        data: {tmId: tmId, empId: empId},
	        success: function(response) {
	            if (response.status == "200 OK") {
	            } 
	            else {
	            	alert(response.errorCode + " / " + response.message);
	            }
	        }
	    });
	}
	
	$().ready(function() {
		$(".sidebar > ul li a").removeClass("active")
		$("#tm_list").addClass("active");
		
		$(".detail_table tr:gt(0)").hide();
		
		$("#addDepIdBtn").click(function(event) {
			event.preventDefault();
			depId = window.open("${context}/dep/search", "부서 검색", "width=500,height=600");
		});
		
		$("#addTmHeadBtn").click(function(event) {
			event.preventDefault();
			var depId = $("#depId").val();
			tmHd = window.open("${context}/emp/search/head?depId=" + depId, "팀장 검색", "width=600,height=700");
		});
		
		$("#addTmMbrBtn").click(function(event) {
			event.preventDefault();
			var depId = $("#depId").val();
			tmMbr = window.open("${context}/emp/search/mbr?depId=" + depId, "팀원검색", "width=600, height=700")
		});
		
		$("#list-btn").click(function(response) {
			location.href = "${context}/tm/list"
		});
		
		$("#save-btn").click(function() {
			  var ajaxUtil = new AjaxUtil();
			    
			  ajaxUtil.upload("#create_form","${context}/api/tm/create",function(response){
			    if (response.status == "200 OK") {
			    	var tmId = response.data;
			    	console.log(tmId);
				   	
			    	empIds.forEach(function(empId) {
			    		
			    	createTmmbr(tmId, empId);
			    		
			    	location.href = "${context}/tm/detail/" + tmId;
			    	});
			    	
			    } 
			    else {
			      alert(response.errorCode + " / " + response.message);
			    }
				
			  });
			  
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
			<div class="path">팀 생성</div>
				<form id="create_form" enctype="multipart/form-data">
					<table class="detail_table">
		                <tr>
		                    <th>부서 관리번호</th>
		                    <td>
		                    	<button id="addDepIdBtn" class="btn regist">등록</button>
		                    	<div class="items">
					            <div class='dep-item'>
					                <input type='text' class="" name='depId' id= "depId" readonly="readonly"/>
					                <span id="depNm"></span>
					            </div>
					        </div>
		                    </td>
		                </tr>
		                <tr>
		                    <th>팀명</th>
		                    <td><input type="text" id="tmNm" name="tmNm" value=""/></td>
		                </tr>
		                <tr>
		                    <th>팀장ID</th>
		                    <td>
						        <button id="addTmHeadBtn" class="btn regist">등록</button>
						        <div class="items">
						            <div class='head-item'>
						                <input type="text" class="" id="tmHdId" name="tmHdId" readonly value=" " />
						                <span id="tmHdNm"></span>						
						            </div>
						        </div>
		                    </td>
		                </tr>
		                <tr>
		                    <th>팀생성일</th>
		                    <td><input type="date" id="tmCrtDt" name="tmCrtDt" /></td>
		                </tr>
		                <tr>
		                    <th>사용여부</th>
		                    <td><input type="checkbox" id="useYn" name="useYn" value="Y"/></td>
		                </tr>
		                <tr>
		                    <th>팀원</th>
		                    <td>
		                    	<div>
									<button id="addTmMbrBtn" class="btn regist add">팀원 추가</button>
									<div class="items"></div>
								</div>
		                        <table class="list_table inner_table">
		                        <thead>
			                        <tr>
			                            <th>팀 직책</th>
										<th>직급</th>
										<th>직원ID</th>
										<th>성명</th>
										<th>직무</th>
										<th>생년월일</th>
										<th>이메일</th>
										<th>전화번호</th>
										<th>직급연차</th>
			                        </tr>
		                        </thead>
		                        <tbody class="tmMbr-tbody"></tbody>
		                    </table>
		                    </td>
		                </tr>
		            </table>
				</form>
        <div class="buttons">
          <button id="list-btn" class="btn new">목록</button>
          <button id="save-btn" class="btn regist">등록</button>
        </div>
			<jsp:include page="../include/footer.jsp" />			
		</div>
	</div>
</body>
</html>