package login;

import java.util.Date;

import exception.ExceptionAlreadyExistingMember;
import member.DaoMember;
import member.Member;
import register.RegisterRequest;

public class ServiceMemberRegister {
	private DaoMember daoMember;

	public ServiceMemberRegister(DaoMember daoMember) {
		super();
		this.daoMember = daoMember;
	}

	public void regist(RegisterRequest req) {
		Member member = daoMember.selectByEmail(req.getEmail());
		if (member != null) {
			throw new ExceptionAlreadyExistingMember("중복 email" + req.getEmail());
		}
		Member newMember = new Member(req.getEmail(), req.getPassword(), req.getName(), new Date());
		daoMember.insert(newMember);
	}
}
