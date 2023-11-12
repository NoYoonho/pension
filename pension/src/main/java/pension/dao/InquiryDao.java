package pension.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pension.dto.BoardDto;
import pension.dto.InquiryDto;
import pension.dto.TourDto;

public class InquiryDao {
	Connection conn;
    PreparedStatement pstmt;
    ResultSet rs;
	public InquiryDao() throws Exception
	{
		// DB연결
		Class.forName("com.mysql.jdbc.Driver"); // 라이브러리를 찾아라
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}

    public void write_ok(HttpServletRequest request,
    		HttpServletResponse response,
    		HttpSession session) throws Exception
    {
    	request.setCharacterEncoding("utf-8");
    	String title=request.getParameter("title");
    	String content=request.getParameter("content");
    	String userid=session.getAttribute("userid").toString();
    	
    	String sql="insert into inquiry(title,content,userid,writeday) ";
    	sql=sql+" values(?,?,?,now())";
    	
    	pstmt=conn.prepareStatement(sql);
    	pstmt.setString(1, title);
    	pstmt.setString(2, content);
    	pstmt.setString(3, userid);
    	
    	pstmt.executeUpdate();
    	
    	pstmt.close();
    	conn.close();
    	
    	response.sendRedirect("success.jsp");
    }
    
    public void mine(HttpServletRequest request,
    		HttpSession session) throws Exception
    {
    	// board, tour, inquiry, review
    	String userid=session.getAttribute("userid").toString();
    	
    	String sql="select * from board where userid=? order by id desc limit 3";
    	
    	pstmt=conn.prepareStatement(sql);
    	pstmt.setString(1, userid);
    	
    	ArrayList<BoardDto> blist=new ArrayList<BoardDto>();
    	ResultSet rs=pstmt.executeQuery();
    	while(rs.next()) 
    	{
    		BoardDto bdto=new BoardDto();
    		bdto.setId(rs.getInt("id"));
    		bdto.setTitle(rs.getString("title"));
    		bdto.setReadnum(rs.getInt("readnum"));
    		bdto.setWriteday(rs.getString("writeday"));
    		
    		blist.add(bdto);
    	}
    	request.setAttribute("blist", blist);
    	

    	sql="select * from tour where userid=? order by id desc limit 3";
    	
    	pstmt=conn.prepareStatement(sql);
    	pstmt.setString(1, userid);
    	
    	ArrayList<TourDto> tlist=new ArrayList<TourDto>();
    	rs=pstmt.executeQuery();
    	while(rs.next()) 
    	{
    		TourDto tdto=new TourDto();
    		tdto.setId(rs.getInt("id"));
    		tdto.setTitle(rs.getString("title"));
    		tdto.setReadnum(rs.getInt("readnum"));
    		tdto.setWriteday(rs.getString("writeday"));
    		
    		tlist.add(tdto);
    	}
    	request.setAttribute("tlist", tlist);


    	sql="select * from inquiry where userid=? order by id desc limit 3";
    	
    	pstmt=conn.prepareStatement(sql);
    	pstmt.setString(1, userid);
    	
    	ArrayList<InquiryDto> ilist=new ArrayList<InquiryDto>();
    	rs=pstmt.executeQuery();
    	while(rs.next()) 
    	{
    		InquiryDto idto=new InquiryDto();
    		idto.setId(rs.getInt("id"));
    		idto.setTitle(rs.getInt("title"));
    		idto.setWriteday(rs.getString("writeday"));
    		idto.setState(rs.getInt("state"));
    		
    		// 관리자가 답변을 다는 기능을 추가했으므로 여기에서도 답변을 읽어온다
    		idto.setAnswer(rs.getString("answer"));
    		
    		ilist.add(idto);
    	}
    	request.setAttribute("ilist", ilist);
    	
    }
}















