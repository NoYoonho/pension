package pension.dao;

import java.io.UnsupportedEncodingException;
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
import pension.dto.GongjiDto;

public class BoardDao {
	Connection conn;
    PreparedStatement pstmt;
    ResultSet rs;
	public BoardDao() throws Exception
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
		// 폼 입력값
		request.setCharacterEncoding("utf-8");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String userid=session.getAttribute("userid").toString();
		
		String sql="insert into board(title,content,userid,writeday) values(?,?,?,now())";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, userid);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("list.jsp");
		
	}
	public int chongPage(String table) throws Exception
	{
		String sql="select ceil(count(*)/10) as chong from "+table;
		pstmt=conn.prepareStatement(sql);
		rs=pstmt.executeQuery();
		rs.next();
		int chong=rs.getInt("chong");
		rs.close();
		pstmt.close();
		
		return chong;
	}
	public void list(HttpServletRequest request) throws Exception
	{
		// 현재 페이지 값
		int pager;
		if(request.getParameter("pager")==null || request.getParameter("pager").equals("null"))
		{
			pager=1;
		}
		else
		{
			pager=Integer.parseInt(request.getParameter("pager"));
		}
		
		// 총페이지값 구하기
		int chong=chongPage("board");
		
		// pstart값, pend값 구하기
		int imsi=pager/10;
		if(pager%10==0)
		{
			imsi=imsi-1;
		}
		int pstart=imsi*10+1;
		int pend=pstart+9;
		
		if(pend > chong)
		{
			pend=chong;
		}
		
		// 페이지당 인덱스 값 구하기
		int index=(pager-1)*10;
		
		String sql="select * from board  order by id desc limit ?,10";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, index);
		rs=pstmt.executeQuery();
		
		ArrayList<BoardDto> blist=new ArrayList<BoardDto>();
		
		while(rs.next())
		{
			BoardDto bdto=new BoardDto();
			bdto.setId(rs.getInt("id"));
			bdto.setTitle(rs.getString("title"));
			bdto.setUserid(rs.getString("userid"));
			bdto.setWriteday(rs.getString("writeday"));
			bdto.setReadnum(rs.getInt("readnum"));
			
			blist.add(bdto);
		}
		
		request.setAttribute("blist", blist);
		// pstart, pend, pager, chong 값 
		request.setAttribute("pstart",pstart);
		request.setAttribute("pend",pend);
		request.setAttribute("pager",pager);
		request.setAttribute("chong",chong);
		
		rs.close();
		pstmt.close();
		conn.close();
	}
	
	public void readnum(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		String pager=request.getParameter("pager");
		String sql="update board set readnum=readnum+1 where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("content.jsp?id="+id+"&pager="+pager);
	}
	
	public void content(HttpServletRequest request) throws Exception
	{
		String id=request.getParameter("id");
		String pager=request.getParameter("pager");
		
		String sql="select * from board where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		BoardDto bdto=new BoardDto();
		
		bdto.setId(rs.getInt("id"));
		bdto.setTitle(rs.getString("title"));
		bdto.setUserid(rs.getString("userid"));
		bdto.setWriteday(rs.getString("writeday"));
		bdto.setReadnum(rs.getInt("readnum"));
		bdto.setContent(rs.getString("content").replace("\r\n", "<br>"));
		
		request.setAttribute("bdto", bdto);
	    request.setAttribute("pager", pager);
	    
	    String name=this.getName(rs.getString("userid"));
	    request.setAttribute("name", name);
	    
		rs.close();
		pstmt.close();
		conn.close();
	}
	
	public void delete(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		// 아이디 체크
		String id=request.getParameter("id");
		String pager=request.getParameter("pager");
		String mychk=request.getParameter("mychk");
				
		String sql="delete from board where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		if(mychk==null)
		{
		   response.sendRedirect("list.jsp?pager="+pager);
		}
		else
		{
		   response.sendRedirect("../inquiry/mine.jsp");
		}
	}
	
	public void update(HttpServletRequest request) throws Exception
	{
        String id=request.getParameter("id");
		String pager=request.getParameter("pager");
		String sql="select * from board where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		BoardDto bdto=new BoardDto();
		
		bdto.setId(rs.getInt("id"));
		bdto.setTitle(rs.getString("title"));
		bdto.setContent(rs.getString("content"));
		
		request.setAttribute("bdto", bdto);
	    request.setAttribute("pager", pager);
		
		rs.close();
		pstmt.close();
		conn.close();	
	}
	
	public void update_ok(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		// 아이디 체크
		
		
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String pager=request.getParameter("pager");
		
		String sql="update board set title=? ,content=? where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		if(request.getParameter("mychk")==null) //|| request.getParameter("mychk").equals("null"))
		    response.sendRedirect("content.jsp?id="+id+"&pager="+pager);
		else
			response.sendRedirect("../inquiry/mine.jsp");
		   
	}
	
	public String getName(String userid) throws Exception
	{
		String sql="select name from member where userid=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		
		ResultSet rs=pstmt.executeQuery();
		if(rs.next())
		{
			return rs.getString("name");
		}
		else
		{
			return "이름 오류";
		}
		
	}
	
	public void getFiveBoard(HttpServletRequest request) throws Exception
	{
		String sql="select id,title,writeday from board order by id desc limit 5";
		pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<BoardDto> blist=new ArrayList<BoardDto>();
		
		while(rs.next())
		{
			BoardDto bdto=new BoardDto();
			bdto.setId(rs.getInt("id"));
			bdto.setTitle(rs.getString("title"));
			bdto.setWriteday(rs.getString("writeday"));
			
			blist.add(bdto);
		}
		
		request.setAttribute("blist", blist);
		
		rs.close();
		pstmt.close();
		conn.close();
	}
}








