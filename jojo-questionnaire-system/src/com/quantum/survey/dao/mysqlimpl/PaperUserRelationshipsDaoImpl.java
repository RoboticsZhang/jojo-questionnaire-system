package com.quantum.survey.dao.mysqlimpl;

import java.sql.SQLException;

import com.quantum.survey.dao.PaperUserRelationShipsDao;
import com.quantum.survey.po.PaperUserRelationships;

public class PaperUserRelationshipsDaoImpl extends BaseDao implements PaperUserRelationShipsDao{
	public int addPaperUserRelationships(PaperUserRelationships PaperUserRelationships) {
		// TODO Auto-generated method stub
		getConn();
		String sql = "insert into paperuserrelationship values (NULL, ?, ?, ?, ?)";
		int paperID = PaperUserRelationships.getPaperId();
		String userIP = PaperUserRelationships.getuserIP();
		int filltimes = PaperUserRelationships.getfilltimes();
		String paperlastfilldate = PaperUserRelationships.getpaperLastFillDate();
		doOperate(sql, paperID, userIP, filltimes, paperlastfilldate);
		closeAll();
		return result;
	}
	public int updatePaperUserRelationships(int relationID, int filltimes, String paperLastFillDate) {
		getConn();
		String sql = "update paperuserrelationship set filltimes = ? where relationID = ?";
		doOperate(sql, filltimes, relationID);
		sql = "update paperuserrelationship set paperLastFillDate = ? where relationID = ?";
		doOperate(sql,  paperLastFillDate, relationID);
		closeAll();
		return result;	
	}
	
	public PaperUserRelationships findRelationShipsBypaperIdandUserip(int paperId, String userIP) {
		PaperUserRelationships paperUserRelationships = null;
		getConn();
		String sql = "select * from paperuserrelationship where paperId = ? and UserIP = ?";
		doQuery(sql, paperId, userIP);
		try {
			while (rs.next()) {
				paperUserRelationships = new PaperUserRelationships();
				paperUserRelationships.setrelationId(rs.getInt(1));
				paperUserRelationships.setPaperId(rs.getInt(2));
				paperUserRelationships.setuserIP(rs.getString(3));
				paperUserRelationships.setfilltimes(rs.getInt(4));
				paperUserRelationships.setpaperLastFillDate(rs.getString(5));
			}
		} catch (SQLException e) {
			// TODO: handle exception
		}
		closeAll();
		return paperUserRelationships;
	}
}
