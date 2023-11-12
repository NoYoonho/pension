<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.AdminDao" %>
<%   // rupdate_ok.jsp
     AdminDao adao=new AdminDao();
     adao.rupdate_ok(request,response);
%>    