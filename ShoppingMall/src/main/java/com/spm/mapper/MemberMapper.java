package com.spm.mapper;

import com.spm.vo.MemberVO;

public interface MemberMapper {

	//회원가입
	public int insert(MemberVO vo);
	
	//아이디 중복 검사
	public int mberIdCheck(String mberId);
	
	//아이디 찾기
	public String findId(String email);
	
	//비밀번호 찾기
	public String findPw(MemberVO vo);
	
	//이메일 중복 체크
	public int emailCheck(String email);
	
	//비밀번호 업데이트
	public int updatePw(MemberVO vo);
	
	//로그인 
	public MemberVO login(MemberVO vo);
	
	//마이페이지
	public MemberVO myPage(String mberId);
	
	//회원탈퇴
	public int deleteMember(String mberId);
	
	//회원정보수정
	public int updateMember(MemberVO vo);
	
	//충전
	public int charge(MemberVO vo);
}
