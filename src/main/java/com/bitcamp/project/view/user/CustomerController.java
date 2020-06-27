package com.bitcamp.project.view.user;

import java.io.File;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bitcamp.project.service.BoardService;
import com.bitcamp.project.service.CommentService;
import com.bitcamp.project.service.AdminService;
import com.bitcamp.project.util.FileUpload;
import com.bitcamp.project.view.board.BoardController;
import com.bitcamp.project.vo.BoardVO;
import com.bitcamp.project.vo.CommentVO;
import com.bitcamp.project.vo.PagingVO;
import com.bitcamp.project.vo.AdminVO;
import com.bitcamp.project.vo.UserVO;

@Controller
public class CustomerController {
	
	@Autowired
	BoardService boardService;

	@Autowired
	CommentService commentService;

	@Autowired
	AdminService adminService;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;
	
	List<String> uploadedFileName = BoardController.uploadedFileName;
	
	@GetMapping(value="/customer")
	public String customerLanding(Model model, BoardVO vo) {
		vo.setBno(3);
		List<BoardVO> ServiceCenternotice = new ArrayList<BoardVO>();
		model.addAttribute("ServiceCenternotice",boardService.ServiceCenternotice(vo));
		
		return "customer/customerLanding";
	}
	
	@GetMapping(value="/customerNotice")
	public String customerNotice(BoardVO vo, Model model, @ModelAttribute("bnowPage") String nowPage,
			@ModelAttribute("searchStyle") String searchStyle, @ModelAttribute("keyword") String keyword) {
		int bno = 3;
		if(nowPage == null || nowPage.equals("")){
			nowPage = "1";
		}
		if(searchStyle.equals("")) {
			keyword = "";
		}
		Map<String, Object> boardList = boardService.boardList(vo, Integer.parseInt(nowPage), searchStyle, keyword, "new", bno, 30);
		model.addAttribute("boardList", (List<BoardVO>)boardList.get("boardList"));
		model.addAttribute("boardPage", (PagingVO)boardList.get("boardPage"));
		model.addAttribute("searchStyle", searchStyle);
		model.addAttribute("keyword", keyword);
		return "customer/customerNotice";
	}	
	@GetMapping("/customerNotice/detail")
	public ModelAndView getView(BoardVO vo, CommentVO cVo, PagingVO pVo, @ModelAttribute("bnowPage") String nowPage) {
		if(nowPage == null || nowPage.equals("")){
			nowPage = "1";
		}
		
		ModelAndView mav = new ModelAndView();
		BoardVO boardDetail = boardService.getBoard(vo);
		boardService.updateViews(vo);
		Map<String, Object> commentList = commentService.commentList(cVo, Integer.parseInt(nowPage));
		mav.addObject("boardDetail", boardDetail);
		mav.addObject("commentList", (List<CommentVO>)commentList.get("commentList"));
		mav.addObject("commentPage", (PagingVO)commentList.get("commentPage"));
		
		
		mav.setViewName("customer/customerNoticeDetail");
		
		return mav;
	}
	
	@GetMapping("/customerNotice/detail/ajax")
	public @ResponseBody Map<String, Object> getBoard(BoardVO vo, CommentVO cVo, PagingVO pVo, @ModelAttribute("bnowPage") String nowPage, @ModelAttribute("pno") int pno) {
		if(nowPage == null || nowPage.equals("")){
			nowPage = "1";
		}
		vo.setPno(pno);
		BoardVO boardDetail = boardService.getBoard(vo);
		List<BoardVO> boardPrevNext = boardService.boardPrevNext(vo);
		// 댓글리스트
		Map<String, Object> commentList = commentService.commentList(cVo, Integer.parseInt(nowPage));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardDetail", boardDetail);
		map.put("commentList", (List<CommentVO>)commentList.get("commentList"));
		map.put("commentPage", (PagingVO)commentList.get("commentPage"));
		map.put("boardPrevNext", boardPrevNext);
		
		return map;
	}
	
	@GetMapping(value="/customerQna")
	public String customerqnaView() {
		return "customer/customerqna";
	}	

	
	@GetMapping(value="/customerNoticeWrite")
	public String customNoticeWrite() {
		return "customer/customerNoticeWrite";
	}	
	
