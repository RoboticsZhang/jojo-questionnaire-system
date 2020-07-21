package com.quantum.survey.dao;

import java.util.List;

import com.quantum.survey.po.User;

public interface UserDao {

	List<User> findAllUsers();
	
	User findUserByUserId(int userId);
	User findUserByUserName(String userName);
	User findUserByUserMail(String userMail);
	
	int addUsers(User user);
	int modifyUsers(User user);
	int deleteUsers(int userId);
}
