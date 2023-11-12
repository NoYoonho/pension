<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.EventDao"%>
<%
     EventDao edao=new EventDao();
     edao.write_ok(request,response);
%>