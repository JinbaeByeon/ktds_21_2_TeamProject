<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  <div class="main_container">
    <div class="sidebar">
        <div class="sidebar__inner">
          <ul>
            <li>
              <a href="${context}/prj/list" id="prj_list">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>프로젝트 목록</span>
              </a>
            </li>
            <li>
              <a href="${context}/req/list" id="req_list">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>요구사항</span>
              </a>
            </li>
            <li>
              <a href="${context}/issu/list" id="issu_list">
                <span class="material-symbols-outlined">fiber_manual_record</span>
                <span>이슈</span>
              </a>
            </li>
            <li>
              <a href="${context}/knw/list" id="knw_list">
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