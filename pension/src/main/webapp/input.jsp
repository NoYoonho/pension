<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script>
   function check1(my)
   {
	   my.value=my.value.replace(/[^0-9]/g,"");
   }
   function check2(my)
   {
	   my.value=my.value.replace(/[0-9]/g,"");
   }
   function check3(my)
   {
	   my.value=my.value.replace(/[a-zA-Z0-9]/g,"");
   }
   function check4(my)
   {
	   my.value=my.value.replace(/[^a-zA-Z]/g,"");
   }
   function check5(my)
   {
	   my.value=my.value.replace(/[!+=-]/g,"");
   }
 </script>
</head>
<body> <!-- input.jsp -->
  <form>
    숫자만 <input type="text" onkeyup="check1(this)"> <p>
    문자만 <input type="text" onkeyup="check2(this)"> <p>
    한글만 <input type="text" onkeyup="check3(this)"> <p>
    영문만 <input type="text" onkeyup="check4(this)"> <p>
    특수문자 <input type="text" onkeyup="check5(this)"> <p>
    
  </form>
</body>
</html>