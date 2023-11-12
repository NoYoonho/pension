<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>    <!-- rdao, rlist 객체변수가 존재해서 문제 -->
<%@page import="pension.dao.ReserveDao" %> 
<%@page import="pension.dto.ReserveDto" %>
<%@page import="pension.dao.MemberDao" %>
<%
     // my_reserve.jsp
     ReserveDao redao=new ReserveDao();
     redao.my_reserve(session,request);
     ArrayList<ReserveDto> relist=(ArrayList<ReserveDto>)request.getAttribute("relist");
%>    
 
  <style>
    #section {
      width:1100px;
      height:500px;
      margin:auto;
      margin-top:50px;
    }
  </style>
  <script>
  
  </script>
  <div id="section">
    <table width="900" align="center">
      <caption> <h2><%=session.getAttribute("name")%>님의 예약 정보</h2></caption>
      <tr align="center">
       <td> 객실명 </td>
       <td> 입실일 </td>
       <td> 퇴실일 </td>
       <td width="50" align="right"> 인원 </td>
       <td width="50" align="right"> bbq </td>
       <td width="50" align="right"> 숯불 </td>
       <td width="100" align="right"> 총결제금액 </td>
       <td> 예약일 </td>
       <td width="100"> 상 태 </td>
       <td width="100"> 신 청 </td>
      </tr>
    <%
     // top.jsp에  RoomDao rdao가 없다면
     //RoomDao rdao2=new RoomDao();
     for(int i=0;i<relist.size();i++)
     {
    	 // ReserveDto rdto=relist.get(i);
    	 // rdto.getInday();
    	 String state;  // String state=""; // default가 없을 경우는 이렇게
    	 switch(relist.get(i).getState())
    	 {
    	    case 0: state="예약완료"; break;
    	    case 1: state="취소신청중"; break;
    	    case 2: state="취소완료"; break;
    	    case 3: state="이용완료"; break;
    	    default: state="";
    	 }
    %>
      <tr>                                      <!-- room테이블의 id를 전달 -->
       <td align="center"> <%=rdao.getRoomName(relist.get(i).getRid())%> </td>
       <td align="center"> <%=relist.get(i).getInday()%> </td>
       <td align="center"> <%=relist.get(i).getOutday()%> </td>
       <td align="right"> <%=relist.get(i).getInwon()%>명 </td>
       <td align="right"> <%=relist.get(i).getBbq()%>개 </td>
       <td align="right"> <%=relist.get(i).getChacol()%>개 </td>
       <td align="right"> <%=pension.util.Util.comma(relist.get(i).getChongprice())%>원 </td>
       <td align="center"> <%=relist.get(i).getWriteday()%> </td>
       <td align="center"> <%=state%> </td>
       <td align="center"> 
        <%
        if(relist.get(i).getState()==0)
        {
        %>
         <%-- <input type="button" value="취소신청" onclick="chgstate(<%=relist.get(i).getId()%>)"> --%>
         <input type="button" value="취소신청" onclick="location='chgstate.jsp?state=1&id=<%=relist.get(i).getId()%>'">
        <%
        }
        
        if(relist.get(i).getState()==1)
        {
        %>
         <input type="button" value="취소신청취소" onclick="location='chgstate.jsp?state=0&id=<%=relist.get(i).getId()%>'">
        <%
        }
        %>
        
        <!-- 리뷰를 쓸수 있는 링크 -->
        <%                              // 리뷰가 작성되었다면 false , 리뷰가 작성이 안되었다면 true
        if(relist.get(i).getState()==3 && MemberDao.isReview(relist.get(i).getJcode())) // 이용완료 : reserve테이블에서 state가 3  && 리뷰가 작성이 안된경우
        {
        %>
         <input type="button" value="리뷰작성" onclick="location='../member/review.jsp?jcode=<%=relist.get(i).getJcode()%>&rid=<%=relist.get(i).getRid()%>'">
        <%
        }
        else if(relist.get(i).getState()==3)
             {
        %>
         <input type="button" value="리뷰완료">
        <%
              }
        %>       
       </td> <!-- 상태에 따라 가능한 동작버튼을 추가 -->
      </tr>
    <%
     }
    %>
    </table>
  
  </div>
  <script>
    function chgstate(id)
    {
    	location="chgstate.jsp?id="+id;
    }
  </script>
<%@ include file="../bottom.jsp" %>




