package com.bitcamp.project.view.user;

import static com.bitcamp.project.view.user.SignUpMailController.signUpEmailNumStr;
import static com.bitcamp.project.view.user.SignUpSend.signUpNumStr;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitcamp.project.service.SignUpService;
import com.bitcamp.project.vo.UserVO;
@Controller
public class SignUpController {
	
	@Autowired
  	PasswordEncoder passwordEncoder;

	@Autowired
	private SignUpService signUpService;
	
	// 회원가입화면
	@GetMapping(value="/signUpPage/1")
	public String signUpVieww() {
		return "signInUp/signup01";
	}

	
//	// 회원가입화면
	@GetMapping(value="/signUpPage/2")
	public String signUpView(UserVO vo) {
		return "signInUp/signup02";
	}

	// 회원가입완료화면
	@PostMapping(value="/signUp")
	public String signUp(UserVO vo, @RequestParam("friend") String friend, Model model) {
		// 추천인 입력을 했을 경우
		if(friend != null) {
			vo.setFriend(friend);
		}
		
		// 비밀번호 암호화 후 vo에 저장
		String encPassword = passwordEncoder.encode(vo.getPw());
		vo.setPw(encPassword);
		
		signUpService.signUp(vo);
		model.addAttribute("login", vo);
		
		return "signInUp/signup03";
	}
	
	
	@PostMapping(value="/signUp/kakao")
	public String signUpKakao(HttpSession session,UserVO vo, @RequestParam("friend") String friend, @RequestParam("id") String id,@RequestParam("nickname") String nickname) {
		if(friend != null) {
			vo.setFriend(friend);
		}
		System.out.println("vo su : " + vo.toString());
		signUpService.signUp(vo);
		
		if(vo.getId().contains("_naver_")) {
			vo.setId(vo.getId().replace("_naver_", ""));
		}
		else if(vo.getId().contains("_kakao_")) {
			vo.setId(vo.getId().replace("_kakao_", ""));
		}
		
		session.setAttribute("login", vo);
		return "signInUp/signup03";
	}
	

	@ResponseBody 
	@GetMapping(value= {"/idCheck", "/cEmailCheck", "/nickCheck", "/friendCheck", "/telCheck", "/cTelCheck"})
	public String duplicateCheck(@ModelAttribute("id") String id, @ModelAttribute("cMail") String cMail,@ModelAttribute("tel") String tel, @ModelAttribute("cTel") String cTel,
								@ModelAttribute("nickname") String nickname, HttpServletRequest request, HttpSession session) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		// 아이디 중복확인
		if(request.getServletPath().equals("/idCheck")) {
			map.put("id", id);
			int result=signUpService.duplicateCheck(map);
			return Integer.toString(result);
		}
		// 이메일 인증번호 확인
		else if(request.getServletPath().equals("/cEmailCheck")) {
			if(signUpEmailNumStr.equals(cMail)) {
				return Integer.toString(0);
			}else {
				return Integer.toString(1);
			}
		}
		
		// 닉네임 중복확인
		else if(request.getServletPath().equals("/nickCheck")) {
			UserVO user =(UserVO)session.getAttribute("loginUser");
			if(user==null) {
				map.put("nickname", nickname);
				int result=signUpService.duplicateCheck(map);
				return Integer.toString(result);
			}else {
				if(user.getNickname().equals(nickname)) {
					return Integer.toString(2);
				}
			}
		}
		
		// 추천인 중복확인
		else if(request.getServletPath().equals("/friendCheck")) {
			map.put("nickname", nickname);
			
			int result=signUpService.duplicateCheck(map);
			return Integer.toString(result);
		}
		// 휴대폰 인증번호 전송
		else if(request.getServletPath().equals("/telCheck")) {
			map.put("tel", tel);
			int result=signUpService.duplicateCheck(map);
			if((Integer)tel.length() == 11) {
				if(result == 0) { // 중복확인 후 해당 전화번호 사용자가 없으면
					SignUpSend send = new SignUpSend();
					send.sendSMS(tel);
				}
			}else { // 11자리가 아닐시
				result = 2; 
				return Integer.toString(result);
			}
			
			return Integer.toString(result); // 이미 사용된 전화번호라면
		}
		// 휴대폰 인증번호 확인
		else if(request.getServletPath().equals("/cTelCheck")) {
			int result = 0;
			if(signUpNumStr.equals(cTel)) {
				result = 0; // 사용자 입력값과 생성된 난수가 같으면
				return Integer.toString(result);
			}else {
				result = 1; // 사용자 입력값과 생성된 난수가 같지 않으면
				return Integer.toString(result);
			}
		}
		return null;
	}
	
	

	@RequestMapping("/signUpPage/jusoPopup")
    public String jusoPopup() {
		return "address/jusoPopup";
    }


	
	
}
