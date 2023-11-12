<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../menu.jsp" %>
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
    #section input[type=file] {
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
    #section .form {
      margin-top:15px;
    }
 </style> <!-- webapp/admin/event/write.jsp -->
 <script src="http://code.jquery.com/jquery-latest.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script> 
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
  <script>
    $(function()
    {
    	 $("#date").datepicker(
    	 {
    		 dateFormat:"yy-mm-dd", // 입력폼에 출력되는 양식
    		 minDate:0 // 오늘 기준으로 이전 선택가능한 날
    		 
    	 });
    });
  </script>
 <div id="section">
    <form method="post" action="write_ok.jsp" enctype="multipart/form-data">
      <div> <h3> 이벤트 등록하기 </h3></div>
      <div class="form"> <input type="text" name="title" placeholder="이벤트 제목"> </div>
      <div class="form"> <textarea name="content" placeholder="이벤트 내용"></textarea> </div>
      <div class="form"> <input type="text" name="gihan" placeholder="이벤트 기한" id="date"> </div>
      <div class="form"> <input type="file" name="fname"> </div>
      <div class="form"> <input type="submit" value="이벤트 등록"> </div>
    </form>
 </div> 
 
</body>
</html>