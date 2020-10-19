package com.bitcamp.project.view.board;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bitcamp.project.service.BoardService;
import com.bitcamp.project.service.CommentService;
import com.bitcamp.project.util.FileUpload;
import com.bitcamp.project.vo.BoardVO;
import com.bitcamp.project.vo.CommentVO;
import com.bitcamp.project.vo.PagingVO;
import com.bitcamp.project.vo.UserVO;

@Controller
public class BoardController {

	@Autowired
	BoardService boardService;

	@Autowired
	HttpSession session;

	@Autowired
	CommentService commentService;

	@Autowired
	HttpServletRequest request;

	public static List<String> uploadedFileName = new ArrayList<String>();

	@GetMapping(value = "/board/free")
	public String boardList(BoardVO vo, Model model, @ModelAttribute("bnowPage") String nowPage,
			@ModelAttribute("searchStyle") String searchStyle, @ModelAttribute("keyword") String keyword,
			@ModelAttribute("orderby") String orderby /* new = 최신순 best = 인기순 */ ) {
		String bno = "free";

		if (nowPage == null || nowPage.equals("")) {
			nowPage = "1";
		}
		if (searchStyle.equals("")) {
			keyword = "";
		}

		if (orderby.equals("")) {
			orderby = "new";
		}
		
		
		Map<String, Object> boardList = boardService.boardList(vo, Integer.parseInt(nowPage), searchStyle, keyword,
				orderby, bno, 30);
					// 한페이지에 게시물 30개
		
		model.addAttribute("boardList", (List<BoardVO>) boardList.get("boardList"));
		model.addAttribute("boardPage", (PagingVO) boardList.get("boardPage"));
		model.addAttribute("searchStyle", searchStyle);
		model.addAttribute("keyword", keyword);
		
		List<BoardVO> ServiceCenternotice = new ArrayList<BoardVO>();
		model.addAttribute("ServiceCenternotice",boardService.ServiceCenternotice(vo));

		return "board/free-board";
	}

	@GetMapping("/board/free/write")
	public String boardWriteView(BoardVO vo, Model model) {
		return "board/free-board-writeForm";
	}

	@PostMapping("/board/free/write")
	public String boardWrite(BoardVO vo, Model model) {

		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		
		if(loginUser == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("location", "/signInPage");
			model.addAttribute("icon", "error");
			return "msg/msg";
		}
		
		
		
		vo.setId(loginUser.getId());
		vo.setBno("free"); // 자유게시판

		List<String> uploadThumbnail = new ArrayList<String>();

		FileUpload fu = new FileUpload();
		try {
			
			fu.thumbnailDel(vo, null, request, uploadedFileName, uploadThumbnail);
			uploadedFileName.clear();
			boardService.writeFreeBoard(vo);
		}
		catch(Exception e) {
			boardService.writeFreeBoard(vo);
			
		}
		return "redirect:/board/free";
	}

	@GetMapping("/board/free/detail")
	public ModelAndView getView(BoardVO vo, CommentVO cVo, PagingVO pVo, @ModelAttribute("bnowPage") String nowPage) {
		if (nowPage == null || nowPage.equals("")) {
			nowPage = "1";
		}

		ModelAndView mav = new ModelAndView();
		BoardVO boardDetail = boardService.getBoard(vo);
		boardService.updateViews(vo);
		Map<String, Object> commentList = commentService.commentList(cVo, Integer.parseInt(nowPage));
		mav.addObject("boardDetail", boardDetail);
//		System.out.println("boardDetail " + boardDetail);
		mav.addObject("commentList", (List<CommentVO>) commentList.get("commentList"));
		mav.addObject("commentPage", (PagingVO) commentList.get("commentPage"));

		mav.setViewName("board/free-board-detail");

		return mav;
	}

