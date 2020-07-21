package com.quantum.survey.dao.mysqlimpl;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.quantum.survey.dao.PaperDao;
import com.quantum.survey.po.Paper;

public class PaperDaoImpl extends BaseDao implements PaperDao {

	public List<Paper> findAllPapers() {
		// TODO Auto-generated method stub
		List<Paper> papers = new ArrayList<Paper>();
		getConn();
		String sql = "select * from Papers";
		doQuery(sql);
		try {
			while (rs.next()) {
				Paper paper = new Paper();
				paper.setPaperId(rs.getInt(1));
				paper.setUserId(rs.getInt(2));
				paper.setPaperTitle(rs.getString(3));
				paper.setPaperSummary(rs.getString(4));
				paper.setPaperStartDate(rs.getString(5));
				paper.setPaperEndDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getDate(6)));
				paper.setPaperType(rs.getInt(7));
				paper.setPaperFilltimes(rs.getInt(8));
				paper.setPaperPeriod(rs.getInt(9));
				paper.setPaperCount(rs.getInt(10));
				papers.add(paper); // 灏唒aper娣诲姞杩沺aperList涓幓銆�
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		closeAll();
		return papers;
	}

	public List<Paper> findPaperByUserId(int userId) {
		// TODO Auto-generated method stub
		List<Paper> papers = new ArrayList<Paper>(); // 褰撳瓨鍦╬aper瀵硅薄鏄啀寤虹珛paper瀵硅薄銆傚厛缃┖銆�
		getConn();
		String sql = "select * from Papers where userId  = ?";
		doQuery(sql, userId);
		try {
			while (rs.next()) {
				Paper paper = new Paper();
				paper.setPaperId(rs.getInt(1));
				paper.setUserId(rs.getInt(2));
				paper.setPaperTitle(rs.getString(3));
				paper.setPaperSummary(rs.getString(4));
				paper.setPaperStartDate(rs.getString(5));
				paper.setPaperEndDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getDate(6)));
				paper.setPaperType(rs.getInt(7));
				paper.setPaperFilltimes(rs.getInt(8));
				paper.setPaperPeriod(rs.getInt(9));
				paper.setPaperCount(rs.getInt(10));
				papers.add(paper); // 灏唒aper娣诲姞杩沺aperList涓幓銆�
			}

		} catch (Exception e) {
			// TODO: handle exception
		}
		closeAll();
		return papers;
	}

	public List<Paper> findPaperByPaperType(int paperType) {
		// TODO Auto-generated method stub
		List<Paper> papers = new ArrayList<Paper>();
		getConn();
		String sql = "select * from Papers where PaperTyep = ?";
		doQuery(sql, paperType);
		try {
			while (rs.next()) {
				Paper paper = new Paper();
				paper.setPaperId(rs.getInt(1));
				paper.setUserId(rs.getInt(2));
				paper.setPaperTitle(rs.getString(3));
				paper.setPaperSummary(rs.getString(4));
				paper.setPaperStartDate(rs.getString(5));
				paper.setPaperEndDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getDate(6)));
				paper.setPaperType(rs.getInt(7));
				paper.setPaperFilltimes(rs.getInt(8));
				paper.setPaperPeriod(rs.getInt(9));
				paper.setPaperCount(rs.getInt(10));
				papers.add(paper); // 灏唒aper娣诲姞杩沺aperList涓幓銆�
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		closeAll();

		return papers;
	}

	public Paper findPaperByPaperId(int paperId) {
		// TODO Auto-generated method stub
		Paper paper = null;
		getConn();
		String sql = "select * from Papers where PaperId = ?";
		doQuery(sql, paperId);
		try {
			while (rs.next()) {
				paper = new Paper();
				paper.setPaperId(rs.getInt(1));
				paper.setUserId(rs.getInt(2));
				paper.setPaperTitle(rs.getString(3));
				paper.setPaperSummary(rs.getString(4));
				paper.setPaperStartDate(rs.getString(5));
				paper.setPaperEndDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getDate(6)));
				paper.setPaperType(rs.getInt(7));
				paper.setPaperFilltimes(rs.getInt(8));
				paper.setPaperPeriod(rs.getInt(9));
				paper.setPaperCount(rs.getInt(10));
			}
		} catch (SQLException e) {
			// TODO: handle exception
		}
		closeAll();
		return paper;
	}

	public int addPapers(Paper paper) {
		// TODO Auto-generated method stub
		getConn();
		String sql = "insert into Papers values (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		String paperTitle0 = paper.getPaperTitle();
		String paperSummary0 = paper.getPaperSummary();
		String paperTitle = null, paperSummary = null;
		try {
			paperTitle = new String(paperTitle0.getBytes("ISO-8859-1"),"utf-8");
			paperSummary = new String(paperSummary0.getBytes("ISO-8859-1"),"utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		doOperate(sql, paper.getUserId(), paperTitle, paperSummary, paper.getPaperStartDate(), paper.getPaperEndDate(), paper.getPaperType(), paper.getPaperFilltimes(), paper.getPaperPeriod(), paper.getPaperCount());
		closeAll();

		return result;
	}

	public int deletePaperByPaperId(int paperId) {
		// TODO Auto-generated method stub
		getConn();
		String sql = "delete from Papers where paperId = ?";
		doOperate(sql, paperId);
		closeAll();
		return result;
	}

	public int deletePaperByUserId(int userId) {
		// TODO Auto-generated method stub
		getConn();
		String sql = "delete from Papers where userId = ?";
		doOperate(sql, userId);
		closeAll();
		return result;
	}

	public int findPaperIdByuserIdAndDate(int userId, String paperStartDate) {
		// TODO Auto-generated method stub
		int paperId = 0;
		getConn();
		String sql = "select paperId from Papers where userId = ? and paperStartDate = ?";
		doQuery(sql, userId, paperStartDate);
		try {
			while (rs.next()) {
				paperId = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return paperId;
	}

	public int modifiedStatusBypaperId(int paperId) {
		// TODO Auto-generated method stub
		return 0;
	}
	public int updatePapercount(int paperId,int papercount) {
		// TODO Auto-generated method stub
		getConn();
		String sql = "update Papers set paperCount = ? where paperID = ?";
		doOperate(sql, papercount,paperId);
		closeAll();
		return result;
	}
}
