<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.TourDao" %>   
<%@page import="pension.dto.TourDto" %> 
<% 
 // list.jsp
 if(session.getAttribute("userid")==null)
 {
	 response.sendRedirect("../member/login.jsp");
 }
 else
 {
	 TourDao tdao=new TourDao();
	 tdao.list(request);
	 ArrayList<TourDto> tlist=(ArrayList<TourDto>)request.getAttribute("tlist");
	 int pstart=(int)request.getAttribute("pstart");
	 int pend=(int)request.getAttribute("pend");
	 int pager=(int)request.getAttribute("pager");
	 int chong=(int)request.getAttribute("chong");
	 
 
%>
<%@ include file="../top.jsp" %>
  <style>
   #section {
     width:1100px;
     height:500px;
     margin:auto;
     margin-top:50px;
   }
   #section a {
     text-decoration:none;
     color:black;
   }
   #section table {
     border-spacing:0px;
   }
   #section table td {
     height:30px;
     
   }
   #section table .cont:hover {
     background:#eeeeee;
   }
   #section table #head td {
     background:#eeeeee;
   }
   #section table .pnum {
     font-size:20px;
   }
   #section table #write {
     text-align:center;
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
     <table width="800" align="center">
       <caption> <h2> 여행후기 </h2></caption>
       <tr align="center" id="head">
         <td> 제 목 </td>
         <td> 작성자 </td>
         <td> 조회수 </td>
         <td> 작성일 </td>
       </tr>
     <%
      for(int i=0;i<10;i++)
      {
    	 if(i<tlist.size())
    	 {
     %>
       <tr align="center" class="cont">
         <td align="left"> <a href="readnum.jsp?pager=<%=pager%>&id=<%=tlist.get(i).getId()%>"> <%=tlist.get(i).getTitle()%> </a></td>
         <td width="100"> <%=tlist.get(i).getUserid()%> </td>
         <td width="80"> <%=tlist.get(i).getReadnum()%> </td>
         <td width="100"> <%=tlist.get(i).getWriteday()%> </td>
       </tr>
     <%
    	 }
    	 else
    	 {
     %>
        <tr align="center">
          <td> &nbsp; </td>
          <td width="100"> &nbsp; </td>
          <td width="80"> &nbsp; </td>
          <td width="100"> &nbsp; </td>
        </tr>
     <%    		 
    	 }
      }
     %>
 
       <tr>
       <td colspan="4" align="center">
       <!-- 사용자가 클릭하면 이동할 페이지를 출력 -->
       <!-- 첫번째 페이지 이동 -->
         <a href="list.jsp?pager=1"> Start </a>
         
     <!-- 현재출력 페이지 그룹의 이전그룹으로 이동 -->
        <%
         if(pstart != 1)
         {
        %>
          <a href="list.jsp?pager=<%=pstart-1%>"> << </a>
        <%
         }
         else
         {
        %>
        << 
        <%
         }
        %>
     <!-- 현재페이지 이전페이지 이동  =>  현재페이지-1  -->
     
        <%
          if(pager != 1)
          {
        %>
         <a href="list.jsp?pager=<%=pager-1%>"> < </a>
        <%
          }
          else
          {
        %>
         < 
        <%
          }

        for(int i=pstart;i<=pend;i++)
        {
        	String str="";
        	if(pager==i)
        	{
        		str="style='color:red'";
        	}
       %>
         <a class="pnum" href="list.jsp?pager=<%=i%>" <%=str%>> <%=i%> </a>
       <%
        }
       %>
       
       <!-- 현재에서 다음페이지 이동 => 현재페이지 + 1 -->
        <%
         if(pager != chong)
         {
        %>
          <a href="list.jsp?pager=<%=pager+1%>"> > </a>
        <%
         }
         else
         {
        %>
          >
        <%
         }
        %>
        
     <!-- 현재 페이지 그룹에서 다음 페이지 그룹으로 이동 pend+1 -->
        <%
         if(pend != chong)
         {
        %>  
          <a href="list.jsp?pager=<%=pend+1%>"> >> </a>
        <%
         }
         else
         {
        %>  
          >>
        <%
         }
        %>
        
 
      <!-- 마지막 페이지 이동 -->   
         <a href="list.jsp?pager=<%=chong%>"> End </a>  
       </td>
     </tr>
   
     <tr>
       <td colspan="4"> <a href="write.jsp" id="write"> 글쓰기 </a> </td>
     </tr>
     </table>
  
  </div>

<%@ include file="../bottom.jsp" %>
<%
 }
%>








