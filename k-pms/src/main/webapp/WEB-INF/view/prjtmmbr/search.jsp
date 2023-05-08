<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀원 검색</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		$("#search-btn").click(function() {
		var prjId = $("#search-prjId").val();
			location.href = "${context}/prjtmmbr/search?prjId=" + prjId + "&nm=" + $("#search-prjTmMbrNm").val();
		});
		
		$("#cancel-btn").click(function() {
			window.close();
		});
		
		$("#regist-btn").click(function() {
			var checkOne = $(".check-idx:checked");
			
			if (checkOne.length == 0) {
				alert("팀원을 선택하세요");
				return;
			}
			
			checkOne.each(function() {
				var each = $(this).closest("tr").data();
				console.log(each);
				opener.addPrjTmMbrFn(each);
			});
			window.close();
		});
		
	});
</script>
</head>
<body>
	<div class="container search_page">
    <h2>프로젝트 팀원 검색</h2>
    <div class="search_wrapper">
        <div class="search_box">
        	<input type="hidden" id="search-prjId" value="${prjTmMbrSearchVO.prjId}"/>
            <select>
            <option>프로젝트 팀원명</option>
            </select>
            <div class="search_field">
            <input type="text" id="search-prjTmMbrNm" class="input" value="${prjTmMbrSearchVO.nm}" placeholder="Search"/>
            </div>
            <div class="search-icon">
	          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
	          </div>
        </div>
    </div>
    <div class="total">총 ${tmMbrList.size() > 0 ? tmMbrList.size() : 0}건</div>
    <table class="list_table search_table">
        <thead>
            <tr>
                <th></th>
                 <th>직원ID</th>
                 <th>이름</th>
                 <th>권한</th>
            </tr>
        </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty ptmList}">
                        <c:forEach items="${ptmList}"
                                    var="ptm">
                            <tr 
                                data-prjtmmbrid="${ptm.prjTmMbrId}"
                                data-empid="${ptm.tmMbrVO.empId}"
                                data-fnm="${ptm.tmMbrVO.empVO.fNm}"
                                data-lnm="${ptm.tmMbrVO.empVO.lNm}"
                                data-prjpstn="${ptm.prjPstn}" >
                                <td>
                                    <input type="radio" class="check-idx" name="check-one" value="${ptm.prjTmMbrId}" />
                                </td>
                                <td>${ptm.tmMbrVO.empId}</td>
                                <td>${ptm.tmMbrVO.empVO.lNm}${ptm.tmMbrVO.empVO.fNm}</td>
                                <td>${ptm.prjPstn}</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" class="no-items">검색된 팀원이 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
    </table>
    <div class="buttons">
        <button id="regist-btn" class="btn regist">등록</button>
        <button id="cancel-btn" class="btn delete">취소</button>
    </div>
</div>
</body>
</html>