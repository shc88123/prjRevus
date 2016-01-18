package login;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import board.BeanBoard;
import board.BeanPaging;
import board.DaoBoard;
import exception.ExceptionIdPasswordNotMatching;
import exception.ExceptionMemberNotFound;

@Controller
public class LoginController {
	private AuthService authService;
	private DaoBoard daoBoard;

	public void setAuthService(AuthService authService) {
		this.authService = authService;
	}

	public void setDaoBoard(DaoBoard daoBoard) {
		this.daoBoard = daoBoard;
	}

	// 로그인
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String form(LoginCommand loginCommand, HttpSession session,
			@CookieValue(value = "REMEMBER", required = false) Cookie rCookie, Model model,
			/*@RequestParam(value = "replies", required = false) List<BeanBoard> replies,*/ HttpServletRequest request) {
		if (rCookie != null) {
			loginCommand.setEmail(rCookie.getValue());
			loginCommand.setRememberEmail(true);
		}
		if (session.getAttribute("authInfo") == null) {
			return "main/start";
		} else {
			// Paging & List
			if (!model.containsAttribute("beanPaging") && !model.containsAttribute("beanBoard")) {
				// Block(=count)
				int listBlock = 10;
				int pageBlock = 3;
				Integer listCountTotal = daoBoard.count(loginCommand.getEmail());
				if (listCountTotal != null) {
					int pageCountTotal = listCountTotal / listBlock * listBlock == listCountTotal
							? listCountTotal / listBlock : listCountTotal / listBlock + 1;
					int startPage = 1;
					int endPage = pageBlock;
					if (endPage > pageCountTotal)
						endPage = pageCountTotal;
					// Attributes
					List<BeanBoard> list = daoBoard.selectAllByEmailPaging(loginCommand.getEmail(), (1 - 1) * listBlock,
							listBlock);
					model.addAttribute("beanBoard", list);
					BeanPaging bp = new BeanPaging();
					bp.setStartPage(startPage);
					bp.setEndPage(endPage);
					bp.setLastPage(pageCountTotal);
					bp.setCurrentPage(1);
					model.addAttribute("beanPaging", bp);
				}
			}
			return "main/main";
		}
	}

	@RequestMapping(value = "/main", method = RequestMethod.POST)
	public String submit(LoginCommand loginCommand, Errors errors, HttpSession session, HttpServletResponse response,
			Model model, HttpServletRequest request) {

		new LoginCommandValidator().validate(loginCommand, errors);
		if (errors.hasErrors()) {
			return "main/start";
		} else {
			try {
				AuthInfo authInfo = authService.authenticate(loginCommand.getEmail(), loginCommand.getPassword());
				// session.setAttribute
				session.setAttribute("authInfo", authInfo);

				Cookie rememberCookie = new Cookie("REMEMBER", loginCommand.getEmail());
				rememberCookie.setPath("/");
				if (loginCommand.isRememberEmail()) {
					rememberCookie.setMaxAge(60 * 60 * 24 * 30);
				} else {
					rememberCookie.setMaxAge(0);
				}
				// Cookie
				response.addCookie(rememberCookie);
				// Paging & List
				if (!model.containsAttribute("beanPaging") && !model.containsAttribute("beanBoard")) {
					// Block(=count)
					int listBlock = 10;
					int pageBlock = 3;
					Integer listCountTotal = daoBoard.count(loginCommand.getEmail());
					if (listCountTotal != null) {
						int pageCountTotal = listCountTotal / listBlock * listBlock == listCountTotal
								? listCountTotal / listBlock : listCountTotal / listBlock + 1;
						int startPage = 1;
						int endPage = pageBlock;
						if (endPage > pageCountTotal)
							endPage = pageCountTotal;
						// Attributes
						List<BeanBoard> list = daoBoard.selectAllByEmailPaging(loginCommand.getEmail(), (1 - 1) * listBlock,
								listBlock);
						model.addAttribute("beanBoard", list);
						BeanPaging bp = new BeanPaging();
						bp.setStartPage(startPage);
						bp.setEndPage(endPage);
						bp.setLastPage(pageCountTotal);
						bp.setCurrentPage(1);
						model.addAttribute("beanPaging", bp);
					}
				}	
				return "main/main";
			} catch (ExceptionMemberNotFound e) {
				errors.reject("memberNotFound");
				return "main/start";
			} catch (ExceptionIdPasswordNotMatching e) {
				errors.reject("idPasswordNotMatching");
				return "main/start";
			}
		}
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}