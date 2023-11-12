<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.TourDao" %>    
<% 
 // write_ok.jsp
 if(session.getAttribute("userid")==null)
 {
	 response.sendRedirect("../member/login.jsp");
 }
 else
 {
     TourDao tdao=new TourDao();
     tdao.write_ok(request,response,session);
 }
%>