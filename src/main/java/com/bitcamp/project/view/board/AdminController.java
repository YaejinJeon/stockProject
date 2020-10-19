package com.bitcamp.project.view.board;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
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

import com.bitcamp.project.service.AdminService;
import com.bitcamp.project.service.BoardService;
import com.bitcamp.project.util.FileUpload;
import com.bitcamp.project.vo.AdminVO;
import com.bitcamp.project.vo.BoardVO;
import com.bitcamp.project.vo.PagingVO;
import com.bitcamp.project.vo.UserVO;
import com.bitcamp.project.vo.VisitVO;

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;
	@Autowired
	BoardService boardService;
	@Autowired
	HttpSession session;
	@Autowired
	HttpServletRequest request;
	
	
	List<String> uploadedFileName = BoardController.uploadedFileName;

	

	@GetMapping("/admin/main")
	public ModelAndView adminPage(BoardVO bVo, AdminVO vo, Model model, @ModelAttribute("bnowPage") String nowPage,
			@ModelAttribute("searchStyle") String searchStyle, @ModelAttribute("keyword") String keyword) {
		ModelAndView mav = new ModelAndView();
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		UserVO allUser = new UserVO();
		if(loginUser == null || loginUser.getPoint() >= 0) {
			mav.addObject("msg", "관리자만 접근할 수 있습니다");
			mav.addObject("location", "/");
			mav.addObject("icon", "error");
			mav.setViewName("msg/msg");
		}
		
		
		List<BoardVO> boardChart = adminService.boardChart(bVo);
		mav.addObject("boardChart", boardChart);
		List<UserVO> userSignUpChart = adminService.userSignUpChart(allUser);
		mav.addObject("userSignUpChart", userSignUpChart);
		
		VisitVO vVo = new VisitVO();
		
		List<VisitVO> visitChart = adminService.userVisitChart(vVo);
		mav.addObject("userVisitChart", visitChart);
		System.out.println(visitChart);
		
		loginUser.getPoint();
		
		
		if (nowPage == null || nowPage.equals("")) {
			nowPage = "1";
		}
		if (searchStyle.equals("")) {
			keyword = "";
		}

		Map<String, Object> qnaList = adminService.qnaList(vo, 0, "", "", 5, "main");
		model.addAttribute("qnaList", (List<AdminVO>) qnaList.get("qnaList"));
		
		
		
		Map<String, Object> reportList = adminService.reportList(vo, Integer.parseInt(nowPage), 30, "", "");
		model.addAttribute("reportList", (List<AdminVO>) reportList.get("reportList"));
		model.addAttribute("reportPage", (PagingVO) reportList.get("reportPage"));
		
		
		mav.setViewName("admin/adminPage");
		return mav;
	}
	
	
	@GetMapping("/admin/qna")
	public String adminQnaList(AdminVO vo, Model model, @ModelAttribute("bnowPage") String nowPage,
			@ModelAttribute("searchStyle") String searchStyle, @ModelAttribute("keyword") String keyword) {

		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		
		if(loginUser == null || loginUser.getPoint() >= 0) {
			model.addAttribute("msg", "관리자만 접근할 수 있습니다");
			model.addAttribute("location", "/");
			model.addAttribute("icon", "error");
			return "msg/msg";
		}
		
		loginUser.getPoint();
		
		
		if (nowPage == null || nowPage.equals("")) {
			nowPage = "1";
		}
		if (searchStyle.equals("")) {
			keyword = "";
		}

		Map<String, Object> qnaList = adminService.qnaList(vo, Integer.parseInt(nowPage), searchStyle, keyword, 30, "");
		model.addAttribute("qnaList", (List<AdminVO>) qnaList.get("qnaList"));
		model.addAttribute("qnaPage", (PagingVO) qnaList.get("qnaPage"));
		model.addAttribute("searchStyle", searchStyle);
		model.addAttribute("keyword", keyword);
		return "admin/adminQna";
	}
	
	@GetMapping("/admin/qna/detail")
	public ModelAndView adminQnaDetail(AdminVO vo) throws IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		ModelAndView mav = new ModelAndView();
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");

		if(loginUser == null || loginUser.getPoint() >= 0) {
			mav.addObject("msg", "관리자만 접근할 수 있습니다");
			mav.addObject("location", "/");
			mav.addObject("icon", "error");
			mav.setViewName("msg/msg");
			
			return mav;
		}
		
		int check = adminService.qnaCount(vo);
		if(check == 1) {
			vo.setAno(1);
		}
		else
			vo.setAno(-1);
		
		
		AdminVO qnaDetail = adminService.qnaDetail(vo);
		
			qnaDetail.setQdateTime(new Date(qnaDetail.getQdateTime().getTime()- (1000 * 60 * 60 * 9)));
			if(qnaDetail.getAno() != 0) {
				qnaDetail.setAdateTime(new Date(qnaDetail.getAdateTime().getTime()- (1000 * 60 * 60 * 9)));
				
			}
		
		System.out.println("?? " + qnaDetail);
		mav.addObject("qna", qnaDetail);
		mav.setViewName("admin/adminQnaDetail");
		
		return mav;
	}
	
	
	
	@GetMapping(value="/admin/qna/answer/write")
	public String qnaAnswerWriteView(AdminVO vo, Model model, @ModelAttribute("qno") int qno) {
		vo.setQno(qno);
		AdminVO qnaDetail = adminService.qnaDetail(vo);
		System.out.println("관리자 "+qnaDetail);
		model.addAttribute("qna", qnaDetail);
		model.addAttribute("qno", vo.getQno());
		return "admin/qnaAnswerWrite";
	}
	
	@PostMapping(value="/admin/qna/answer/write")
	public String qnaAnswerWrite(AdminVO vo, Model model, @ModelAttribute("qno") int qno, @ModelAttribute("acontent") String acontent) {
		vo.setQno(qno);
		
		int check = adminService.qnaCount(vo);
		if(check == 1) {
			vo.setAno(1);
		}
		else
			vo.setAno(-1);
		System.out.println("v?o "+vo);
		
		
		AdminVO qnaDetail = adminService.qnaDetail(vo);
		qnaDetail.setAcontent(acontent);
		model.addAttribute("qna", qnaDetail);
		adminService.writeAnswer(qnaDetail);
		
		
		List<String> uploadThumbnail = new ArrayList<String>();

		FileUpload file = new FileUpload();
		try {

			file.thumbnailDel(null, vo, request, uploadedFileName, uploadThumbnail);
			uploadedFileName.clear();
		}
		catch(Exception e) {
			return "redirect:/admin/qna/detail?qno="+vo.getQno();
		}
		
		
		return "redirect:/admin/qna/detail?qno="+vo.getQno();
	}
	
	@GetMapping("/admin/qna/answer/update")
	public String adminQnaUpdateView(AdminVO vo, Model model, @ModelAttribute("qno") int qno, @ModelAttribute("acontent") String acontent) {
		vo.setQno(qno);
		vo.setAno(1);
		vo.setAcontent(acontent);
		AdminVO qnaDetail = adminService.qnaDetail(vo);
		model.addAttribute("qna", qnaDetail);
		
		
		
		
		return "admin/qnaAnswerUpdate";
	}
	
	@PostMapping("/admin/qna/answer/update")
	public String adminQnaUpdate(AdminVO vo, @ModelAttribute("qno") int qno) {
		vo.setQno(qno);
		
		

		List<String> uploadThumbnail = new ArrayList<String>();

		FileUpload file = new FileUpload();
		try {

			file.thumbnailDel(null, vo, request, uploadedFileName, uploadThumbnail);
			uploadedFileName.clear();
			adminService.updateAnswer(vo);
		}
		catch(Exception e) {
			adminService.updateAnswer(vo);
		}
		
		return "redirect:/admin/qna/detail?qno="+vo.getQno();
	}
	
	
	@GetMapping("/admin/qna/delete")
	public String adminQnaDelete(AdminVO vo) {
		if(vo.getAno() != 0)
			vo.setAno(1);
				
		AdminVO aVo = adminService.qnaDetail(vo);
		List<String> uploadThumbnail = new ArrayList<String>();
		FileUpload fileUpload = new FileUpload();
		fileUpload.fileDel(null, aVo, uploadedFileName, uploadThumbnail, request);
			adminService.answerDelete(aVo);
			adminService.questionDelete(aVo);
		return "redirect:/admin/qna";
	}
	
	
	@GetMapping("/admin/answer/delete")
	public String adminAnswerDelete(AdminVO vo) {
	
		AdminVO aVo = adminService.qnaDetail(vo);
//		List<String> uploadThumbnail = new ArrayList<String>();
//		FileUpload fileUpload = new FileUpload();
//		fileUpload.fileDel(null, aVo, uploadedFileName, uploadThumbnail, request);
			adminService.answerDelete(aVo);
		return "redirect:/admin/qna/detail?qno=" + aVo.getQno();
	}
	
	
	
	@GetMapping("/admin/report")
	public String adminReportList(AdminVO vo, HttpServletRequest request, HttpSession session, Model model, @ModelAttribute("bnowPage") String nowPage,
			@ModelAttribute("searchStyle") String searchStyle, @ModelAttribute("keyword") String keyword,
			@ModelAttribute("orderby") String orderby ) {

		if (nowPage == null || nowPage.equals("")) {
			nowPage = "1";
		}
		if (searchStyle.equals("")) {
			keyword = "";
		}

		if (orderby.equals("")) {
			orderby = "new";
		}
		Map<String, Object> reportList = adminService.reportList(vo, Integer.parseInt(nowPage), 30, searchStyle, keyword);
		model.addAttribute("reportList", (List<AdminVO>) reportList.get("reportList"));
		model.addAttribute("reportPage", (PagingVO) reportList.get("reportPage"));
		model.addAttribute("searchStyle", searchStyle);
		model.addAttribute("keyword", keyword);
		return "admin/adminReport";
	}
	
	@ResponseBody
	@PostMapping("/admin/findRno")
	public Map<String, Object> adminReportList(HttpSession session, Model model, AdminVO vo, @ModelAttribute("rno") String rno) {
		Map<String, Object> reportSelectList = adminService.reportSelectList(vo, rno);
		model.addAttribute("reportSelectList", (AdminVO) reportSelectList.get("reportSelectList"));
		return reportSelectList ;
	}

	@GetMapping("/admin/report/delete")
	public String reportDelete(Model model, BoardVO vo) {
		int delCheck = boardService.deleteBoard(vo);
		if(delCheck == 1) {
			int pno = vo.getPno();
			adminService.updateRcheck(pno);
			model.addAttribute("msg", "성공적으로 삭제되었습니다.");
			model.addAttribute("location", "/admin/report");
			model.addAttribute("icon", "success");
		}
		
		
		return "msg/msg";
	}
	
	@ResponseBody
	@PostMapping("/admin/showReport")
	public Map<String, Object> showReport(HttpSession session, Model model, AdminVO vo, @ModelAttribute("pno") String pno, @ModelAttribute("bno") String bno) {
		Map<String, Object> showReport = adminService.showReport(vo, pno);
		if(showReport == (null)) {
			return null;
		}
		model.addAttribute("showReport", (AdminVO) showReport.get("showReport"));
		return showReport;
	}
}
