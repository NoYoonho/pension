<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.AdminDao" %> 
<%@page import="java.util.ArrayList" %>
<%@page import="pension.dto.RoomDto" %>   
<%
     // 관리자가 객실 현황을 보는 거 
     AdminDao adao=new AdminDao();
     adao.rlist(request);
     ArrayList<RoomDto> list=(ArrayList<RoomDto>)request.getAttribute("list");
%>    
 <%@ include file="../menu.jsp" %>
  <script>
    function viewroom(id)
    {
    	var chk=new XMLHttpRequest();
    	
    	var x=window.innerWidth;
    	var y=window.innerHeight;
    	
    	x=x/2;
    	y=y/2;
    	
    	x=x-200;
    	y=y-100;
    	
    	    	
    	chk.onload=function()
    	{
    		//alert(chk.responseText);
    		document.getElementById("roomcontent").style.visibility="visible";
    		document.getElementById("roomcontent").style.left=x+"px";
    		document.getElementById("roomcontent").style.top=y+"px";
    		var str="<div align='center'> <input type='button' onclick='hidecontent()' value='닫기'> </div>";
    		document.getElementById("roomcontent").innerHTML=chk.responseText+str;
    	}
    	chk.open("get","viewroom.jsp?id="+id);
    	chk.send();
    }
    function hidecontent()
    {
    	document.getElementById("roomcontent").style.visibility="hidden";
    }
    function addback(my)
    {
    	my.style.background="#eeeeee";
    }
    function delback(my)
    {
    	my.style.background="white";
    }
  </script>
  <style>
    #roomcontent {
       position:absolute;
       width:400px;
       height:200px;
       border:1px solid #cccccc;
       padding:8px;
       background:white;
       visibility:hidden;
    }
    #section {
    width:1100px;
    margin:auto;
  }
 #section table {
     border-spacing:0px;
   }
   #section table tr:hover {
      background:#eeeeee;
   }
   #section table tr:first-child:hover {
      background:white;
   }
   #section table tr:last-child:hover {
      background:white;
   }
   #section table td {
     height:34px;
     font-size:13px;
     border-bottom:1px solid purple;
   }
   #section table tr:first-child td {
     border-top:2px solid purple;
     font-weight:900;
   }
   #section table tr:last-child td {
     border-bottom:2px solid purple;
   }
  </style>
  <!-- rlist.jsp -->
  <div id="section">
   <div id="roomcontent"></div>
   <table width="850" align="center" cellspacing="0">
     <caption> <h3> 객실 현황 </h3></caption>
     <tr>
       <td width="100"> 객실명 </td>
       <td width="80"> 가격 </td>
       <td width="80"> 최소인원 </td>
       <td width="80"> 최대인원 </td>
       <td> 객실사진 </td>
       <td width="50"> 삭제 </td>
       <td width="50"> 수정 </td>
     </tr>
    <%
     for(int i=0;i<list.size();i++)
     {
    %> 
     <tr onmouseover="addback(this)" onmouseout="delback(this)">
       <td onclick="viewroom(<%=list.get(i).getId()%>)"> <%=list.get(i).getName()%> </td>
       <td onclick="viewroom(<%=list.get(i).getId()%>)"> <%=list.get(i).getPrice()%> </td>
       <td> <%=list.get(i).getMin()%> </td>
       <td> <%=list.get(i).getMax()%> </td>
       <td>
        <div id="main" style="width:400px;height:60px;overflow-x:auto">
       <%
          String[] img=list.get(i).getImg().split(","); // aa.jpg, bb.jpg, cc.jpg, 
          
          for(int j=0;j<img.length;j++)
          {
       %>
             <img src="../../room/img/<%=img[j]%>" width="50">
       <%
          }
       %>
        </div>  
       </td>
       <td> <a href="rdelete.jsp?id=<%=list.get(i).getId()%>"> click </a> </td>
       <td> <a href="rupdate.jsp?id=<%=list.get(i).getId()%>"> click </a> </td>
      </tr>
    <%
     }
    %>
      <tr>
        <td colspan="7"> <a href="rwrite.jsp"> 객실 등록하기 </a> </td>
      </tr>
   </table>
  </div>
</body>
</html>






