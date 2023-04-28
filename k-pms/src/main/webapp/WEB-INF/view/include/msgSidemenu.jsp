<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
	
	<div class="main_container">
    <div class="sidebar">
        <div class="sidebar__inner">
          <ul>
            <li>
              <a href="${context}/sndmsg/send" class="active">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>쪽지보내기</span>
              </a>
            </li>
            <li>
              <a href="${context}/rcvmsg/list">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>받은쪽지함</span>
              </a>
            </li>
            <li>
              <a href="${context}/sndmsg/list">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>보낸쪽지함</span>
              </a>
            </li>
            
            <li>
              <a href="${context}/rcvmsg/trash">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>휴지통</span>
              </a>
            </li>

          </ul>
        </div>
        <div class="sidebar_bottom">
          <div class="logout"><a href="${context}/emp/lgt">Logout</a></div>
        </div>
    </div>    
