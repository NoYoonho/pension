<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.GongjiDao" %>    
<%
    if( session.getAttribute("userid")==null || !session.getAttribute("userid").equals("admin") )
    {
	    response.sendRedirect("../../main/index.jsp");
    }
    else
    {
    	GongjiDao gdao=new GongjiDao();
    	gdao.readnum(request,response);
    }
%>  
 