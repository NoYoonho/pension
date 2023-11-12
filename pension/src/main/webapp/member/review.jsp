<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.MemberDao" %>
<%
     MemberDao mdao=new MemberDao();
     mdao.review(request);
     
     String name=(String)request.getAttribute("name");
     String inday=(String)request.getAttribute("inday");
%>  
<%@ include file="../top.jsp" %>
  <style>
   #section {
     width:1100px;
     height:500px;
     margin:auto;
     margin-top:50px;
   }
   #section input[type=text] {
      width:300px;
      height:30px;
    }
    #section textarea {
      width:300px;
      height:100px;
    }
    #section input[type=submit] {
      width:306px;
      height:33px;
    }
    #section table   {
      border-spacing:20px;
    }
  </style>
  <script>
    function chgstar(n)
    {
    	// 매개변수 n까지 별을 노란색(stat1.png)으로 변경
    	for(i=0;i<=n;i++)
    	{
    		document.getElementsByClassName("star")[i].src="../img/star1.png";
    	}	
    	
    	// 클릭된 위치 오른쪽 별은 회색으로 (star2.png)
    	for(i=n+1;i<5;i++)
        {
    		document.getElementsByClassName("star")[i].src="../img/star2.png";
        }    
    	
    	document.pkc.star.value=n+1;
    }
    function check(my)
    {
    	if(my.star.value==0)
    	{
    		alert("별점을 주세요");
    		return false;
    	}	
    	else if(my.content.value.trim()=="")
    		 {
    		    alert("상세리뷰를 적으세요");
    		    return false;
    		 }
    	     else if(my.title.value.trim()=="")
    	    	  {
    	    	     alert("한줄 요약을 적으세요");
    	    	     return false;
    	    	  }
    	          else
    		         return true;
    }
  </script> <!-- member/review.jsp -->
  <div id="section">
   <form name="pkc" method="post" action="review_ok.jsp" onsubmit="return check(this)">
    <input type="hidden" name="star" value="0">
    <input type="hidden" name="rid" value="<%=request.getParameter("rid")%>"> 
    <input type="hidden" name="jcode" value="<%=request.getParameter("jcode")%>">
    <table width="500" align="center">
      <caption> <h3><%=inday%> : <%=name%>  </h3></caption>
      <tr>
        <td align="center"> 별 점 </td>
        <td> 
          <img src="../img/star2.png" onclick="chgstar(0)" class="star">
          <img src="../img/star2.png" onclick="chgstar(1)" class="star">
          <img src="../img/star2.png" onclick="chgstar(2)" class="star">
          <img src="../img/star2.png" onclick="chgstar(3)" class="star">
          <img src="../img/star2.png" onclick="chgstar(4)" class="star">
        </td>
      </tr>  
      <tr>
        <td align="center"> 상세리뷰 </td>
        <td> <textarea name="content" maxlength="200"></textarea> </td>
      </tr>  
      <tr>
        <td align="center"> 한줄요약 </td>
        <td> <input type="text" name="title"> </td>
      </tr>    
      <tr>
        <td>&nbsp;</td>
        <td>
          <input type="submit" value="리뷰 작성하기">
        </td> 
      </tr>
    </table>
   </form>
  </div>

<%@ include file="../bottom.jsp" %>









