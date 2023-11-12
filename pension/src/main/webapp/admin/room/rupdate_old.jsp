<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.AdminDao" %>
<%@page import="pension.dto.RoomDto" %>
<%
    AdminDao adao=new AdminDao();
    adao.rupdate(request);
    RoomDto rdto=(RoomDto)request.getAttribute("rdto");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
   textarea {
     width:400px;
     height:200px;
   }
 </style>
 <script>
   function check(my)
   {
	   // 삭제할 이미지랑 존재할 이미지 이름을 분리한 후 폼태그내에 전달
	   // 삭제이미지를 저장할 변수, 존재이미지를 저장할 변수
	   var delimg="";  // ,로 구분하여 저장
	   var eximg="";
	   
	   // checkbox의 객체를 자바변수에 저장
	   var oimg=document.getElementsByClassName("oimg");
	   
	   // checkbox의 길이
	   var len=oimg.length;
	   
	   for(i=0;i<len;i++)
	   {
		   if(oimg[i].checked)
		   {
			   delimg=delimg+oimg[i].value+",";
		   }	
		   else
		   {
			   eximg=eximg+oimg[i].value+","; 
		   }	   
	   }	   
	   
	   //alert(delimg+"\n"+eximg);
	   // 폼태그에 전달
	   my.delimg.value=delimg;
	   my.eximg.value=eximg;
	    
   }
 </script>
</head>
<body> <!-- rupdate.jsp -->
  <!-- 방이름, 방의 가격, 최소인원, 최대인원, content, 사진 -->
  <form method="post" action="rupdate_ok.jsp" enctype="multipart/form-data" onsubmit="return check(this)">
    <input type="hidden" name="id" value="<%=rdto.getId()%>">
    <input type="hidden" name="delimg"> <!-- 삭제할 이미지 : 이름은 ,로 구분해서-->
    <input type="hidden" name="eximg"> <!-- 존재할 이미지 -->
    <table width="700" align="center">
      <caption> <h3> 객실 수정 </h3></caption>
      <tr>
        <td> 객실명 </td>
        <td> <input type="text" name="name" value="<%=rdto.getName()%>"> </td>
      </tr>
      <tr>
        <td> 1박가격 </td>
        <td> <input type="text" name="price" value="<%=rdto.getPrice()%>"> </td>
      </tr>
      <tr>
        <td> 최소인원 </td>
        <td> <input type="text" name="min" value="<%=rdto.getMin()%>"> </td>
      </tr>
      <tr>
        <td> 최대인원 </td>
        <td> <input type="text" name="max" value="<%=rdto.getMax()%>"> </td>
      </tr>
      <tr>
        <td> 방의 정보 </td>
        <td> <textarea name="content"><%=rdto.getContent()%></textarea> </td>
      </tr>
      <tr>
        <td> 객실사진 </td>
        <td>
          * 삭제할 사진을 체크해주세요 <p>
         <%
          for(int i=0;i<rdto.getArrayimg().length;i++)
          {
         %>
             <img src="../../room/img/<%=rdto.getArrayimg()[i]%>" width="40">
             <input type="checkbox" class="oimg" value="<%=rdto.getArrayimg()[i]%>">
         <%
          }
         %>
        </td>
      </tr>
      <tr>
        <td rowspan="2"> 사진추가 </td>
        <td> 
            <input type="button" value="추가" onclick="addform()"> 
            <input type="button" value="삭제" onclick="delform()"> 
        </td>
      </tr>
      <tr>
        <td id="outer"> <p class="up"> <input type="file" name="fname1"> </p>  </td>
      </tr>
      <tr>
        <td colspan="2" align="center"> <input type="submit" value="객실수정">   </td>
      </tr>
    </table>
 
  </form>
  <script>
    function addform()
    {
    	var size=document.getElementsByClassName("up").length;
    	if(size<10)
        {
    	   var out=document.getElementById("outer");
    	   out.innerHTML=out.innerHTML+"<p class='up'> <input type='file' name='fname"+(size+1)+"'> </p>";
        }
    }
    function delform()
    {
    	var size=document.getElementsByClassName("up").length;
    	if(size!=1)
    	{	
    	    document.getElementsByClassName("up")[size-1].remove();
    	}
    }
    
  </script>
</body>
</html>








