<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 검색 페이지</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		
		$("#cancel_btn").click(function() {
			window.close();	
		});
	
		$(".grid tbody tr").click(function() {
			var data = $(this).data();
			location.href = "${context}/tmmbr/search?tmId=" + data.tmid + "&tmNm="+data.tmnm;
		});
	
	});

</script>
</head>
<body>
	<div class="container search_page">
    <h2>팀 검색</h2>
    <div class="search_wrapper">
        <div class="search_box">
            <select>
            <option>팀명</option>
            </select>
            <div class="search_field">
            <input type="text" name="tmNm" class="input" value="${tmNm}" placeholder="Search"/>
            </div>
            <div class="search-icon">
                <button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
            </div>
        </div>
    </div>
    <div class="total">총 ${tmList.size() > 0 ? tmList.size() : 0}건</div>
    <table class="list_table search_table">
        <thead>
            <tr>
                 <th>팀명</th>
                 <th>팀ID</th>
            </tr>
        </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty tmList}">
                        <c:forEach items="${tmList}" var="tm">
                            <tr data-tmid="${tm.tmId}"
                                data-tmnm="${tm.tmNm}">
                                <td>${tm.tmNm}</td>
                                <td>${tm.tmId}</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="2">검색된 팀이 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
    </table>
    <div class="buttons">
        <button id="cancel_btn" class="btn delete">취소</button>
    </div>
</div>
</body>
</html>