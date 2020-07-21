<%@page import="com.quantum.survey.po.Login"%>
<%@page import="com.quantum.survey.po.Question"%>
<%@page import="com.quantum.survey.dao.mysqlimpl.QuestionDaoImpl"%>
<%@page import="com.quantum.survey.dao.QuestionDao"%>
<%@page import="com.quantum.survey.po.NonRegUsers"%>
<%@page import="com.quantum.survey.dao.mysqlimpl.NonRegUsersDaoImpl"%>
<%@page import="com.quantum.survey.dao.NonRegUsersDao"%>
<%@page import="com.quantum.survey.po.PaperUserRelationships"%>
<%@page import="com.quantum.survey.dao.mysqlimpl.PaperUserRelationshipsDaoImpl"%>
<%@page import="com.quantum.survey.dao.PaperUserRelationShipsDao"%>
<%@page import="com.quantum.survey.service.PaperService"%>
<%@page import="com.quantum.survey.service.impl.PaperServiceImpl"%>
<%@page import="com.quantum.survey.dao.mysqlimpl.PaperDaoImpl"%>
<%@page import="com.quantum.survey.dao.PaperDao"%>
<%@page import="com.quantum.survey.po.Paper"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE>
<html lang="en">
  <head>
    <base href="<%=basePath%>">
    
    <title>问卷</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
    
    <script src="js/jquery.js"></script>
    <script type="text/javascript">	
	var multichoice = [0, 0, 0, 0];
	var q1checked = 0;
	var q2checked = 0;
	var q3checked = 0;
	var q4checked = 0;
	function countNum(multi) {
		/*if(multi[0].checked == 1 && !q1checked) {
			multichoice[0] = 1;
			q1checked = 1;
		}
		if(multi[1].checked == 1 && !q2checked) {
			multichoice[1] = 1;
			q2checked = 1;
		}
		if(multi[2].checked == 1 && !q3checked) {
			multichoice[2] = 1;
			q3checked = 1;
		}
		if(multi[3].checked == 1 && !q4checked) {
			multichoice[3] = 1;
			q4checked = 1;
		}*/
		if(multi.value == 0){
			if(multi.checked == 1 && !q1checked){
				multichoice[0] = 1;
				q1checked = 1;
			}
		}
		if(multi.value == 1){
			if(multi.checked == 1 && !q2checked){
				multichoice[1] = 1;
				q2checked = 1;
			}
		}		
		if(multi.value == 2){
			if(multi.checked == 1 && !q3checked){
				multichoice[2] = 1;
				q3checked = 1;
			}
		}
		if(multi.value == 3){
			if(multi.checked == 1 && !q4checked){
				multichoice[3] = 1;
				q4checked = 1;
			}
		}		
		//request.setAttribute("multi-answer", multichoice);
	}
	//////ajax方法传递checkbox值
	function sub_multi(){
		  $.ajax({
          url: "http://localhost:8080/SurveySystem/submitSucess",
          data: {'mchoice': multichoice},
          type: "POST",
          traditional: true,
          success: function(data) {
          }
        });
	}
	var cas_option;
	function cascadeShow(option, paperid){
	//var cascade_id = id;
	//var temp = document.getElementById('q'+id);
		//var temp = document.createElement("Cascade_Option");
		var value;
		cas_option = option;
		if(option == '0'){
			//$(".alert").show();
		    //session.setAttribute("showCascade", new Integer(1));
		    value = 1;
		    cas_option = option;
		    window.location.href = "http://localhost:8080/SurveySystem/surveypage.jsp?Cascade_Option="+value+"&paperId="+paperid;
		}
		else if (option == '1'){
            //session.setAttribute("showCascade", new Integer(2));
            value = 2;
            cas_option = option;
            window.location.href = "http://localhost:8080/SurveySystem/surveypage.jsp?Cascade_Option="+value+"&paperId="+paperid;
            //temp.value = "B";
        }
        
        $.ajax({
          url: "http://localhost:8080/SurveySystem/surveypage.jsp?&paperId="+paperid,
          data: {'Cascade_Option': value},
          type: "POST",
          async : false,
          traditional: true,
          success: function(data) {
            window.location.href;
          	return;
          }
        });
        
        /*temp.action = "http://localhost:8080/SurveySystem/surveypage.jsp";//提交的地址
		//temp.value = "";
		temp.method = "post";//也可指定为get
		temp.style.display = "none";
		temp.submit();*/
        //window.location.Reload();
	}
