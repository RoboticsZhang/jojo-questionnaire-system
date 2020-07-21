package com.quantum.survey.dao;

import com.quantum.survey.po.NonRegUsers;

public interface NonRegUsersDao {
	int addNonRegUsers(NonRegUsers NonRegUsers) ;
	NonRegUsers findNonRegUsersByUserIP(String userIP) ;
}
