<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 생성</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">	
	
	var depId;
	var tmHd;
	var tmMbr;
	var empId;
	var tmHdId;
	var empIds = [];
	
	function addDepFn(message) {
		
		var depItems = $("#addDepIdBtn").closest(".create-group").find(".items");
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
	}
	
	function addHdEmpFn(message) {
		
		for (i = 0; i < empIds.length; i++) {
			if(empIds[i] === tmHdId) {
				empIds.splice(i, 1);
				i--;
			}
		}
		
		tmHdId = message.empid;
		
		var tmHdIdItems = $("#addTmHeadBtn").closest(".create-group").find(".items");
		if (tmHdIdItems.find("." + tmHdId).length > 0) {
			tmHd.alert(message.lnm + message.fnm + "은(는) 이미 추가된 팀장입니다.");
			return;
		}
			
		var itemDiv = tmHdIdItems.find(".head-item");
			
		var itemId = itemDiv.find("#tmHdId")
		itemId.val(tmHdId);
		itemDiv.append(itemId);
			
		var itemSpan = itemDiv.find("span");
		itemSpan.text(message.lnm + message.fnm);
		itemDiv.append(itemSpan);
			
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

	    var td = "<td>" + empId + "</td>"
	    td += "<td>" + message.pstnnm + "</td>"
	    td += "<td>" + message.lnm  + message.fnm + "</td>"
	    td += "<td>" + message.jobnm + "</td>"
	    td += "<td>" + message.phn + "</td>"

	    var rmbtn = $("<td><button class='trRemoveBtn'>X</button></td>")

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
	                location.href = "${context}/tm/list";
	            } 
	            else {
	            	alert(response.errorCode + " / " + response.message);
	            }
	        }
	    });
	}
	
	$().ready(function() {
		$("#addDepIdBtn").click(function(event) {
			event.preventDefault();
			depId = window.open("${context}/dep/search", "부서 검색", "width=500,height=500");
		});
		
		$("#addTmHeadBtn").click(function(event) {
			event.preventDefault();
			var depId = $("#depId").val();
			tmHd = window.open("${context}/emp/search/head?depId=" + depId, "팀장 검색", "width=500,height=500");
		});
		
		$("#addTmMbrBtn").click(function(event) {
			event.preventDefault();
			var depId = $("#depId").val();
			tmMbr = window.open("${context}/emp/search/mbr?depId=" + depId, "팀원검색", "width=500, height=500")
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
				<div class="path"> 팀 생성</div>
				<form id="create_form" enctype="multipart/form-data">
					<div class="create-group">
						<label for="addDepIdBtn" style="width: 180px;">부서ID</label> 
						<button id="addDepIdBtn" class="btn-dep">등록</button>
						<div class="items">
							<div class='dep-item'>
								<input type='text' class="" name='depId' id= "depId" readonly="readonly"/>
								<span id="depNm"></span>
							</div>
						</div>
					</div>
					<div class="create-group hide">
						<label for="tmId" style="width: 180px;">팀ID</label><input type="text" id="tmId" name="tmId" readonly value="" />
					</div>
					<div class="create-group hide">
						<label for="tmNm" style="width: 180px;">팀명</label><input type="text" id="tmNm" name="tmNm" value=""/>
					</div>
					<div class="create-group hide">
						<label for="addTmHeadBtn" style="width: 180px;">팀장ID</label>
						<button id="addTmHeadBtn" class="btn-tm">등록</button>
						<div class="items">
							<div class='head-item'>
								<input type="text" class="" id="tmHdId" name="tmHdId" readonly value=" " />
								<span id="tmHdNm"></span>						
							</div>
						</div>
					</div>
					<div class="create-group hide">
						<label for="tmCrtDt" style="width: 180px;">팀생성일</label><input type="date" id="tmCrtDt" name="tmCrtDt" />
					</div>
					<div class="create-group hide">
						<label for="useYn" style="width: 180px;">사용여부</label><input type="checkbox" id="useYn" name="useYn" value="Y"/>
					</div>
				
					<div class="create-group hide">
							<div>
								<label for="addTmMbrBtn">팀원</label>
								<button id="addTmMbrBtn" class="btn-primary">추가</button>
								<div class="items"></div>
							</div>
							<div class="grid">
								<table>
									<thead>
										<tr>
											<th>직원ID</th>
											<th>직급</th>
											<th>성명</th>
											<th>직무</th>
											<th>전화번호</th>
											<th>삭제</th>
										</tr>
									</thead>
									<tbody class="tmMbr-tbody">
									</tbody>
								</table>
							</div>
						</div>
				</form>	
				<div class="align-right">
					<button id="list-btn" class="btn-primary">목록</button>
					<button id="save-btn" class="btn-primary">등록</button>
				</div>
			<jsp:include page="../include/footer.jsp" />			
		</div>
	</div>
</body>
</html>