	@PostMapping("/customerNoticeWrite")
	public String boardWrite(BoardVO vo) {
		
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		vo.setId(loginUser.getId());
		vo.setBno(3); // 공지사항
		List<String> uploadThumbnail = new ArrayList<String>();
		
		FileUpload file = new FileUpload();
		try {
			file.thumbnailDel(vo, null, request, uploadThumbnail, uploadThumbnail);
			uploadedFileName.clear();
			boardService.writeFreeBoard(vo);
		}
		catch(Exception e) {
			boardService.writeFreeBoard(vo);
		}
		return "redirect:/customerNotice";
	}
	
	@GetMapping("/customerNotice/update")
	public String updateBoardView(BoardVO vo, Model model) {
		BoardVO boardUpdate = boardService.getBoard(vo);
		model.addAttribute("boardUpdate", boardUpdate);
		return "customer/customNoticeUpdate";
	}

	@PostMapping("/customerNotice/update")
	public String updateBoard(BoardVO vo, Model model) {
		BoardVO bVo = boardService.getBoard(vo);
		List<String> uploadThumbnail = new ArrayList<String>();
		
		FileUpload file = new FileUpload();
		try {
			file.thumbnailDel(vo, null, request, uploadThumbnail, uploadThumbnail);
			uploadedFileName.clear();
			boardService.updateBoard(vo);
		}
		catch(Exception e) {
			boardService.updateBoard(vo);
		}			
		return "redirect:/customerNotice";
	}
	
	@GetMapping("/customerNotice/delete")
	public String deleteBoard(BoardVO vo) {
		BoardVO bVo = boardService.getBoard(vo);
		List<String> uploadThumbnail = new ArrayList<String>();
		FileUpload fileUpload = new FileUpload();
		fileUpload.fileDel(bVo, null, uploadedFileName, uploadThumbnail, request);
		
		boardService.deleteBoard(vo);
		return "redirect:/customerNotice";
	}
	
	@GetMapping(value="/customerClaim/write")
	public String customerClaimWriteView(Model model) {
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		
		if(loginUser == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("location", "/signInPage");
			model.addAttribute("icon", "error");
			return "msg";
		}else {
			return "customer/customerClaimWrite";
		}
	}
	@PostMapping(value="/customerClaim/write")
	public ModelAndView customerClaimWrite(AdminVO vo) {
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		ModelAndView mav = new ModelAndView();
		
		if(loginUser == null) {
			mav.addObject("msg", "로그인이 필요한 페이지입니다.");
			mav.addObject("location", "/signInPage");
			mav.addObject("icon", "error");
			mav.setViewName("msg/msg");
			return mav;
		}else {
		
			vo.setNickname(loginUser.getNickname());
			List<String> uploadThumbnail = new ArrayList<String>();

			FileUpload file = new FileUpload();
			try {

				file.thumbnailDel(null, vo, request, uploadedFileName, uploadThumbnail);
				uploadedFileName.clear();
				adminService.writeQuestion(vo);
			}
			catch(Exception e) {
				adminService.writeQuestion(vo);
			}
			
			mav.addObject("msg", "문의가 등록되었습니다");
			mav.addObject("location", "/customerClaim/list");
			mav.addObject("icon", "success");
			mav.setViewName("msg/msg");
			
			return mav;
		}
	}
	
	@GetMapping(value="/customerClaim/list")
	public String customerQnaList(AdminVO vo, Model model, @ModelAttribute("bnowPage") String nowPage,
			@ModelAttribute("searchStyle") String searchStyle, @ModelAttribute("keyword") String keyword) {

		if (nowPage == null || nowPage.equals("")) {
			nowPage = "1";
		}
		if (searchStyle.equals("")) {
			keyword = "";
		}

		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		if(loginUser == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("location", "/signInPage");
			model.addAttribute("icon", "error");
			return "msg/msg";
		}
		else {
			vo.setNickname(loginUser.getNickname());
			
			
			Map<String, Object> qnaList = adminService.qnaList(vo, Integer.parseInt(nowPage), searchStyle, keyword, 15, "");	
			model.addAttribute("qnaList", (List<AdminVO>) qnaList.get("qnaList"));
			model.addAttribute("qnaPage", (PagingVO) qnaList.get("qnaPage"));
			model.addAttribute("searchStyle", searchStyle);
			model.addAttribute("keyword", keyword);
			
			
		
			return "customer/customerClaimList";
		}
	}
	
