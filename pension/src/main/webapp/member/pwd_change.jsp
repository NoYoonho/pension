<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
   input[type=password] {
      width:140px;
      height:23px;
      border:1px solid #cccccc;
      outline:none;
   }
   input[type=submit] {
      width:146px;
      height:25px;
      border:1px solid #cccccc;
      background:#cccccc;
   }
   #pchk {
     font-size:11px;
   }
 </style>
 <script>
 var pwd_chk=0; // 비밀번호가 일치하면 1, 아니면 0
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
  function formcheck(my)  // my=document.mform
  {
	  if(my.opwd.value.trim()=="")
	  {
		  alert("기존 비밀번호를 입력하세요");
		  return false;
	  }
	  else if(pwd_chk==0)
		   {
		       alert("새 비밀번호가 일치하지 않아요");
		       return false;
		   }
	       else
	       {
	    	   return true;
	       }	    
  }
 
 </script>
</head>
<body>
    <form name="mform" method="post" action="pwd_change_ok.jsp" onsubmit="return formcheck(this)">
      <p align="center"> <input type="password" name="opwd" placeholder="기존 비밀번호"> </p> 
      <p align="center"> <input type="password" name="pwd" placeholder="새 비밀번호" onkeyup="pcheck()"> </p>  
      <p align="center"> 
         <input type="password" name="pwd2" placeholder="비밀번호 확인" onkeyup="pcheck()"> 
         <br> <span id="pchk"></span>
      </p> 
      <p align="center"> <input type="submit" value="비밀번호 변경"> </p>
    </form>
</body>
</html>