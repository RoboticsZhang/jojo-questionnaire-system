package com.quantum.survey.po;

public class Paper {
	private int paperId;//问卷ID号
	private int userId;//用户ID
	private String paperTitle;//问卷标题
	private String paperSummary;//问卷摘要介绍
	private String paperStartDate;//问卷发布日期
	private String paperEndDate;//问卷结束日期
	private int paperType;//问卷类型
	private int paperFilltimes;//问卷可填写次数
	private int paperPeriod;//问卷周期
	private int paperCount;//问卷回答次数
	
	public int getPaperId() {
		return paperId;
	}
	public void setPaperId(int paperId) {
		this.paperId = paperId;
	}
	public String getPaperTitle() {
		return paperTitle;
	}
	public void setPaperTitle(String paperTitle) {
		this.paperTitle = paperTitle;
	}
	public String getPaperSummary() {
		return paperSummary;
	}
	public void setPaperSummary(String paperSummary) {
		this.paperSummary = paperSummary;
	}
	public String getPaperStartDate() {
		return paperStartDate;
	}
	public void setPaperStartDate(String paperStartDate) {
		this.paperStartDate = paperStartDate;
	}
	public String getPaperEndDate() {
		return paperEndDate;
	}
	public void setPaperEndDate(String paperEndDate) {
		this.paperEndDate = paperEndDate;
	}
	public int getPaperType() {
		return paperType;
	}
	public void setPaperType(int paperType) {
		this.paperType = paperType;
	}
	public int getPaperCount() {
		return paperCount;
	}
	public void setPaperCount(int paperCount) {
		this.paperCount = paperCount;
	}
	public int getPaperFilltimes() {
		return paperFilltimes;
	}
	public void setPaperFilltimes(int paperFilltimes) {
		this.paperFilltimes = paperFilltimes;
	}
	public int getPaperPeriod() {
		return paperPeriod;
	}
	public void setPaperPeriod(int paperPeriod) {
		this.paperPeriod = paperPeriod;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public Paper(int paperId, int userId, String paperTitle, String paperSummary, String paperStartDate, String paperEndDate, int paperType, int paperFilltimes, int paperPeriod, int paperCount) {
		super();
		this.paperId = paperId;
		this.userId = userId;
		this.paperTitle = paperTitle;
		this.paperSummary = paperSummary;
		this.paperStartDate = paperStartDate;
		this.paperEndDate = paperEndDate;
		this.paperType = paperType;
		this.paperFilltimes = paperFilltimes;
		this.paperPeriod = paperPeriod;
		this.paperCount = paperCount;
	}
	public Paper() {
		super();
		// TODO Auto-generated constructor stub
	}
}
