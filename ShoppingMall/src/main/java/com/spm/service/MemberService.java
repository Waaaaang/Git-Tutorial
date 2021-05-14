package com.spm.service;

import com.spm.vo.MemberVO;

public interface MemberService {

	//회원가입
	public int insert(MemberVO vo);
	
	//아이디중복검사
	public int mberIdCheck(String mberId);
	
	//이메일중복검사
	public int emailCheck(String email);
	
	//아이디 찾기
	public String findId(String email);
	
	//비밀번호 찾기
	public String findPw(MemberVO vo);
	
	//비밀번호 변경
	public int updatePw(MemberVO vo);
	
	//로그인
	public MemberVO login(MemberVO vo);
	
	//마이페이지
	public MemberVO myPage(String mberId);

	//회원탈퇴
	public boolean deleteMember(String mberId);
	
	//회원정보수정
	public boolean updateMember(MemberVO vo);
	
	//충전
	public int charge(MemberVO vo);
}
