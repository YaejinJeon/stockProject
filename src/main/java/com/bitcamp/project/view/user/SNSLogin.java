package com.bitcamp.project.view.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bitcamp.project.service.SignInService;
import com.bitcamp.project.vo.UserVO;

@Controller
public class SNSLogin {

	@Autowired
	private SignInService signInService;

	@GetMapping(value = "/kakao")
	public ModelAndView signInView(@RequestParam("code") String code, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		System.out.println("code : " + code);
		String access_Token = signInService.kakao_GetToken(code);
		System.out.println("controller access_token : " + access_Token);
		String userId = signInService.getKakaoId(access_Token) + "_kakao_";
		if (userId.equals("null_kakao_")) {
			System.out.println("카카오 널 발생");
			mav.setViewName("msg/notice");
			mav.addObject("msg", "오류가 발생했습니다. 메인페이지로 이동합니다.");
			mav.addObject("location", "/");
			return mav;
		}
		System.out.println("KaKaoID : " + userId); // 이후 DB에서 ID 확인후 , 있으면 로그인 진행 , 없으면 추가정보 입력 회원가입 진행
		UserVO vo = new UserVO();
		vo.setId(userId);
		vo = signInService.logIn(vo);
		session.setAttribute("access_Token", access_Token);

		if (vo == null) { // 추가정보 입력 필요
			mav.addObject("kakaoID", userId);
			mav.setViewName("signInUp/signup02_kakao");
			return mav;
		} else {
			session.setAttribute("loginUser", vo);
			mav.setViewName("redirect:/");
			return mav;
		}
	}
}