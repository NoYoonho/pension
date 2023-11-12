<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../menu.jsp" %>
<%@page import="pension.dao.AdminDao" %>
<%@page import="pension.dto.InquiryDto" %>
<%@page import="java.util.ArrayList" %>
<%
     AdminDao adao=new AdminDao();
     adao.inquiry_list(request);
     ArrayList<InquiryDto> ilist=(ArrayList<InquiryDto>)request.getAttribute("ilist");
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
   .inquiry , .answer {
     width:300px;
     height:80px;
     overflow:auto;
   }
   #section textarea {
     width:230px;
     height:74px;
     vertical-align:middle;
   }
   #section input[type=submit] {
     width:40px;
     height:80px;
   }
    
 </style>
 
 <div id="section">
   <table width="900" align="center">
     <caption> <h3> 1:1 문의 현황 </h3></caption>
     <tr align="center">
       <td width="90"> 작성자 </td>
       <td> 문의주제 </td>
       <td width="300"> 문의내용 </td>
       <td width="300"> 답변내용 </td>
       <td width="80"> 작성일 </td>
     </tr>
    <%
    for(int i=0;i<ilist.size();i++)
    {
    	InquiryDto idto=ilist.get(i);
    	
    	String title="";
    	switch(idto.getTitle())
    	{
    	    case 0: title="예약관련"; break;
    	    case 1: title="객실관련"; break;
    	    case 2: title="뷔페관련"; break;
    	    case 3: title="할인관련"; break;
    	    case 4: title="주변관광지"; break;
    	    case 5: title="기타 관련"; break;
    	}
    %>
     <tr>
       <td align="center"> <%=idto.getUserid()%> </td>
       <td> <%=title%> </td>
       <td> <div class="inquiry"> <%=idto.getContent()%> </div></td>
       <td>
       <%
        if(idto.getState()==0)
        {
       %>
           <form method="post" action="inquiry_ok.jsp">
             <input type="hidden" name="id" value="<%=idto.getId()%>"> 
             <textarea name="answer" maxlength="200" placeholder="답변을 입력하세요"></textarea> 
             <input type="submit" value="완료">
           </form>
       <%
        }
        else
        {
       %>
         <div class="answer"> 
           <%=idto.getAnswer().replace("\r\n","<br>")%>
         </div> 
       <%
        }
       %>
       </td>
       <td align="center"> <%=idto.getWriteday()%> </td>
     </tr>
    <%
    }
    %>
   </table>
 </div>
</body>
</html>