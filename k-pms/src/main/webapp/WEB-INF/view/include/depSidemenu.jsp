<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />



 <div class="main_container">
    <div class="sidebar">
        <div class="sidebar__inner">
          <ul>
            <li>
              <a href="${context}/dep/list" id="dep_list">
                <span>부서 상세</span>
              </a>
            </li>
            <li>
              <a href="${context}/tm/list" id="tm_list">
                <span>팀 관리</span>
              </a>
            </li>
            <li>
              <a href="${context}/dep/mbrlist" id="dep_mbrlist">
                <span>팀원 관리</span>
              </a>
            </li>
          </ul>
        </div>
        <div class="sidebar_bottom">
          <div class="logout"><a href="${context}/emp/lgt">Logout</a></div>
        </div>
    </div>
    
   