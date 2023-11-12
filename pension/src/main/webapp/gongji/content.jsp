<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.GongjiDao" %> 
<%@page import="pension.dto.GongjiDto" %>   
<%
    	GongjiDao gdao=new GongjiDao();
    	gdao.content(request);
    	
    	GongjiDto gdto=(GongjiDto)request.getAttribute("gdto");

%>  
<%@ include file="../top.jsp" %>
  <style>
    #section {
      width:1100px;
      height:500px;
      margin:auto;
      margin-top:50px;
   }
  </style>
  
  <div id="section">
    <table width="600" align="center">
      <tr>
        <td> 제 목 </td>
        <td> <%=gdto.getTitle()%> </td>
      </tr>
      <tr>
        <td> 작성일 </td>
        <td> <%=gdto.getWriteday()%> </td>
      </tr>
      <tr>
        <td> 조회수 </td>
        <td> <%=gdto.getReadnum()%> </td>
      </tr>
      <tr>
        <td> 내 용 </td>
        <td> <%=gdto.getContent()%> </td>
      </tr>
      <tr>
        <td colspan="2" align="center">
          <a href="list.jsp"> 목록 </a>
        </td>
      </tr>
    </table>
  </div>
 <%@ include file="../bottom.jsp" %>