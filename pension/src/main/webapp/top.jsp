<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- top.jsp -->    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>
    body {
      margin:0px;
    }
    #fouter {
      width:100%;
      height:30px;
      background:#eeeeee;
    }
    #first {
      width:1100px;
      height:30px;
      line-height:30px;
      margin:auto;
      background:#eeeeee;
    }
    #first #left {
      width:1050px;
      display:inline-block;
      text-align:center;
    }
    #first #right {
      width:40px;
      display:inline-block;
      text-align:right;
    }
    #second {
      width:1200px;
      height:80px;
      line-height:30px;
      text-align:right;
      margin:auto;
    }
    #second a {
      text-decoration:none;
      color:black;
    }
    #second #mypage {
      position:relative;
      display:inline-block;
      width:60px;
      height:60px;
    }
    #second #mypage_sub {
      position:absolute;
      padding-left:0px;
      left:-8px;
      top:15px;
      width:80px;
      height:65px;
      border:1px solid #cccccc;
      background:white;
      z-index:10;
      visibility:hidden;
    }
    #second #mypage_sub li{
      list-style-type:none;
      width:80px;
      text-align:center;
      font-size:14px;
      height:20px;
      z-index:10;
    }
    #third {
      width:1100px;
      height:40px;
      line-height:40px;
      margin:auto;
      font-weight:900;
      border-bottom:2px solid #eeeeee;
      z-index:100;
      position:relative;
    }
    #third a {
    text-decoration:none;
      color:black;
    }
    #third ul {
      margin-left:70px;
    }
    #third .main {  /* 주 메뉴 */
      display:inline-block;
      list-style-type:none;
      width:152px;
      height:40px;
      font-size:17px;
      position:relative;
    }
    #third .sub {  /* 부 메뉴 */
      position:absolute;
      padding-left:0px;
      margin-left:0px;
      background:white;
      left:-35px;
      visibility:hidden;
    }
    #third .sub li {
      list-style-type:none;
      width:138px;
      height:40px;
      line-height:40px;
      text-align:center;
    }
     #eighth {
      width:1100px;
      height:160px;
      margin:auto;
      background:#eeeeee;
      padding-top:24px;
      font-size:14px;
    }
    #eighth td {
      height:24px;
    }
 </style>
 <script>
   function menuview(n)
   {
	   document.getElementsByClassName("sub")[n].style.visibility="visible";
   }
   function menuhide(n)
   {
	   document.getElementsByClassName("sub")[n].style.visibility="hidden";
   }
   function mypageview()
   {
	   document.getElementById("mypage_sub").style.visibility="visible";   
   }
   function mypagehide()
   {
	   document.getElementById("mypage_sub").style.visibility="hidden"; 
   }
 </script>
 </head> 
 <body> <!-- index.jsp -->
   <div id="fouter">
     <div id="first">
      <div id="left"> 펜션 오픈 기념 이벤트 1박에 10,000원 </div>
      <div id="right"> X </div> 
     </div>
   </div>
   <div id="second">
      <%
      if(session.getAttribute("userid")==null)
      {
      %> 
        <a href="../member/login.jsp"> 로그인 </a> | <a href="../member/member.jsp"> 회원가입 </a>
        | <a href="../inquiry/write.jsp"> 1:1문의 </a>
      <%
      }
      else if(session.getAttribute("userid").equals("admin"))
           {
      %>
    	      관리자님 |
    		  <a href="../member/logout.jsp"> 로그아웃 </a> |
    		  <a href="../admin/main/index.jsp"> 관리페이지 </a>
      <%
           }
           else
           {
      %>
        <%=session.getAttribute("name")%>님 |
        <a href="../member/logout.jsp"> 로그아웃 </a> |
        <span id="mypage" onmouseover="mypageview()" onmouseout="mypagehide()"> Mypage
           <ul id="mypage_sub">
             <li> <a href="../member/member_view.jsp"> 회원정보 </a> </li>
             <li> <a href="../reserve/my_reserve.jsp"> 예약 정보 </a> </li>
             <li> <a href="../inquiry/mine.jsp"> 나의 글 </a></li>
           </ul> 
        </span> 
         | <a href="../inquiry/write.jsp"> 1:1문의 </a>
      <%
           }
      %>   
        
   
   </div>
   <div id="third">
     <ul>
       <li class="main"> <a href="../main/index.jsp"> HOME </a></li>
       <li class="main" onmouseover="menuview(0)" onmouseout="menuhide(0)"> 펜션소개 
         <ul class="sub">
           <li> 인사말 </li>
           <li> 오시는 길 </li>
         </ul>
       </li>
      <%@page import="pension.dao.RoomDao" %>
      <%@page import="java.util.ArrayList" %>
      <%@page import="pension.dto.RoomDto" %>
      <%
         RoomDao rdao=new RoomDao();
         rdao.getRoom(request);
         ArrayList<RoomDto> rlist=(ArrayList<RoomDto>)request.getAttribute("rlist");
      %>
       <li class="main" onmouseover="menuview(1)" onmouseout="menuhide(1)"> 객실현황 
         <ul class="sub">
         <%
          for(int i=0;i<rlist.size();i++)
          {
         %>
           <li> <a href="../room/room_view.jsp?id=<%=rlist.get(i).getId()%>"> <%=rlist.get(i).getName()%> </a> </li>
         <%
          }
         %>
         </ul>
       </li>
       <li class="main" onmouseover="menuview(2)" onmouseout="menuhide(2)"> 주변관광 
         <ul class="sub">
           <li> 만리포해수욕장 </li>
           <li> 꽃지해수욕장 </li>
           <li> 태안불빛축제 </li>
           <li> 안흥낚시체험 </li>
           <li> 신진도투어 </li>  
         </ul>
       </li>
       <li class="main" onmouseover="menuview(3)" onmouseout="menuhide(3)"> 예약관련 
         <ul class="sub">
           <li> 예약 안내 </li>
           <li> <a href="../reserve/reserve.jsp"> 실시간예약 </a></li>
         </ul>
       </li>
       <li class="main" onmouseover="menuview(4)" onmouseout="menuhide(4)"> 커뮤니티 
         <ul class="sub">
           <li> <a href="../board/list.jsp"> 회원게시판 </a></li>
           <li> <a href="../tour/list.jsp"> 여행후기 </a> </li>
           <li> <a href="../gongji/list.jsp"> 공지사항 </a></li>
         </ul>
       </li>
     </ul>
   </div>



