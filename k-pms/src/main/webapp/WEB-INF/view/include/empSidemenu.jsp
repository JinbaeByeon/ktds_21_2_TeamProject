<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"/>
    
  <div class="main_container">
    <div class="sidebar">
        <div class="sidebar__inner">
          <ul>
            <li>
              <a href="${context}/emp/create" id="emp_create">
                <span>임직원 등록</span>
              </a>
            </li>
            <li>
              <a href="${context}/emp/list" id="emp_list">
                <span>임직원 목록</span>
              </a>
            </li>
            <li>
              <a href="${context}/emp/log/lgn" id="emp_log_lgn">
                <span>로그인 이력</span>
              </a>
            </li>
            <li>
              <a href="${context}/emp/log/acs" id="emp_log_acs">
                <span>화면 접근 이력</span>
              </a>
            </li>
            <li>
              <a href="${context}/emp/log/pstn" id="emp_log_pstn">
                <span>직급 변경 이력</span>
              </a>
            </li>
            <li>
              <a href="${context}/emp/log/job" id="emp_log_job">
                <span>직무 변경 이력</span>
              </a>
            </li>
            <li>
              <a href="${context}/emp/log/dep" id="emp_log_dep">
                <span>부서 변경 이력</span>
              </a>
            </li>

          </ul>
        </div>
        <div class="sidebar_bottom">
          <div class="logout"><a href="${context}/emp/lgt">Logout</a></div>
        </div>
    </div>    