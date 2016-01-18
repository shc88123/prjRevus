package board;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import login.AuthInfo;

@Controller
public class ControllerBoard {
	private DaoBoard daoBoard;

	public void setDaoBoard(DaoBoard daoBoard) {
		this.daoBoard = daoBoard;
	}

	@RequestMapping("/boardPage/{page}")
	public String boardPage(@PathVariable("page") int page, RedirectAttributes redirectAttributes,
			HttpSession session) {		
		AuthInfo authInfo = (AuthInfo) session.getAttribute("authInfo");
		if (authInfo != null) {
			// Block(=count)
			int listBlock = 10;
			int pageBlock = 3;
			Integer listCountTotal = daoBoard.count(authInfo.getEmail());
			if (listCountTotal != null) {
				int pageCountTotal = listCountTotal / listBlock * listBlock == listCountTotal
						? listCountTotal / listBlock : listCountTotal / listBlock + 1;
				int startPage = page <= (pageBlock - 1) / 2 ? 1 : page - (pageBlock - 1) / 2;
				int endPage = page <= (pageBlock - 1) / 2 ? pageBlock : page + (pageBlock - 1) / 2;
				if (endPage > pageCountTotal)
					endPage = pageCountTotal;
				// RedirectAttributes
				List<BeanBoard> list = daoBoard.selectAllByEmailPaging(authInfo.getEmail(), (page - 1) * listBlock,
						listBlock);
				redirectAttributes.addFlashAttribute("beanBoard", list);
				BeanPaging bp = new BeanPaging();
				bp.setStartPage(startPage);
				bp.setEndPage(endPage);
				bp.setLastPage(pageCountTotal);
				bp.setCurrentPage(page);
				redirectAttributes.addFlashAttribute("beanPaging", bp);
			}
		}
		return "redirect:/main";
	}

	@RequestMapping("/boardReplyView/{page}/{num}")
	public String boardReplyView(@PathVariable("page") int page, @PathVariable("num") int num,
			RedirectAttributes redirectAttributes) {
//		List<BeanBoard> replies = daoBoard.selectReplyById(num);
//		redirectAttributes.addFlashAttribute("replies", replies);
//		redirectAttributes.addAttribute("replies", replies);
		return "redirect:/boardPage/" + page;
	}

	@RequestMapping("/boardReplyDo/{page}/{num}")
	public String boardReplyDo(@PathVariable("page") int page, @PathVariable("num") int num, Model model,
			HttpSession session, @RequestParam(value = "reply", defaultValue = "좋아요", required = false) String reply) {
		// AuthInfo
		AuthInfo authInfo = (AuthInfo) session.getAttribute("authInfo");
		BeanBoard re = new BeanBoard();
		re.setName(authInfo.getName());
		re.setPosting(reply);
		re.setEmail(authInfo.getEmail());
		re.setRe_ref(num);
		daoBoard.boardReply(re);
		return "redirect:/boardReplyView/" + page + "/" + num;
	}

	@RequestMapping(value = "/addBoard")
	public String add(CommandBoard cmdBoard, HttpSession session, HttpServletRequest req, Model model) {
		String realFolder = req.getSession().getServletContext().getRealPath("/upload");
		// AuthInfo
		AuthInfo authInfo = (AuthInfo) session.getAttribute("authInfo");
		// BeanBoard
		BeanBoard bb = new BeanBoard();
		bb.setEmail(authInfo.getEmail());
		bb.setName(authInfo.getName());
		bb.setPosting(cmdBoard.getPosting());
		bb.setPostOption(cmdBoard.getPostOption());
		bb.setWdate(new Date());

		File realUploadDir = new File(realFolder);
		if (!realUploadDir.exists()) {
			realUploadDir.mkdirs();
		}
		/*
		MultipartHttpServletRequest multipartHttpServletRequest =  (MultipartHttpServletRequest)req;
		List<MultipartFile> files = multipartHttpServletRequest.getFiles("upFile");
		return new ModelAndView("redirect:*.spring?action=list"); 
		  
		 
		  MultipartHttpServletRequest multipartHttpServletRequest =
		  (MultipartHttpServletRequest) req; Iterator<String> iterator =
		  multipartHttpServletRequest.getFileNames(); MultipartFile
		  multipartFile = null; while (iterator.hasNext()) { multipartFile =
		  multipartHttpServletRequest.getFile(iterator.next()); if
		  (!multipartFile.isEmpty()) { String fileName =
		  multipartFile.getOriginalFilename(); cmdBoard.setFileName(fileName);
		  bb.setFileName(cmdBoard.getFileName()); try { byte[] fileData =
		  multipartFile.getBytes(); FileOutputStream out } catch (IOException
		  e) {
		  
		  } } }
		 */
		MultipartFile uploadFile = cmdBoard.getFile();
		if (uploadFile.getSize() > 0) {
			String fileName = uploadFile.getOriginalFilename();
			cmdBoard.setFileName(fileName);
			bb.setFileName(cmdBoard.getFileName());
			try {
				File file = new File(realFolder + fileName);
				if (file.exists()) {
					String sysFileName = System.currentTimeMillis() + fileName;
					file = new File(realFolder, sysFileName);
					bb.setFileName(sysFileName);
				}
				uploadFile.transferTo(file);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		daoBoard.insert(bb);
		return "redirect:/boardPage/1";
	}
}