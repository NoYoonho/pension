<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.RoomDao" %>
<%@page import="pension.dto.RoomDto" %>
<%@page import="pension.util.Util" %>
<%@page import="pension.dao.MemberDao" %>
<%@page import="pension.dto.ReviewDto" %>

<%
     RoomDao rdao2=new RoomDao();
     rdao2.room_view(request);
     RoomDto rdto=(RoomDto)request.getAttribute("rdto");
     
     // 현재 보여주는 객실의 리뷰를 읽어오기 : room 테이블의 id
     // review.jsp는 member폴더에 존재 : MemberDao에 추가
     MemberDao mdao=new MemberDao();
     mdao.getReview(request);
     ArrayList<ReviewDto> reviewlist=(ArrayList<ReviewDto>)request.getAttribute("reviewlist");
     double staravg=(double)request.getAttribute("staravg");
%>    
<%@ include file="../top.jsp" %>
  <style>
    #section {
      width:1100px;
      margin:auto;
      margin-top:50px;
      margin-bottom:30px;
    }
    #section #cont {
      width:430px;
      height:100px;
      border:1px solid #cccccc;
      overflow:auto;
    }
  </style>
  <script>
  
  </script>
  <div id="section">
    <table width="800" align="center">
      <caption>
        <h3> <%=rdto.getName()%> 객실 현황 
         <%
          //staravg=3.5; // 완성되면 주석으로
          int n=(int)staravg; // 노란별 갯수
          if(staravg-n>0.8) // .8보다 큰수는 노란별로 하기 위해 1증가
        	  n++;
           
          for(int i=1;i<=n;i++) // 노란별 출력
          {
         %>
            <img src="../img/star1.png">
         <%
          }
         %>
         <!-- 반별 짜리 -->
         <%
          if(n+0.3<=staravg && staravg<=n+0.8)  // .8이 넘어야 노란별,  .3~.8사이는 반별
          {
         %>
            <img src="../img/star3.png">
         <%	  
            n++; // 반별이 출력되었으므로 n의 값을 증가시켜서 회색별을 하나 감소
          }
         %>
         
         <!-- 회색별 -->
         <%
  
          for(int i=1;i<=5-n;i++)
          {
         %>
            <img src="../img/star2.png">
         <%
          }
         %>
         
        
        </h3>
      </caption>
      <tr>
        <td> 기준인원 </td>
        <td> <%=rdto.getMin()%>명 </td>
        <td> 최대인원 </td>
        <td> <%=rdto.getMax()%>명 </td>
      </tr>
      <tr>
        <td> 1박 가격 </td>
        <td> <%=Util.comma(rdto.getPrice())%>원 </td>
        <td colspan="2"> 1인 추가 : 10,000원 </td>
      </tr>
      <tr>
        <td colspan="4"> <%=rdto.getContent()%> </td>
      </tr>
      <tr>
        <td colspan="4"> 객실 사진 </td>
      </tr>
      <tr>
        <td colspan="4" align="center"> 
        <%
           //String[] arrayimg=(String[])request.getAttribute("arrayimg");
        %>
           <input type="button" value="<<" onclick="leftview()">
           <img id="roomimg" src="img/<%=rdto.getArrayimg()[0]%>" width="500" height="300" valign="middle">
           <input type="button" value=">>" onclick="rightview()">
        </td>
      </tr>
    </table>
    
    <table width="800" align="center">
     <%
     for(int i=0;i<reviewlist.size();i++)
     {
    	 int num=reviewlist.get(i).getStar();
     %>
      <tr>
        <td width="150">
         <!-- 노란별, 회색별 출력 -->
         <%
           for(int j=1;j<=num;j++)
           {
         %>
            <img src="../img/star1.png" width="20">
         <%
           }
         %>
         <%
           for(int j=1;j<=5-num;j++)
           {
         %>
            <img src="../img/star2.png" width="20">
         <%
           }
         %>
        </td>
        <td width="200"> <%=reviewlist.get(i).getTitle()%> </td>
        <td> 
         <div id="cont">
          <%=reviewlist.get(i).getContent()%>
         </div> 
        </td>
      </tr>
     <%
     }
     %>
    </table>
    
  </div>
  <script>
    <%
       String[] arrayimg=rdto.getArrayimg();
    
       String imsi="";
       for(int i=0;i<arrayimg.length;i++)
       {
    	   imsi=imsi+"'"+arrayimg[i]+"'";
    	   if(i != arrayimg.length-1) // 마지막 요소가 아닌 경우에만 , 를 붙인다
    	   {	   
    	      imsi=imsi+",";
    	   }
       }
    %>    
    var img=[<%=imsi%>];
    var imgindex=0;
    function leftview()
    {
    	imgindex--;
    	if(imgindex<0)
    	{
    		imgindex=img.length-1;
    	}	
    	document.getElementById("roomimg").src="img/"+img[imgindex];
    }
    function rightview()
    {
    	imgindex++;
    	if(imgindex == img.length)
    	{
    		imgindex=0;
    	}	
    	document.getElementById("roomimg").src="img/"+img[imgindex];
    }
  </script>
<%@ include file="../bottom.jsp" %>










