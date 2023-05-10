<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set scope="request" var="selected" value="dep"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀원 조회 및 등록</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	window.onpageshow = function(event) {
	    if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
	        location.reload();
	    }
	}
	var empId;
	var tmMbr;
	var tmMbrList=[];
	var nextIndex=0;
		
	function addMbrFn(message) {
	
	    var empItems = $(document).find(".tmMbr-tbody");
	    empId = message.empid;
	
	    if (empItems.find("." + empId).length > 0) {
	        tmMbr.alert(message.lnm + message.fnm + "은(는) 이미 추가된 팀원입니다.");
	        return;
	    }
	
	    var itemId = $("<input type='hidden' name='tmMbrList[" + nextIndex + "].empId' class='emp-item'/>");
	    itemId.val(empId);
	
	    var empTr = $("<tr class='emp-tr " + empId + "' data-index='" + nextIndex++ + "' data-empid='" + empId 
				+ "'></tr>");
	
	    var td = "<td></td>"
	    td += "<td>" + empId + "</td>"
	    td += "<td>" + message.pstnnm + "</td>"
	    td += "<td>" + message.lnm  + message.fnm + "</td>"
	    td += "<td>" + message.jobnm + "</td>"
	
	    var rmbtn = $("<td><button class='trRemoveBtn'><span class='material-symbols-outlined'>delete</span></button></td>")
	
	    rmbtn.click(function() {
	        var empTrToRemove = $(this).closest(".emp-tr");
	        var empIndexToRemove = empTrToRemove.data("index");
	        empTrToRemove.remove();
	        $(".emp-tr[data-index]").each(function(i, tr) {
	            $(tr).data("index", i);
	            $(tr).find(".emp-item").attr("name", "tmMbrList[" + i + "].empId");
	        });
	        --nextIndex;
	    });
	
	    empItems.append(empTr);
	    empTr.append(itemId);
	    empTr.append(td);
	    empTr.append(rmbtn);
	
	}
	
	var detailWindow
	
	$().ready(function() {
		$(".sidebar > ul li a").removeClass("active")
		$("#dep_mbrlist").addClass("active");
		
		var activeDepId = ""
		var activeTmId = ""
		
		$(".dep-tbody tr").click(function() {
			activeTmId = "";
			$(".tmMbr-tbody").empty();
			$("#tmMbr-count").text("총 0건");
			$(".dep-tbody").find("tr").removeClass("active");
			$(this).toggleClass("active");
			activeDepId = $(this).data("depid");
			
			$(".tm-tbody").find("tr").remove();
			
			$.get("${context}/api/tm/list/" + activeDepId, function(response) {
				for (var i in response.data) {
					var tmId = response.data[i].tmId;
					var depId = response.data[i].depId;
					var tmNm = response.data[i].tmNm;
					var tmHdId = response.data[i].tmHdId;
					var lNm = (response.data[i].tmHdEmpVO.lNm == null) ? "" : response.data[i].tmHdEmpVO.lNm;
					var fNm = (response.data[i].tmHdEmpVO.fNm == null) ? "" : response.data[i].tmHdEmpVO.fNm;
					
					var tr = $("<tr data-tmid='" + tmId + "'></tr>");
					var td = "<td>" + tmId + "</td>"
					td += "<td>" + tmNm + "</td>"
					td += "<td>" + tmHdId + "</td>"
					td += "<td>" + lNm + fNm + "</td>"
					
					$(".tm-tbody").append(tr);
					tr.append(td);
				}
			}).done(function() {
				var tmCount = $(".tm-tbody tr").length;
				$("#tm-count").text("총 " + tmCount + "건");
			    $(".tm-tbody tr:first-child").click();
			});
		});
		
		$(document).on("click", ".tm-tbody tr", function() {
			$("#all_check").prop("checked", false);
			$(".tm-tbody").find("tr").removeClass("active");
			$(this).addClass("active");
			activeTmId = $(".tm-tbody .active").data("tmid");
			
			$(".tmMbr-tbody").find("tr").remove();

			$.get("${context}/api/tmmbr/lists/" + activeTmId, function(response) {
				for (var i in response.data) {
					var tmMbrId = response.data[i].tmMbrId;
					var tmId = response.data[i].tmId;
					var empId = response.data[i].empId;
					var fNm = (response.data[i].empVO.fNm == null) ? "" : response.data[i].empVO.fNm;
					var lNm = (response.data[i].empVO.lNm == null) ? "" : response.data[i].empVO.lNm;
					var tmNm = response.data[i].tmVO.tmNm;
					var jobNm = response.data[i].empVO.job.jobNm;
					var pstnNm = response.data[i].empVO.pstn.pstnNm;
					
					var tr = $("<tr data-tmmbrid='" + tmMbrId + "'data-empid='" + empId 
							+ "'data-tmid='" + tmId + "'data-fnm='" + fNm + "'data-lnm='" 
							+ lNm + "'data-tmnm='" + tmNm + "' data-jobnm='" + jobNm + "' data-pstnnm='" + pstnNm + "'></tr>");
					var td = "<td class='check'><input type='checkbox' class='check-idx' value=" + tmMbrId + " /></td>"
					td += "<td>" + empId + "</td>"
					td += "<td>" + pstnNm + "</td>"
					td += "<td>" + lNm + fNm + "</td>"
					td += "<td>" + jobNm + "</td>"
					
					$(".tmMbr-tbody").append(tr);	
					tr.append(td);
				}
			}).done(function() {
				 var tmMbrCount = $(".tmMbr-tbody tr").length;
				 $("#tmMbr-count").text("총 " + tmMbrCount + "건");
			});

		});
		
		$("#all_check").change(function() {
			$(".check-idx").prop("checked", $(this).prop("checked"));
			
		});
		
		$(document).on("change",".check-idx" , function() {
			var count = $(".check-idx").length;
			var checkCount = $(".check-idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("#delete-btn").click(function() {
		    var checkLen = $(".check-idx:checked").length;
		    if (checkLen == 0) {
		        alert("팀원이 선택되지 않았습니다.");
		        return;
		    }
		    if (confirm("선택된 팀원을 삭제 하시겠습니까?")) {
		    	$(".check-idx:checked").each(function() {
		            var tmMbrId = $(this).val();
		            
		            $.get("${context}/api/tmmbr/delete/" + tmMbrId, function(response) {
		            	if (response.status == "200 OK") {
		            		 $(".tmMbr-tbody").find("tr[data-tmmbrid='" + tmMbrId + "']").remove();
		            	}
		            	else {
		            		alert(response.errorCode + "/" + response.message);
		            	}
		            });
		        });
		    	
		        $("#all_check").prop("checked", false);
		    }
		});
		
		$("#addTmMbrBtn").click(function(event) {
			event.preventDefault();
			if (activeTmId == "") {
				alert("팀을 선택해주세요.");
				return;
			}
			var depId = activeDepId;
			tmMbr = window.open("${context}/emp/search/mbr?depId=" + depId +"&tmMbr.tmId=" + activeTmId, "팀원검색", "width=600, height=600")
		});
		
		$("#regist-btn").click(function() {
			var tmId = activeTmId;
			$.post("${context}/api/tm/updates/" + tmId, $("#create_form").serialize(), function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}" + response.redirectURL;
					
				}
				else {
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		
		$(document).on("click", ".tmMbr-tbody .emp-tr", function() {
			var empId = $(this).closest("tr").data("empid");
			detailWindow = window.open("${context}/emp/detail/"+ empId,"사원 정보","width=600, height= 700");
		});
		$(document).on("click", ".tmMbr-tbody > tr > td:not(.check)", function() {
			var empId = $(this).closest("tr").data("empid");
			detailWindow = window.open("${context}/emp/detail/"+ empId,"사원 정보","width=600, height= 700");
		});
		
		$("#search-btn").click(function() {
			movePage(0);
		});
	});
	 function movePage(pageNo) {
			var searchOption = $("#search-option").val();
			var searchKeyword = $("#search-keyword").val();
			var queryString = "?searchOption=" + searchOption;
			queryString += "&searchKeyword=" + searchKeyword;
			
			location.href = "${context}/dep/mbrlist" + queryString;
		}
		 
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/depSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
				<div class="search_page">
				  <div class="path">부서 관리 > 팀원 관리</div>
				  		<div class="search_wrapper">
					        <div class="search_box">
					          <select id="search-option">
					            <option value="depNm" ${depVO.searchOption eq "depNm" ? "selected": ""}>부서명</option>
								<option value="tmNm" ${depVO.searchOption eq "tmNm" ? "selected": ""}>팀명</option>
								<option value="hdNm" ${depVO.searchOption eq "hdNm" ? "selected": ""}>부서장명</option>
								<option value="tmHdNm" ${depVO.searchOption eq "tmHdNm" ? "selected": ""}>팀장명</option>
					          </select>
					          <div class="search_field">
					          	<input type="text" id="search-keyword" class="input" placeholder="Search" value="${depVO.searchKeyword}"/>
					          </div>
					          <div class="search-icon">
					          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
					          </div>
					        </div>
					      </div>
				  <form id="create_form" enctype="multipart/form-data">
				   	<h3>부서</h3>
					<div class="tableWrapper">
						 <table class="scroll_table" id="userListTable">
							 <thead>
					             <tr>
					                  <th>순번</th>
					                  <th>부서 관리번호</th>
					                  <th>부서명</th>
					                  <th>부서장ID</th>
					                  <th>부서장명</th>
					             </tr>
							  </thead>
						      <tbody class="dep-tbody">
					              <c:choose>
					                  <c:when test="${not empty depList}">
					                      <c:forEach items="${depList}"
					                                  var="dep"
					                                  varStatus="index">
					                          <tr data-depid="${dep.depId}"
					                              data-depnm="${dep.depNm}">
					                              <td>${index.index + 1}</td>
					                              <td>${dep.depId}</td>
					                              <td>${dep.depNm}</td>
					                              <td>${dep.depHdId}</td>
					                              <td>${dep.hdNmEmpVO.lNm}${dep.hdNmEmpVO.fNm}</td>
					                          </tr>
					                      </c:forEach>
					                  </c:when>
					                  <c:otherwise>
					                      <tr>
					                          <td colspan="5">검색된 부서가 없습니다.</td>
					                      </tr>
					                  </c:otherwise>
					              </c:choose>
						      </tbody>
						 </table>                      
					</div>
				    <div style="height: 30px;"></div>
				    <h3>팀</h3>
					<div class="tableWrapper">
						 <table class="scroll_table" id="userListTable">
							 <thead>
				                  <tr>
				                      <th>팀 관리번호</th>
				                      <th>팀명</th>
				                      <th>팀장ID</th>
				                      <th>팀장명</th>
				                  </tr>
							  </thead>
						      <tbody class="tm-tbody"></tbody>
						 </table>                      
					</div>
				    <div style="height: 30px;"></div>
				    <h3>팀원</h3>
					<div class="tableWrapper">
						 <table class="scroll_table" id="userListTable">
							 <thead>
								  <tr>
				                      <th class="input"><input type="checkbox" id="all_check" /></th>
				                      <th>직원ID</th>
				                      <th>직급</th>
				                      <th>직원명</th>
				                      <th>직무명</th>
				                      <th></th>
				                  </tr>
							  </thead>
						      <tbody class="tmMbr-tbody"></tbody>
						 </table>                      
					</div>
				</form>

				    <div class="buttons">
					<button id="addTmMbrBtn" class="btn edit">팀원 추가</button>
					<button id="regist-btn" class="btn regist">등록</button>
					<button id="delete-btn" class="btn delete">팀원 삭제</button>
				    </div>
				</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>