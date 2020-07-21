package com.quantum.survey.po;

public class PaperUserRelationships {
	private int relationId;//关系ID
	private int paperId;   //问卷ID
	private String userIP;   //非注册用户ID
	private int filltimes;	 //问卷已经填写的次数
	private String paperLastFillDate;//问卷上次填写日期

	public int getrelationId() {
		return relationId;
	}
	public void setrelationId(int relationId) {
		this.relationId = relationId;
	}
	public int getPaperId() {
		return paperId;
	}
	public void setPaperId(int paperId) {
		this.paperId = paperId;
	}
	public String getuserIP() {
		return userIP;
	}
	public void setuserIP(String userIP) {
		this.userIP = userIP;
	}
	public int getfilltimes() {
		return filltimes;
	}
	public void setfilltimes(int filltimes) {
		this.filltimes = filltimes;
	}	
	public String getpaperLastFillDate() {
		return paperLastFillDate;
	}
	public void setpaperLastFillDate(String paperLastFillDate) {
		this.paperLastFillDate = paperLastFillDate;
	}
	public PaperUserRelationships(int relationId, int paperId, String userIP, int filltimes, String paperLastFillDate) {
		super();
		this.relationId = relationId;
		this.paperId = paperId;
		this.userIP = userIP;
		this.filltimes = filltimes;
		this.paperLastFillDate = paperLastFillDate;
	}
	public PaperUserRelationships() {
		super();
		// TODO Auto-generated constructor stub
	}
}
