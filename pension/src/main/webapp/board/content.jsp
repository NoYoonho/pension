<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.BoardDao" %> 
<%@page import="pension.dto.BoardDto" %>    
<% 
 // content.jsp
 if(session.getAttribute("userid")==null)
 {
	 response.sendRedirect("../member/login.jsp");
 }
 else
 {
	 BoardDao bdao=new BoardDao();
	 bdao.content(request);
	 BoardDto bdto=(BoardDto)request.getAttribute("bdto");
	 String pager=(String)request.getAttribute("pager");
	 String name=(String)request.getAttribute("name");
%>
<%@ include file="../top.jsp" %>
  <style>
    #section {
     width:1100px;
     height:500px;
     margin:auto;
     margin-top:50px;
   }
   #section table tr td {
     border:1px solid #cccccc;
   }
   #section table tr:last-child td {
     border:none;
     height:50px;
   }
   #section table td {
     height:30px;
   }
   #section table #inner {
     width:500px;
     height:200px;
     overflow:auto;
   }
   
   #section table a {
     text-decoration:none;
     color:black;
     margin-left:20px;
     display:inline-block;
     width:100px;
     height:30px;
     line-height:30px;
     border:1px solid black;
   }
   
  </style>
  <script>
  
  </script>
 
  <div id="section">
     <table width="600" align="center">
       <caption> <h2> <%=name%>님의 글</h2></caption>
       <tr>
         <td width="100"> 제 목 </td>
         <td> <%=bdto.getTitle()%> </td>
       </tr>
       <tr>
         <td> 작성자 </td>
         <td> <%=bdto.getUserid()%> </td>
       </tr>
       <tr>
         <td> 조회수 </td>
         <td> <%=bdto.getReadnum()%> </td>
       </tr>
       <tr>
         <td> 내 용 </td>
         <td> <div id="inner"><%=bdto.getContent()%> </div> </td>
       </tr>
       <tr>
         <td colspan="2" align="center">
          <%
           if(request.getParameter("mychk")==null)
           {
          %>
           <a href="list.jsp?pager=<%=pager%>"> 목록 </a>
           
          <%
           }
           else
           {
          %> 
           <a href="../inquiry/mine.jsp"> 목록 </a>
           
          <%
           }
         
          if(bdto.getUserid().equals( session.getAttribute("userid").toString() ) || session.getAttribute("userid").equals("admin"))
          {
        	  if(request.getParameter("mychk")==null)
        	  {
         %> 
                 <a href="update.jsp?id=<%=bdto.getId()%>&pager=<%=pager%>"> 수정 </a>
                 <a href="delete.jsp?id=<%=bdto.getId()%>&pager=<%=pager%>"> 삭제 </a>
         <%
        	  }
        	  else
        	  {
         %>
                 <a href="update.jsp?id=<%=bdto.getId()%>&mychk=1"> 수정 </a>
                 <a href="delete.jsp?id=<%=bdto.getId()%>&mychk=1"> 삭제 </a>
         <%		  
        	  }
          }
         %>
         </td>
       </tr>
     </table>
  
  </div>

<%@ include file="../bottom.jsp" %>
<%
 }
%>