<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../menu.jsp" %>
 <style>
   textarea {
     width:400px;
     height:200px;
   }
 </style>
  <!-- rwrite.jsp -->
  <!-- 방이름, 방의 가격, 최소인원, 최대인원, content, 사진 -->
  <form method="post" action="rwrite_ok.jsp" enctype="multipart/form-data">
    <table width="700" align="center">
      <caption> <h3> 객실 등록 </h3></caption>
      <tr>
        <td> 객실명 </td>
        <td> <input type="text" name="name"> </td>
      </tr>
      <tr>
        <td> 1박가격 </td>
        <td> <input type="text" name="price"> </td>
      </tr>
      <tr>
        <td> 최소인원 </td>
        <td> <input type="text" name="min"> </td>
      </tr>
      <tr>
        <td> 최대인원 </td>
        <td> <input type="text" name="max"> </td>
      </tr>
      <tr>
        <td> 방의 정보 </td>
        <td> <textarea name="content"></textarea> </td>
      </tr>
      <tr>
        <td rowspan="2"> 객실사진 </td>
        <td> 
            <input type="button" value="추가" onclick="addform()"> 
            <input type="button" value="삭제" onclick="delform()"> 
        </td>
      </tr>
      <tr>
        <td id="outer"> <p class="up"> <input type="file" name="fname1"> </p>  </td>
      </tr>
      <tr>
        <td colspan="2" align="center"> <input type="submit" value="객실등록">   </td>
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
    
    function resize1(size)
    {
    	if(size>4)
    	{
    		
    	}	
    	else
    	{
    		
    	}	
    }
  </script>
</body>
</html>








