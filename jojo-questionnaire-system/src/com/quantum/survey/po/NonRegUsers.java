package com.quantum.survey.po;


public class NonRegUsers {
	private String userIP;//非注册用户IP

	public String getuserIP() {
		return userIP;
	}
	public void setuserIP(String userIP) {
		this.userIP = userIP;
	}

	public NonRegUsers(String userIP) {
		super();
		this.userIP = userIP;

	}
	public NonRegUsers() {
		super();
		// TODO Auto-generated constructor stub
	}
}
