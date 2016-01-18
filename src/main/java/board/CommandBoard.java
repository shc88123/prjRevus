package board;

import org.springframework.web.multipart.MultipartFile;

public class CommandBoard {
	private MultipartFile file;
	private String postOption;
	private String posting;
	private String fileName;
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	public String getPostOption() {
		return postOption;
	}
	public void setPostOption(String postOption) {
		this.postOption = postOption;
	}
	public String getPosting() {
		return posting;
	}
	public void setPosting(String posting) {
		this.posting = posting;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
}