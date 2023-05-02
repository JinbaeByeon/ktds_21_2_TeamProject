<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"/>
    
  <div class="main_container">
    <div class="sidebar">
        <div class="sidebar__inner">
          <ul>
            <li>
             <a href="${context}/prj/list" class="active">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>프로젝트목록</span>
              </a>
            </li>
            <li>
              <a href="${context}/issu/list" class="active">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>이슈</span>
              </a>
            </li>
            <li>
              <a href="${context}/req/list" class="active">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>요구사항</span>
              </a>
            </li>
            <li>
              <a href="${context}/knw/list" class="active">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>지식관리</span>
              </a>
            </li>
          </ul>
        </div>
        <div class="sidebar_bottom">
          <div class="logout"><a href="${context}/emp/lgt">Logout</a></div>
        </div>
    </div>