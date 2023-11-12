<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
  <style>
    #fourth {
      width:1500px;
      height:400px;
      margin:auto;
      overflow:hidden;
    }
 
    #fourth #mainimg {
      width:8000px;
      height:400px;
    }
    #fifth {
      width:1100px;
      height:200px;
      margin:auto;
 
    }
    #fifth .comm {
      width:350px;
      height:200px;
      float:left;
      margin-left:10px;
      line-height:26px;
      font-size:15px;
    }
    #fifth .comm .title {
      display:inline-block;
      width:240px;
    }
    #fifth .comm .writeday {
      display:inline-block;
      width:100px;
    }
    #fifth .comm a {
      text-decoration:none;
      color:black;
    }
    #sixth {
      clear:both;
      width:1100px;
      height:200px;
      margin:auto;
    }
    #sixth .eventimg {
      margin-left:5px;
    }
    #seventh {
      width:1100px;
      height:250px;
      margin:auto;
      background:pink;
    }
   
  </style>
  <script src="http://code.jquery.com/jquery-latest.js"></script>
  <script>
    $(function()
    {
    	 move();    
    	 $("#mainimg").mouseover(function()
    	 {
    		 move_stop();
    	 });
    	 $("#mainimg").mouseout(function()
    	 {
    		 move();
    	 });
    });
    function move()
    {
    	ss=setInterval(function()
     	{
       	   $("#mainimg").animate(
    	   {
    	     	 marginLeft:"-1500px"
    	   },2000,function()
    	 	      {
    	    	       $("#mainimg").css("margin-left","0px");
    	    	       $(".img").eq(0).insertAfter($(".img").eq(4));
    	    	  });
    	},4000);
    	    	 
    }
    function move_stop()
    {
    	clearInterval(ss);
    }
  </script>
<%@page import="pension.dao.*"%>
<%@page import="pension.dto.*" %>
<%
    GongjiDao gdao=new GongjiDao();
    gdao.getFiveGongji(request);
    ArrayList<GongjiDto> glist=(ArrayList<GongjiDto>)request.getAttribute("glist");
    
    BoardDao bdao=new BoardDao();
    bdao.getFiveBoard(request);
    ArrayList<BoardDto> blist=(ArrayList<BoardDto>)request.getAttribute("blist");
    
    TourDao tdao=new TourDao();
    tdao.getFiveTour(request);
    ArrayList<TourDto> tlist=(ArrayList<TourDto>)request.getAttribute("tlist");
    
    EventDao edao=new EventDao();
    edao.getFourEvent(request);
    ArrayList<EventDto> elist=(ArrayList<EventDto>)request.getAttribute("elist");
%>  
   <div id="fourth">
     <div id="mainimg">
      <img src="../img/main1.jpg" width="1500" height="400" class="img"><img src="../img/main2.jpg" width="1500" height="400" class="img"><img src="../img/main3.jpg" width="1500" height="400" class="img"><img src="../img/main4.jpg" width="1500" height="400" class="img"><img src="../img/main5.jpg" width="1500" height="400" class="img">
     </div>
   </div>
   <div id="fifth"> <!-- 공지사항, 게시판, 여행후기 5개  :  제목 날짜 -->
      <div class="comm">
        <p align="center"> <b>공지사항</b> </p>
      <%
      for(int i=0;i<glist.size();i++)
      {
    	  String title=glist.get(i).getTitle();
    	  if(title.length() >= 16)
    	    title=glist.get(i).getTitle().substring(0,15)+"···.";
      %>
        <span class="title"> <a href="../gongji/readnum.jsp?id=<%=glist.get(i).getId()%>"> <%=title%> </a></span>
        <span class="writeday"> <%=glist.get(i).getWriteday()%></span> <br>
      <%
      }
      %>
      </div>
      <div class="comm">
        <p align="center"> <b>게시판</b> </p>
      <%
      for(int i=0;i<blist.size();i++)
      {
    	  String title=blist.get(i).getTitle();
    	  if(title.length() >= 16)
    	    title=blist.get(i).getTitle().substring(0,15)+"···.";
      %>
        <span class="title"> <a href="../board/readnum.jsp?pager=1&id=<%=blist.get(i).getId()%>"> <%=title%> </a></span>
        <span class="writeday"> <%=blist.get(i).getWriteday()%></span> <br>
      <%
      }
      %>
      </div>
      <div class="comm">
        <p align="center"> <b>여행후기</b> </p>
      <%
      for(int i=0;i<tlist.size();i++)
      {
    	  String title=tlist.get(i).getTitle();
    	  if(title.length() >= 16)
    	    title=tlist.get(i).getTitle().substring(0,15)+"···.";
      %>
        <span class="title"> <a href="../tour/readnum.jsp?pager=1&id=<%=tlist.get(i).getId()%>"> <%=title%> </a></span>
        <span class="writeday"> <%=tlist.get(i).getWriteday()%></span> <br>
      <%
      }
      %>
      </div>
   </div>
   <div id="sixth">
     <%
      for(int i=0;i<elist.size();i++)
      {
     %>
       <img onclick="location='../event/content.jsp?id=<%=elist.get(i).getId()%>'" class="eventimg" src="../admin/event/img/<%=elist.get(i).getImg()%>" width="265" height="200">
     <% 
      }
     %>
   </div>
   <div id="seventh"></div>
   

<%@ include file="../bottom.jsp" %>




