<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ include file="../top.jsp" %> 
 <!-- reserve.jsp -->
<%@page import="pension.dao.ReserveDao"%>
<%@page import="pension.dao.RoomDao" %>
<%@page import="pension.util.Util" %>
<%
    ReserveDao rdao2=new ReserveDao();
    rdao2.getCalendar(request);
    
    int yoil=(int)request.getAttribute("yoil");
    int chong=(int)request.getAttribute("chong");
    int ju=(int)request.getAttribute("ju");
    int year=(int)request.getAttribute("year");
    int month=(int)request.getAttribute("month");
    
 /*    // 방의 정보를 구해오기 => 객실명,id
    RoomDao rdao3=new RoomDao();
    rdao3.getRoom(request);
    ArrayList<RoomDto> rlist3=(ArrayList<RoomDto>)request.getAttribute("rlist");
     */
%>
<style>
  #section {
    width:1100px;
    margin:auto;
    margin-bottom:50px;
    margin-top:50px;
  }
  #section a {
    text-decoration:none;
    color:black;
  }
  #section table caption {
    font-size:20px;
    height:40px;
  }
</style>
<div id="section">
  <table width="1000" height="600" align="center" border="1">
    <caption>
      <a href="reserve.jsp?year=<%=year%>&month=<%=month-1%>"> ← </a>
      <%=year%>년 <%=month%>월
      <a href="reserve.jsp?year=<%=year%>&month=<%=month+1%>"> → </a>
    </caption>
    <tr height="30">
      <td> 일 </td>
      <td> 월 </td>
      <td> 화 </td>
      <td> 수 </td>
      <td> 목 </td>
      <td> 금 </td>
      <td> 토 </td>
    </tr>
   <%

   int day=1;
   for(int i=1;i<=ju;i++)
   {
   %>
     <tr> <!-- <%=i%>행 -->
     <%
    for(int j=0;j<7;j++)
     {
       if( (j<yoil && i==1) || (chong < day) )  // 1일 이전의 요일은 빈칸,  총일수보다 큰 곳도 빈칸
       {
     %>
        <td> &nbsp; </td>
     <%
       }  
       else
       {
    	   
     %>
        <td> <%=day%> <p>
          <!-- 방 출력 -->
          <%
      boolean kk=Util.isCheck(year, month, day);
      if(!kk)
      {
          for(int k=0;k<rlist.size();k++)
          {
        	  
        	// ?년?월?일 특정방이 예약되었느냐를 검사
        	boolean chk=rdao2.isEmpty(year, month, day, rlist.get(k).getId());
        	if(chk)
        	{
          %>
            <a href="reserve_next.jsp?year=<%=year%>&month=<%=month%>&day=<%=day%>&id=<%=rlist.get(k).getId()%>"> <%=rlist.get(k).getName()%> </a> <br>
          <%
        	}
        	else
        	{
          %>  
            <span style="color:red"> <%=rlist.get(k).getName()%> </span><br>
          <%
        	} // if문 종료
          } // k변수 for문 종료 (객실출력되는 부분)
      } // 날짜 체크 if문 종료
          %>
          
        </td>
     <%
         day++;
       } // else 끝
     } // j변수 for끝
       
       
     %> 
     </tr>
   <%
   
   } // i변수의 for 끝
   %>
  </table>
</div>
<%@ include file="../bottom.jsp" %>






