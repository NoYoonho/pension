<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../top.jsp" %>
<%@page import="pension.dao.EventDao"%>
<%@page import="java.util.ArrayList" %>
<%@page import="pension.dto.EventDto" %>
<%
     EventDao edao=new EventDao();
     edao.list(request);
     ArrayList<EventDto> elist=(ArrayList<EventDto>)request.getAttribute("elist");
%> 
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
   #section a {
     text-decoration:none;
     color:black;
   }
 </style> <!-- webapp/admin/event/list.jsp -->
 
 <div id="section">
   <table width="900" align="center">
     <caption> <h3> 이벤트 현황 </h3></caption>
     <tr>
       <td> 이벤트 제목 </td>
       <td> 이벤트 사진 </td>
       <td> 게시 기한 </td>
       <td> 등록 일자 </td>
     </tr>
    <%
    for(int i=0;i<elist.size();i++)
    {
    	
    %>
     <tr>
       <td> 
        <%
        // isBefore()호출하여 날짜가 지났는지 여부를 boolean으로 받는다
        if(edao.isBefore(elist.get(i).getGihan()))
        {
        %>
         <a href="content.jsp?id=<%=elist.get(i).getId()%>"> <%=elist.get(i).getTitle()%> </a>
        <%
        }
        else
        {
        %> 
         <s><%=elist.get(i).getTitle()%></s> <b style="color:red">[종료이벤트]</b>
        <%
        }
        %> 
       </td> 
       <td> <img src="../admin/event/img/<%=elist.get(i).getImg()%>" width="30"></td>
       <td> <%=elist.get(i).getGihan()%> </td>
       <td> <%=elist.get(i).getWriteday()%> </td>
     </tr>
    <%
    }
    %>

   </table>
 </div> 
 
<%@ include file="../bottom.jsp" %>

