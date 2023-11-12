<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.InquiryDao" %>
<%@page import="pension.dto.BoardDto" %>
<%@page import="pension.dto.TourDto" %>
<%@page import="pension.dto.InquiryDto" %>
<%
     InquiryDao idao=new InquiryDao();
     idao.mine(request,session);
     
     ArrayList<BoardDto> blist=(ArrayList<BoardDto>)request.getAttribute("blist");
     ArrayList<TourDto> tlist=(ArrayList<TourDto>)request.getAttribute("tlist");
     ArrayList<InquiryDto> ilist=(ArrayList<InquiryDto>)request.getAttribute("ilist");
%>    
<%@ include file="../top.jsp" %>
  <style>
    #section {
      width:1100px;
      height:500px;
      margin:auto;
      margin-top:50px;
    }
    
    #section #answer {
      width:300px;
      height:80px;
      overflow:auto;
    }
  </style>
  <script>
  
  </script>
  <div id="section">
    <table width="700" align="center">
      <caption> <h3> 회원게시판 </h3></caption>
    <%
     for(int i=0;i<blist.size();i++)
     {
    %>
      <tr>
        <td> <a href="../board/content.jsp?mychk=1&id=<%=blist.get(i).getId()%>"> <%=blist.get(i).getTitle()%> </a> </td>
        <td width="50"> <%=blist.get(i).getReadnum()%> </td>
        <td width="100"> <%=blist.get(i).getWriteday()%> </td>
      </tr>
    <%
     }
    %>
    </table>
     
    <hr>
    
    <table width="700" align="center">
      <caption> <h3> 여행후기 </h3></caption>
    <%
     for(int i=0;i<tlist.size();i++)
     {
    %>
      <tr>
        <td> <a href="../tour/content.jsp?mychk=1&id=<%=tlist.get(i).getId()%>"> <%=tlist.get(i).getTitle()%> </a></td>
        <td width="50"> <%=tlist.get(i).getReadnum()%> </td>
        <td width="100"> <%=tlist.get(i).getWriteday()%> </td>
      </tr>
    <%
     }
    %>
    </table>
     
    <hr>
    
    <table width="700" align="center">
      <caption> <h3> 1:1문의 </h3></caption>
    <%
     for(int i=0;i<ilist.size();i++)
     {
    	 String title="";
    	 switch(ilist.get(i).getTitle())
    	 {
    	     case 0: title="예약 관련 문의"; break;
    	     case 1: title="객실 관련 문의"; break;
    	     case 2: title="뷔페 관련 문의"; break;
    	     case 3: title="할인 관련 문의"; break;
    	     case 4: title="주변 관광지 문의"; break;
    	     case 5: title="기타 관련 문의"; break;
    	 }
    	 String state;
    	 if(ilist.get(i).getState()==0)
    	 {
    		 state="답변 준비";
    	 }
    	 else
    	 {
    		 state=ilist.get(i).getAnswer().replace("\r\n","<br>");
    	 }
    %>
      <tr>
        <td> <%=title%> </td>
        <td width="80"> <div id="answer"> <%=state%> </div></td>
        <td width="100"> <%=ilist.get(i).getWriteday()%> </td>
      </tr>
    <%
     }
    %>
    </table>
  </div>

<%@ include file="../bottom.jsp" %>







