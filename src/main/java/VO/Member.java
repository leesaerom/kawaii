package VO;

public class Member {
	private String userid;
	private String username;
	private String userpassword;
	private String nickname; 
	private String gender;

	public Member() {
	}

	public Member(String userid, String username, String userpassword, String nickname, String gender) {
		super();
		this.userid = userid;
		this.username = username;
		this.userpassword = userpassword;
		this.nickname = nickname;
		this.gender = gender;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUserpassword() {
		return userpassword;
	}

	public void setUserpassword(String userpassword) {
		this.userpassword = userpassword;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	@Override
	public String toString() {
		return "Member [ userid=" + userid + ", username=" + username + ", userpassword="
				+ userpassword + ", nickname=" + nickname + ", gender=" + gender + "]";
	}

}
