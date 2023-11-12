<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  ReserveDao redao=new ReserveDao();

  if(session.getAttribute("userid")==null)
  {
	  // 년,월,일,방id
	  redao.sendlogin(request,response);
  }
  else
  {
%>    
<%@ include file="../top.jsp" %>
<%@page import="pension.dao.ReserveDao" %>
<%@page import="pension.util.Util" %>
<%

     // 방의 정보
     redao.getRoomInfo(request);
     RoomDto rdto=(RoomDto)request.getAttribute("rdto");
     
 
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
    function priceChg(my)
    {
    	// 숙박가격 구하기
    	var suk=parseInt(my.suk.value);
    	var sprice=suk*<%=rdto.getPrice()%>;
    	// 인원 가격 구하기
    	var inwon=parseInt(my.inwon.value);
    	var iprice=(inwon-<%=rdto.getMin()%>)*10000;
    	// bbq 가격 구하기
    	var bbq=parseInt(my.bbq.value);
    	var bprice=bbq*35000;
    	// 숯불가격 구하기
    	var chacol=parseInt(my.chacol.value);
    	var cprice=chacol*20000;
    	// 각 가격요소에 전달
    	document.getElementById("sukprice").innerText=comma(sprice);
    	document.getElementById("inwonprice").innerText=comma(iprice);
    	document.getElementById("bbqprice").innerText=comma(bprice);
    	document.getElementById("chacolprice").innerText=comma(cprice);
    	var chong=sprice+iprice+bprice+cprice;
    	document.getElementById("chongprice2").value=chong;
    	document.getElementById("chongprice").innerText=comma(chong);
    }
    
    function comma(num)
    {
    	return new Intl.NumberFormat().format(num);
    }
    //comma(12345678);
    function comma1(price)
    {
       n=price.length; // 변경할 값의 길이를 구하기
        var num="";
        for(i=0;i<n;i++)
       {
          if(i%3==0&&i!=0)
            num=","+num;
          
     	   num=price.substr(price.length-1,1)+num;
          price=price.substring(0,price.length-1);
       }
        return num;
    }
    //alert(comma1("12345678"));
    function comma2(price)
    {
	   price=price.replace(/\B(?=(\d{3})+(?!\d))/g,",");
	   return price; 
    }
    //alert(comma2("12345678"));
  </script><!-- reserve_next.jsp -->
  <div id="section">
    <%
         int num=rdto.getPrice();
         String price=Util.comma(num);
         String inday=(String)request.getAttribute("inday");
         String inday2=(String)request.getAttribute("inday2");
     %>
    <form method="post" action="reserve_ok.jsp">
      <input type="hidden" name="inday" value="<%=inday2%>">
      <input type="hidden" name="rid" value="<%=rdto.getId()%>">
      <input type="hidden" name="chongprice" id="chongprice2" value="<%=rdto.getPrice()%>">
     <table width="600" align="center">

       <caption> <h3> 예약하기 </h3></caption>
       <tr>
         <td> 객실명 </td>
         <td> <%=rdto.getName()%> </td>
         <td> 가격(1박) </td>
         <td> <%=Util.comma(rdto.getPrice())%>원 </td>
       </tr>
       <%
          int suk=redao.getSuk(request);
       %>
       <tr>
         <td> 입실일 </td>
         <td> <%=inday%> </td>
         <td> 숙박일수 </td>
         <td> 
           <select name="suk" onchange="priceChg(this.form)">
           <%
           for(int i=1;i<=suk;i++)
           {
           %>
             <option value="<%=i%>"> <%=i%>박 </option>
           <%
           }
           %>
           </select>
         </td>
       </tr>
       <tr>
         <td> 기준인원 </td>
         <td> <%=rdto.getMin()%>명 </td>
         <td> 입실인원 </td>
         <td> 
           <select name="inwon"  onchange="priceChg(this.form)">
           <%
           for(int i=rdto.getMin();i<=rdto.getMax();i++)
           {
           %>
             <option value="<%=i%>"> <%=i%>명 </option>
           <%
           }
           %>  
           </select>
         </td>
       </tr>
       <tr>
         <td> bbq패키지<br>(1개 : 35,000원) </td>
         <td> 
           <select name="bbq" onchange="priceChg(this.form)">
            <option value="0"> 선택안함 </option>
           <%
             for(int i=1;i<=10;i++)
             {
           %>
             <option value="<%=i%>"> <%=i%>개 </option>
           <%
             }
           %>
           </select>
         </td>
         <td> 숯불패키지<br> (1회 : 20,000원) </td>
         <td> 
           <select name="chacol" onchange="priceChg(this.form)">
            <option value="0"> 선택안함 </option>
           <%
             for(int i=1;i<=10;i++)
             {
           %>
             <option value="<%=i%>"> <%=i%>개 </option>
           <%
             }
           %>
           </select>
         </td>
       </tr>
       <tr>
         <td> 숙박 가격 </td>
         <td colspan="3" align="right"> <span id="sukprice"><%=Util.comma(rdto.getPrice())%></span>원 </td> 
       </tr>
       <tr>
         <td> 인원 추가 </td>
         <td colspan="3" align="right"> <span id="inwonprice">0</span>원 </td> 
       </tr>
       <tr>
         <td> BBQ 가격 </td>
         <td colspan="3" align="right"> <span id="bbqprice">0</span>원 </td> 
       </tr>
       <tr>
         <td> 숯불 가격 </td>
         <td colspan="3" align="right"> <span id="chacolprice">0</span>원 </td> 
       </tr>
       <tr>
         <td> 총 결제금액 </td>
         <td colspan="3" align="right"> <span id="chongprice"><%=Util.comma(rdto.getPrice())%></span>원 </td> 
       </tr>
       <tr>
         <td colspan="4"> <input type="submit" value="예약하기">
       </tr>
     </table>
    </form>
  </div>

<%@ include file="../bottom.jsp" %>
<%
  }
%>  
 