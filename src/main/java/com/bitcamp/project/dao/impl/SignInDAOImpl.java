package com.bitcamp.project.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bitcamp.project.dao.SignInDAO;
import com.bitcamp.project.vo.UserVO;

@Repository("SignInDAO")
public class SignInDAOImpl implements SignInDAO{
	
	@Autowired
	private SqlSessionTemplate mybatis;

	
	
	
	@Override
	public void withdrawal(String id) {
		System.out.println("마이바이트"+id);
		mybatis.delete("user.withdrawal", id);
	}

	@Override
	public String existenceID(String id) {
		return mybatis.selectOne("existenceID", id);
	}

	@Override
	public UserVO logIn(UserVO vo) {
		return mybatis.selectOne("signInCheck", vo);
	}

	@Override
	public void logOut() {
		// TODO Auto-generated method stub
	}

	@Override
	public UserVO findId(UserVO vo) {
		return mybatis.selectOne("findId", vo);
		
	}

	@Override
	public void tryId() {
	}
	
	@Override
	public UserVO findPw(UserVO vo) {
		return mybatis.selectOne("findPassword", vo);
	}
	
	@Override
	public UserVO updatePw(UserVO vo) {
		return mybatis.selectOne("updatePassword", vo);
	}
	

}
