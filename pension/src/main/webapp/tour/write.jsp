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
      height:100px;
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
  function addform()
  {
  	var size=document.getElementsByClassName("up").length;
  	if(size<10)
      {
  	   var out=document.getElementById("outer");
  	   out.innerHTML=out.innerHTML+"<p class='up'> <input type='file' name='fname"+(size+1)+"'> </p>";
  	   resize1(size+1);
      }
  
  	
  }
  function delform()
  {
  	var size=document.getElementsByClassName("up").length;
  	if(size!=1)
  	{	
  	    document.getElementsByClassName("up")[size-1].remove();
  	    resize1(size);
  	}
  	  	
  }
  var hh=500; // section의 원래높이
  function resize1(size)
  {
	
   	 if(size>4)
  	 {
  		ss=((size-3)*37)+500;
  		document.getElementById("section").style.height=ss+"px";
  	 }	
  	 else
  	 {
  		document.getElementById("section").style.height="500px";
  	 }	
  }
    function check(my)
    {
    	// 제목과 글을 체크하는 거 추가
    }
  </script>
 
  <div id="section">
    <form method="post" action="write_ok.jsp" onsubmit="return check(this)" enctype="multipart/form-data">
      <h2> 여행후기 쓰기 </h2>
      <div class="msg"> <input type="text" name="title" placeholder="제 목"> </div>  
      <div class="msg"> <textarea name="content" placeholder="내용을 입력하세요"></textarea> </div>
      <div class="msg">
         <input type="button" value="추가" onclick="addform()"> 
         <input type="button" value="삭제" onclick="delform()"> 
      </div>
      <div class="msg" id="outer"> <p class="up"> <input type="file" name="fname1"> </p> </div>
      <div class="msg"> <input type="submit" value="글 저장"> </div> 
    </form>  
  </div>

<%@ include file="../bottom.jsp" %>
<%
 }
%>












