package pension.dao;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pension.dto.BoardDto;
import pension.dto.TourDto;

public class TourDao {
	Connection conn;
    PreparedStatement pstmt;
    ResultSet rs;
	public TourDao() throws Exception
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
		String path=request.getRealPath("/tour/img");
		int size=1024*1024*100;
		MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy());
		
		// 폼에 입력값 가져오기
		String title=multi.getParameter("title");
		String content=multi.getParameter("content");
        String userid=session.getAttribute("userid").toString();
		
		// 파일이름을 ,로서 구분하여 문자열로 만들기
		Enumeration file=multi.getFileNames();  // type="file"의 name을 불러온다..
		
		String img="";
		while(file.hasMoreElements())
		{
			//System.out.println( file.nextElement().toString() );
			String imsi=file.nextElement().toString();
			
			img=img+multi.getFilesystemName(imsi)+",";
		}
        img=img.replace("null,", "");
		// 쿼리 생성
		String sql="insert into tour(userid,title,content,img,writeday)";
		sql=sql+" values(?,?,?,?,now())";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.setString(2, title);
		pstmt.setString(3, content);
		pstmt.setString(4, img);
	 		
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
		if(request.getParameter("pager")==null)
		{
			pager=1;
		}
		else
		{
			pager=Integer.parseInt(request.getParameter("pager"));
		}
		
		// 총페이지값 구하기
		int chong=chongPage("tour");
		
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
		
		String sql="select * from tour  order by id desc limit ?,10";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, index);
		rs=pstmt.executeQuery();
		
		ArrayList<TourDto> tlist=new ArrayList<TourDto>();
		
		while(rs.next())
		{
			TourDto bdto=new TourDto();
			bdto.setId(rs.getInt("id"));
			bdto.setTitle(rs.getString("title"));
			bdto.setUserid(rs.getString("userid"));
			bdto.setWriteday(rs.getString("writeday"));
			bdto.setReadnum(rs.getInt("readnum"));
			
			tlist.add(bdto);
		}
		
		request.setAttribute("tlist", tlist);
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
		String sql="update tour set readnum=readnum+1 where id=?";
		
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
		
		String sql="select * from tour where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		TourDto tdto=new TourDto();
		
		tdto.setId(rs.getInt("id"));
		tdto.setTitle(rs.getString("title"));
		tdto.setUserid(rs.getString("userid"));
		tdto.setWriteday(rs.getString("writeday"));
		tdto.setReadnum(rs.getInt("readnum"));
		tdto.setContent(rs.getString("content").replace("\r\n", "<br>"));
		
		tdto.setImgs(rs.getString("img").split(","));
		
		request.setAttribute("tdto", tdto);
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
		this.imgdel(request,id); // 삭제할 레코드의 그림 삭제
		String sql="delete from tour where id=?";
		
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
	
	public void imgdel(HttpServletRequest request,String id) throws Exception
	{
		String sql="select img from tour where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		String[] imgs=rs.getString("img").split(",");
		String path=request.getRealPath("/tour/img");
		for(int i=0;i<imgs.length;i++)
		{
			File file=new File(path+"/"+imgs[i]);
			if(file.exists())
			{
				file.delete();
			}
		}
	}
	
	public void update(HttpServletRequest request) throws Exception
	{
        String id=request.getParameter("id");
		String pager=request.getParameter("pager");
		String sql="select * from tour where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		TourDto tdto=new TourDto();
		
		tdto.setId(rs.getInt("id"));
		tdto.setTitle(rs.getString("title"));
		tdto.setContent(rs.getString("content"));
		 
		tdto.setImgs(rs.getString("img").split(","));
		request.setAttribute("tdto", tdto);
	    request.setAttribute("pager", pager);
		
		rs.close();
		pstmt.close();
		conn.close();	
	}
	
	public void update_ok(HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String path=request.getRealPath("/tour/img");
		int size=1024*1024*100;
		MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy());
		
		// 읽어오기
		String id=multi.getParameter("id");
		String delimg=multi.getParameter("delimg");
		String eximg=multi.getParameter("eximg");  
		String title=multi.getParameter("title");
		String content=multi.getParameter("content");
		String pager=multi.getParameter("pager");
		// 추가된 사진이름 가져오기
		Enumeration enu=multi.getFileNames(); // 모든 type='file'의 name값을 다 가져온다.
		
		String chuga="";
		while(enu.hasMoreElements())
		{
		   String imsi=enu.nextElement().toString();
		   
		   chuga=chuga+multi.getFilesystemName(imsi)+",";
		}
		  
		chuga=chuga.replace("null,","");
		String img=eximg+chuga;
		
		// 삭제할 사진을 삭제하기  
		String[] del=delimg.split(",");
		
		for(int i=0;i<del.length;i++)
		{
			File file=new File(path+"/"+del[i]);
			
			if(file.exists()) // 파일이 존재하면
			{
			   file.delete();
			}
		}
		
		String sql="update tour set title=? ,content=?,img=? where id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, img);
		pstmt.setString(4, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		if(multi.getParameter("mychk")==null)
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
	
	public void getFiveTour(HttpServletRequest request) throws Exception
	{
		String sql="select id,title,writeday from tour order by id desc limit 5";
		pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<TourDto> tlist=new ArrayList<TourDto>();
		
		while(rs.next())
		{
			TourDto tdto=new TourDto();
			tdto.setId(rs.getInt("id"));
			tdto.setTitle(rs.getString("title"));
			tdto.setWriteday(rs.getString("writeday"));
			
			tlist.add(tdto);
		}
		
		request.setAttribute("tlist", tlist);
		
		rs.close();
		pstmt.close();
		conn.close();
	}
}








