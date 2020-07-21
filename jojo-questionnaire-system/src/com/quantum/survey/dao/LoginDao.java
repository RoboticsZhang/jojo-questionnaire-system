package com.quantum.survey.dao;

import com.quantum.survey.po.Login;

public interface LoginDao {

	Login loginInfo(String userName, String userPassword);
}
