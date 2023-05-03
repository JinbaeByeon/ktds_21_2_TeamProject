<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"/>
    
  <div class="main_container">
    <div class="sidebar">
        <div class="sidebar__inner">
          <ul>
            <li>
              <a href="${context}/eqp/rent" id="eqp_rent">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>대여 관리</span>
              </a>
            </li>
            <li>
              <a href="${context}/eqp/apply" id="eqp_apply">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>대여 신청</span>
              </a>
            </li>
          </ul>
        </div>
        <div class="sidebar_bottom">
          <div class="logout"><a href="${context}/emp/lgt">Logout</a></div>
        </div>
    </div>  
