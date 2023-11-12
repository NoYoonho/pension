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
      background:yellow;
    }
    #sixth {
      width:1100px;
      height:200px;
      margin:auto;
      background:green;
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
    });
   
  </script>
   <div id="fourth">
     <div id="mainimg">
      <img src="../img/main1.jpg" width="1500" height="400" class="img"><img src="../img/main2.jpg" width="1500" height="400" class="img"><img src="../img/main3.jpg" width="1500" height="400" class="img"><img src="../img/main4.jpg" width="1500" height="400" class="img"><img src="../img/main5.jpg" width="1500" height="400" class="img">
     </div>
   </div>
   <div id="fifth">
      
   </div>
   <div id="sixth"></div>
   <div id="seventh"></div>
  

<%@ include file="../bottom.jsp" %>