	@GetMapping("/board/free/detail/ajax")
	public @ResponseBody Map<String, Object> getBoard(BoardVO vo, CommentVO cVo, PagingVO pVo, Model model,
			@ModelAttribute("bnowPage") String nowPage, @ModelAttribute("pno") int pno) {
		if (nowPage == null || nowPage.equals("")) {
			nowPage = "1";
		}
		vo.setPno(pno);
		vo.setBno("free");
		BoardVO boardDetail = boardService.getBoard(vo);
		System.out.println(vo);
		List<BoardVO> boardPrevNext = boardService.boardPrevNext(vo);
		System.out.println(vo);
		// 댓글리스트
		Map<String, Object> commentList = commentService.commentList(cVo, Integer.parseInt(nowPage));
		Map<String, Object> map = new HashMap<String, Object>();
		List<CommentVO> comment = (List<CommentVO>) commentList.get("commentList");
		
		// 아이폰에서 시간이 제대로 표시 안되는 관계로 String으로 형변환
		// mysql Timezone이 UTC로 설정되어있어 시간 재설정
		// 게시물
		boardDetail.setBdateTime(new Date(boardDetail.getBdateTime().getTime()- (1000 * 60 * 60 * 9)));
		Date from = boardDetail.getBdateTime();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String boardDate = transFormat.format(from);
		// 댓글
		String commentDateString = null;
		List<String> commentDate = new ArrayList<String>();
		
		for (int i = 0; i < comment.size(); i++) {
			comment.get(i).setCdateTime(new Date(comment.get(i).getCdateTime().getTime()- (1000 * 60 * 60 * 9)));
			Date commentDate_ = comment.get(i).getCdateTime();
			commentDateString = transFormat.format(commentDate_);
			commentDate.add(commentDateString);
		}
		
		

		
		map.put("boardDetail", boardDetail);
		map.put("commentList", comment);
		map.put("commentPage", (PagingVO) commentList.get("commentPage"));
		map.put("boardPrevNext", boardPrevNext);
		model.addAttribute("loginUser", session.getAttribute("loginUser")); // 비로그인 유저는 신고 못하게를 위한
		map.put("loginUser", model.getAttribute("loginUser"));
		map.put("boardDate", boardDate);
		map.put("commentDate", commentDate);
		return map;
	}

	@GetMapping("/board/detail/likes/ajax")
	@ResponseBody
	public int boardLikes(BoardVO vo, @RequestParam("pno") int pno) {
		UserVO uVo = (UserVO) session.getAttribute("loginUser");
		try {
			vo.setId(uVo.getId());
		} catch (Exception e) {
			return 2;
		}

		vo.setPno(pno);
		return boardService.boardLikes(vo);
	}

	@GetMapping("/board/free/update")
	public String updateBoardView(BoardVO vo, Model model) {
		BoardVO boardUpdate = boardService.getBoard(vo);
		model.addAttribute("boardUpdate", boardUpdate);
		return "board/free-board-updateForm";
	}

	@PostMapping("/board/free/update")
	public String updateBoard(BoardVO vo, Model model) {

		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		
		if(loginUser == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("location", "/signInPage");
			model.addAttribute("icon", "error");
			return "msg/msg";
		}
		
		
		List<String> uploadThumbnail = new ArrayList<String>();

		FileUpload fu = new FileUpload();
		try {
			fu.thumbnailDel(vo, null, request, uploadedFileName, uploadThumbnail);
			uploadedFileName.clear();
			boardService.updateBoard(vo);
		}
		catch(Exception e) {
			boardService.updateBoard(vo);
		}
		return "redirect:/board/free";
	}

	@GetMapping("/board/free/delete")
	public String deleteBoard(BoardVO vo, Model model) {
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		
		if(loginUser == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("location", "/signInPage");
			model.addAttribute("icon", "error");
			return "msg/msg";
		}
		

		boardService.deleteBoard(vo);
		return "redirect:/board/free";
	}

	@PostMapping("/reportBoard")
	public ModelAndView reportBoard(BoardVO vo, @RequestParam("title") String title,
			@RequestParam("rtype") String rtype, @RequestParam("rcontent") String rcontent, @ModelAttribute("bno") String bno, HttpSession session,
			Model model) {
		vo.setTitle(title);
		vo.setRtype(rtype);
		System.out.println(bno);
		vo.setBno(bno);
		vo.setRcontent(rcontent);
		UserVO user = (UserVO) session.getAttribute("loginUser");
		vo.setNickname(user.getNickname());
		
		

		int report = boardService.reportBoard(vo);

		ModelAndView mav = new ModelAndView();

		
	
		
		if (report == 1) {
			mav.addObject("msg", "해당 게시물이 신고 완료되었습니다.");
			
			mav.addObject("location", "");
			mav.addObject("icon", "success");
			mav.setViewName("msg/msg");
			return mav;
		} else {
			mav.addObject("msg", "신고는 1회만 가능합니다.");
			mav.addObject("location", "");
			mav.addObject("icon", "error");
			mav.setViewName("msg/msg");
			return mav;
		}

	}

	@RequestMapping("/fileUpload")
	public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {
		FileUpload file = new FileUpload();
		BoardVO vo = file.file(request, response);
		uploadedFileName.add(vo.getThumbnailName());
		System.out.println(uploadedFileName);
	}
	
	

}
