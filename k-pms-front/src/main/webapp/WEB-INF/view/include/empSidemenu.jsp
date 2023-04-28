<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"/>
    
  <div class="main_container">
    <div class="sidebar">
        <div class="sidebar__inner">
          <ul>
            <li>
              <a href="${context}/emp/create" class="active">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>임직원 등록</span>
              </a>
            </li>
            <li>
              <a href="${context}/emp/list">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>임직원 목록</span>
              </a>
            </li>
            <li>
              <a href="${context}/emp/log/lgn">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>로그인 이력</span>
              </a>
            </li>
            <li>
              <a href="${context}/emp/log/acs">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>화면 접근 이력</span>
              </a>
            </li>
            <li>
              <a href="${context}/emp/log/pstn">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>직급 변경 이력</span>
              </a>
            </li>
            <li>
              <a href="${context}/emp/log/job">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>직무 변경 이력</span>
              </a>
            </li>
            <li>
              <a href="${context}/emp/log/dep">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>부서 변경 이력</span>
              </a>
            </li>

          </ul>
        </div>
        <div class="sidebar_bottom">
          <div class="logout"><a href="${context}/emp/lgt">Logout</a></div>
        </div>
    </div>    