package pension.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import pension.dto.RoomDto;

public class RoomDao {
	Connection conn;
    PreparedStatement pstmt;
    ResultSet rs;
	public RoomDao() throws Exception
	{
		// DB연결
		Class.forName("com.mysql.jdbc.Driver"); // 라이브러리를 찾아라
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	// 메뉴에서 방이름을 부메뉴로 출력하기 위한 부분
	public void getRoom(HttpServletRequest request) throws Exception
	{
		// 방의 이름을 읽어와서 뷰(jsp)에 전달
		String sql="select id,name from room order by price asc";
		
		pstmt=conn.prepareStatement(sql);
		
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<RoomDto> rlist=new ArrayList<RoomDto>();
		
		while(rs.next()) 
		{
		    RoomDto rdto=new RoomDto();
		    rdto.setId(rs.getInt("id"));
		    rdto.setName(rs.getString("name"));
		    
		    rlist.add(rdto);
		}
		
		request.setAttribute("rlist", rlist);
	}
	
	// 방의 정보를 사용자에 보여주는 메소드
	public void room_view(HttpServletRequest request) throws Exception
	{
		String id=request.getParameter("id");
		
		String sql="select * from room where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		rs=pstmt.executeQuery();
		rs.next();
		
		RoomDto rdto=new RoomDto();
		rdto.setId(rs.getInt("id"));
		rdto.setName(rs.getString("name"));
		rdto.setPrice(rs.getInt("price"));
		rdto.setMin(rs.getInt("min"));
		rdto.setMax(rs.getInt("max"));
		rdto.setContent(rs.getString("content").replace("\r\n", "<br>"));
		
		// 그림파일명을 여기서 잘라서 넘기는게 낫다
		String[] arrayimg=rs.getString("img").split(",");
		rdto.setArrayimg(arrayimg);
		//request.setAttribute("arrayimg", arrayimg);
		
		request.setAttribute("rdto", rdto);
		
	}
	
	// room테이블의 id가 올 경우 room테이블의 name만 리턴해주기
	public String getRoomName(int id) throws Exception 
	{
		String sql="select name from room where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		
		if(rs.next())
			return rs.getString("name");
		else
			return "객실사망";
	}
}










