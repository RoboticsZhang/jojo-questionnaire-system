package com.quantum.survey.dao.mysqlimpl;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.quantum.survey.dao.QuestionDao;
import com.quantum.survey.po.Question;

public class QuestionDaoImpl extends BaseDao implements QuestionDao {

	public List<Question> findQuestionsByPaperId(int paperId) {
		// TODO Auto-generated method stub
		List<Question> questions = new ArrayList<Question>();
		getConn();
		String sql = "select * from Questions where paperId = ?";
		doQuery(sql, paperId);
		try {
			while (rs.next()) {
				Question question = new Question();
				question.setQstId(rs.getInt(1));
				question.setPaperId(rs.getInt(2));
				question.setQstType(rs.getInt(3));
				question.setQstTitle(rs.getString(4));
				question.setQstOption(rs.getString(5));
				question.setQstAnswer(rs.getString(6));
				question.setQstCascade(rs.getString(7));
				question.setQstSetTime(rs.getString(8));
				questions.add(question);
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		closeAll();
		return questions;
	}

	public List<Question> showResultByPaperId(int paperId) {
		// TODO Auto-generated method stub

		List<Question> questions = new ArrayList<Question>();
		getConn();
		String sql = "select * from Questions where paperId = ?";
		doQuery(sql, paperId);
		try {
			while (rs.next()) {
				Question question = new Question();
				question.setQstId(rs.getInt(1));
				question.setPaperId(rs.getInt(2));
				question.setQstType(rs.getInt(3));
				question.setQstTitle(rs.getString(4));
				question.setQstOption(rs.getString(5));
				question.setQstAnswer(rs.getString(6));
				question.setQstCascade(rs.getString(7));
				question.setQstSetTime(rs.getString(8));
				questions.add(question);
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		closeAll();
		return questions;
	}

	public int addQuestions(Question question) {
		// TODO Auto-generated method stub
		getConn();
		String sql = "insert into Questions values(NULL,?, ?, ?, ?, ?, ?, ?)";
		String QstTitle0 = question.getQstTitle();
		String QstOption0 = question.getQstOption();
		String QstAnswer0 = question.getQstAnswer();
		String QstTitle = null, QstOption = null, QstAnswer = null;
		try {
			QstTitle = new String(QstTitle0.getBytes("ISO-8859-1"),"utf-8");
			QstOption = new String(QstOption0.getBytes("ISO-8859-1"),"utf-8");
			QstAnswer = new String(QstAnswer0.getBytes("ISO-8859-1"),"utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		doOperate(sql, question.getPaperId(), question.getQstType(), QstTitle,  QstOption , QstAnswer, question.getQstCascade(), question.getQstSetTime());
		closeAll();
		return result;
	}

	public int updateQuestions(int questionId, String qstAnswer) {
		// TODO Auto-generated method stub
		getConn();
		String QstAnswer = null;
		try {
			QstAnswer = new String(qstAnswer.getBytes("ISO-8859-1"),"utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String sql = "update Questions set qstAnswer = ? where qstId = ?";
		doOperate(sql, QstAnswer, questionId);
		closeAll();
		return result;
	}

	public int deleteQusetionByQuestionId(int questionId) {
		// TODO Auto-generated method stub
		getConn();
		String sql = "delete * from Questions where qstId = ?";
		doOperate(sql, questionId);
		closeAll();
		return result;
	}
	public List<Question> findAllQuestions(){
		List<Question> questions = new ArrayList<Question>();
		getConn();
		String sql = "select * from questions";
		doQuery(sql);
		try {
			while (rs.next()) {
				Question question = new Question();
				question.setQstId(rs.getInt(1));
				question.setPaperId(rs.getInt(2));
				question.setQstType(rs.getInt(3));
				question.setQstTitle(rs.getString(4));
				question.setQstOption(rs.getString(5));
				question.setQstAnswer(rs.getString(6));
				question.setQstCascade(rs.getString(7));
				question.setQstSetTime(rs.getString(8));
				questions.add(question);
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		closeAll();
		return questions;
	}
	public List<String> findQstAnswerByPaperId(int paperId) {
		// TODO Auto-generated method stub
		List<String> strings = new ArrayList<String>();

		getConn();
		String sql = "select qstId qstAnswer from Questions where paperId = ?";
		doQuery(sql, paperId);
		try {
			while (rs.next()) {
				String string = "";
				string += rs.getString(1);
				// 将qstId和qstanswer一起存储
				string += "&" + rs.getString(2);
				strings.add(string);
			}
		} catch (SQLException e) {
			// TODO: handle exception
		}
		closeAll();
		return strings;
	}

	public int findQstIdBypaperIdAndSetTime(int paperID,String QstSetTime) {
		// TODO Auto-generated method stub
		int QsTId = 0;
		getConn();
		String sql = "select QstID from questions where paperID = ? and QstSetTime = ?";
		doQuery(sql, paperID, QstSetTime);
		try {
			while (rs.next()) {
				QsTId = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return QsTId;
	}
	public int deleteQusetionByPaperId(int paperId) {
		// TODO Auto-generated method stub
		getConn();
		String sql = "delete from Questions where paperId = ?";
		doOperate(sql, paperId);
		closeAll();

		return result;
	}
}
