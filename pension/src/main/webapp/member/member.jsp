<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
 <style>
   #section {
      width:1100px;
      height:500px;
      margin:auto;
      text-align:center;
      margin-top:50px;
   }
   #section #uid {
      font-size:11px;
   }
   #section #pchk {
      font-size:11px;
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
 </style>
 <script>
   function check(my)
   {
	    // 아이디를 4자 이상일때 체크가 가능해야 된다..
	    // 아이기가 4자 미만이면 메시지가 필요
	    if(my.value.length >= 4)
	    {
	        var chk=new XMLHttpRequest();
	        chk.onload=function()
	        {
		         //alert(chk.responseText); // 서버에서 동작후에 돌아오는 텍스트
		        if(chk.responseText.trim()=="1")
		        {
		   	        document.getElementById("uid").innerText="사용 불가능 아이디";
			        document.getElementById("uid").style.color="red";
			        userid_chk=0;
		        }
		        else
		        {
			        document.getElementById("uid").innerText="사용 가능 아이디";
			        document.getElementById("uid").style.color="blue";
			        userid_chk=1;
		        }
	         }
	         chk.open("get","userid_check.jsp?userid="+my.value); // userid_check.jsp?userid=channy
	         chk.send();
	    }
	    else
	    {
	    	document.getElementById("uid").innerText="아이디 길이는 4자 이상입니다.";
	        document.getElementById("uid").style.color="red";
	        userid_chk=0;
	    }	
   }
   
   function pcheck()
   {
	   var pwd1=document.mform.pwd.value;
	   var pwd2=document.mform.pwd2.value;
	   
	   if(pwd2.length>0)
	   {	   
	      if(pwd1==pwd2)
	      {
		      document.getElementById("pchk").innerText="비빌번호가 일치합니다";
		      document.getElementById("pchk").style.color="blue";
		      pwd_chk=1;
	      }	
	      else
	      {
		      document.getElementById("pchk").innerText="비빌번호가 일치하지 않습니다";
		      document.getElementById("pchk").style.color="red";
		      pwd_chk=0;
	      }	  
	   }
   }
   
   var userid_chk=0;
   var pwd_chk=0;
   function member_check()
   {
	   // 아이디가 사용불가능인지
	   if(userid_chk==0)
	   {
		   alert("아이디 중복체크 혹은 길이를 다시 확인하세요");
		   return false;
	   }	   
	   else if(pwd_chk==0)
		    {
		       alert("비밀번호를 체크하세요");
		       return false;
		    }
	        else
	        {
	        	return true;
	        }	
	   // 비밀번호가 둘다 일치하는지
   }
 </script>
 
  <div id="section">
     <div align="center"> <h3> 회원 가입 </h3></div>
     <form name="mform" method="post" action="member_ok.jsp" onsubmit="return member_check()">
       <!-- 아이디 중복확인은 아이디입력폼에서 blur될때 ajax로 확인 -->
       <input type="text" name="userid" placeholder="아이디" onblur="check(this)">
       <br><span id="uid"></span>
        <p>
       <input type="text" name="name" placeholder="이름"> <p>
       <input type="password" name="pwd" placeholder="비밀번호" onkeyup="pcheck()"> <p>
       <input type="password" name="pwd2" placeholder="비밀번호확인" onkeyup="pcheck()">
       <br><span id="pchk"></span>
        <p>
       <input type="text" name="phone" placeholder="전화번호"> <p>
       <input type="text" name="email" placeholder="이메일"> <p>
       <input type="submit" value="가입하기">     
     </form>
  </div>


<%@ include file="../bottom.jsp" %>