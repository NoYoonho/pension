<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
 // write.jsp
 if(session.getAttribute("userid")==null)
 {
	 response.sendRedirect("../member/login.jsp");
 }
 else
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
    #section input[type=text] {
      width:400px;
      height:30px;
    }
    #section textarea {
      width:400px;
      height:200px;
    }
    #section input[type=submit] {
      width:406px;
      height:33px;
    }
    #section .msg {
      margin-top:20px;
    }
  </style>
  <script>
    function check(my)
    {
    	// 제목과 글을 체크하는 거 추가
    }
  </script>
 
  <div id="section">
    <form method="post" action="write_ok.jsp" onsubmit="return check(this)">
      <h2> 게시판 글쓰기 </h2>
      <div class="msg"> <input type="text" name="title" placeholder="제 목"> </div>  
      <div class="msg"> <textarea name="content" placeholder="내용을 입력하세요"></textarea> </div>
      <div class="msg"> <input type="submit" value="글 저장"> </div> 
    </form>  
  </div>

<%@ include file="../bottom.jsp" %>
<%
 }
%>












