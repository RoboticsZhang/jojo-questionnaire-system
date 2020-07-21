package com.quantum.survey.dao.mysqlimpl;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import com.quantum.survey.dao.NonRegUsersDao;
import com.quantum.survey.po.NonRegUsers;

public class NonRegUsersDaoImpl extends BaseDao implements NonRegUsersDao{
	public int addNonRegUsers(NonRegUsers nonRegUsers){
		// TODO Auto-generated method stub
		getConn();
		String sql = "insert into nonregusers values (?)";
		String UserIp = nonRegUsers.getuserIP();
		doOperate(sql, UserIp);
		closeAll();
		return result;
	}
	public NonRegUsers findNonRegUsersByUserIP(String userIP) {
		NonRegUsers nonRegUsers = null;
		getConn();
		String sql = "select * from nonregusers where UserIP = ?";
		doQuery(sql, userIP);
		try {
			while (rs.next()) {
				nonRegUsers = new NonRegUsers();
				nonRegUsers.setuserIP(rs.getString(1));
			}
		} catch (SQLException e) {
			// TODO: handle exception
		}
		closeAll();
		return nonRegUsers;
	}
}
