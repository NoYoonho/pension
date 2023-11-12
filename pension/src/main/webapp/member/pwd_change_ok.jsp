<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.MemberDao" %>    
<%
     // pwd_change_ok.jsp
     MemberDao mdao=new MemberDao();
     int chk=mdao.pwd_change_ok(request, session);
     
     if(chk==1)
     {
%>
      <script>
         opener.location="../member/login.jsp";
         close();
      </script>
<%
     }
     else
     {
    	 response.sendRedirect("pwd_change.jsp");
     }
%>