<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.MemberDao" %>  
<%@page import="pension.dto.MemberDto" %>  
<%   
     // member_view.jsp
     MemberDao mdao=new MemberDao();
     mdao.member_view(session,request);
     MemberDto mdto=(MemberDto)request.getAttribute("mdto");
%>    
<%@ include file="../top.jsp" %>
  <style>
    #section {
      width:1100px;
      height:500px;
      margin:auto;
      margin-top:50px;
    }
    #section #main {
      width:400px;
      margin:auto;
    }
    #section #main div {
      margin-top:20px;
    }
    #section div #aa {
      display:inline-block;
      width:100px;
      text-align:left;
    }
    #section input[type=text] {
      width:150px;
      height:20px;
      border:1px solid #cccccc;
      outline:none;
    }
     
    #section input[type=submit] {
      width:40px;
      height:23px;
      border:1px solid #cccccc;
      outline:none;
      vertical-align:bottom;
    }
  </style>
  <script>
  
  </script>
  <div id="section">
   <div id="main">
    <div style="margin-left:100px;"> <h3> 회 원 정 보 </h3></div>
    <div> <span id="aa"> 아이디 </span> <span id="bb"><%=mdto.getUserid()%></span> </div>
    <div> <span id="aa"> 이 름 </span> <span id="bb"><%=mdto.getName()%></span> </div>
    <div>
       <span id="aa"> 전화번호 </span> 
       <span id="bb">
        <form method="post" action="phone_change.jsp" style="display:inline;">
         <input type="text"  name="phone" value="<%=mdto.getPhone()%>">
         <input type="submit" value="변경">
        </form>
       </span>
       <br><span>
       <%
        if(request.getParameter("chk")!=null)
        {
       %>
         전화번호를 무사히 변경했습니다.
       <%
        }
       %>
       </span>
    </div>
    <div> 
       <span id="aa"> 이메일 </span> 
       <span id="bb">
        <form method="post" action="email_change.jsp" style="display:inline;">
         <input type="text"  name="email" value="<%=mdto.getEmail()%>">
         <input type="submit" value="변경">
        </form>        
       </span>  
    </div>
    <div> <span id="aa"> 가입일 </span> <span id="bb"><%=mdto.getWriteday()%></span> </div>
    
    <div style="margin-left:100px;"> <input type="button" value="비밀번호변경" onclick="formopen()"> </div>
    
   </div>
  </div>
 <script>
   function formopen()
   {
	   son=open("pwd_change.jsp","","width=250,height=280");
	   x=screen.availWidth;
	   y=screen.availHeight;
	   x=x/2;
	   x=x-(250/2);
	   y=y/2;
	   y=y-(280/2);
	   
	   son.moveTo(x,y);
   }
 </script>
<%@ include file="../bottom.jsp" %>




