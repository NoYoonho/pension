<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.MemberDao" %>    
<%
      // userid_check.jsp
      // 아이디값이 넘어오면 해당 아이디값이 기존에 존재하는지 여부를 javascript에 전달
      
      MemberDao mdao=new MemberDao();
      mdao.userid_check(request,out);
      
%>
