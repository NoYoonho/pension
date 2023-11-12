<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  if(session.getAttribute("userid")!=null)
  {
%>
<%@ include file="../top.jsp" %>
 
  <style>
    #section {
      width:1100px;
      height:500px;
      margin:auto;
      margin-top:50px;
      text-align:center;
    }
    #section select {
      width:404px;
      height:33px;
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
 
    #section .inq {
      width:410px;
      margin:auto;
      margin-top:20px;
    }
  </style>
  <script>
   function check(my)
   {
	   // 폼 입력값 체크
	   if(my.content.value.trim()=="")
	   {
		   alert("내용을 입력하세요");
		   my.content.focus();
		   return false;
	   }	
	   else
	   {
		   return true;
	   }
   }
  </script>
  <!-- /webapp/inquiry/write.jsp -->
  <div id="section">
   <form method="post" action="write_ok.jsp" onsubmit="return check(this)">
     <h2> 1:1 문의</h2>
     <div class="inq"> 
       <select name="title">
         <option value="0"> 예약 관련 </option>
         <option value="1"> 객실 관련 </option>
         <option value="2"> 뷔페 관련 </option>
         <option value="3"> 할인 관련 </option>
         <option value="4"> 주변 관광지 </option>
         <option value="5"> 기타 관련 </option>
       </select>
     </div>
     <div class="inq"> 
         <textarea name="content" onkeyup="lencheck(this)" placeholder="1:1문의 내용쓰기" maxlength="200"></textarea> <br>
         <span id="len"></span>
     </div>
     <div class="inq"> <input type="submit" value="1:1문의 등록"> </div>
   </form>
   <script>
     function lencheck(my)
     {
    	document.getElementById("len").innerText=my.value.length+"자";
     }
   </script>
   <style>
     #len {
       font-size:12px;
       color:purple;
     }
   </style>
  </div>
 <%@ include file="../bottom.jsp" %>
<%
  }
  else
  {
	  response.sendRedirect("../member/login.jsp");
  }
%> 





