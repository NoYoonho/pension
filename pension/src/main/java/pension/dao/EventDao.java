package pension.dao;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pension.dto.EventDto;
import pension.dto.TourDto;

public class EventDao {
	Connection conn;
    PreparedStatement pstmt;
    ResultSet rs;
	public EventDao() throws Exception
	{
		// DB연결
		Class.forName("com.mysql.jdbc.Driver"); // 라이브러리를 찾아라
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void write_ok(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String path=request.getRealPath("/admin/event/img");
		int size=1024*1024*10;
		
		MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy());
		
		String title=multi.getParameter("title");
		String content=multi.getParameter("content");
		String gihan=multi.getParameter("gihan");
		String fname=multi.getFilesystemName("fname");
		
		String sql="insert into event(title,content,gihan,img,writeday) ";
		sql=sql+" values(?,?,?,?,now())";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, gihan);
		pstmt.setString(4, fname);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("list.jsp");
	
	}
	
	public void list(HttpServletRequest request) throws SQLException
	{
		String sql="select * from event order by gihan desc";
		
		pstmt=conn.prepareStatement(sql);
		
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<EventDto> elist=new ArrayList<EventDto>();
		while(rs.next())
		{
			EventDto edto=new EventDto();
			edto.setId(rs.getInt("id"));
			edto.setTitle(rs.getString("title"));
			edto.setGihan(rs.getString("gihan"));
			edto.setWriteday(rs.getString("writeday"));
			edto.setImg(rs.getString("img"));
			elist.add(edto);
		}
		
		request.setAttribute("elist", elist);
		
		rs.close();
		pstmt.close();
		conn.close();
	}
	
	public void content(HttpServletRequest request) throws Exception
	{
		String id=request.getParameter("id");
		
		String sql="select * from event where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		EventDto edto=new EventDto();
		edto.setId(rs.getInt("id"));
		edto.setTitle(rs.getString("title"));
		edto.setGihan(rs.getString("gihan"));
		edto.setWriteday(rs.getString("writeday"));
		edto.setImg(rs.getString("img"));
		edto.setContent(rs.getString("content").replace("\r\n", "<br>"));
		
		request.setAttribute("edto", edto);
		
		rs.close();
		pstmt.close();
		conn.close();
	}
	
	public void delete(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		this.imgDelete(id, request);
		
		String sql="delete from event where id=?";
		
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
		
		String sql="select * from event where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		EventDto edto=new EventDto();
		edto.setId(rs.getInt("id"));
		edto.setTitle(rs.getString("title"));
		edto.setGihan(rs.getString("gihan"));
		edto.setImg(rs.getString("img"));
		edto.setContent(rs.getString("content"));
		
		request.setAttribute("edto", edto);
		
		rs.close();
		pstmt.close();
		conn.close();
	}
	
	public void update_ok(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String path=request.getRealPath("/admin/event/img");
		int size=1024*1024*10;
		
		MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy());
		
		String id=multi.getParameter("id");
		String title=multi.getParameter("title");
		String content=multi.getParameter("content");
		String gihan=multi.getParameter("gihan");
		String fname=multi.getFilesystemName("fname");
		
		String str="";
		if(fname!=null)  // 11.jpg
		{
			str=", img='"+fname+"' ";  //  " , img='11.jpg' "  
			
			this.imgDelete(id, request);
		}
		
		String sql="update event set title=?, content=?,gihan=? "+str+" where id=?";
		                                                       
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, gihan);
		pstmt.setString(4, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("content.jsp?id="+id);
	}
	
	public void imgDelete(String id,HttpServletRequest request) throws Exception
	{
		String sql="select img from event where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		String path=request.getRealPath("/admin/event/img");
		System.out.println(path);
		File file=new File(path+"/"+rs.getString("img"));
		
		if(file.exists())
			file.delete();
		
		rs.close();
		 
	}
	
	public void getFourEvent(HttpServletRequest request) throws Exception
	{
		String sql="select id,img from event order by id desc limit 4";
		pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<EventDto> elist=new ArrayList<EventDto>();
		
		while(rs.next())
		{
			EventDto edto=new EventDto();
			edto.setId(rs.getInt("id"));
			edto.setImg(rs.getString("img"));
			
			elist.add(edto);
		}
		
		request.setAttribute("elist", elist);
		
		rs.close();
		pstmt.close();
		conn.close();
	}
	
	// 이벤트의 기한과 오늘날짜를 비교하여 이전은 종료된 이벤트
	public boolean isBefore(String gihan)
	{
		String[] ymd=gihan.split("-");
		int y=Integer.parseInt(ymd[0]);
		int m=Integer.parseInt(ymd[1]);
		int d=Integer.parseInt(ymd[2]);
		
		LocalDate today=LocalDate.now();
		LocalDate xday=LocalDate.of(y, m, d);
 
		return xday.isAfter(today);
	}
}















