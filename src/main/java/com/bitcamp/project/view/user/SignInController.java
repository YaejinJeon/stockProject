package com.bitcamp.project.view.user;

import static com.bitcamp.project.view.user.ExampleSend.numStr;
import static com.bitcamp.project.view.user.MailController.EmailNumStr;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bitcamp.project.service.SignInService;
import com.bitcamp.project.vo.UserVO;

@Controller
public class SignInController {
	
	@Autowired
	private SignInService signInService;
	@Autowired
    PasswordEncoder passwordEncoder;	
	@Autowired
	BCryptPasswordEncoder bPasswordEncoder;
	
	@GetMapping(value="/signInPage" )
	public String signInView(UserVO vo) {
		return "signInUp/login";
	}
	
	@PostMapping(value="/signIn")
	public ModelAndView signIn(@ModelAttribute("id") String id, @ModelAttribute("pw") String pw, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		UserVO vo = new UserVO();
		vo.setId(id);
		
		try {
			vo = signInService.logIn(vo);
			String dbPw = vo.getPw(); // db에 저장된 pw
            String inputPw = pw;	// 사용자가 입력한 pw
            System.out.println("1 "+dbPw);
            System.out.println("2 " +inputPw);

            if(bPasswordEncoder.matches(pw, dbPw)) {
                vo.setPw(dbPw);
                session.setAttribute("loginUser", vo);
                mav.addObject("msg","login");
                mav.addObject("location","/");
				mav.setViewName("msg/msg");
				

				String saveId = request.getParameter("saveId");
				//아이디 저장 여부를 보고 쿠키로 아이디값 저장
				if(saveId!=null) {
		            Cookie c = new Cookie("saveId",id);
		            //쿠키값 저장 시간을 지정함, 숫자당 1초로 계산
		            c.setMaxAge(60*60*24*7); //7일간 저장
		            response.addCookie(c);
		        }else {
		            Cookie c = new Cookie("saveId",id);
		            c.setMaxAge(0);
		            response.addCookie(c);
		        } 
				
				return mav;
            }else {
            	mav.addObject("msg", "입력한 정보가 일치하지 않습니다!");
				mav.addObject("location", "/signInPage");
				mav.setViewName("msg/notice");
				return mav;
            }
		}
		catch(Exception e) {
			mav.addObject("msg", "입력한 정보가 일치하지 않습니다!");
			mav.addObject("location", "/signInPage");
			mav.setViewName("msg/notice");
			return mav;
		}
            
	}
	
