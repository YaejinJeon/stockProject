package com.bitcamp.project.view.user;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.bitcamp.project.service.MyPostService;
import com.bitcamp.project.service.UserInfoService;
import com.bitcamp.project.vo.BoardVO;
import com.bitcamp.project.vo.CommentVO;
import com.bitcamp.project.vo.PagingVO;
import com.bitcamp.project.vo.UserVO;

@Controller
public class MyPageController {
	
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private MyPostService myPostService;
	
	@GetMapping(value="/myPage01")
	public String myPage01() {
		return "mypage01";
	}
	
	@GetMapping(value="/myPage02")
	public String myPage02() {
		return "mypage02";
	}

	@GetMapping(value="/myPage03")
	public String myPage03(HttpSession session, @ModelAttribute("bnowPage") String bnowPage, @ModelAttribute("cnowPage") String cnowPage) {
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		if(loginUser == null)
			return "redirec:/mainPage";
		if(bnowPage == null || bnowPage.equals("")){
			bnowPage = "1";
		}
		if(cnowPage == null || cnowPage.equals("")) {
			cnowPage = "1";
		}
		Map<String, Object> myPost = myPostService.myPostList(loginUser, Integer.parseInt(bnowPage), Integer.parseInt(cnowPage));
		session.setAttribute("myBoard", (List<BoardVO>)myPost.get("myBoard"));
		session.setAttribute("myComment",(List<CommentVO>)myPost.get("myComment"));
		session.setAttribute("boardPage",(PagingVO)myPost.get("boardPage"));
		session.setAttribute("commentPage",(PagingVO)myPost.get("commentPage"));
		return "mypage03";
	}
	
	@PostMapping(value="/updateUser")
	public String updateUser(@ModelAttribute("pw") String pw, @ModelAttribute("address") String address,
							@ModelAttribute("tel") String tel, @ModelAttribute("showEsetSetting") String showEset, HttpSession session) {
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		loginUser.setPw(pw);
		loginUser.setAddress(address);
		loginUser.setTel(tel);
		loginUser.setShowEsetSetting(Integer.parseInt(showEset));
		userInfoService.memberInfoUpdate(loginUser);
		session.setAttribute("loginUser", loginUser);
		return "redirect:mypage01";
	}
	
	@GetMapping(value="/delete/*")
	public String deleteMyPost(@ModelAttribute("delBoardList")String delBoardList, @ModelAttribute("delCommentList")String delCommentList, HttpServletRequest request) {
		System.out.println("delList = " + delBoardList);
		System.out.println("delList = " + delCommentList);
		String[] deleted;
		if(!delBoardList.equals(""))
			deleted = delBoardList.split(",");
		else
			deleted = delCommentList.split(",");
		if(request.getRequestURI().equals("/delete/myBoard")) {
			myPostService.deleteMyPost(deleted, "board");
			return "redirect:/myPage03";
		}
		else {
			System.out.println("comment");
			myPostService.deleteMyPost(deleted, "comment");
			return "redirect:/myPage03";
		}
	}
	
	@PostMapping(value="/myPage03/*")
	public String searchPost(@ModelAttribute("bSearchStyle")String bSearchStyle, @ModelAttribute("cSearchStyle")String cSearchStyle,
			HttpSession session, @ModelAttribute("bnowPage") String bnowPage, @ModelAttribute("cnowPage") String cnowPage) {
		
		if(cSearchStyle.equals(""))
			return null;
		else
			return null;
	}
	
}
