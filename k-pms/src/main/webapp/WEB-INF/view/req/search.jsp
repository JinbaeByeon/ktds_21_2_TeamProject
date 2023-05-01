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
<title>요구사항 검색 페이지</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		$(".grid > table > tbody > tr").click(function(){
			$(this).find(".radio_idx").prop("checked",true);
		});
		
		$("#cancel_btn").click(function(){
			window.close();	
		});
		
		$("#regist_btn").click(function(){
			var radiobox = $(".radio_idx:checked");
			if(radiobox.length == 0) {
				alert("요구사항을 선택하세요");
				return;
			}

			var req = radiobox.closest("tr").data();
			opener.addReqFn(req);
		});
	});
</script>
</head>
<body>
	 <div class="container search_page">
		<h2>요구사항 검색</h2>
        <div class="search_wrapper">
        	<form>
	            <div class="search_box">
	                <select>
	                <option>프로젝트명</option>
	                <option>고객사명</option>
	                </select>
	                <div class="search_field">
	                	<input type="text" name="prjNm" class="input" value="${prjNm}"/>
	                </div>
	                <div class="search-icon">
		          		<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
		          </div>
	            </div>
            </form>
        </div>
        <div class="total">총 ${reqList.size() > 0 ? reqList.size() : 0}건</div>
        <table class="list_table search_table">
            <thead>
                <tr>
                    <th></th>
                    <th>제목</th>
                    <th>진행상태</th>
                    <th>등록자</th>
                    <th>시작일</th>
                    <th>종료일</th>
                    <th>프로젝트</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty reqList}">
                        <c:forEach items="${reqList}" var="req">
                            <tr data-reqid = "${req.reqId}"
                                data-reqttl = "${req.reqTtl}">
                                <td>
                                    <input type="radio" name ="radio_idx" class="radio_idx" value="${req.reqId}" />
                                </td>
                                <td>${req.reqTtl}</td>
                                <td>${req.prcsStts}</td>
                                <td>${req.crtr}</td>
                                <td>${req.strtDt}</td>
                                <td>${req.expctEndDt}</td>
                                <td>${req.reqPrjVO.prjNm} (${req.prjId})</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" class="">검색된 요구사항이 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <div class="buttons">
	        <button id="cancel_btn" class="btn delete">취소</button>
	        <button id="regist_btn" class="btn primary">등록</button>
        </div>
    </div>
</body>
</html>