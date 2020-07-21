package com.quantum.survey.service;

import java.util.List;

import com.quantum.survey.po.Question;

public interface QuestionService {

	List<Question> findQuestionsByPaperId(int paperId);
	int addQuestions(Question question);
}
