package com.quantum.survey.po;

public class User {
	private int userId;//ID号
	private String userName;//用户名
	private String userPassword;//用户密码
	private String userMail;//邮箱
	private String userReg;//注册日期
	private int userRole;//用户角色    0-管理员,1-注册用户
	
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserMail() {
		return userMail;
	}
	public void setUserMail(String userMail) {
		this.userMail = userMail;
	}
	public String getUserReg() {
		return userReg;
	}
	public void setUserReg(String userReg) {
		this.userReg = userReg;
	}
	public int getUserRole() {
		return userRole;
	}
	public void setUserRole(int userRole) {
		this.userRole = userRole;
	}
	public User(int userId, String userName, String userPassword, String userMail, String userReg,  int userRole) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.userPassword = userPassword;
		this.userMail = userMail;
		this.userReg = userReg;
		this.userRole = userRole;
	}
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
}