	@GetMapping(value="/customerClaim/detail")
	public String customerClaimDetail(AdminVO vo, Model model, @ModelAttribute("bnowPage") String nowPage) {
		if (nowPage == null || nowPage.equals("")) {
			nowPage = "1";
		}
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		if(loginUser == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("location", "/signInPage");
			model.addAttribute("icon", "error");
			return "msg/msg";
		}
		else {
		
			vo.setNickname(loginUser.getNickname());
			
			int check = adminService.qnaCount(vo);
			if(check == 1) {
				vo.setAno(1);
			}
			else
				vo.setAno(-1);
			
			AdminVO qna = adminService.qnaDetail(vo);

				qna.setQdateTime(new Date(qna.getQdateTime().getTime()- (1000 * 60 * 60 * 9)));
				if(qna.getAno() != 0) {
					qna.setAdateTime(new Date(qna.getAdateTime().getTime()- (1000 * 60 * 60 * 9)));
					
				}
			
			
			model.addAttribute("qna", qna);
			model.addAttribute("qno", vo.getQno());
			return "customer/customerClaimDetail";
		}
				
	}
	
	
//	@GetMapping(value="/customerClaim/update")
//	public String customerClaimUpdateView(AdminVO vo, Model model) {
//		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
//		System.out.println("ab "+vo);
//		System.out.println(loginUser);
//		if(loginUser == null) {
//			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
//			model.addAttribute("location", "/signInPage");
//			model.addAttribute("icon", "error");
//			return "msg";
//		}
//		else {
//			AdminVO qna = adminService.qnaDetail(vo);
//			
//			model.addAttribute("qna", qna);
//			model.addAttribute("qno", qna.getQno());
//			return "customerClaimUpdate";
//		}
//	}
//
//	@PostMapping(value="/customerClaim/update")
//	public String customerClaimUpdate(AdminVO vo, Model model, @ModelAttribute("qno") int qno) {
//		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
//		if(loginUser == null) {
//			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
//			model.addAttribute("location", "/signInPage");
//			model.addAttribute("icon", "error");
//			return "msg";
//		}
//		else {
//			vo.setQno(qno);
//			
//			FileUpload file = new FileUpload();
//			try {
//				List<String> uploadThumbnail = new ArrayList<String>();
//
//				file.thumbnailDel(null, vo, request, uploadedFileName, uploadThumbnail);
//				uploadedFileName.clear();
//				adminService.qnaUpdate(vo);
//			}
//			catch(Exception e) {
//				adminService.qnaUpdate(vo);
//			}
//			return "redirect:/customerClaim/list";
//		}
//	}

	
	
	@GetMapping(value="/customerClaim/delete")
	public String customerClaimDelete(AdminVO vo, Model model, @ModelAttribute("qno") int qno) {
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		if(loginUser == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("location", "/signInPage");
			model.addAttribute("icon", "error");
			return "msg/msg";
		}
		else {
			vo.setNickname(loginUser.getNickname());
			
			int check = adminService.qnaCount(vo);
			if(check == 1) {
				vo.setAno(1);
			}
			else {
				vo.setAno(-1);
			}
			AdminVO qna = adminService.qnaDetail(vo);
			
			
			int delCheck = adminService.questionDelete(qna);
			if(delCheck == 1) {
				
				FileUpload file = new FileUpload();
				try {
					List<String> uploadThumbnail = new ArrayList<String>();

					file.thumbnailDel(null, vo, request, uploadedFileName, uploadThumbnail);
					uploadedFileName.clear();
				}
				catch(Exception e) {
				}

				
				return "redirect:/customerClaim/list";
			}
			else {
				
				return "redirect:/customerClaim/list";
				
			}
		}
	}
	

}
