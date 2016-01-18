package login;

import exception.ExceptionMemberNotFound;
import member.DaoMember;
import member.Member;

public class ServiceChangePassword {
	private DaoMember daoMember;

	public ServiceChangePassword(DaoMember daoMember) {
		super();
		this.daoMember = daoMember;
	}

	public void changePassword(String email, String olPwd, String newPwd) {
		Member member = daoMember.selectByEmail(email);
		if (member == null) {
			throw new ExceptionMemberNotFound();
		}

		member.changePassword(olPwd, newPwd);

		daoMember.update(member);
	}

}
