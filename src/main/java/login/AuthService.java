package login;

import exception.ExceptionIdPasswordNotMatching;
import exception.ExceptionMemberNotFound;
import member.DaoMember;
import member.Member;

public class AuthService {
	private DaoMember daoMember;

	public void setDaoMember(DaoMember daoMember) {
		this.daoMember = daoMember;
	}

	public AuthInfo authenticate(String email, String password) {
		Member member = daoMember.selectByEmail(email);
		if (member == null)
			throw new ExceptionMemberNotFound();

		if (!member.matchPassword(password))
			throw new ExceptionIdPasswordNotMatching();

		return new AuthInfo(member.getId(), member.getEmail(), member.getName());
	}
}
