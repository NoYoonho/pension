package pension.util;

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

import pension.dto.TourDto;

public class UtilDao {
	Connection conn;
    PreparedStatement pstmt;
    ResultSet rs;
	public UtilDao() throws Exception
	{
		// DB연결
		Class.forName("com.mysql.jdbc.Driver"); // 라이브러리를 찾아라
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void twrite_ok(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception
	{
 
		String path=request.getRealPath("/util/img");
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
	 		
		//pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("list.jsp");
		
	}
	 
}








