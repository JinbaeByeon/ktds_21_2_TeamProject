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
<title>직원 검색 페이지</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		$("#all_check").change(function(){
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
		$(".check_idx").click(function(e){
			$(this).prop("checked",$(this).prop("checked")==false);
		});
		$(".list_table > tbody > tr > td").click(function(){
			var check_idx = $(this).closest("tr").find(".check_idx");
			check_idx.prop("checked",check_idx.prop("checked")==false);
			checkIndex();
		});
		
		$("#cancel_btn").click(function(){
			window.close();	
		});
		
		$("#regist_btn").click(function(){
			var checkbox = $(".check_idx:checked");
			if(checkbox.length == 0) {
				alert("직원을 선택하세요");
				return;
			}
			checkbox.each(function(){
				var emp = $(this).closest("tr").data();
				opener.addEmpFn(emp);
			});
		});
	});
</script>
</head>
<body>
<div class="container search_page">
    <h2>직원검색</h2>
    <div class="search_wrapper">
    	<form>
    	<input type="hidden" name="depId" value="${depId}">
        <div class="search_box">
            <select>
            <option>직원명</option>
            </select>
            <div class="search_field">
           	 <input type="text" name="fNm" class="input" value="${fNm}"/>
            </div>
            <div class="search-icon">
                <button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
            </div>
        </div>
        </form>
    </div>
    <div class="total">총 ${empList.size() > 0 ? empList.size() : 0}건</div>
    <table class="list_table search_table">
        <thead>
            <tr>
					<th>
						<input type="checkbox" id="all_check" />
					</th>
					<th>직원ID</th>
                    <th>직급</th>
                    <th>성명</th>
                    <th>직무</th>
                    <th>부서 관리번호</th>
            </tr>
        </thead>
            <tbody>
					<c:choose>
						<c:when test="${not empty empList}">
							<c:forEach items="${empList}" var="emp">
								<tr data-empid = "${emp.empId}"
	                                data-fnm = "${emp.fNm}"
	                                data-lnm = "${emp.lNm}"
	                                data-pstnnm = "${emp.pstn.pstnNm}"
	                                data-jobnm = "${emp.job.jobNm}"
	                                data-phn = "${emp.phn}"
	                                data-brthdy = "${emp.brthdy}"
	                                data-eml = "${emp.eml}"
	                                data-pstnprd = "${emp.pstnPrd}">
									<td class="check">
										<input type="checkbox" class="check_idx" value="${emp.empId}" />
									</td>
									<td>${emp.empId}</td>
                                	<td>${emp.pstn.pstnNm}</td>
									<td>${emp.lNm}${emp.fNm}</td>
									<td>${emp.job.jobNm}</td>
									<td>${emp.depId} </td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="6" class="no-items">검색된 직원이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
            </tbody>
    </table>
    <div class="buttons">
        <button id="regist_btn" class="btn regist">등록</button>
        <button id="cancel_btn" class="btn delete">취소</button>
    </div>
</div>
</body>
</html>