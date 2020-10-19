// 관리자페이지 일반 유저가 주소로 접근했을 때 메인페이지로 넘기기 

package com.bitcamp.project.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bitcamp.project.vo.UserVO;

public class InterCeptor extends HandlerInterceptorAdapter{
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler){
		try {
			//logininfo 세션값이 널일경우
			UserVO vo = (UserVO)request.getSession().getAttribute("loginUser");
			
			System.out.println(vo);
			
			if(vo == null || vo.getPoint() >= 0){
					//로그인페이지로 redirect
					response.sendRedirect("/");	
					return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		//널이 아니면 정상적으로 컨트롤러 호출
		return true;
	}
}


