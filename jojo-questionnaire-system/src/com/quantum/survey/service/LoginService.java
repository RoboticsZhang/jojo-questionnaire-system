package com.quantum.survey.service;

import com.quantum.survey.po.Login;

public interface LoginService {
	
	Login loginInfo(String userName, String userPassword);
	
}
