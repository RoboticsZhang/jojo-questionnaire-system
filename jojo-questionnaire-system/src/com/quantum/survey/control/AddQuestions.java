package com.quantum.survey.control;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.quantum.survey.dao.QuestionDao;
import com.quantum.survey.dao.mysqlimpl.QuestionDaoImpl;
import com.quantum.survey.po.Paper;
import com.quantum.survey.po.Question;
import com.quantum.survey.po.User;
import com.quantum.survey.service.UserService;
import com.quantum.survey.service.impl.UserServiceImpl;
import com.quantum.survey.dao.PaperDao;
import com.quantum.survey.dao.mysqlimpl.PaperDaoImpl;

import com.quantum.survey.service.PaperService;
import com.quantum.survey.service.impl.PaperServiceImpl;

public class AddQuestions extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public AddQuestions() {
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

		//&#%&  棰樹笌棰樼殑鍒嗗壊鍙�   $#$闂闂寸殑鍒嗗壊鍙�
		//涓嶇敤瀛楃涓茬浉杩烇紝鏀圭敤list瀛樺偍锛岀劧鍚庡啓鍏ユ暟鎹簱
		Question question = new Question();
		QuestionDao questionDao = new QuestionDaoImpl();
		
		HttpSession session = request.getSession();
		Integer paperIdString = (Integer)session.getAttribute("paperId");
		int paperId = paperIdString.intValue();
		
		Integer fatherqstIDString = (Integer)session.getAttribute("QSTID");
		int fatherqstID = 0;
		if(fatherqstIDString != null){
			fatherqstID = fatherqstIDString.intValue();
		}

		/*String s = "father" + fatherqstID;
		System.out.println(s);*/
				
		Date date = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String QstSetTime = simpleDateFormat.format(date);
		question.setQstSetTime(QstSetTime);
		
		String StartCascade = request.getParameter("startcascade");
		if(StartCascade != null) {	//当前是级联题，正在进行设置
			session.setAttribute("enableCascade", new Integer(1)); //长久保存，直到出现endcascade
			//System.out.println("case1");
		}
		String EndCascade = request.getParameter("endcascade");
		
		char cascade_option = ' ';
		int enable_cascade = 0;
		String EnableCascade = null;
		if(session.getAttribute("enableCascade") != null){
			EnableCascade = String.valueOf(session.getAttribute("enableCascade"));
		}
		if(EndCascade != null) {	//当前是级联题，且试图关闭级联
			session.setAttribute("Endcascade", EndCascade);	//长久保存，直到出现非级联题
			/*String s_end = "cas" + EndCascade;
			System.out.println(s_end);
			System.out.println("case2");*/
		}
		
		String OldEndcascade = (String)session.getAttribute("Endcascade");
		if(StartCascade == null && EnableCascade != null && OldEndcascade == null) {	//当前不是级联题，有级联选项，且未停止级联
			
			String CascadeOption = request.getParameter("CascadeOption");	//获取级联选项
			if(CascadeOption != null) {
				if(CascadeOption.contains("A")) {
					cascade_option = 'A';
				}
				else if (CascadeOption.contains("B")) {
					cascade_option = 'B';
				}
			}
			//System.out.println("case3");
			enable_cascade = 1;
		}
		else if(StartCascade == null && EnableCascade != null && OldEndcascade != null) {		//当前不是级联题，有级联选项，但已经停止级联
			session.setAttribute("enableCascade", null);
			session.setAttribute("Endcascade", null);
			//System.out.println("case4");
		}
		
		if(enable_cascade != 0 && fatherqstID != 0) {
			String cas = "" + fatherqstID + '#' + cascade_option;
			//System.out.println(cas);
			question.setQstCascade(cas);
		}
		else {
			question.setQstCascade("no");
		}		

		question.setPaperId(paperId);
		
//		@SuppressWarnings("unchecked")
//		List<String> qstContent = (List<String>) session.getAttribute("qstContent");
		
		String qstTitle0 = request.getParameter("qstTitle");
		//String qstTitle = new String(qstTitle0.getBytes("ISO-8859-1"),"utf-8");
		question.setQstTitle(qstTitle0);
		
