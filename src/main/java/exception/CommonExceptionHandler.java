package exception;

import org.springframework.beans.TypeMismatchException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice("controller")
public class CommonExceptionHandler {
	@ExceptionHandler(TypeMismatchException.class)
	public String handleTypeMismatchException() {
		return "error/commonException";
	}
}