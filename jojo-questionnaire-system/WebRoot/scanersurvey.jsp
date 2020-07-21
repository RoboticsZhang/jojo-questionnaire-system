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

.masthead {
	background-color: none;
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


.mastfoot {
	text-align: center;
	margin: 10px 0px 5px;
}
</style>

    <script src="js/jquery.js"></script>
    <script type="text/javascript">
    function cascadeShow(){
      window.location.replace("addquestion1.jsp");
  	}
    </script>
	<script src="js/bootstrap.min.js"></script>	
    
</head>

<body>
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
			<form action="pubPaper" method="post">
				<%
					QuestionDao questionDao = new QuestionDaoImpl();

					String ss = "";
					Integer paperIdInt = (Integer) session.getAttribute("paperId");
					int paperId = paperIdInt.intValue();
					
					PaperService paperservice = new PaperServiceImpl();
					Paper paper = paperservice.findPaperByPaperId(paperId);
					
					String title = paper.getPaperTitle();
					String paperSummary = paper.getPaperSummary();
					String startdate =  paper.getPaperStartDate();
					String enddate =  paper.getPaperEndDate();
					List<Question> questions = questionDao
							.findQuestionsByPaperId(paperId);
					int totalNum = questions.size();
					int i = 1;
				%>
				<input type="hidden" name="totalNum" value=<%=questions.size()%>>
				<div class="div_question">
				<label><h4>问卷题目：<%=title%></h4>
				</label>
				<label><h5>问卷说明:<%=paperSummary%></h5>
				</label>
				<label><h5>开始时间：<%=startdate%></h5>
				</label>
				<label><h5>结束时间：<%=enddate%></h5>
				</label>
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
					<label><h4>题目：<%=question.getQstTitle()%> <%=type_string%> </h4>
					</label>	
			<%

					String content = question.getQstOption();
					//单选
					if (content != null && (question.getQstType() == 1)) {
						String[] options = content.split("#");
						for (String option : options) {
						%>
							<label class="radio""> <input type="radio" name=<%=ss%>
							id=<%=ss%> value=<%=i %>> <%=option%> </label>
						<%
						}
					}
					//多选
					else if (content != null && (question.getQstType() == 2)) {
						String[] options = content.split("#");
						for (String option : options) {
					%>
							<label class="checkbox"> <input type="checkbox" name=<%=ss%>
							id=<%=ss%> value=<%=i %>> <%=option%> </label>
					<%
						}
					} 
					//文本
					else if (question.getQstType() == 3){
						%>
							<textarea rows="4" cols="50" name=<%=ss%>></textarea>
						<%
						}
					else if (question.getQstType() == 4){
						%>
							<input onKeyPress="if((event.keyCode<48 || event.keyCode>57) && event.keyCode!=46 || /\.\d\d$/.test(value))event.returnValue=false" name=<%=ss%>>
						<%
						}		
					else if (question.getQstType() == 5){
						String score = "";
						String[] options = content.split("#");
						%>
							<label class="radio-inline"> <input type="radio" name=<%=ss%> id=<%=ss%> value="1"> 1 (<%=options[0] %>)</label>
							<label class="radio-inline"> <input type="radio" name=<%=ss%> id=<%=ss%> value="2"> 2 </label>
							<label class="radio-inline"> <input type="radio" name=<%=ss%> id=<%=ss%> value="3"> 3 </label>
							<label class="radio-inline"> <input type="radio" name=<%=ss%> id=<%=ss%> value="4"> 4 </label>
							<label class="radio-inline"> <input type="radio" name=<%=ss%> id=<%=ss%> value="5"> 5 </label>
							<label class="radio-inline"> <input type="radio" name=<%=ss%> id=<%=ss%> value="6"> 6 </label>
							<label class="radio-inline"> <input type="radio" name=<%=ss%> id=<%=ss%> value="7"> 7 (<%=options[1] %>) </label>					
						<%
						}	
					if (content != null && (question.getQstType() == 6)) {
						String[] options = content.split("#");
						for (String option : options) {
						%>
							<label class="radio"> <input type="radio" name=<%=ss%>
							id=<%=ss%> value=<%=i %> onclick="cascadeShow();"/> <%=option%> </label>
						<%
						}
					}								
					i++;
					}
					%>
					<br>
					<input class="btn btn-danger" type="submit" value="发布"> 
					<a href="addquestion1.jsp" class="btn btn-success">继续添加</a>
						</div>
			</form>
		</div>

	</div>
</body>
</html>