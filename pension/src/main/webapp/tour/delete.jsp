<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.TourDao" %>     
<% 
 // delete.jsp
 if(session.getAttribute("userid")==null)
 {
	 response.sendRedirect("../member/login.jsp");
 }
 else
 {
     TourDao tdao=new TourDao();
     tdao.delete(request,response);
     
 }
%>