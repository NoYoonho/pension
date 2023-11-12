package pension.util;

import java.io.File;
import java.text.DecimalFormat;
import java.time.LocalDate;

public class Util {

	public static String comma(int num)
	{
		DecimalFormat df=new DecimalFormat("#,###");
	 	
		//System.out.println(df.format(num));
		return df.format(num);
	}
	
	// xday부터 suk값 이후의 날짜를 String로 리턴해주기
	public static LocalDate getDate(String xday,int suk)
	{
		// xday의 값을 가지고 날짜 객체를 생성
		String[] imsi=xday.split("-");
		int y=Integer.parseInt(imsi[0]);
		int m=Integer.parseInt(imsi[1]);
		int d=Integer.parseInt(imsi[2]);
		LocalDate myday=LocalDate.of(y,m,d);
		
		// myday로부터 suk변수의 값에 해당하는 날
		LocalDate resultday=myday.plusDays(suk);
		
		System.out.println(resultday);
		return resultday;
	}
	
	public static boolean isCheck(int y,int m, int d)
	{
		// 오늘날짜랑 특정날짜를 비교하여 오늘날짜 이전인지 체크
		LocalDate today=LocalDate.now();
		LocalDate xday=LocalDate.of(y,m,d); // 특정날짜
		
		// xday(특정날짜)가 오늘날짜 이전이면 true, 아니면 false
		boolean kk=xday.isBefore(today);
		
		// System.out.println(kk);
		return kk;
	}
	
	public void deltest()
	{
		File file=new File("c:/java/a1.jpg");
		
		System.out.println(file.exists());
		System.out.println(file.length());
		
		file.delete(); // 삭제
	}
	
}

















