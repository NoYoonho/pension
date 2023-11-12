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

import pension.dto.GongjiDto;

public class GongjiDao {
	Connection conn;
    PreparedStatement pstmt;
    ResultSet rs;
	public GongjiDao() throws Exception
	{
		// DB연결
		Class.forName("com.mysql.jdbc.Driver"); // 라이브러리를 찾아라
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void write_ok(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		int step;
		if(request.getParameter("step")==null)
		{
			step=0;
		}
		else
		{
			step=1;
			// step=Integer.parseInt(request.getParameter("step"));
		}
		
		String sql="insert into gongji(title,content,writeday,step) values(?,?,now(),?)";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setInt(3, step);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("list.jsp");
	}
	
	public void list(HttpServletRequest request) throws Exception
	{
		String sql="select * from gongji order by step desc , id desc";
		
		pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<GongjiDto> glist=new ArrayList<GongjiDto>();
		while(rs.next())
		{
			GongjiDto gdto=new GongjiDto();
			gdto.setId(rs.getInt("id"));
			gdto.setTitle(rs.getString("title"));
			gdto.setReadnum(rs.getInt("readnum"));
			gdto.setWriteday(rs.getString("writeday"));
			gdto.setStep(rs.getInt("step"));
			
			glist.add(gdto);
		}
		
		request.setAttribute("glist", glist);
	
		pstmt.close();
		conn.close();
	}
	
	public void readnum(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		
		String sql="update gongji set readnum=readnum+1 where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("content.jsp?id="+id);
	}
	
	public void content(HttpServletRequest request) throws Exception
	{
		String id=request.getParameter("id");
		
		String sql="select * from gongji where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
				
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		GongjiDto gdto=new GongjiDto();
		gdto.setId(rs.getInt("id"));
		gdto.setTitle(rs.getString("title"));
		gdto.setContent(rs.getString("content").replace("\r\n", "<br>"));
		gdto.setReadnum(rs.getInt("readnum"));
		gdto.setWriteday(rs.getString("writeday"));
		gdto.setStep(rs.getInt("step"));
		
		request.setAttribute("gdto", gdto);
		
		rs.close();
		pstmt.close();
		conn.close();
	}
	
	public void delete(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		
		String sql="delete from gongji where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("list.jsp");
	}
	
	public void update(HttpServletRequest request) throws Exception
	{
		String id=request.getParameter("id");
		
		String sql="select * from gongji where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		GongjiDto gdto=new GongjiDto();
		gdto.setId(rs.getInt("id"));
		gdto.setTitle(rs.getString("title"));
		gdto.setContent(rs.getString("content"));
		gdto.setStep(rs.getInt("step"));
		
		request.setAttribute("gdto", gdto);
		
		rs.close();
		pstmt.close();
		conn.close();
	}
	
	public void update_ok(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		int step;
		if(request.getParameter("step")==null)
		{
			step=0;
		}
		else
		{
			step=1;
			// step=Integer.parseInt(request.getParameter("step"));
		}
		
		String sql="update gongji set title=?, content=?, step=? where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setInt(3, step);
		pstmt.setString(4, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("content.jsp?id="+id);
		
	}
	
	public void getFiveGongji(HttpServletRequest request) throws Exception
	{
		String sql="select id,title,writeday from gongji order by step desc , id desc limit 5";
		pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<GongjiDto> glist=new ArrayList<GongjiDto>();
		
		while(rs.next())
		{
			GongjiDto gdto=new GongjiDto();
			gdto.setId(rs.getInt("id"));
			gdto.setTitle(rs.getString("title"));
			gdto.setWriteday(rs.getString("writeday"));
			
			glist.add(gdto);
		}
		
		request.setAttribute("glist", glist);
		
		rs.close();
		pstmt.close();
		conn.close();
	}
}













