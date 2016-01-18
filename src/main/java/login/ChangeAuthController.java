package login;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import exception.ExceptionIdPasswordNotMatching;

@Controller
public class ChangeAuthController {
	ServiceChangePassword srvChgPwd;

	public void setSrvChgPwd(ServiceChangePassword srvChgPwd) {
		this.srvChgPwd = srvChgPwd;
	}
	@RequestMapping(value="/edit/changeAuthInfo", method=RequestMethod.GET)
	public String changeForm(@ModelAttribute("authCmd") AuthInfoCommand authCmd) {
		return "member/edit/changeAuthForm";
	}
	
	@RequestMapping(value="/edit/changeAuthInfo", method=RequestMethod.POST)
	public String changeSubmit(@ModelAttribute("authCmd") AuthInfoCommand authCmd,
			Errors errors, HttpSession session) {
		new AuthInfoValidator().validate(authCmd, errors);
		if (errors.hasErrors()) {
			return "member/edit/changeAuthForm";
		} else {
			AuthInfo authInfo = (AuthInfo) session.getAttribute("authInfo");

			try {
				srvChgPwd.changePassword(authInfo.getEmail(),
						authCmd.getCurrentPw(), 
						authCmd.getNewPw());
				return "member/edit/changedAuth";
			} catch (ExceptionIdPasswordNotMatching e) {
				errors.rejectValue("currentPw", "notMatching");
				return "member/edit/changeAuthForm";
			}
		}
	}
}