<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.GongjiDao" %>
<%@page import="pension.dto.GongjiDto" %>
<%
     GongjiDao gdao=new GongjiDao();
     gdao.update(request);
     
     GongjiDto gdto=(GongjiDto)request.getAttribute("gdto");
%>    
<%@include file="../menu.jsp" %>
 
  <style>
    #section {
      width:1100px;
      height:500px;
      margin:auto;
      margin-top:50px;
      text-align:center;
    }
    #section input[type=text] {
      width:400px;
      height:30px;
      border:1px solid purple;
    }
    #section textarea {
      width:400px;
      height:100px;
      border:1px solid purple;
    }
    #section input[type=submit] {
      width:406px;
      height:33px;
      border:1px solid purple;
      background:purple;
      color:white;
      font-weight:900;
    }
 
    #section .gong {
      width:410px;
      margin:auto;
      margin-top:20px;
    }
  </style>
  <!-- /webapp/admin/gongji/update.jsp -->
  <div id="section">
   <form method="post" action="update_ok.jsp">
     <input type="hidden" name="id" value="<%=gdto.getId()%>">
     <h2> 공지사항 수정</h2>
     <div class="gong"> <input type="text" name="title" placeholder="제 목" value="<%=gdto.getTitle()%>"> </div>
     <div class="gong"> <textarea name="content" placeholder="공지사항 내용쓰기"><%=gdto.getContent()%></textarea> </div>
     <%
        String msg="";
        if(gdto.getStep()==1)
        {
        	msg="checked";
        }
     %>
     <div class="gong" align="left"> <input type="checkbox" <%=msg%> value="1" name="step"> 항상 첫페이지에 공지하기 </div>
     <div class="gong"> <input type="submit" value="공지사항 수정"> </div>
   </form>
    
    
  </div>
  
 </body>
 
</html>









