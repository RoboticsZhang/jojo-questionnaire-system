package com.quantum.survey.po;

public class Question {
	private int qstId;//棰樺彿ID
	private int paperId;//鎵�灞為棶鍗稩D
	private int qstType;//棰樼洰绫诲瀷
	private String qstTitle;//棰樺共
	private String qstOption;//閫夐」
	private String qstAnswer;//缁熻缁撴灉
	private String qstCascade;
	private String qstSetTime;//问卷发布日期
	
	public int getQstId() {
		return qstId;
	}
	public void setQstId(int qstId) {
		this.qstId = qstId;
	}
	public int getPaperId() {
		return paperId;
	}
	public void setPaperId(int paperId) {
		this.paperId = paperId;
	}
	public int getQstType() {
		return qstType;
	}
	public void setQstType(int qstType) {
		this.qstType = qstType;
	}
	public String getQstTitle() {
		return qstTitle;
	}
	public void setQstTitle(String qstTitle) {
		this.qstTitle = qstTitle;
	}
	public String getQstOption() {
		return qstOption;
	}
	public void setQstOption(String qstOption) {
		this.qstOption = qstOption;
	}
	public String getQstAnswer() {
		return qstAnswer;
	}
	public void setQstAnswer(String qstAnswer) {
		this.qstAnswer = qstAnswer;
	}
	public String getQstCascade() {
		return qstCascade;
	}
	public void setQstCascade(String qstCascade) {
		this.qstCascade = qstCascade;
	}
	
	public String getQstSetTime() {
		return qstSetTime;
	}
	public void setQstSetTime(String qstSetTime) {
		this.qstSetTime = qstSetTime;
	}
	
	public Question(int qstId, int paperId, int qstType, String qstTitle, String qstOption, String qstAnswer, String qstCascade, String qstSetTime) {
		super();
		this.qstId = qstId;
		this.paperId = paperId;
		this.qstType = qstType;
		this.qstTitle = qstTitle;
		this.qstOption = qstOption;
		this.qstAnswer = qstAnswer;
		this.qstCascade = qstCascade;
		this.qstSetTime = qstSetTime; 
	}
	public Question() {
		super();
		// TODO Auto-generated constructor stub
	}
}
