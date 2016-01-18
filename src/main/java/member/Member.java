package member;

import java.util.Date;

import exception.ExceptionIdPasswordNotMatching;

public class Member {
	private Long id;
	private String email;
	private String password;
	private String name;
	private Date registerDate;

	public Member(String email, String password, String name, Date registerDate) {
		this.email = email;
		this.password = password;
		this.name = name;
		this.registerDate = registerDate;
	}

	public void changePassword(String oldPassword, String newPassword) {
		if (!password.equals(oldPassword)) {
			throw new ExceptionIdPasswordNotMatching();
		}
		this.password = newPassword;
	}
	
	public boolean matchPassword(String pw) {
		return (password.equals(pw)) ? true : false;
	}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}


	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}

}
