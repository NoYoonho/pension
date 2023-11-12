<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.TourDao" %>
<%@page import="pension.dto.TourDto" %>      
<% 
 // write.jsp
 if(session.getAttribute("userid")==null)
 {
	 response.sendRedirect("../member/login.jsp");
 }
 else
 {
	 TourDao tdao=new TourDao();
	 tdao.update(request);
	 
	 TourDto tdto=(TourDto)request.getAttribute("tdto");
	 String pager=(String)request.getAttribute("pager");
%>
<%@ include file="../top.jsp" %>
  <style>
    #section {
      width:1100px;
      height:500px;
      margin:auto;
      margin-top:50px;
      text-align:center;
    }
    #section input[type=text] {
      width:400px;
      height:30px;
    }
    #section textarea {
      width:400px;
      height:100px;
    }
    #section input[type=submit] {
      width:406px;
      height:33px;
    }
    #section .msg {
      margin-top:20px;
    }
  </style>
    <script>
  function addform()
  {
  	var size=document.getElementsByClassName("up").length;
  	if(size<10)
      {
  	   var out=document.getElementById("outer");
  	   out.innerHTML=out.innerHTML+"<p class='up'> <input type='file' name='fname"+(size+1)+"'> </p>";
  	   resize1(size+1);
      }
  
  	
  }
  function delform()
  {
  	var size=document.getElementsByClassName("up").length;
  	if(size!=1)
  	{	
  	    document.getElementsByClassName("up")[size-1].remove();
  	    resize1(size);
  	}
  	  	
  }
  var hh=500;
  function resize1(size)
  {
	
   	 if(size>1)
  	 {
  		ss=((size-1)*37)+500;
  		document.getElementById("section").style.height=ss+"px";
  	 }	
  	 else
  	 {
  		document.getElementById("section").style.height="500px";
  	 }	
  }
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
  
  function selectimg(n,my)
  {
	   if(document.getElementsByClassName("oimg")[n].checked) // oimg의 n번째 checkbox의 checked속성에 따라서 
	   {
	       document.getElementsByClassName("oimg")[n].checked=false;
	       my.style.opacity=1;
	   }
	   else
	   {	   
	       document.getElementsByClassName("oimg")[n].checked=true;
	       my.style.opacity=0.2;
	   }
  }
  </script>
 
  <div id="section">
    <form method="post" action="update_ok.jsp" enctype="multipart/form-data" onsubmit="return check(this)">
     <%
     if(request.getParameter("mychk")!=null)
     {
     %>
      <input type="hidden" name="mychk" value="<%=request.getParameter("mychk")%>">
     <%
     }
     %>
      <input type="hidden" name="delimg">
      <input type="hidden" name="eximg">
      <input type="hidden" name="pager" value="<%=pager%>">
      <input type="hidden" name="id" value="<%=tdto.getId()%>">
      <h2> 여행후기 수정 </h2>
      <div class="msg"> <input type="text" name="title" placeholder="제 목" value="<%=tdto.getTitle()%>"> </div>  
      <div class="msg"> <textarea name="content" placeholder="내용을 입력하세요"><%=tdto.getContent()%></textarea> </div>
      <div class="msg">
         * 삭제할 사진을 체크해주세요 <p>
         <%
          for(int i=0;i<tdto.getImgs().length;i++)
          {
        	  if( !tdto.getImgs()[i].equals(""))
        	  {
         %>
             <img src="img/<%=tdto.getImgs()[i]%>" width="40" onclick="selectimg(<%=i%>,this)">
             <input style="display:none" type="checkbox" class="oimg" value="<%=tdto.getImgs()[i]%>">
         <%
        	  }
          }
         %>
      </div>
      <div class="msg">
         <input type="button" value="추가" onclick="addform()"> 
         <input type="button" value="삭제" onclick="delform()"> 
      </div>
      <div class="msg" id="outer"> <p class="up"> <input type="file" name="fname1"> </p> </div>
      
      <div class="msg"> <input type="submit" value="글 수정"> </div> 
    </form>  
  </div>

<%@ include file="../bottom.jsp" %>
<%
 }
%>












