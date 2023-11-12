<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../menu.jsp" %>
<%@page import="pension.dao.AdminDao" %>
<%@page import="pension.dto.ReserveDto" %>
<%@page import="java.util.ArrayList" %>
<%@page import="pension.util.Util" %>
<%
    AdminDao adao=new AdminDao(); 
    adao.reserve_list(request);
    ArrayList<ReserveDto> rlist=(ArrayList<ReserveDto>)request.getAttribute("rlist");
%>
 <style>
  #section {
    width:1100px;
    margin:auto;
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
 </style>
 <div id="section">
   <table width="900" align="center">
     <caption> <h3> 예약 현황 </h3></caption>
     <tr align="center">
       <td> 예약자 </td>
       <td> 입실일 </td>
       <td> 퇴실일 </td>
       <td> 객실명 </td>
       <td width="50" align="right"> 인 원 </td>
       <td width="50" align="right"> bbq </td>
       <td width="50" align="right"> 숯불 </td>
       <td width="100" align="right"> 결제금액 </td>
       <td> 예약일 </td>
       <td> 상태 </td>
     </tr>
    <%
    for(int i=0;i<rlist.size();i++)
    {
    	ReserveDto rdto=rlist.get(i);
    	
    	// state처리하기
    	String state="";
    	switch(rdto.getState())
    	{
    	   case 0: state="예약완료"; break;
    	   case 1: state="취소신청중";  break;
    	   case 2: state="취소완료"; break;
    	   case 3: state="사용완료"; break;
    	}
    	
    %>
     <tr align="center">
       <td> <%=rdto.getUserid()%> </td>
       <td> <%=rdto.getInday()%> </td>
       <td> <%=rdto.getOutday()%> </td>
       <td> <%=rdto.getName()%> </td>
       <td align="right"> <%=rdto.getInwon()%>명 </td>
       <td align="right"> <%=rdto.getBbq()%>개 </td>
       <td align="right"> <%=rdto.getChacol()%>개 </td>
       <td align="right"> <%=Util.comma(rdto.getChongprice())%>원 </td>
       <td> <%=rdto.getWriteday()%> </td>
       <td>
       <%
        if(rdto.getState()==1) // 취소신청중일때 => 취소완료
        {
       %>
          <a href="chgstate.jsp?id=<%=rdto.getId()%>"> <%=state%> </a>     
       <%
        }
        else
        {
       %>
          <%=state%>
       <%
        }
       %>
       </td>
     </tr>
    <%
    }
    %>
   </table>
 </div>
</body>
</html>






