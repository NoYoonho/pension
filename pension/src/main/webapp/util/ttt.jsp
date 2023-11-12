<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <%
    out.print( request.getRealPath("/util") +"<p>");
    out.print( request.getPathInfo() +"<p>");
    out.print( request.getRequestURI() +"<p>");
    out.print( request.getRemoteHost() +"<p>");
    out.print( request.getServletPath()+"<p>");
    out.print( request.getRequestURL() +"<p>");
    out.print( request.getContextPath() +"<p>");
 %>
</body>
</html>