</script>

  <style type="text/css">
  body{

  	background-repeat:repeat-x;
  	background-attachment:fixed;
  }
  .container{
  margin-top:15px;
  
  }
  .masthead{
  background-color:none;
  }
  .radio.inline.q2 + .radio.inline.q2{
  margin-right:30px;
  }

  .survey{
  	border:1px;
  	background-color:white;
  	height:auto;
  	margin:0px;
  	padding:15px 0px 0px 30px;
  	
  }
  .div_question{
  	width:96%;
  	height:auto;
  	border:2px solid white;
  	padding :4px 4px;
  	margin:2px auto;
  	border-bottom:1px solid #EFEEEE;
  }
 
  .mastfoot{
  text-align:center;
  margin:10px 0px 5px;
  }
  
  .radio_inline{  
  display: inline-block;  
  width: 65%;  
  }  
            
  .radio_inline label{  
  width: 20%;  
  padding-left: 40px;  
  padding-right: 40px;  
  }  
  
  .radio_inline input[type=radio]{  
  width: 15%;               
  right: auto;  
            }  
  </style>
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
			<h1>Quantum_Survey</h1>
		</div>
		<hr>
		<hr>
	<%!public String getIpAddr(HttpServletRequest request) {  
    	String ip = request.getHeader("x-forwarded-for");     
    	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {     
        	ip = request.getHeader("Proxy-Client-IP");     
    	}     
    	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {     
        	ip = request.getHeader("WL-Proxy-Client-IP");     
    	}     
    	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {     
        	ip = request.getRemoteAddr();     
    	}     
   	 	return ip;     
	}%>
 <div class="survey">
			<form action="submitSucess" method="post" onSubmit="return sub_multi()">
				<%
					String paperIdString = request.getParameter("paperId");
					int paperId = Integer.parseInt(paperIdString);
					session.setAttribute("paperId", new Integer(paperId));
					//获得问卷信息					
					PaperService paperservice = new PaperServiceImpl();	
					Paper paper = paperservice.findPaperByPaperId(paperId);
				
					String startdate =  paper.getPaperStartDate();
					String enddate =  paper.getPaperEndDate();
					SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date PaperEndDate = simpleDateFormat.parse(enddate);
					String title = paper.getPaperTitle();
					String paperSummary = paper.getPaperSummary();
					int papertype = paper.getPaperType();		//问卷类型
					int filltimes = paper.getPaperFilltimes();  //问卷可填写次数
					
					String Last_year=null;
   					String Last_mon=null;
  					String Last_day=null;
  									   
  					String current_year=null;
   					String current_mon=null;
  					String current_day=null;			
  						
					String paperTypeInform = null;
					switch(papertype){
						case 1: paperTypeInform = "该问卷仅限注册用户填写，"; break;
						case 2: paperTypeInform = "该问卷无需注册,可填写" + filltimes + "次,"; break;
						case 3: paperTypeInform = "该问卷无需注册,每天可填写" + filltimes + "次,"; break;
						default: break;
					}
					String informResult = null;
					String UserTypeinform = null; //用户信息提示
					
					String ip = null;
					if(getIpAddr(request).contains("0:0:0:0:0:0:0:1")){	//说明是主机
						InetAddress addr = InetAddress.getLocalHost();
						ip=addr.getHostAddress();
					}	
					else{
						ip = getIpAddr(request);
					}			

					session.setAttribute("UserIP", ip);
					
					PaperUserRelationShipsDao paperUserRelationShipsDao = new PaperUserRelationshipsDaoImpl();
					
					NonRegUsersDao nonRegUsersDao = new NonRegUsersDaoImpl();
					NonRegUsers nonRegUsers = nonRegUsersDao.findNonRegUsersByUserIP(ip);
					int enable_showsurvey = 1;
					Login login = (Login) session.getAttribute("loginInfo");//获取登录信息,如果为null，则是非注册用户
					Date current_time = new Date();
					//String current_time = simpleDateFormat.format(Current_time);
					if(papertype == 1 && login != null){		//是注册用户，且问卷仅限注册用户
						UserTypeinform = "您是注册用户,请填写问卷!";
						informResult = paperTypeInform + UserTypeinform;
					}
					else if (papertype == 1 && login == null){	//不是注册用户，而问卷仅限注册用户
						UserTypeinform = "您不是注册用户,无法填写问卷!";
						informResult = paperTypeInform + UserTypeinform;
						enable_showsurvey = 0;
					}
					else if(papertype != 1){	//问卷不仅限注册用户，则一视同仁
						//先验证用户信息，是的话就不用这么麻烦了
						if(nonRegUsers == null){			//之前没填过问卷的非注册用户,则加入该用户，并添加关系
							nonRegUsers = new NonRegUsers();
							//添加用户
							nonRegUsers.setuserIP(ip);
							nonRegUsersDao.addNonRegUsers(nonRegUsers);
						    PaperUserRelationships newRelationship = new PaperUserRelationships(); 
						    //添加用户关系
						    newRelationship.setPaperId(paperId);
						    newRelationship.setuserIP(ip);
						    newRelationship.setfilltimes(1);
						    Date date = new Date();
							String paperLastFillDate = simpleDateFormat.format(date);
						    newRelationship.setpaperLastFillDate(paperLastFillDate);
							paperUserRelationShipsDao.addPaperUserRelationships(newRelationship);
							UserTypeinform = "您可以填写问卷!";
							informResult = paperTypeInform + UserTypeinform;
						}
							else if(nonRegUsers != null){
							PaperUserRelationships paperUserRelationShips = paperUserRelationShipsDao.findRelationShipsBypaperIdandUserip(paperId, ip);
							if(paperUserRelationShips == null){	//该问卷没有被填写过，添加关系
						   		PaperUserRelationships newRelationship = new PaperUserRelationships(); 
						    	newRelationship.setPaperId(paperId);
						   		newRelationship.setuserIP(ip);
						   		newRelationship.setfilltimes(1);
						    	Date date = new Date();
								String paperLastFillDate = simpleDateFormat.format(date);
						    	newRelationship.setpaperLastFillDate(paperLastFillDate);
								paperUserRelationShipsDao.addPaperUserRelationships(newRelationship);
								UserTypeinform = "您可以填写问卷!";
							    informResult = paperTypeInform + UserTypeinform;
							}
							else{
								int relationId = paperUserRelationShips.getrelationId();;
							//检查问卷关系，包括日期，填写次数
								int nowfilltime = paperUserRelationShips.getfilltimes();
								int overFillTime = 0;
								String LastFillDate = paperUserRelationShips.getpaperLastFillDate();
								Date LastDate = simpleDateFormat.parse(LastFillDate);
								Date date = new Date();
								String newdate = simpleDateFormat.format(date);
								Date NewDate = simpleDateFormat.parse(newdate);
								String currentTime = simpleDateFormat.format(date);
								if(nowfilltime >= filltimes){ //填写次数超出限制
									overFillTime = 1;
								}
								if(papertype == 2){		//总共可填写n次
									if(overFillTime == 1){//次数超限
										UserTypeinform = "您的填写次数超限,不可填写问卷!";
										informResult = paperTypeInform + UserTypeinform;
										enable_showsurvey = 0;
									}
									else{
										UserTypeinform = "您可以填写问卷!";
										informResult = paperTypeInform + UserTypeinform;
										//更新关系表
										int newfilltime = nowfilltime + 1;
										paperUserRelationShipsDao.updatePaperUserRelationships(relationId, newfilltime, currentTime);
									}
								}
								else if(papertype == 3){	//每天可填写n次
									int iftoday = 0;
									   Last_year=String.format("%tY", LastDate);
   									   Last_mon=String .format("%tm", LastDate);
  									   Last_day=String .format("%td", LastDate);
  									   
  									   current_year=String.format("%tY", NewDate);
   									   current_mon=String .format("%tm", NewDate);
  									   current_day=String .format("%td", NewDate);
  									   if(Last_year.equals(current_year) && Last_mon.equals(current_mon) && Last_day.equals(current_day)){
  									   		iftoday = 1;
  									   }
  									   if(iftoday == 1){	//还在同一天
  									   		if(overFillTime == 1){//次数超限
												UserTypeinform = "您今天的填写次数超限，不可填写问卷!";
												informResult = paperTypeInform + UserTypeinform;
												enable_showsurvey = 0;
											}
											else{
											  	UserTypeinform = "您今天还可以填写问卷!";
												informResult = paperTypeInform + UserTypeinform;
												//更新关系表
												int newfilltime = nowfilltime + 1;
												paperUserRelationShipsDao.updatePaperUserRelationships(relationId, newfilltime, currentTime);
											}
  									   }
  									   else{		//不是在同一天了
  									   			UserTypeinform = "您今天还可以填写问卷!";
												informResult = paperTypeInform + UserTypeinform;
												//更新关系表，注意由于是新的一天，要重置填写次数
												paperUserRelationShipsDao.updatePaperUserRelationships(relationId , 1, currentTime);
  									   }
								}
							}
						}
					}
					if(current_time.getTime() > PaperEndDate.getTime()){	//问卷超时，则无论如何都不可以填写
						informResult = "问卷已停止收集,无法再填写问卷!";
						enable_showsurvey = 0;
					}
					
							
					QuestionDao questionDao = new QuestionDaoImpl();
					String ss = "";
					List<Question> questions = questionDao.findQuestionsByPaperId(paperId);
					int totalNum = questions.size();
					int i = 1;					
								
				%>
				
				<script type="text/javascript">
						var informResult = "<%=informResult%>";
						alert(informResult);
				</script>	
				<%if(enable_showsurvey == 1){%>
					<label><h4>题目：<%=title%></h4>
					</label>
					<label><h5>问卷说明:<%=paperSummary%></h5>
					</label>
					<label><h5>开始时间：<%=startdate%></h5>
					</label>
					<label><h5>结束时间：<%=enddate%></h5>
					</label>
				<%}%>								
				
				<input type="hidden" name="totalNum" value=<%=questions.size()%>>
				<div class="div_question">
				<%
					for (Question question : questions) {
						ss = "q" + i;
						String div_id = "tp" + i;
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
							String cascade_single = question.getQstCascade();
							int is_casoption = 0;
							int casoption = 0;
							if(cascade_single.contains("#")) {
								is_casoption = 1;		//说明是被级联题
								String[] options = cascade_single.split("#");
								String fatherQstID = options[0];
								String fatherOption = options[1];
								if(fatherOption.contains("A")) casoption = 1;
								if(fatherOption.contains("B")) casoption = 2;
							}
	
				%>

				<div id= tp<%=i%> class = "t1"" >
					<label><h5><%=i %>、<%=question.getQstTitle()%> <%=type_string%></h5>
					</label>
					<%
					String content = question.getQstOption();
					if (content != null && (question.getQstType() == 1)) {
						String[] options = content.split("#");
						int j = 0;//跟踪选择的值变化
						for (String option : options) {
					%>
						<label class="radio"> <input type="radio" name=<%=ss%>
						id=<%=ss%> value=<%=j %>> <%=option%> </label>
					<%
						j++;
						}
					} 
					if (content != null && (question.getQstType() == 2)) {
						String[] options = content.split("#");
						int j = 0;//跟踪选择的值变化
						for (String option : options) {
						ss = "q" + i + j;
					%>
						<label class="checkbox"> 
						<input type="checkbox" name=<%=ss%> id=<%=ss%> value=<%= j%> onclick="countNum(<%=ss%>)" > <%=option%>  </label>
					<%
						j++;
						}
					} 
					//文本题
					else if (question.getQstType() == 3){
						%>
							<textarea rows="4" cols="50" name=<%=ss%>></textarea>
						<%
						}
					//数字题
					else if (question.getQstType() == 4){
						%>			    
					    <input onKeyPress="if((event.keyCode<48 || event.keyCode>57) && event.keyCode!=46 || /\.\d\d$/.test(value))event.returnValue=false" name=<%=ss%>>
						<%
						}
					//评分题
					else if (question.getQstType() == 5){
							String score = "";
							String[] options = content.split("#");
						//for(int j = 0; j < 7; j++){
							//score = "" + (j+1);
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
						int j = 0;//跟踪选择的值变化
						for (String option : options) {
						String j_string = j + "";
					%>
						<label class="radio"> <input type="radio" name=<%=ss%>
						id=<%=ss%> value=<%=j %> onclick="cascadeShow(<%=j_string%>, <%=paperId%>);" > <%=option%> </label>
					<%
						j++;
						}
					} 
					String show_cascade = request.getParameter("Cascade_Option");
					int showCascade = 0;
					if(show_cascade != null){
						showCascade = Integer.parseInt(show_cascade);
					}
					%>
					</div>
				<script type="text/javascript">
						var is_casoption = <%=is_casoption%>;
						var casoption = <%=casoption%>;
						var showCascade = <%=showCascade%>;
						var enable_showsurvey = <%=enable_showsurvey%>;
						var ss = <%=i%>;
						/*if(showCascade){
							document.getElementById('q'+id)
						}*/
						if(is_casoption == '1'){
							$("#tp"+ss).hide();
						}
						if(is_casoption == 1 && showCascade == '1' && casoption == 1){
							$("#tp"+ss).show();
						}
						if(is_casoption == 1 && showCascade == '2' && casoption == 2){
							$("#tp"+ss).show();
						}
						if( enable_showsurvey == 0){
							$("#tp"+ss).hide();
						}
				</script>	
				<%
					i++;
				}			
				if(enable_showsurvey == 1){
				%>
					<br>
					<input class="btn btn-success" type="submit" value="提交"> 
					<input type="reset" class="btn btn-danger" >
				<%}%>
			</form>
		</div>
  	</div>
</html>
