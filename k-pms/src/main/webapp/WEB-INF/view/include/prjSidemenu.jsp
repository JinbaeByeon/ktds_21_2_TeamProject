<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"/>
    
  <div class="main_container">
    <div class="sidebar">
        <div class="sidebar__inner">
          <ul>
            <li>
              <a href="${context}/prj/list" id="prj_list">
                <span>프로젝트 목록</span>
              </a>
            </li>
            <li>
              <a href="${context}/req/list" id="req_list">
                <span>요구사항</span>
              </a>
            </li>
            <li>
              <a href="${context}/issu/list" id="issu_list">
                <span>이슈</span>
              </a>
            </li>
            <li>
              <a href="${context}/knw/list/0" id="knw_list">
                <span>지식관리</span>
              </a>
            </li>
            <li>
              <a href="${context}/knw/list/1" id="com_knw_list">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>사내지식관리</span>
              </a>
            </li>
            <li>
              <a href="${context}/prj/log" id="prj_log">
                <span>프로젝트 변경 이력</span>
              </a>
            </li>
          </ul>
        </div>
        <div class="sidebar_bottom">
          <div class="logout"><a href="${context}/emp/lgt">Logout</a></div>
        </div>
    </div>
  </div>