		String qstTypeString = request.getParameter("qstType"); // 闂绫诲瀷
		int qstType = Integer.parseInt(qstTypeString);
		question.setQstType(qstType);
		
		if(qstType == 1){
			String qstNum10 = request.getParameter("qstOption1");
			//String qstNum1 = new String(qstNum10.getBytes("ISO-8859-1"),"utf-8");
			
			String qstNum20 = request.getParameter("qstOption2");
			//String qstNum2 = new String(qstNum20.getBytes("ISO-8859-1"),"utf-8");
			     
			String qstNum30 = request.getParameter("qstOption3");
			//String qstNum3 = new String(qstNum30.getBytes("ISO-8859-1"),"utf-8");
			    
			String qstNum40 = request.getParameter("qstOption4");
			//String qstNum4 = new String(qstNum40.getBytes("ISO-8859-1"),"utf-8");
			
			String content =qstNum10 +"#"+qstNum20 +"#"+qstNum30+"#"+qstNum40;
			question.setQstOption(content);
			question.setQstAnswer("0&0&0&0");
		}
		else if (qstType == 2){
			String qstNum10 = request.getParameter("qstOptionmulti1");
			//String qstNum1 = new String(qstNum10.getBytes("ISO-8859-1"),"utf-8");
			
			String qstNum20 = request.getParameter("qstOptionmulti2");
			//String qstNum2 = new String(qstNum20.getBytes("ISO-8859-1"),"utf-8");
			     
			String qstNum30 = request.getParameter("qstOptionmulti3");
			//String qstNum3 = new String(qstNum30.getBytes("ISO-8859-1"),"utf-8");
			    
			String qstNum40 = request.getParameter("qstOptionmulti4");
			//String qstNum4 = new String(qstNum40.getBytes("ISO-8859-1"),"utf-8");
			
			String content =qstNum10 +"#"+qstNum20 +"#"+qstNum30+"#"+qstNum40;
			question.setQstOption(content);
			question.setQstAnswer("0&0&0&0");
		}
		else if (qstType == 3){
			question.setQstOption("");
			question.setQstAnswer("");
		}
		else if (qstType == 4){
			question.setQstOption("");
			question.setQstAnswer("0");
		}
		//评分题
		else if (qstType == 5){
			String score1 = request.getParameter("score1");
			String score2 = request.getParameter("score2");
			String content =score1 +"#"+score2;
			question.setQstOption(content);
			question.setQstAnswer("0&0&0&0&0&0&0");
		}
		
		//级联
		else if (qstType == 6){
			String score1 = request.getParameter("cascade_qstOption1");
			String score2 = request.getParameter("cascade_qstOption1");

			String content =score1 +"#"+score2;
			question.setQstOption(content);
			question.setQstAnswer("0&0");
		}
		
		if(EndCascade == null) {				//停止级联时不加入题目
			questionDao.addQuestions(question);
		}
		
		//问卷情况更新
		int QstID = 0;
		QstID = questionDao.findQstIdBypaperIdAndSetTime(paperId, QstSetTime);
		if(EndCascade != null) {			//是级联题，正要停止级联
			request.getRequestDispatcher("addquestion1.jsp").forward(request, response);
		}
		else if(StartCascade == null && OldEndcascade == null) {					//不是级联题，且还在级联过程中，则保留父题目ID
			session.setAttribute("QSTID", new Integer(fatherqstID));
			response.sendRedirect("success.jsp");
		}
		else if(StartCascade == null && OldEndcascade != null) {					//不是级联题，且将要停止级联，则父ID置0，且提示界面关闭级联选择项目
			session.setAttribute("QSTID", new Integer(0));
			session.setAttribute("enableCascade", null);
			response.sendRedirect("success.jsp");
		}
		else if(StartCascade != null){
			/*String QstID_String = QstID + "";
			request.setAttribute("QSTID", QstID_String);
			System.out.println(QstID);
	        request.getRequestDispatcher("addquestion1.jsp").forward(request,response); 
			//response.sendRedirect("addquestion1.jsp");*/
			session.setAttribute("QSTID", new Integer(QstID));		//是级联题，更新父亲题目ID
			session.setAttribute("Endcascade", null);
			request.getRequestDispatcher("addquestion1.jsp").forward(request, response);
		}
		
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
