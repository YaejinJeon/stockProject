// 관리자페이지 일반 유저가 주소로 접근했을 때 메인페이지로 넘기기 

package com.bitcamp.project.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bitcamp.project.vo.UserVO;

public class URLLogger extends HandlerInterceptorAdapter {
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {

		String ip = request.getRemoteAddr();
		SimpleDateFormat format = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분 ss초");

		Date time_ = new Date();

		String time = format.format(time_);
		System.out.println("ip : " + ip + " " + time + " path " + request.getServletPath());

		return true;
	}
}
