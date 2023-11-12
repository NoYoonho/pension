package pension.dto;

public class ReserveDto {
     private int id,rid,inwon,bbq,chacol,chongprice;
     private String inday,outday,userid,writeday,jcode,name;
     private int state; // 방의 상태를 저장
     
     
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getRid() {
		return rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
	}
	public int getInwon() {
		return inwon;
	}
	public void setInwon(int inwon) {
		this.inwon = inwon;
	}
	public int getBbq() {
		return bbq;
	}
	public void setBbq(int bbq) {
		this.bbq = bbq;
	}
	public int getChacol() {
		return chacol;
	}
	public void setChacol(int chacol) {
		this.chacol = chacol;
	}
	public int getChongprice() {
		return chongprice;
	}
	public void setChongprice(int chongprice) {
		this.chongprice = chongprice;
	}
	public String getInday() {
		return inday;
	}
	public void setInday(String inday) {
		this.inday = inday;
	}
	public String getOutday() {
		return outday;
	}
	public void setOutday(String outday) {
		this.outday = outday;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getWriteday() {
		return writeday;
	}
	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	public String getJcode() {
		return jcode;
	}
	public void setJcode(String jcode) {
		this.jcode = jcode;
	}
     
     
}
