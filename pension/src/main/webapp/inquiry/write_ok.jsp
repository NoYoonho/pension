<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.InquiryDao"%>
<%
  // write_ok.jsp

  if(session.getAttribute("userid") != null)
  {	  
     InquiryDao idao=new InquiryDao();
     idao.write_ok(request,response,session);
  }
  else
  {
	  response.sendRedirect("../member/login.jsp");
  }
%>