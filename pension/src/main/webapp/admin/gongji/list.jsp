<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    if( session.getAttribute("userid")==null || !session.getAttribute("userid").equals("admin") )
    {
	    response.sendRedirect("../../main/index.jsp");
    }
    else
    {
%>     
<%@page import="pension.dao.GongjiDao" %>
<%@page import="pension.dto.GongjiDto" %>
<%@page import="java.util.ArrayList" %>
<%
    GongjiDao gdao=new GongjiDao();
    gdao.list(request);
    
    ArrayList<GongjiDto> glist=(ArrayList<GongjiDto>)request.getAttribute("glist");
%>    
<%@include file="../menu.jsp" %>
<style>
    #section {
      width:1100px;
      height:500px;
      margin:auto;
      margin-top:50px;
    }
  #section table {
     border-spacing:0px;
   }
   #section table tr:hover {
      background:#eeeeee;
   }
   #section table tr:first-child:hover {
      background:white;
   }
   #section table tr:last-child:hover {
      background:white;
   }
   #section table td {
     height:34px;
     font-size:13px;
     border-bottom:1px solid purple;
   }
   #section table tr:first-child td {
     border-top:2px solid purple;
     font-weight:900;
   }
   #section table tr:last-child td {
     border-bottom:2px solid purple;
   }
   #section table a {
     text-decoration:none;
     color:black;
   }
  </style>
  <!-- /webapp/admin/gongji/list.jsp -->
  <div id="section">
    <table width="800" align="center">
      <caption> <h2> 공지사항 </h2></caption>
      <tr align="center">
        <td> 제 목 </td>
        <td width="60"> 작성자 </td>
        <td width="60"> 조회수 </td>
        <td width="100"> 작성일 </td>
      </tr>
    <%
     for(int i=0;i<glist.size();i++)
     {
    %>
      <tr>
        <td> 
         <%
         if(glist.get(i).getStep()==1)
         {
         %>
          <img src="../../img/gong.png" valign="middle" width="20">
         <%
         }
         else
         {
        	 out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
         }
         %>
          <a href="readnum.jsp?id=<%=glist.get(i).getId()%>"> <%=glist.get(i).getTitle()%> </a> 
        </td>
        <td> 관리자 </td>
        <td> <%=glist.get(i).getReadnum()%> </td>
        <td> <%=glist.get(i).getWriteday()%> </td>
      </tr> 
   
    <%
     }
    %>
       <tr align="center">
        <td colspan="4"> <a href="write.jsp" id="write"> 등록하기 </a> </td>
       </tr>
    </table>
  </div>
</body>
</html>

<%
    }
%>








