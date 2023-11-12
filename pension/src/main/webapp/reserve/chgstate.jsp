<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.ReserveDao" %>
<%
     // chgstate.jsp
     ReserveDao rdao=new ReserveDao();
     rdao.chgstate(request,response);
%>