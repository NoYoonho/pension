<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.AdminDao" %>    
<%
      // rwrite_ok.jsp
      AdminDao adao=new AdminDao();
      adao.rwrite_ok(request,response);
%>





