package pension.dao;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pension.dto.InquiryDto;
import pension.dto.MemberDto;
import pension.dto.ReserveDto;
import pension.dto.RoomDto;
import pension.util.Util;

public class AdminDao {
	Connection conn;
    PreparedStatement pstmt;
    ResultSet rs;
	public AdminDao() throws Exception
	{
		// DB연결
		Class.forName("com.mysql.jdbc.Driver"); // 라이브러리를 찾아라
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	public void rwrite_ok(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String path=request.getRealPath("/room/img");
		int size=1024*1024*100;
		MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy());
		
		// 폼에 입력값 가져오기
		String name=multi.getParameter("name");
		String price=multi.getParameter("price");
		String min=multi.getParameter("min");
		String max=multi.getParameter("max");
		String content=multi.getParameter("content");
		
		// 파일이름을 ,로서 구분하여 문자열로 만들기
		Enumeration file=multi.getFileNames();  // type="file"의 name을 불러온다..
		
		String img="";
		while(file.hasMoreElements())
		{
			//System.out.println( file.nextElement().toString() );
			String imsi=file.nextElement().toString();
			
			img=img+multi.getFilesystemName(imsi)+",";
		}
 
		// 쿼리 생성
		String sql="insert into room(name,price,min,max,content,img,writeday)";
		sql=sql+" values(?,?,?,?,?,?,now())";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, price);
		pstmt.setString(3, min);
		pstmt.setString(4, max);
		pstmt.setString(5, content);
		pstmt.setString(6, img);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("rlist.jsp");
	}
	
	public void rlist(HttpServletRequest request) throws Exception
	{
		// 쿼리생성
		String sql="select * from room order by price asc";
		
		pstmt=conn.prepareStatement(sql);
		
		ResultSet rs=pstmt.executeQuery();
		
	    ArrayList<RoomDto> list=new ArrayList<RoomDto>();
		
		while(rs.next()) 
		{
		    RoomDto rdto=new RoomDto();	
		    rdto.setId(rs.getInt("id"));
		    rdto.setName(rs.getString("name"));
		    rdto.setPrice(rs.getInt("price"));
		    rdto.setMax(rs.getInt("max"));
		    rdto.setMin(rs.getInt("min"));
		    rdto.setImg(rs.getString("img"));
		    list.add(rdto);
		}
		
		request.setAttribute("list", list);
	}
	
	public void viewroom(HttpServletRequest request,
			JspWriter out) throws Exception
	{
		 String id=request.getParameter("id");
		 
		 String sql="select content from room where id=?";
		 
		 pstmt=conn.prepareStatement(sql);
		 pstmt.setString(1, id);
		 
		 ResultSet rs=pstmt.executeQuery();
		 rs.next();
		 
		 out.print(rs.getString("content").replace("\r\n", "<br>"));
	}
	
	public void rdelete(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		
		String sql="delete from room where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		pstmt.executeUpdate();
		
		System.out.println(pstmt.toString());
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("rlist.jsp");
	}
	
	public void rupdate(HttpServletRequest request) throws Exception
	{
		String id=request.getParameter("id");
		
		String sql="select * from room where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		RoomDto rdto=new RoomDto();
		rdto.setId(rs.getInt("id"));
		rdto.setName(rs.getString("name"));
		rdto.setPrice(rs.getInt("price"));
		rdto.setMin(rs.getInt("min"));
		rdto.setMax(rs.getInt("max"));
		rdto.setContent(rs.getString("content"));
		// img를 불러와서 ,기준으로 split()나눈후 배열에 저장
		String[] img=rs.getString("img").split(",");
		rdto.setArrayimg(img);
		
		request.setAttribute("rdto", rdto);
	}
	
	public void rupdate_ok(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		// cos.jar => MultipartRequest
		String path=request.getRealPath("/room/img");
		int size=1024*1024*100;
		MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy());
		
		// 읽어오기
		String id=multi.getParameter("id");
		String delimg=multi.getParameter("delimg");
		String eximg=multi.getParameter("eximg");  // bb.jpg,cc.jpg,
		String name=multi.getParameter("name");
		String price=multi.getParameter("price");
		String min=multi.getParameter("min");
		String max=multi.getParameter("max");
		String content=multi.getParameter("content");
		
		// 추가된 사진이름 가져오기
		Enumeration enu=multi.getFileNames(); // 모든 type='file'의 name값을 다 가져온다.
		
		String chuga="";
		while(enu.hasMoreElements())
		{
		   String imsi=enu.nextElement().toString();
		   
		   chuga=chuga+multi.getFilesystemName(imsi)+",";
		}
		System.out.println(chuga);
		// while문을 실행하는 동안 jsp에서 선택이 안된 type='file'은  null로 들어온다.. => 지우면 된다..
		
		chuga=chuga.replace("null,","");
		System.out.println(chuga);
		//System.out.println(chuga);
		// chugae="pp.jpg,qq.jpg,ss.jpg,"
		// 존재하는 사진 + 추가된 사진
		String img=eximg+chuga; // bb.jpg,cc.jpg,pp.jpg,qq.jpg,ss.jpg,
		
		// 삭제할 사진을 삭제하기 => File 클래스를 이용한다..
		String[] del=delimg.split(",");
		
		for(int i=0;i<del.length;i++)
		{
			File file=new File(path+"/"+del[i]);
			
			if(file.exists()) // 파일이 존재하면
			{
			   file.delete();
			}
		}
		
		String sql="update room set name=?, price=?, min=?, max=?, content=?, img=? where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, price);
		pstmt.setString(3, min);
		pstmt.setString(4, max);
		pstmt.setString(5, content);
		pstmt.setString(6, img);
		pstmt.setString(7, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("rlist.jsp");
	}
	
	// 관리자 메뉴 : 회원관리
	public void member_list(HttpServletRequest request) throws Exception
	{
	    String sql="select * from member where userid<>'admin' order by id desc";
	    
	    pstmt=conn.prepareStatement(sql);
	    
	    ResultSet rs=pstmt.executeQuery();
	    
	    ArrayList<MemberDto> mlist=new ArrayList<MemberDto>();
	    
	    while(rs.next())
	    {
	    	MemberDto mdto=new MemberDto();
	    	mdto.setId(rs.getInt("id"));
	    	mdto.setUserid(rs.getString("userid"));
	    	mdto.setPhone(rs.getString("phone"));
	    	mdto.setEmail(rs.getString("email"));
	    	mdto.setName(rs.getString("name"));
	    	mdto.setWriteday(rs.getString("writeday"));
	    	
	    	mlist.add(mdto);
	    }
	    
	    request.setAttribute("mlist", mlist);
	    
	    rs.close();
	    pstmt.close();
	    //conn.close();
	}
	
	public int getCount(String userid) throws Exception
	{
		String sql="select count(*) as cnt from reserve where userid=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		return rs.getInt("cnt");
	}
	
	public String getChong(String userid) throws Exception
	{
        String sql="select sum(chongprice) as chong from reserve where userid=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
 
		String chong=Util.comma(rs.getInt("chong"));
		System.out.println(chong);
		
		return chong;
		//return rs.getInt("chong"); 
 
	}
	public void myclose() throws Exception
	{
		if(!conn.isClosed())
		    conn.close();
	}
	
	
	public void reserve_list(HttpServletRequest request) throws Exception
	{
		String sql="select * from reserve order by inday desc";
		
		pstmt=conn.prepareStatement(sql);
	
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<ReserveDto> rlist=new ArrayList<ReserveDto>();
		
		while(rs.next())
		{
			ReserveDto rdto=new ReserveDto();
			rdto.setId(rs.getInt("id"));
			rdto.setInday(rs.getString("inday"));
			rdto.setOutday(rs.getString("outday"));
			rdto.setUserid(rs.getString("userid"));
			rdto.setRid(rs.getInt("rid"));
			rdto.setInwon(rs.getInt("inwon"));
			rdto.setBbq(rs.getInt("bbq"));
			rdto.setChacol(rs.getInt("chacol"));
			rdto.setChongprice(rs.getInt("chongprice"));
			rdto.setWriteday(rs.getString("writeday"));
			rdto.setState(rs.getInt("state"));
			rdto.setName(this.getRoomName(rs.getInt("rid"))); 
			rlist.add(rdto);
	    }
		request.setAttribute("rlist", rlist);
		 
		rs.close();
		pstmt.close();
		conn.close();
	}
	
	public String getRoomName(int id) throws Exception
	{                        // room테이블 id
		String sql="select name from room where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		return rs.getString("name");
	}
	
	public void chgstate(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		
		String sql="update reserve set state=2 where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("reserve_list.jsp");
	}
	
	
	
	public void inquiry_list(HttpServletRequest request) throws Exception
	{
		String sql="select * from inquiry order by id desc";
		
		pstmt=conn.prepareStatement(sql);
		
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<InquiryDto> ilist=new ArrayList<InquiryDto>();
		
		while(rs.next())
		{
			InquiryDto idto=new InquiryDto();
			idto.setId(rs.getInt("id"));
			idto.setUserid(rs.getString("userid"));
			idto.setTitle(rs.getInt("title"));
			idto.setContent(rs.getString("content"));
			idto.setWriteday(rs.getString("writeday"));
			idto.setState(rs.getInt("state"));
			idto.setAnswer(rs.getString("answer"));
			ilist.add(idto);
		}
		
		request.setAttribute("ilist", ilist);
		
		rs.close();		
		pstmt.close();
		conn.close();
	}
	
	public void inquiry_ok(HttpServletRequest request
			, HttpServletResponse response) throws Exception
	{
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		String answer=request.getParameter("answer");
		
		String sql="update inquiry set answer=? ,state=1 where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, answer);
		pstmt.setString(2, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("inquiry_list.jsp");
	}
}
























