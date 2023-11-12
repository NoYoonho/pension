<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../menu.jsp" %>
 <%@page import="pension.dao.EventDao"%>
 <%@page import="pension.dto.EventDto" %> 
<%
     EventDao edao=new EventDao();
     edao.content(request);
     
     EventDto edto=(EventDto)request.getAttribute("edto");
%>
 <style>
   #section {
     width:1100px;
     height:500px;
     margin:auto;
     margin-top:50px;
   }
 </style> <!-- webapp/admin/event/content.jsp -->
 
 <div id="section">
    <table width="600" align="center">
      <caption> <h3> 이벤트 내용보기 </h3></caption>
      <tr>
        <td> 이벤트 제목 </td>
        <td> <%=edto.getTitle()%> </td>
      </tr>
      <tr>
        <td> 이벤트 내용 </td>
        <td> <%=edto.getContent()%> </td>
      </tr>
      <tr>
        <td> 이벤트 사진 </td>
        <td> <img src="img/<%=edto.getImg()%>"> </td>
      </tr>
      <tr>
        <td> 이벤트 기한 </td>
        <td> <%=edto.getGihan()%> </td>
      </tr>
      <tr>
        <td> 이벤트 등록일 </td>
        <td> <%=edto.getWriteday()%> </td>
      </tr>
      <tr>
        <td colspan="2" align="center">
          <a href="list.jsp"> 목록 </a>
          <a href="update.jsp?id=<%=edto.getId()%>"> 수정 </a>
          <a href="delete.jsp?id=<%=edto.getId()%>"> 삭제 </a>
        </td>
      </tr>
    </table>
 </div> 
 
</body>
</html>






