<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%
 if(session.getAttribute("userid")!=null)
 {
    if(!session.getAttribute("userid").equals("admin"))
    {
	    response.sendRedirect("../../main/index.jsp");
    }
    else
    {
%>    
<%@page import="pension.dao.GongjiDao" %>
<%
      GongjiDao gdao=new GongjiDao();
      gdao.write_ok(request,response);
    
    
    }
 }
 else
 {
	 response.sendRedirect("../../member/login.jsp");
 }
%>    