package com.quantum.survey.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.quantum.survey.dao.PaperDao;
import com.quantum.survey.dao.mysqlimpl.PaperDaoImpl;
import com.quantum.survey.dao.QuestionDao;
import com.quantum.survey.dao.mysqlimpl.QuestionDaoImpl;
import com.quantum.survey.po.Paper;
import com.quantum.survey.po.Question;
import com.quantum.survey.service.PaperService;
import com.quantum.survey.service.impl.PaperServiceImpl;
public class SubmitSucess extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public SubmitSucess() {
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

		doPost(request,response);
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
			
			QuestionDao questionDao = new QuestionDaoImpl();
			
			HttpSession session = request.getSession();

			Integer paperIdString =(Integer) session.getAttribute("paperId");
			int paperId = paperIdString.intValue();
			
			String UserIP =(String) session.getAttribute("UserIP");
			String UIP = "当前用户IP是:" + UserIP;
			System.out.println(UIP);
			
			String totalNumString = request.getParameter("totalNum");
			int totalNum = 0;
			if(totalNumString != null) {
				totalNum = Integer.parseInt(totalNumString);
			}
			
			String answers[] = new String[totalNum];
			String ss = "";
			int casoption = 0;
			for (int i = 0; i < answers.length; i++) {
				ss =  "q" + (i + 1);
				// 鍦ㄨ繖閲岃澶勭悊鍒板簳鏄棶绛旈杩樻槸閫夋嫨棰樸��
				String answerString = request.getParameter(ss);
				answers[i] = answerString;  //寰楀埌绛旀鐨勫瓧绗︿覆
			}
			if(answers.length != 0) {		
//				List<String> strings = questionDao.findQstAnswerByPaperId(paperId);
				List<Question> questions = questionDao.findQuestionsByPaperId(paperId);
				int j = 0; //璁板綍棰樺彿
				//单选题
				for (Question question : questions) {
					String cascade_single = question.getQstCascade();
					if(cascade_single.contains("#")) {
						String[] options = cascade_single.split("#");
						String fatherQstID = options[0];
						String fatherOption = options[1];
						if(fatherOption.contains("A")) casoption = 1;
						if(fatherOption.contains("B")) casoption = 2;
					}
					if(question.getQstType() == 1){
						String string = question.getQstAnswer();
						String regex = "&";
						String[] answerNumString = string.split(regex);
						int[] answerNum = new int[answerNumString.length];
						for (int i = 0; i < answerNumString.length; i++) {
							answerNum[i] = Integer.parseInt(answerNumString[i]);
						}
						int k = 0;
						if(answers[j] != null) {
							k = Integer.parseInt(answers[j]) + 1;
						}
						//System.out.println("single");
						//System.out.println(k);		
						switch (k) {
						case 1:
							answerNum[0] += 1;
						break;
						case 2:
							answerNum[1] += 1;
						break;
						case 3:
							answerNum[2] += 1;
						break;
						case 4:
							answerNum[3] += 1;
						break;
						 
						default:
						break;
					}
					//灏嗕慨鏀瑰悗鐨勭瓟妗堝啓鍏ユ暟鎹簱
					String newAnswer = answerNum[0] + "&" +answerNum[1] + "&" +answerNum[2] + "&" +answerNum[3];
					
					questionDao.updateQuestions(question.getQstId(), newAnswer);
					
				}
				//多选题
				else if(question.getQstType() == 2){
					String string = question.getQstAnswer();
					String regex = "&";
					String[] answerNumString = string.split(regex);
					int[] answerNum = new int[answerNumString.length];
					for (int i = 0; i < answerNumString.length; i++) {
						answerNum[i] = Integer.parseInt(answerNumString[i]);
					}
					//System.out.println("multiple");
					for (int i= 0; i < 4; i++) {
						String multians_name =  "q" + (j + 1) + i;
						String answerString = request.getParameter(multians_name);
						int k = 0;
						if(answerString != null) {
							if(answerString != null) {
								k = Integer.parseInt(answerString) + 1;
							}
							//System.out.println(k);		
							switch (k) {
							case 1:
								answerNum[0] += 1;
							break;
							case 2:
								answerNum[1] += 1;
							break;
							case 3:
								answerNum[2] += 1;
							break;
							case 4:
								answerNum[3] += 1;
							break;
							 
							default:
							break;
							}
						}				
					}
					String newAnswer = answerNum[0] + "&" +answerNum[1] + "&" +answerNum[2] + "&" +answerNum[3];
					
					questionDao.updateQuestions(question.getQstId(), newAnswer);
				}
				//文本题
				else  if(question.getQstType() == 3){
					String string = question.getQstAnswer();
					//System.out.println("context");
					//System.out.println(answers[j]);		
					questionDao.updateQuestions(question.getQstId(), answers[j]);
				}
				//数字题
				else  if(question.getQstType() == 4){
					String string = question.getQstAnswer();
					Double ans_sum = new Double(string);
					if(answers[j] != "") {
						Double ans_curr = new Double(answers[j]);
						Double ans_sum_new = ans_sum + ans_curr;
						String newAnswer = "" + ans_sum_new;
						questionDao.updateQuestions(question.getQstId(), newAnswer);
					}
				}
				//评分题
				else  if(question.getQstType() == 5){
					String string = question.getQstAnswer();
					String regex = "&";
					String[] answerNumString = string.split(regex);
					int[] answerNum = new int[answerNumString.length];
					for (int i = 0; i < answerNumString.length; i++) {
						answerNum[i] = Integer.parseInt(answerNumString[i]);
					}
					int k = 0;
					if(answers[j] != null) {
						k = Integer.parseInt(answers[j]) + 1;
					}
					//System.out.println("single");
					//System.out.println(k);		
					switch (k) {
					case 1:
						answerNum[0] += 1;
					break;
					case 2:
						answerNum[1] += 1;
					break;
					case 3:
						answerNum[2] += 1;
					break;
					case 4:
						answerNum[3] += 1;
					break;
					case 5:
						answerNum[4] += 1;
					break;
					case 6:
						answerNum[5] += 1;
					break;
					case 7:
						answerNum[6] += 1;
					break;
					 
					default:
					break;
				}
				//灏嗕慨鏀瑰悗鐨勭瓟妗堝啓鍏ユ暟鎹簱
				String newAnswer = answerNum[0] + "&" +answerNum[1] + "&" +answerNum[2] + "&" 
				+answerNum[3]+ "&" +answerNum[4] + "&" +answerNum[5] + "&" +answerNum[6];
				
				questionDao.updateQuestions(question.getQstId(), newAnswer);
				}	
				//级联题
					if(question.getQstType() == 6){
						String string = question.getQstAnswer();
						String regex = "&";
						String[] answerNumString = string.split(regex);
						int[] answerNum = new int[answerNumString.length];
						for (int i = 0; i < answerNumString.length; i++) {
							answerNum[i] = Integer.parseInt(answerNumString[i]);
						}
						int k = 0;
						if(answers[j] != null) {
							k = Integer.parseInt(answers[j]) + 1;
						}
						//System.out.println("single");
						//System.out.println(k);	
						//switch k
						switch (casoption) {
						case 1:
							answerNum[0] += 1;
						break;
						case 2:
							answerNum[1] += 1;
						break;
						default:
						break;
					}
					//灏嗕慨鏀瑰悗鐨勭瓟妗堝啓鍏ユ暟鎹簱
					String newAnswer = answerNum[0] + "&" +answerNum[1];
					
					questionDao.updateQuestions(question.getQstId(), newAnswer);
					
				}					
				j++;
			}
			
			PaperService paperservice = new PaperServiceImpl();
			Paper paper = paperservice.findPaperByPaperId(paperId);
			
			int papercount = paper.getPaperCount();
			int new_papercount = papercount + 1;
			paper.setPaperCount(new_papercount);
			PaperDao paperDao = new PaperDaoImpl();
			
			paperDao.updatePapercount(paperId, new_papercount);
				
			response.sendRedirect("success2.jsp");
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
