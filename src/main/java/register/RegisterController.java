package register;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import exception.ExceptionAlreadyExistingMember;
import login.ServiceMemberRegister;

@Controller
public class RegisterController {
	private ServiceMemberRegister srvMemReg;

	public void setSrvMemReg(ServiceMemberRegister srvMemReg) {
		this.srvMemReg = srvMemReg;
	}

	@RequestMapping("/register/step1")
	public String handleStep() {
		return "member/register/step1";
	}

	@RequestMapping(value = "/register/step2", method = RequestMethod.POST)
	public String handleStep2(@RequestParam(value = "agree", defaultValue = "false") boolean agreeVal, Model model) {
		if (!agreeVal) {
			return "member/register/step1";
		} else {
			model.addAttribute("rr", new RegisterRequest());
			return "member/register/step2";
		}
	}

	@RequestMapping(value = "/register/step2", method = RequestMethod.GET)
	public String handleStep2() {
		return "redirect:/register/step1";
	}

	@RequestMapping(value = "/register/step3", method = RequestMethod.POST)
	public String handleStep3(@ModelAttribute("rr") RegisterRequest regReq, Errors errors) {
		new RegisterRequestValidator().validate(regReq, errors);
		if (errors.hasErrors()) {
			return "member/register/step2";			
		} else {
			try {
				// Command Object
				srvMemReg.regist(regReq);
				return "member/register/step3";
			} catch (ExceptionAlreadyExistingMember e) {
				errors.rejectValue("email", "duplicate");
				return "member/register/step2";
			}
		}


		/*
		 * String email = request.getParameter("email"); String name =
		 * request.getParameter("name"); String password =
		 * request.getParameter("password"); String confirmPassword =
		 * request.getParameter("confirmPassword"); RegisterRequest regReq = new
		 * RegisterRequest(); regReq.setEmail(email); regReq.setName(name);
		 * regReq.setPassword(password);
		 * regReq.setConfirmPassword(confirmPassword);
		 * model.addAttribute("regReq", regReq);
		 */
	}

	@RequestMapping(value = "/register/step3", method = RequestMethod.GET)
	public String handleStep3() {
		return "redirect:step1";
	}
}