<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%@ include file="../menu.jsp" %>
 <!-- /webapp/admin/member/member_list.jsp -->
<%@page import="pension.dao.AdminDao" %>
<%@page import="pension.dto.MemberDto" %>
<%@page import="java.util.ArrayList" %>
<%
    AdminDao adao=new AdminDao();
    adao.member_list(request);
    
    ArrayList<MemberDto> mlist=(ArrayList<MemberDto>)request.getAttribute("mlist");

%>
 <style>
   #section {
     width:1100px;
     height:500px;
     margin:auto;
     margin-top:50px;
     text-align:center;
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
     <tr>
       <td> 이름 </td>
       <td> 아이디 </td>
       <td> 전화번호 </td>
       <td> 이메일 </td>
       <td> 가입일 </td>
       <td> 예약횟수 </td>
       <td> 총예약금액 </td>
     </tr>
    <%
    for(int i=0;i<mlist.size();i++)
    {
    %>
     <tr>
       <td> <%=mlist.get(i).getName()%> </td>
       <td> <%=mlist.get(i).getUserid()%> </td>
       <td> <%=mlist.get(i).getPhone()%> </td>
       <td> <%=mlist.get(i).getEmail()%> </td>
       <td> <%=mlist.get(i).getWriteday()%> </td>
       <td> <%=adao.getCount(mlist.get(i).getUserid())%>번 </td>
       <td> <%=adao.getChong(mlist.get(i).getUserid())%>원 </td>
     </tr>
    <%
    }
    %>
   </table>
 </div>
</body>
</html>
<%
    adao.myclose();
%>









