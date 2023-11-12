<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.MemberDao" %>    
<%
     // logout.jsp
     //MemberDao mdao=new MemberDao();
     //mdao.logout(session,response);
     MemberDao.logout(session, response);
%>