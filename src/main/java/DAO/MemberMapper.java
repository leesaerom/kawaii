package DAO;

import VO.Member;

public interface MemberMapper {

	public int registerMember(Member member);

	public Member selectOne(Member member);

}
