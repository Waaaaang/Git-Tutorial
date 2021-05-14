package com.spm.service.Impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.spm.mapper.MemberMapper;
import com.spm.service.MemberService;
import com.spm.vo.MemberVO;

@Service("memberService")
public class MemberServiceImpl implements MemberService {

	@Resource(name="memberMapper")
	private MemberMapper memberMapper;
	
	//회원가입
	@Override
	public int insert(MemberVO vo) {
		return memberMapper.insert(vo);
	}

	//아이디 중복 검사
	@Override
	public int mberIdCheck(String mberId) {
		return memberMapper.mberIdCheck(mberId);
	}
	
	//이메일 중복 검사
	@Override
	public int emailCheck(String email) {
		return memberMapper.emailCheck(email);
	}

	//아이디 찾기
	@Override
	public String findId(String email) {
		return memberMapper.findId(email);
	}

	//비밀번호 찾기
	@Override
	public String findPw(MemberVO vo) {
		return memberMapper.findPw(vo);
	}

	//비밀번호 변경
	@Override
	public int updatePw(MemberVO vo) {
		return memberMapper.updatePw(vo);
		
	}

	//로그인
	@Override
	public MemberVO login(MemberVO vo) {
		return memberMapper.login(vo);
	}

	//마이페이지
	@Override
	public MemberVO myPage(String mberId) {
		return memberMapper.myPage(mberId);
	}

	//회원탈퇴
	@Override
	public boolean deleteMember(String mberId) {
		return memberMapper.deleteMember(mberId) == 1;
	}

	//회원정보수정
	@Override
	public boolean updateMember(MemberVO vo) {
		return memberMapper.updateMember(vo) == 1;
	}

	//충전
	@Override
	public int charge(MemberVO vo) {
		return memberMapper.charge(vo);
	}

	

}
