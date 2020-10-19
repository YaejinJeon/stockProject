package com.bitcamp.project.service.impl;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.project.dao.SignInDAO;
import com.bitcamp.project.service.SignInService;
import com.bitcamp.project.vo.UserVO;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class SignInServiceImpl implements SignInService {

	@Autowired
	private SignInDAO signInDAO;

	@Override
	public String existenceID(String id) {
		return signInDAO.existenceID(id);
	}

	@Override
	public void withdrawal(String id) {
		signInDAO.withdrawal(id);
	}

	@Override
	public String withdrawal_Kakao(String access_Token) {
		String kakaoId = null;
		String reqURL = "https://kapi.kakao.com/v1/user/unlink";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");

			// 요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			kakaoId = result.split(":")[1].replaceAll("}", "_kakao_");

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(kakaoId);
		return kakaoId;
	}

	@Override
	public String getKakaoId(String access_Token) {
		String kakaoId = null;
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");

			// 요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}

			kakaoId = result.split(",")[0].split(":")[1];

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return kakaoId;
	}

	@Override
	public String kakao_GetToken(String code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=411ad5d7607a5206006f889840ab2b27");
			sb.append("&redirect_uri=http://www.fantasystock.shop/kakao");
			sb.append("&code=" + code);
			bw.write(sb.toString());
			bw.flush();

			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);

			br.close();
			bw.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return access_Token;
	}

	@Override
	public UserVO logIn(UserVO vo) {
		return signInDAO.logIn(vo);
	}

	@Override
	public void logOut() {
		signInDAO.logOut();
	}

	@Override
	public UserVO findId(UserVO vo) {
		return signInDAO.findId(vo);

	}

	@Override
	public void tryId() {
	}

	@Override
	public UserVO findPw(UserVO vo) {
		return signInDAO.findPw(vo);
	}

	@Override
	public UserVO updatePw(UserVO vo) {
		return signInDAO.updatePw(vo);
	}

}
