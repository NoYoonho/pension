<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../menu.jsp" %>
 
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
      border:1px solid purple;
    }
    #section textarea {
      width:400px;
      height:100px;
      border:1px solid purple;
    }
    #section input[type=submit] {
      width:406px;
      height:33px;
      border:1px solid purple;
      background:purple;
      color:white;
      font-weight:900;
    }
 
    #section .gong {
      width:410px;
      margin:auto;
      margin-top:20px;
    }
  </style>
  <!-- /webapp/admin/gongji/write.jsp -->
  <div id="section">
   <form method="post" action="write_ok.jsp">
     <h2> 공지사항 등록</h2>
     <div class="gong"> <input type="text" name="title" placeholder="제 목"> </div>
     <div class="gong"> <textarea name="content" placeholder="공지사항 내용쓰기"></textarea> </div>
     <div class="gong" align="left"> <input type="checkbox" value="1" name="step"> 항상 첫페이지에 공지하기 </div>
     <div class="gong"> <input type="submit" value="공지사항 등록하기"> </div>
   </form>
    
    
  </div>
  
 </body>
 
</html>









