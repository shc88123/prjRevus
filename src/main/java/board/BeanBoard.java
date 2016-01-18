package board;

import java.util.Date;

public class BeanBoard {
	// 빅토르A에서 입력합니다
	private int bnum;
	private String name;
	private String pass;
	private String subject;
	private String posting;
	private String fileName;
	private int re_ref;
	private int re_lev;
	private int re_seq;
	private int readcount;
	private Date wdate;
	private String email;
	private String postOption;
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getPosting() {
		return posting;
	}
	public void setPosting(String posting) {
		this.posting = posting;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public int getRe_ref() {
		return re_ref;
	}
	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}
	public int getRe_lev() {
		return re_lev;
	}
	public void setRe_lev(int re_lev) {
		this.re_lev = re_lev;
	}
	public int getRe_seq() {
		return re_seq;
	}
	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Date getWdate() {
		return wdate;
	}
	public void setWdate(Date wdate) {
		this.wdate = wdate;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPostOption() {
		return postOption;
	}
	public void setPostOption(String postOption) {
		this.postOption = postOption;
	}
}