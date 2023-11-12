<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../menu.jsp" %>
 <%@page import="pension.dao.EventDao"%>
 <%@page import="pension.dto.EventDto" %>
<%
     EventDao edao=new EventDao();
     edao.update(request);
     
     EventDto edto=(EventDto)request.getAttribute("edto");

%>
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
 </style> <!-- webapp/admin/event/update.jsp -->
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
    <form method="post" action="update_ok.jsp" enctype="multipart/form-data">
      <input type="hidden" name="id" value="<%=edto.getId()%>">
      <div class="form"> <input type="text" name="title" value="<%=edto.getTitle()%>"> </div>
      <div class="form"> <textarea name="content"><%=edto.getContent()%></textarea> </div>
      <div class="form"> <input type="text" name="gihan" value="<%=edto.getGihan()%>" id="date"> </div>
      <div class="form"> <img src="img/<%=edto.getImg()%>" width="100"></div>
      <div class="form"> <input type="file" name="fname"> * 사진 변경시 선택 </div>
      <div class="form"> <input type="submit" value="이벤트 수정"> </div>
    </form>
 </div> 
 
</body>
</html>