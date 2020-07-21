<%@page import="com.quantum.survey.po.Login"%>
<%@page import="com.quantum.survey.po.Question"%>
<%@page import="com.quantum.survey.dao.mysqlimpl.QuestionDaoImpl"%>
<%@page import="com.quantum.survey.dao.QuestionDao"%>
<%@page import="com.quantum.survey.service.PaperService"%>
<%@page import="com.quantum.survey.service.impl.PaperServiceImpl"%>
<%@page import="com.quantum.survey.dao.mysqlimpl.PaperDaoImpl"%>
<%@page import="com.quantum.survey.dao.PaperDao"%>
<%@page import="com.quantum.survey.po.Paper"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Quantum-Survey</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="css/bookstrap-responsive.min.css" rel="stylesheet"
	type="text/css">
<!--[if lt IE 9]>
      	<script src="js/html5shiv.js"></script>
    <![endif]-->
<script src="js/jquery-1.9.1.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/html5shiv.js"></script>
<style type="text/css">
body {
	background-repeat: repeat-x;
	background-attachment: fixed;
}

.container {
	margin-top: 15px;
}

.radio.inline.q2+.radio.inline.q2 {
	margin-right: 30px;
}

.survey {
	border: 1px;
	background-color: white;
	height: auto;
	margin: 0px;
	padding: 15px 0px 0px 30px;
}

.div_question {
	width: 96%;
	height: auto;
	border: 2px solid white;
	padding: 4px 4px;
	margin: 2px auto;
	border-bottom: 1px solid #EFEEEE;
}

.plength {
	width: 60%;
	text-align: center;
}

.mastfoot {
	text-align: center;
	margin: 10px 0px 5px;
}
</style>

</head>