	@GetMapping(value="/logOut")
	public String logout(HttpSession session) {
		System.out.println("#####: " + session.getAttribute("loginUser"));
		if(((UserVO)session.getAttribute("loginUser")).getId().substring(((UserVO)session.getAttribute("loginUser")).getId().length()-1).equals("_")) { //끝글자 확인
			String ID = ((UserVO)session.getAttribute("loginUser")).getId();
			String[] ID_s = ID.split("_");
			
			switch (ID_s[ID_s.length-1]) {
			case "kakao":
				System.out.println("카카오 로그아웃");
				session.invalidate();
//				return "redirect:Https://kauth.kakao.com/oauth/logout?client_id=411ad5d7607a5206006f889840ab2b27&logout_redirect_uri=http://www.fantasystock.ml";
				return "redirect:/";
				
			case "naver":
				System.out.println("네이버 로그아웃");
				session.invalidate();
				return "redirect:/";
				
			default:
				break;
			}
			
		}
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping(value="/forgetId")
	public String findIdView() {
		System.out.println("로그");
		return "forgetidpw/forgetidpage";
	}
	
	@GetMapping(value="/forgetIdTry") //문자 전송이 완료했으면.
	public String tryIdView(@ModelAttribute("answer") String answer) {
			return "forgetidpw/forgetidpage-try-success"; // 인증화면
	}
	
	@SuppressWarnings("unused")
	@PostMapping(value= {"/forgetId", "/forgetIdTry"})
	public String findId(Model model, String[] args, UserVO vo, @ModelAttribute("tel") String tel, @ModelAttribute("answer") String answer, HttpSession session, HttpServletRequest request) {
			
		if(request.getServletPath().equals("/forgetId")) {
			vo.setTel(tel);
			vo = signInService.findId(vo);
			session.setAttribute("findUser", vo);
			if(vo == null || tel.equals("")) { // 없는 전화번호
				return "forgetidpw/forgetidpagefail"; // 데이터베이스에 없는 값 입력시 페이지
			}else if(vo.getId().contains("_naver_"))  {
				model.addAttribute("msg", "회원님은 네이버회원이십니다. 네이버로 이동합니다");
				model.addAttribute("icon", "success");
				model.addAttribute("location", "https://nid.naver.com/user2/help/idInquiry.nhn?menu=idinquiry");
				return "msg/msg";	
			}else if(vo.getId().contains("_kakao_")){
				model.addAttribute("msg", "회원님은 카카오톡회원이십니다. 카카오톡으로 이동합니다");
				model.addAttribute("icon", "success");
				model.addAttribute("location", "https://accounts.kakao.com/weblogin/find_account?continue=https%3A%2F%2Faccounts.kakao.com%2Fweblogin%2Faccount#pageFindAccountSelect");
				return "msg/msg";
			}else {
				ExampleSend es = new ExampleSend(); // 문자보내는 클래스 
				ExampleSend.main(args, tel);  // 문자보내는 메서드
				model.addAttribute("msg", "번호를 확인중입니다.");
				model.addAttribute("icon", "success");
				model.addAttribute("location", "/forgetIdTry");
				return "msg/msg";
			}
		}
		
		else if(request.getServletPath().equals("/forgetIdTry")) {
			if(answer.equals(numStr)) { // 대답과 인증번호가 같다면
				return "forgetidpw/forgetidpagesuccess";
			}else {
				model.addAttribute("msg", "인증번호가 일치하지않습니다.");
				model.addAttribute("icon", "error");
				model.addAttribute("location", "/forgetIdTry");
				return "msg/msg";
			} 
		}
		return null;
	}
	
	@GetMapping(value="/forgetPassword")
	public String findPwView() {
		return "forgetidpw/forgetpasswordpage";
	}
	
	@GetMapping(value="/forgetPasswordTry")
	public String findPw() {
		return "forgetidpw/forgetpasswordpage-try-success";
	}

	@PostMapping(value= {"/forgetPassword", "forgetPasswordTry"})
	public String findPw(Model model, UserVO vo, @ModelAttribute("id") String id, @ModelAttribute("email_answer") String email_answer, 
			HttpSession session, HttpServletRequest request) throws MailException, UnsupportedEncodingException, MessagingException {
		if(request.getServletPath().equals("/forgetPassword")) {
			vo.setId(id);
			vo = signInService.findPw(vo);
			session.setAttribute("findUser", vo);
			if(vo==null || vo.getId().equals("") ) {
				return "forgetidpw/forgetpasswordpagefail";
			}else {
				return "redirect:/user/mail";
				
			}
		}
		if(request.getServletPath().equals("/forgetPasswordTry")) {
			if(email_answer.equals(EmailNumStr)) { // 대답과 인증번호가 같다면
				return "forgetidpw/forgetpasswordpagereset"; 
			}else {
				model.addAttribute("msg", "인증번호가 일치하지않습니다.");
				model.addAttribute("icon", "error");
				model.addAttribute("location", "/forgetPasswordTry");
				return "msg/msg"; // 대답과 인증번호가 다르면
			} 
		}
		return null;
	}
	
	@GetMapping(value="/updatePassword")
	public String updatePasswordView() {
		return "forgetidpw/forgetpasswordpagereset";
	}
	
	@PostMapping(value="/updatePassword")	
	public String updatePassword(UserVO vo, @ModelAttribute("password") String password, 
			@ModelAttribute("passwordAgain") String passwordAgain, HttpSession session) {
		String encPassword = passwordEncoder.encode(password);
		
		if(bPasswordEncoder.matches(password, encPassword)) {
			System.out.println("password @@@: " + password);
			UserVO finduserVO = (UserVO) session.getAttribute("findUser");
			finduserVO.setPw(encPassword);
			vo = signInService.updatePw(finduserVO);
			return "forgetidpw/forgetpasswordpagesuccess";
		}else{ // 비밀번호랑 비밀번호 확인이 같지않으면 어처피 클릭이 되지 않아 else는 구현 안함
			System.out.println("password ###: " + password);
		}
	return "forgetidpw/forgetpasswordpagereset";
	}
}