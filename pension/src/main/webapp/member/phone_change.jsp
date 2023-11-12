<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.MemberDao" %>    
<%
    // phone_change.jsp
    MemberDao mdao=new MemberDao();
    mdao.phone_change(request,session,response);
%>