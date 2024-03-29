<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"/>

<div class="main_container">
    <div class="sidebar">
        <div class="sidebar__inner">
          <ul>
            <li>
              <a href="${context}/cmncd/list" id="cmncd_list">
                <span>공통코드 관리</span>
              </a>
            </li>
            <li>
              <a href="${context}/pstn/list" id="pstn_list">
                <span>직급관리</span>
              </a>
            </li>
            <li>
              <a href="${context}/job/list" id="job_list">
                <span>직무관리</span>
              </a>
            </li>
          </ul>
        </div>
        <div class="sidebar_bottom">
          <div class="logout"><a href="${context}/emp/lgt">Logout</a></div>
        </div>
    </div>
    
