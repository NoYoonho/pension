<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.TourDao" %> 
<%@page import="pension.dto.TourDto" %>    
<% 
 // content.jsp
 if(session.getAttribute("userid")==null)
 {
	 response.sendRedirect("../member/login.jsp");
 }
 else
 {
	 TourDao tdao=new TourDao();
	 tdao.content(request);
	 TourDto tdto=(TourDto)request.getAttribute("tdto");
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
     position:relative;
   }
   #section table #inner {
     width:500px;
     height:300px;
     overflow:auto;
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
   #section .timg {
     cursor:pointer;
   }
   #section #imglayer {
     position:absolute;
     left:370px;
   }
  </style>
  <script>
    function viewImg(fname)
    { 
    	document.getElementById("myimg").src=fname;
    }
    function hideImg()
    {
    	document.getElementById("myimg").src="";
    }
  </script>
  
  <div id="section">
  <div id="imglayer"><img id="myimg" width="360" onclick="hideImg()"></div>
     <table width="600" align="center">
       <caption> <h2> <%=name%>님의 후기</h2></caption>
       <tr>
         <td width="100"> 제 목 </td>
         <td> <%=tdto.getTitle()%> </td>
       </tr>
       <tr>
         <td> 작성자 </td>
         <td> <%=tdto.getUserid()%> </td>
       </tr>
       <tr>
         <td> 조회수 </td>
         <td> <%=tdto.getReadnum()%> </td>
       </tr>
       <tr>
         <td> 내 용 </td>
         <td> <div id="inner"><%=tdto.getContent()%> </div> </td>
       </tr>
       <tr>
         <td> 사 진 </td>
         <td align="center">
           <div id="imginner">
           <%
           for(int i=0;i<tdto.getImgs().length;i++)
           {
        	   if(!tdto.getImgs()[i].equals(""))
        	   {
           %>
              <img class="timg" src="img/<%=tdto.getImgs()[i]%>" width="40" onclick="viewImg('img/<%=tdto.getImgs()[i]%>')">
           <%
        	   }
           }
           %>
           </div>
         </td>
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
 
          if(tdto.getUserid().equals( session.getAttribute("userid").toString() ) || session.getAttribute("userid").equals("admin"))
          {
        	  if(request.getParameter("mychk")==null)
    	     {
     %> 
             <a href="update.jsp?id=<%=tdto.getId()%>&pager=<%=pager%>"> 수정 </a>
             <a href="delete.jsp?id=<%=tdto.getId()%>&pager=<%=pager%>"> 삭제 </a>
     <%
    	     }
    	     else
    	     {
     %>
             <a href="update.jsp?id=<%=tdto.getId()%>&mychk=1"> 수정 </a>
             <a href="delete.jsp?id=<%=tdto.getId()%>&mychk=1"> 삭제 </a>
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