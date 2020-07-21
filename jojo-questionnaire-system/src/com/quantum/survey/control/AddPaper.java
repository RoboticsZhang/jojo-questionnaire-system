package com.quantum.survey.control;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.quantum.survey.dao.PaperDao;
import com.quantum.survey.dao.mysqlimpl.PaperDaoImpl;
import com.quantum.survey.po.Paper;
import com.quantum.survey.po.User;
//import com.sun.org.apache.bcel.internal.generic.NEW;

public class AddPaper extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public AddPaper() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	@Override
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PaperDao paperDao = new PaperDaoImpl();
		
		Paper paper = new Paper();
		
		HttpSession session = request.getSession();
		
		User user = (User) session.getAttribute("userInfo");
		int userId = user.getUserId();			//需要需要需要需要debug

		paper.setUserId(userId);
		//标题
		String paperTitle0 = request.getParameter("paperTitle");
		//String paperTitle = new String(paperTitle0.getBytes("ISO-8859-1"),"utf-8");
		paper.setPaperTitle(paperTitle0);
		//填写方式
		String paperTypeString = request.getParameter("paperType");
		int paperType = Integer.parseInt(paperTypeString);
		paper.setPaperType(paperType);
		//摘要
		String paperSummary0 = request.getParameter("paperSummary");
		//String paperSummary = new String(paperSummary0.getBytes("ISO-8859-1"),"utf-8");
		paper.setPaperSummary(paperSummary0);
		//填写周期
		String paperPeriodString = request.getParameter("paperPeriod");
		int paperPeriod = Integer.parseInt(paperPeriodString);
		paper.setPaperPeriod(paperPeriod);

		//填写次数
		String paperTimesString = request.getParameter("paperFilltimes");
		int paperTimes = 0;
		if(paperTimesString != "") {
			paperTimes = Integer.parseInt(paperTimesString);
		}
		//System.out.println(paperTimes);
		paper.setPaperFilltimes(paperTimes);
		
		
		//String paperBg = request.getParameter("paperBg");
		//paper.setPaperBg(paperBg);
		
		//鍙戝竷鏃ユ湡
		Date date = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String paperStartDate = simpleDateFormat.format(date);
		paper.setPaperStartDate(paperStartDate);
		
		//鎴鏃ユ湡鐨勮缃�
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.DATE,+paperPeriod);
		date = calendar.getTime();
		String dataString = simpleDateFormat.format(date);
		paper.setPaperEndDate(dataString);
		
		
		//鍥炵瓟娆℃暟 
		int paperCount = 0;
		paper.setPaperCount(paperCount);
		
	
		paperDao.addPapers(paper);
		
		int paperId = paperDao.findPaperIdByuserIdAndDate(userId, paperStartDate);
		
		session.setAttribute("paperId", new Integer(paperId));
		response.sendRedirect("addquestion1.jsp");
		
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	@Override
	public void init() throws ServletException {
		// Put your code here
	}

}
