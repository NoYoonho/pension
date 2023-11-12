<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.BoardDao" %>    
<% 
 // update_ok.jsp
 if(session.getAttribute("userid")==null)
 {
	 response.sendRedirect("../member/login.jsp");
 }
 else
 {
     BoardDao bdao=new BoardDao();
     bdao.update_ok(request,response);
 }
%>