<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.util.UtilDao" %>    
<% 
 // write_ok.jsp
 if(session.getAttribute("userid")==null)
 {
	 response.sendRedirect("../member/login.jsp");
 }
 else
 {
     UtilDao udao=new UtilDao();
     udao.twrite_ok(request,response,session);
 }
%>