<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Random" %>
<%
    // write_ok.jsp
    
    // DB연결
 	Class.forName("com.mysql.jdbc.Driver");  
	String db="jdbc:mysql://localhost:3306/pension";
	Connection conn=DriverManager.getConnection(db,"root","1234");

	Random rand=new Random();
    // 읽어오기
    request.setCharacterEncoding("utf-8");

    String[] userid1={"channy","super","batman","hong","pororo"};
    
    
    String[] title1={"페이지를 처리하고 있습니다 ","오늘은 월요일입니다","내일은 화요일입니다","열심히 공부합시다","오늘도 놀고싶다!! 여러본!!"};
    
    String content="학교종이 땡땡땡 어서 모이자";
    PreparedStatement pstmt=null;
    for(int i=1;i<=2459;i++)
    {
      String title=title1[rand.nextInt(5)];
      String userid=userid1[rand.nextInt(5)];
      // 쿼리 생성
      String sql="insert into board(userid,title,content,writeday) values(?,?,?,now())";
      // 심부름꾼 생성
      pstmt=conn.prepareStatement(sql);
      pstmt.setString(1, userid);
      pstmt.setString(2, title+" "+i);
      pstmt.setString(3, content);
    
    // 쿼리 실행
    pstmt.executeUpdate();
    }
    // 닫기
    pstmt.close();
    conn.close();
    
    // 이동(list)
    response.sendRedirect("list.jsp");
%>






