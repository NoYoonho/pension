package pension.dao;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

import pension.dto.MemberDto;
import pension.dto.ReviewDto;

public class MemberDao {
    Connection conn;
    PreparedStatement pstmt;
    ResultSet rs;
	public MemberDao() throws Exception
	{
		// DB연결
		Class.forName("com.mysql.jdbc.Driver"); // 라이브러리를 찾아라
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void member_ok(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
	    // 읽어오기
		request.setCharacterEncoding("utf-8");
		String userid=request.getParameter("userid");
		String pwd=request.getParameter("pwd");
		String phone=request.getParameter("phone");
		String email=request.getParameter("email");
		String name=request.getParameter("name");
		
		// 쿼리 생성
		String sql="insert into member(userid,pwd,phone,email,name,writeday)";
		sql=sql+" values(?,?,?,?,?,now())";
		
		// 심부름꾼 생성
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.setString(2, pwd);
		pstmt.setString(3, phone);
		pstmt.setString(4, email);
		pstmt.setString(5, name);
		
		// 쿼리 실행
		pstmt.executeUpdate();
		
		// 닫기
		pstmt.close();
		conn.close();
		
		// 이동 => login.jsp
		response.sendRedirect("login.jsp");
	}
	
	public void userid_check(HttpServletRequest request,
			JspWriter out) throws Exception
	{
		// 읽어오기(아이디)
		String userid=request.getParameter("userid");
		
		// 쿼리 생성
		String sql="select count(*) as cnt from member where userid=?"; 
		
		// 심부름꾼 생성
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		
		// 쿼리실행
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		out.print( rs.getInt("cnt") );
		
		// 실행결과에 따라 두개의 값중에 하나를 보낸댜..
	}
	
	public void login_ok(HttpServletRequest request,
			HttpSession session,
			HttpServletResponse response) throws Exception
	{
		// 읽어오기
		String userid=request.getParameter("userid");
		String pwd=request.getParameter("pwd");
		String year=request.getParameter("year");
		String month=request.getParameter("month");
		String day=request.getParameter("day");
		String id=request.getParameter("id");
		
		 
		
		// 아이디,비번으로 사용자가 맞는지 체크
		String sql="select * from member where userid=? and pwd=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.setString(2, pwd);
		
		ResultSet rs=pstmt.executeQuery();
		
		if(rs.next()) 
		{
			// 세션변수를 생성
			session.setAttribute("userid", userid);
			session.setAttribute("name", rs.getString("name"));
			// 메인페이지로 이동
			if(year==null)
			{   // top.jsp, login_ok.jsp, member_ok.jsp를 통해 login으로 온경우
			    response.sendRedirect("../main/index.jsp");
			}
			else
			{
				// 예약하다 온 경우  reserve_next.jsp에서 온 경우
				response.sendRedirect("../reserve/reserve_next.jsp?year="+year+"&month="+month+"&day="+day+"&id="+id);
			}
		}
		else
		{
			response.sendRedirect("login.jsp?chk=1");
		}
	}
	
	public static void logout(HttpSession session,
			HttpServletResponse response) throws Exception
	{
		session.invalidate();
		response.sendRedirect("../main/index.jsp");
	}
	
	public void member_view(HttpSession session,
			HttpServletRequest request) throws Exception
	{
		String userid=session.getAttribute("userid").toString();
		String sql="select * from member where userid=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		// rs=> dto
		MemberDto mdto=new MemberDto();
		mdto.setUserid(rs.getString("userid"));
		mdto.setPhone(rs.getString("phone"));
		mdto.setEmail(rs.getString("email"));
		mdto.setName(rs.getString("name"));
		mdto.setWriteday(rs.getString("writeday"));
		
		request.setAttribute("mdto", mdto);
		
		rs.close();
		pstmt.close();
		conn.close();
	}
	
	public void phone_change(HttpServletRequest request,
			HttpSession session,
			HttpServletResponse response) throws Exception
	{
		String phone=request.getParameter("phone");
		String userid=session.getAttribute("userid").toString();
		
		String sql="update member set phone=? where userid=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, phone);
		pstmt.setString(2, userid);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("member_view.jsp?chk=2");
	}
	
	public void email_change(HttpServletRequest request,
			HttpSession session,
			HttpServletResponse response) throws Exception
	{
		String email=request.getParameter("email");
		String userid=session.getAttribute("userid").toString();
		
		String sql="update member set email=? where userid=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, email);
		pstmt.setString(2, userid);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("member_view.jsp");
	}
	
	public int pwd_change_ok(HttpServletRequest request,
			HttpSession session) throws Exception
	{
		String opwd=request.getParameter("opwd");
		String pwd=request.getParameter("pwd");
		String userid=session.getAttribute("userid").toString();
		// 테이블에 있는 비밀번호를 가져오기
		String sql="select pwd from member where userid=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		String pwd2=rs.getString("pwd");  // 테이블에 있는 비번
		
		if(opwd.equals(pwd2))
		{   // 변수 재사용
			sql="update member set pwd=? where userid=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, pwd);
			pstmt.setString(2, userid);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
			
			session.invalidate();
			
			return 1; 
		}
		else
		{
			pstmt.close();
			conn.close();
			
            return 0;
		}
	}
	
	// 리뷰를 쓸때 객실이름, 입실일 넘기기
	public void review(HttpServletRequest request) throws Exception
	{
		String rid=request.getParameter("rid");
		String jcode=request.getParameter("jcode");
		
		String sql="select name from room where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, rid);
		
		rs=pstmt.executeQuery();
		rs.next();
		String name=rs.getString("name");
		
		sql="select inday from reserve where jcode=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, jcode);
		
		rs=pstmt.executeQuery();
		rs.next();
		String inday=rs.getString("inday");
		
		request.setAttribute("name", name);
		request.setAttribute("inday", inday);
		
		// sql="select r1.name , r2.inday from room as r1 inner join reserve as r2 ";
		// sql=sql+" on r1.id=r2.rid and r2.jcode=?";  // jcode값 주기
		
		// sql="select r1.name , r2.inday from room as r1, reserve as r2 ";
		// sql=sql+" where r2.rid=r1.id and jcode=?"; // jcode값 추가
	}
	
	public void review_ok(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception
	{
		request.setCharacterEncoding("utf-8");
		String star=request.getParameter("star");
		String content=request.getParameter("content");
		String title=request.getParameter("title");
		String userid=session.getAttribute("userid").toString();
		String rid=request.getParameter("rid");
		String jcode=request.getParameter("jcode");
		
		String sql="insert into review(star,content,title,writeday,userid,rid,jcode)";
		sql=sql+" values(?,?,?,now(),?,?,?)";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, star);
		pstmt.setString(2, content);
		pstmt.setString(3, title);
		pstmt.setString(4, userid);
		pstmt.setString(5, rid);
		pstmt.setString(6, jcode);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("../reserve/my_reserve.jsp");
	}
	
	public static boolean isReview(String jcode) throws Exception
	{
		// DB연결
		Class.forName("com.mysql.jdbc.Driver"); // 라이브러리를 찾아라
		String db="jdbc:mysql://localhost:3306/pension";
		Connection conn=DriverManager.getConnection(db,"root","1234");
		
		String sql="select count(*) as cnt from review where jcode=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, jcode);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		if(rs.getInt("cnt")==0)
		{
			return true;
		}
		else
		{
			return false;
		}
				
		
		
	}
	
	// 객실조회시 해당 객실의 리뷰를 전달하는 메소드
	public void getReview(HttpServletRequest request) throws Exception
	{
		String id=request.getParameter("id"); // room테이블 id
		
		String sql="select * from review where rid=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<ReviewDto> reviewlist=new ArrayList<ReviewDto>();
		
		int hap=0;
		
		while(rs.next())
		{
			ReviewDto rdto=new ReviewDto();
			rdto.setId(rs.getInt("id"));
			rdto.setStar(rs.getInt("star"));
			rdto.setContent(rs.getString("content").replace("\r\n", "<br>"));
			rdto.setTitle(rs.getString("title"));
			rdto.setWriteday(rs.getString("writeday"));
			rdto.setRid(rs.getInt("rid"));
			rdto.setJcode(rs.getString("jcode"));
			
			reviewlist.add(rdto);
			
			hap=hap+rs.getInt("star");
		}
		
		// 평균 별점 구하기
		double staravg=hap/(reviewlist.size()*1.0);
		System.out.println(staravg);
		request.setAttribute("reviewlist", reviewlist);
		request.setAttribute("staravg", staravg);
	}
}