<body>
<%
	Login login = (Login) session.getAttribute("loginInfo");
 %>
	<div class="container">
		<div class="masthead">
			<ul class="nav nav-pills pull-right">
				<li><a href="#myMadel" role="button" class="btn"
					data-toggle="modal"> 登录</a>
				</li>
				<li><a href="#" class="btn" data-toggle="modal"> 注册</a>
				</li>
			</ul>
			<h1>Quantum-Survey</h1>
		</div>
		<hr>
		<hr>
		<div class="survey">
			<form action="" method="post">
				<%
					QuestionDao questionDao = new QuestionDaoImpl();
					//Integer paperIdiInteger = (Integer) session.getAttribute("paperId");
					//int paperId = paperIdiInteger.intValue();
					String paperIdString = request.getParameter("paperId");
					int paperId = Integer.parseInt(paperIdString);
					
					
					PaperService paperservice = new PaperServiceImpl();
					Paper paper = paperservice.findPaperByPaperId(paperId);
					
					String paperSummary = paper.getPaperSummary();
					String startdate =  paper.getPaperStartDate();
					String enddate =  paper.getPaperEndDate();
					String title = paper.getPaperTitle();
					int papercount = paper.getPaperCount();

					List<Question> questions = questionDao.showResultByPaperId(paperId);
					int totalNum = questions.size();
					int i = 1;
					String ss = "";
				%>
				<label><h4>问卷题目：<%=title%></h4>
				</label>
				<label><h5>问卷说明:<%=paperSummary%></h5>
				</label>
				<label><h5>总填写人数：<%=papercount%></h5>
				</label>
				<label><h5>开始时间：<%=startdate%></h5>
				</label>
				<label><h5>结束时间：<%=enddate%></h5>
				</label>
				<input type="hidden" name="totalNum" value=totalNum>
				<div class="div_question">
					<%
						for (Question question : questions) {
							ss = "q" + i;
							int type = question.getQstType();
							String type_string = null;
							switch(type){
								case 1: type_string = "(单选题)"; break;
								case 2: type_string = "(多选题)"; break;
								case 3: type_string = "(文本题)"; break;
								case 4: type_string = "(数字题)"; break;
								case 5: type_string = "(评分题)"; break;
								case 6: type_string = "(级联题)"; break;
							}
					%>
					<label><h5><%=i%>、<%=question.getQstTitle()%> <%=type_string%> </h5> </label>
					<%
						String content = question.getQstOption();
							if (content != null && (question.getQstType() == 1)) {
								String[] options = content.split("#");
								int j = 0;//跟踪选择的值变化
								for (String option : options) {
					%>
					<label class="radio"> <input type="radio" name=<%=ss%>
						id=<%=ss%> value=<%=j%>> <%=option%> </label>
					<%
						j++;
					}
								String answesrString = question.getQstAnswer();
								String answer[] = answesrString.split("&");
								int answerInt[] = new int[answer.length];
								int totalCount = 0;
								for (int k = 0; k < answer.length; k++) {
									answerInt[k] = Integer.parseInt(answer[k]);
									totalCount += answerInt[k];
								}
								
								if (totalCount != 0) {
					%>
					
					<div class="plength">
						<div class="progress">
							<div class="bar bar-success"
								style="width: <%=(answerInt[0]*100 / totalCount)%>%;">
								A:<%=(answerInt[0]*100 / totalCount )%>%
							</div>
							<div class="bar bar-warning"
								style="width: <%=(answerInt[1]*100 / totalCount )%>%;">
								B:<%=(answerInt[1]*100 / totalCount )%>%
							</div>
							<div class="bar bar-danger"
								style="width: <%=(answerInt[2]*100 / totalCount )%>%;">
								C:<%=(answerInt[2]*100 / totalCount )%>%
							</div>
							<div class="bar bar-success"
								style="width: <%=(100-(answerInt[0]*100 / totalCount )-(answerInt[1]*100 / totalCount )-(answerInt[2]*100 / totalCount )) %>%">
								D:<%=(100-(answerInt[0]*100 / totalCount )-(answerInt[1]*100 / totalCount )-(answerInt[2]*100 / totalCount )) %>%
							</div>
						</div>
					</div>

					<%
						} else {
					%>
					<div class="plength">
						<div class="progress"></div>
					</div>
					<%
						}
					} 
					else if (content != null && (question.getQstType() == 2)) {
							String[] options = content.split("#");
							int j = 0;//跟踪选择的值变化
							for (String option : options) {
					%>
							<label class="checkbox"> <input type="checkbox" name=<%=ss%>
							id=<%=ss%> value=<%=j%>> <%=option%></label>


					<%
							j++;
							}
								String answesrString = question.getQstAnswer();
								String answer[] = answesrString.split("&");
								int answerInt[] = new int[answer.length];
								int totalCount = 0;
								for (int k = 0; k < answer.length; k++) {
									answerInt[k] = Integer.parseInt(answer[k]);
									totalCount += answerInt[k];
								}
								
								if (totalCount != 0) {
					%>
					
					<div class="plength">
						<div class="progress">
							<div class="bar bar-success"
								style="width: <%=(answerInt[0]*100 / totalCount)%>%;">
								A:<%=(answerInt[0]*100 / totalCount )%>%
							</div>
							<div class="bar bar-warning"
								style="width: <%=(answerInt[1]*100 / totalCount )%>%;">
								B:<%=(answerInt[1]*100 / totalCount )%>%
							</div>
							<div class="bar bar-danger"
								style="width: <%=(answerInt[2]*100 / totalCount )%>%;">
								C:<%=(answerInt[2]*100 / totalCount )%>%
							</div>
							<div class="bar bar-success"
								style="width: <%=(100-(answerInt[0]*100 / totalCount )-(answerInt[1]*100 / totalCount )-(answerInt[2]*100 / totalCount )) %>%">
								D:<%=(100-(answerInt[0]*100 / totalCount )-(answerInt[1]*100 / totalCount )-(answerInt[2]*100 / totalCount )) %>%
							</div>
						</div>
					</div>

					<%
						} else {
					%>
					<div class="plength">
						<div class="progress"></div>
					</div>
					<%
						}
					}
					else if (content != null && (question.getQstType() == 3)) {
					%>
					<textarea rows="4" cols="50" name=<%=ss%>><%=question.getQstAnswer()%></textarea>
					<%
					}
					else if (content != null && (question.getQstType() == 4)) {
						String answesrString = question.getQstAnswer();
						Double ans_sum = new Double(answesrString);
						Double ans_average = ans_sum / papercount;
					%>
					<div class="plength">
						<div class="progress">
							<div class="bar bar-success"
								style="width: 100%;">
								total:<%=(ans_sum)%>
							</div>								
						</div>
					</div>
					<div class="plength">
						<div class="progress">
							<div class="bar bar-warning"
								style="width: 100%;">
								average:<%=(ans_average)%>
							</div>								
						</div>
					</div>
					<%
					}
					else if (content != null && (question.getQstType() == 5)) {
							String[] options = content.split("#");
							int j = 0;//跟踪选择的值变化
					%>
							<label class="radio-inline"> <input type="radio" name=<%=ss%> id=<%=ss%> value="1"> 1 (<%=options[0] %>)</label>
							<label class="radio-inline"> <input type="radio" name=<%=ss%> id=<%=ss%> value="2"> 2 </label>
							<label class="radio-inline"> <input type="radio" name=<%=ss%> id=<%=ss%> value="3"> 3 </label>
							<label class="radio-inline"> <input type="radio" name=<%=ss%> id=<%=ss%> value="4"> 4 </label>
							<label class="radio-inline"> <input type="radio" name=<%=ss%> id=<%=ss%> value="5"> 5 </label>
							<label class="radio-inline"> <input type="radio" name=<%=ss%> id=<%=ss%> value="6"> 6 </label>
							<label class="radio-inline"> <input type="radio" name=<%=ss%> id=<%=ss%> value="7"> 7 (<%=options[1] %>) </label>
					<%
								String answesrString = question.getQstAnswer();
								String answer[] = answesrString.split("&");
								int answerInt[] = new int[answer.length];
								int totalCount = 0;
								for (int k = 0; k < answer.length; k++) {
									answerInt[k] = Integer.parseInt(answer[k]);
									totalCount += answerInt[k];
								}
								
								if (totalCount != 0) {
					%>
					
					<div class="plength">
						<div class="progress">
							<div class="bar bar-success"
								style="width: <%=(answerInt[0]*100 / totalCount)%>%;">
								1:<%=(answerInt[0]*100 / totalCount )%>%
							</div>
							<div class="bar bar-warning"
								style="width: <%=(answerInt[1]*100 / totalCount )%>%;">
								2:<%=(answerInt[1]*100 / totalCount )%>%
							</div>
							<div class="bar bar-danger"
								style="width: <%=(answerInt[2]*100 / totalCount )%>%;">
								3:<%=(answerInt[2]*100 / totalCount )%>%
							</div>
							<div class="bar bar-danger"
								style="width: <%=(answerInt[3]*100 / totalCount )%>%;">
								4:<%=(answerInt[3]*100 / totalCount )%>%
							</div>
							<div class="bar bar-danger"
								style="width: <%=(answerInt[4]*100 / totalCount )%>%;">
								5:<%=(answerInt[4]*100 / totalCount )%>%
							</div>
							<div class="bar bar-danger"
								style="width: <%=(answerInt[5]*100 / totalCount )%>%;">
								6:<%=(answerInt[5]*100 / totalCount )%>%
							</div>
							<div class="bar bar-danger"
								style="width: <%=(answerInt[6]*100 / totalCount )%>%;">
								7:<%=(answerInt[6]*100 / totalCount )%>%
							</div>												
						</div>
					</div>

				<%
					}							
				}
				if (content != null && (question.getQstType() == 6)) {
								String[] options = content.split("#");
								int j = 0;//跟踪选择的值变化
								for (String option : options) {
					%>
					<label class="radio"> <input type="radio" name=<%=ss%>
						id=<%=ss%> value=<%=j%>> <%=option%> </label>
					<%
						j++;
					}
								String answesrString = question.getQstAnswer();
								String answer[] = answesrString.split("&");
								int answerInt[] = new int[answer.length];
								int totalCount = 0;
								for (int k = 0; k < answer.length; k++) {
									answerInt[k] = Integer.parseInt(answer[k]);
									totalCount += answerInt[k];
								}
								
								if (totalCount != 0) {
					%>
					
					<div class="plength">
						<div class="progress">
							<div class="bar bar-success"
								style="width: <%=(answerInt[0]*100 / totalCount)%>%;">
								A:<%=(answerInt[0]*100 / totalCount )%>%
							</div>
							<div class="bar bar-warning"
								style="width: <%=(answerInt[1]*100 / totalCount )%>%;">
								B:<%=(answerInt[1]*100 / totalCount )%>%
							</div>
						</div>
					</div>

					<%
						} else {
					%>
					<div class="plength">
						<div class="progress"></div>
					</div>
					<%
						}
					} 
				i++;
			}
		%>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
