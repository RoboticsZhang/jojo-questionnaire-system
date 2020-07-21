package com.quantum.survey.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.util.List;
import java.util.Properties;

import com.quantum.survey.dao.PaperDao;
import com.quantum.survey.dao.QuestionDao;
import com.quantum.survey.dao.mysqlimpl.QuestionDaoImpl;
import com.quantum.survey.po.Question;
import com.quantum.survey.service.QuestionService;

public class QuestionServiceImpl implements QuestionService {
	
	private QuestionDao questionDao = new QuestionDaoImpl();
	File file = new File("C://config.properties");
	Properties properties = new Properties();
	public List<Question> findQuestionsByPaperId(int paperId) {
		// TODO Auto-generated method stub
		try {
			properties.load(new FileInputStream(file));
			String questionDaoString = properties.getProperty("questionDao");
			questionDao = (QuestionDao) Class.forName(questionDaoString).newInstance();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return questionDao.findQuestionsByPaperId(paperId);
	}

	public int addQuestions(Question question) {
		// TODO Auto-generated method stub
		try {
			properties.load(new FileInputStream(file));
			String questionDaoString = properties.getProperty("questionDao");
			questionDao = (QuestionDao) Class.forName(questionDaoString).newInstance();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return questionDao.addQuestions(question);
	}

}
