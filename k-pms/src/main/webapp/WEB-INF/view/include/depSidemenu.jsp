<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />



 <div class="main_container">
    <div class="sidebar">
        <div class="sidebar__inner">
          <ul>
            <li>
              <a href="${context}/dep/list" class="active">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>부서 관리</span>
              </a>
            </li>
            <li>
              <a href="${context}/tm/list" class="active">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>팀 관리</span>
              </a>
            </li>
            <li>
              <a href="${context}/dep/mbrlist">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>팀원 관리</span>
              </a>
            </li>
          </ul>
        </div>
        <div class="sidebar_bottom">
          <div class="logout"><a href="${context}/emp/lgt">Logout</a></div>
        </div>
    </div>
    
   