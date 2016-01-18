package login;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

public class AuthInfoValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return AuthInfoCommand.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "currentPw", "required");
		ValidationUtils.rejectIfEmpty(errors, "newPw", "required");
	}
}