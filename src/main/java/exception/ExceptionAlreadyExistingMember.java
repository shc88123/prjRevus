package exception;

public class ExceptionAlreadyExistingMember extends RuntimeException {
	private static final long serialVersionUID = 2261348112383416115L;
	public ExceptionAlreadyExistingMember(String message) {
		super(message);
	}
}