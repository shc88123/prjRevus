package member;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import exception.ExceptionMemberNotFound;

@Controller
public class MemberController {
	private DaoMember daoMember;

	public void setDaoMember(DaoMember daoMember) {
		this.daoMember = daoMember;
	}

	@RequestMapping(value = "/memberList")
	public String getMemList(@ModelAttribute("cmd") ListCommand listCommand, Errors errors, Model model) {
		if (errors.hasErrors()) {
			return "member/memberList";
		}
		if (listCommand.getFrom() != null && listCommand.getTo() != null) {
			List<Member> members = daoMember.selectByRegDate(listCommand.getFrom(), listCommand.getTo());
			model.addAttribute("members", members);
		}
		return "member/memberList";
	}

	@RequestMapping(value = "/member/detail/{id}")
	public String detail(@PathVariable("id") Long memId, Model model) {
		Member member = daoMember.selectById(memId);
		if (member == null) {
			throw new ExceptionMemberNotFound();
		}
		model.addAttribute("member", member);
		return "member/memberDetail";
	}

	/*
	 * @ExceptionHandler(value=TypeMismatchException.class) public String
	 * handleTypeMismatchException() { return "member/invalidId"; }
	 */
	@ExceptionHandler(ExceptionMemberNotFound.class)
	public String handleExceptionMemberNotFound() {
		return "member/noMember";
	}
}