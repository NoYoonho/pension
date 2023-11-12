<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.AdminDao" %>
<%
     //rdelete.jsp
     AdminDao adao=new AdminDao();
     adao.rdelete(request,response);
%> 