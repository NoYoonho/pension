<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
  <style>
    #section {
      width:1100px;
      height:500px;
      margin:auto;
      margin-top:50px;
    }
     #section input[type=text] {
      width:300px;
      height:30px;
      border:1px solid #cccccc;
      outline:none;
   }
   #section input[type=password] {
      width:300px;
      height:30px;
      border:1px solid #cccccc;
      outline:none;
   }
   #section input[type=submit] {
      width:306px;
      height:32px;
      border:1px solid #cccccc;
   }
   #section div {
      margin-top:20px;
   }
   #section #top {
      font-size:24px;
   }
   #section #msg {
      font-size:12px;
      color:red;
   }
  </style>
  <script>
    function formcheck(my)
    {
    	if(my.userid.value=="")
    	{
    		alert("아이디를 입력하세요");
    		return false;
    	}	
    	else if(my.pwd.value=="")
    		 {
    		     alert("비밀번호를 입력하세요");
    		     return false;
    		 }
    	     else
    	     {
    	    	 return true;
    	     }	 
    }
  </script>
  <div id="section">
     <form method="post" action="login_ok.jsp" onsubmit="return formcheck(this)">
     <%
      if(request.getParameter("year")!=null) // reserve_next.jsp에서 올 경우에만 가능
      {
     %>
       <input type="hidden" name="year" value="<%=request.getParameter("year")%>">
       <input type="hidden" name="month" value="<%=request.getParameter("month")%>">
       <input type="hidden" name="day" value="<%=request.getParameter("day")%>">
       <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
     <%
      }
     %>
       <div align="center" id="top"> 로 그 인 </div>
       <div align="center"> <input type="text" name="userid" placeholder="아이디" value="channy"> </div>
       <div align="center"> <input type="password" name="pwd" placeholder="비밀번호" value="1234"> </div>
       <div align="center"> <input type="submit" value="로그인"></div>
       <%
       if(request.getParameter("chk")!=null)
       {
       %>
       <div align="center" id="msg"> 아이디 혹은 비밀번호가 틀립니다. </div>
       <%
       }
       %>
     </form>
  
  </div>

<%@ include file="../bottom.jsp" %>