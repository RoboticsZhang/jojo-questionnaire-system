package com.quantum.survey.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;

import com.quantum.survey.dao.LoginDao;
import com.quantum.survey.dao.mysqlimpl.LoginDaoImpl;
import com.quantum.survey.po.Login;
import com.quantum.survey.service.LoginService;

public class LoginServiceImpl implements LoginService {

	private LoginDao loginDao = new LoginDaoImpl();
	File file = new File("C:\\config.properties");
	Properties properties = new Properties();

	public Login loginInfo(String userName, String userPassword) {
		// TODO Auto-generated method stub
		try {
			properties.load(new FileInputStream(file));
			String loginDaoString = properties.getProperty("loginDao");
			loginDao = (LoginDao) Class.forName(loginDaoString).newInstance();

		} catch (Exception e) {
			// TODO: handle exception
		}
		return loginDao.loginInfo(userName, userPassword);
	}
}
