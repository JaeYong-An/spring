package com.myweb.www.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myweb.www.repository.MemberDAO;
import com.myweb.www.security.MemberVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{

	private final MemberDAO mdao;

	@Transactional
	@Override
	public int register(MemberVO mvo) {
		int isOK = mdao.insert(mvo);
		return mdao.insertAuthInit(mvo.getEmail());
	}

	@Override
	public boolean updateLastLogin(String authEmail) {
		
		return mdao.updateLastLogin(authEmail)>0? true:false;
	}

	@Transactional
	@Override
	public MemberVO detail(String email) {
		// TODO Auto-generated method stub
		MemberVO mvo = mdao.selectEmail(email);
		mvo.setAuthList(mdao.selectAuths(email));
		return mvo;
	}

	@Transactional
	@Override
	public List<MemberVO> getList() {
		// TODO Auto-generated method stub
		List<MemberVO> list = mdao.getList();
		for(MemberVO mvo : list) {
			mvo.setAuthList(mdao.selectAuths(mvo.getEmail()));
		}
		return list;
	}

	@Override
	public void noPwd(MemberVO mvo) {
		// TODO Auto-generated method stub
		mdao.noPwd(mvo);
	}

	@Override
	public void yesPwd(MemberVO mvo) {
		// TODO Auto-generated method stub
		mdao.yesPwd(mvo);
	}

	@Transactional
	@Override
	public void remove(String email) {
		// TODO Auto-generated method stub
		mdao.removeAuth(email);
		int isOK = mdao.remove(email);
	}
}
