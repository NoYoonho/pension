<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>
    #menu {
       width:1100px;
       height:50px;
       margin:auto;
       text-align:center;
    }
    #menu ul {
       padding-left:0px;
    }
    #menu ul li {
       display:inline-block;
       list-style-type:none;
       width:100px;
       height:28px;
       line-height:28px;
       text-align:center;
       border:1px solid purple;
    }
    #menu ul li a{
       text-decoration:none;
       color:black;
    }
  </style>
</head>
<body>
   <div id="menu">
     <ul>
       <li> <a href="../member/member_list.jsp"> 회원관리 </a></li>
       <li> <a href="../reserve/reserve_list.jsp"> 예약관리 </a></li>
       <li> <a href="../room/rlist.jsp"> 객실관리 </a></li>
       <li> <a href="../inquiry/inquiry_list.jsp"> 1:1질문 </a></li>
       <li> <a href="../gongji/list.jsp"> 공지사항 </a></li>
       <li> <a href="../../board/list.jsp"> 게시판 </a></li>
       <li> <a href="../../tour/list.jsp"> 여행후기 </a></li>
       <li> <a href="../event/list.jsp"> 이벤트관리 </a></li>
     </ul>
   </div>
 