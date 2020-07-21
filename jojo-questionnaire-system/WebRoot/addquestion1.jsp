<%@page import="com.quantum.survey.po.Login"%>
<%@page import="com.quantum.survey.po.Question"%>
<%@page import="com.quantum.survey.dao.mysqlimpl.QuestionDaoImpl"%>
<%@page import="com.quantum.survey.dao.QuestionDao"%>
<%@page import="com.quantum.survey.service.PaperService"%>
<%@page import="com.quantum.survey.service.impl.PaperServiceImpl"%>
<%@page import="com.quantum.survey.dao.mysqlimpl.PaperDaoImpl"%>
<%@page import="com.quantum.survey.dao.PaperDao"%>
<%@page import="com.quantum.survey.po.Paper"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE>
<html lang="en">
  <head>
    <base href="<%=basePath%>">
    
    <title>Quantum-Survey</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/bootstrap-responsive.css">
	<link rel="stylesheet" href="css/bootstrap-responsive.min.css">
	<!--[if lt IE 9]>
      	<script src="js/html5shiv.js"></script>
    <![endif]-->
    <script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<style type="text/css">
		body {
			padding-top: 20px;
			padding-bottom: 40px;
		}
		.container1{
			margin:auto;
			width:960px;
		}
		/*内容部分*/
		.maincontent{
			margin-top:40px;
			height:auto;
		}
		.right-button{
			border-width:3px;
			border-color:red;
			margin:0;
			padding:30px 0px 0px 3px;
		}
		.buttonspace{
			margin-left:20px;
			padding:20px 0px 0px 3px; 
		}
		/*热门推荐等格式*/
		.marketing p + h4 {
			margin-top: 28px;
		}
		.controls input{
		 	height:30px;
		 	line-height:30px;
		}
	</style>
    <script src="js/jquery.js"></script>
    <script type="text/javascript">
	
	function radioShow() {
		//debugger;
		var myradiolist = document.getElementsByName("QuestionType");
		//单选题
		if (myradiolist[0].checked){
   			$("#tp1").show();
   		}	
   		else{
   			$("#tp1").hide();
   		}
   		//多选题
		if (myradiolist[1].checked){
   			$("#tp2").show();
   				
   		}	
   		else{
   			$("#tp2").hide();
   		}
   		//问答题
		if (myradiolist[2].checked){
   			$("#tp3").show();
   				
   		}	
   		else{
   			$("#tp3").hide();
   		}
   		//数字题   		
   		if (myradiolist[3].checked){
   			$("#tp4").show();
   				
   		}	
   		else{
   			$("#tp4").hide();
   		}
   		//评分题		
   		if (myradiolist[4].checked){
   			$("#tp5").show();
   				
   		}	
   		else{
   			$("#tp5").hide();
   		}
   		//级联单选题		
   		if (myradiolist[5].checked){
   			$("#tp6").show();
   		}	
   		else{
   			$("#tp6").hide();

   		}
	}
	
  	function startcascade(){
      request.setParameter("cascade", 1);
  	}
  	function endcascade(){
      request.setParameter("cascade", 0);
  	}
  	
  	var httpRequest;

       if(window.XMLHttpRequest) {

           //在IE6以上的版本以及其他内核的浏览器(Mozilla)等
           httpRequest = new XMLHttpRequest();
       }else if(window.ActiveXObject) {

           //在IE6以下的版本
           httpRequest = new ActiveXObject();
   	}
</script>
<script src="js/bootstrap.min.js"></script>	
  </head>
  
  <body>
  	<%
		/*QuestionDao questionDao = new QuestionDaoImpl();
		String QsTIdString =(String)request.getAttribute( "QSTID ");
		int QsTId = 0;*/
		

		Integer QsTIdString = (Integer)session.getAttribute("QSTID");
		int QsTID = 0;
		if(QsTIdString != null){
			QsTID = QsTIdString.intValue();
		}
		int enableCascade = 0;
		String EnableCascade = null;
		if(session.getAttribute("enableCascade") != null){
			EnableCascade = String.valueOf(session.getAttribute("enableCascade"));
		}
		if(EnableCascade != null){
			enableCascade = Integer.parseInt(EnableCascade);
		}
	%>

    <div class="QsTIdStringiner1">
    	<div class="masthead">
    		<ul class="nav nav-pills pull-right">
    			<li><a href="login.jsp" role="button" class="btn">登录</a></li>
    			<li>&nbsp;</li>
    			<li><a href="reg.jsp" role="button" class="btn">注册</a></li>
    		</ul>
    		<h1><a href="index.jsp">Quantum-Survey</a></h1>
    	</div>
    	<hr>
    	<div class="maincontent">
    		<!--<ul class="nav nav-pills">
    			<li class="active">
    				<a href="addquestion1.jsp">单选题</a>
    			</li>
    			<li> <a href="addmutiplechoice.jsp">多选题</a></li>
    			<li> <a href="addquestion2.jsp">问答题</a></li>
    		</ul>-->
    		<!-- form end -->
    		<div class="control-group">
			    <h3>选择问题类型：</h3>
			    	<div class="controls">
						<label for="r1" class="red"><input name="QuestionType" id="qst" type="radio" value="1" onclick="radioShow();" />单选题</label>
  						<label for="r2" class="red"><input name="QuestionType" id="qst" type="radio" value="2" onclick="radioShow();" />多选题</label>
  						<label for="r3" class="red"><input name="QuestionType" id="qst" type="radio" value="3" onclick="radioShow();" />文本题</label>
  						<label for="r4" class="red"><input name="QuestionType" id="qst" type="radio" value="4" onclick="radioShow();" />数字题</label>
  						<label for="r5" class="red"><input name="QuestionType" id="qst" type="radio" value="5" onclick="radioShow();" />评分题</label>
  						<label for="r5" class="red"><input name="QuestionType" id="qst" type="radio" value="5" checked="checked" onclick="radioShow();" />级联单选题</label>
			    	</div>
			</div>
			
    		<form action="addQuestions" method="post" class="form-horizontal">
    		<input type="hidden" value="1" name="qstType" id="single" >		
    			<div id="tp1" class = "t1" style="display:none;">
				    <div class="control-group">
				        <h3>添加单选题问题</h3>
				        <label>请选择:</label>
					    <label class="control-label" for="inputTitle">问题题目</label>
					    <div class="controls">
					    <textarea rows="3" cols="50" name="qstTitle" placeholder="输入单选题题目 " ></textarea>
					    </div>
				    </div>
				    <div class="control-group">
					    <label class="control-label" for="inputOption">A、</label>
					    <div class="controls">
					      <input type="text" id="inputOption" placeholder="输入选项内容" name="qstOption1" >
					    </div>
				    </div>
				    <div class="control-group">
					    <label class="control-label" for="inputOption">B、</label>
					    <div class="controls">
					      <input type="text" id="inputOption" placeholder="输入选项内容" name="qstOption2">
					    </div>
				    </div>
				    <div class="control-group">
					    <label class="control-label" for="inputOption">C、</label>
					    <div class="controls">
					      <input type="text" id="inputOption" placeholder="输入选项内容" name="qstOption3">
					    </div>
				    </div>
				    <div class="control-group">
					    <label class="control-label" for="inputOption">D、</label>
					    <div class="controls">
					      <input type="text" id="inputOption" placeholder="输入选项内容" name="qstOption4">
					    </div>
					
						<%if(enableCascade == 1){%>
						<div class="controls">
							<label for="o1" class="red"><input name="CascadeOption" id="CascadeOption" type="radio" value="A" />添加为A选项级联</label>
  							<label for="o2" class="red"><input name="CascadeOption" id="CascadeOption" type="radio" value="B" />添加为B选项级联</label>
			    	    </div>
			    	    <%}%>
			    	    
			    	    <input type="button" name="addoption" class="btn btn" value="添加选项">	
			    	    	
			    	    <input type="submit" name="Sumbit" class="btn btn-success" value="添加单选题">
				    </div>
				</div>
			</form>  
	
    		<form action="addQuestions" method="post" class="form-horizontal">
    		<input type="hidden" value="2" name="qstType" id="multi" >	
    			<div id="tp2" class = "t2" style="display:none;">
				    <div class="control-group">
				        <h3>添加多选题问题</h3>
				        <label>请选择:</label>
					    <label class="control-label" for="inputTitle">问题题目</label>
					    <div class="controls">
					    <textarea rows="3" cols="50" name="qstTitle" placeholder="输入多选题题目 " ></textarea>
					    </div>
				    </div>
				    <div class="control-group">
					    <label class="control-label" for="inputOption">A、</label>
					    <div class="controls">
					      <input type="text" id="inputOption" placeholder="输入选项内容" name="qstOptionmulti1" >
					    </div>
				    </div>
				    <div class="control-group">
					    <label class="control-label" for="inputOption">B、</label>
					    <div class="controls">
					      <input type="text" id="inputOption" placeholder="输入选项内容" name="qstOptionmulti2">
					    </div>
				    </div>
				    <div class="control-group">
					    <label class="control-label" for="inputOption">C、</label>
					    <div class="controls">
					      <input type="text" id="inputOption" placeholder="输入选项内容" name="qstOptionmulti3">
					    </div>
				    </div>
				    <div class="control-group">
					    <label class="control-label" for="inputOption">D、</label>
					    <div class="controls">
					      <input type="text" id="inputOption" placeholder="输入选项内容" name="qstOptionmulti4">
					    </div>
						
						<%if(enableCascade == 1){%>
						<div class="controls">
							<label for="o1" class="red"><input name="CascadeOption" id="CascadeOption" type="radio" value="A" />添加为A选项级联</label>
  							<label for="o2" class="red"><input name="CascadeOption" id="CascadeOption" type="radio" value="B" />添加为B选项级联</label>
			    	    </div>
			    	    <%}%>
			    	    
			    	    <input type="button" name="addoption" class="btn btn" value="添加选项">		
			    	    <input type="submit" name="Sumbit" class="btn btn-success" value="添加多选题">
				    </div>
				</div>
			</form>  
			
    		<form action="addQuestions" method="post" class="form-horizontal">
    		<input type="hidden" value="3" name="qstType" id="context" >					
				<div id="tp3" class = "t3" style="display:none;">
				    <div class="control-group">
				        <h3>添加文本题问题</h3>
					    <label class="control-label" for="inputTitle">问题题目</label>
					    <div class="controls">
					    <textarea rows="3" cols="50" name="qstTitle" placeholder="输入文本题题目 " ></textarea>
					    </div>
					    
						<%if(enableCascade == 1){%>
						<div class="controls">
							<label for="o1" class="red"><input name="CascadeOption" id="CascadeOption" type="radio" value="A" />添加为A选项级联</label>
  							<label for="o2" class="red"><input name="CascadeOption" id="CascadeOption" type="radio" value="B" />添加为B选项级联</label>
			    	    </div>
			    	    <%}%>
			    	    
			    	    <input type="submit" name="Sumbit" class="btn btn-success" value="添加文本题">
				    </div>
				</div>		
    		</form>  
    		
    		<form action="addQuestions" method="post" class="form-horizontal">
    		<input type="hidden" value="4" name="qstType" id="num" >					
				<div id="tp4" class = "t4" style="display:none;">
				    <div class="control-group">
				        <h3>添加数字题问题</h3>
					    <label class="control-label" for="inputTitle">问题题目</label>
					    <div class="controls">
					    <textarea rows="3" cols="50" name="qstTitle" placeholder="输入数字题题目 " ></textarea>
					    </div>
					    
						<%if(enableCascade == 1){%>
						<div class="controls">
							<label for="o1" class="red"><input name="CascadeOption" id="CascadeOption" type="radio" value="A" />添加为A选项级联</label>
  							<label for="o2" class="red"><input name="CascadeOption" id="CascadeOption" type="radio" value="B" />添加为B选项级联</label>
			    	    </div>
			    	    <%}%>
			    	    
			    	    <input type="submit" name="Sumbit" class="btn btn-success" value="添加数字题">
				    </div>	
				 </div>	
    		</form>  
    		
     		<form action="addQuestions" method="post" class="form-horizontal">
    		<input type="hidden" value="5" name="qstType" id="score" >					
				<div id="tp5" class = "t5" style="display:none;">
				    <div class="control-group">
				        <h3>添加评分题问题</h3>
					    <label class="control-label" for="inputTitle">问题题目</label>
					    
					    <div class="controls">
					    <textarea rows="3" cols="50" name="qstTitle" placeholder="输入评分题题目 " ></textarea>
					    </div>
					    
					    <label class="control-label" for="inputOption">输入评价1</label>
					    <div class="controls">
					    	<input type="text" id="inputOption" placeholder="输入评价1" name="score1">
					    </div>

						<label class="control-label" for="inputOption">输入评价2</label>
					    <div class="controls">
					    	<input type="text" id="inputOption" placeholder="输入评价2" name="score2">
					    </div>
						<label class="control-label" for="inputOption">输入最低分</label>
					    <div class="controls">
					    	<input type="text" id="inputOption" placeholder="输入最低分" name="minscore">
					    </div>		
					    <label class="control-label" for="inputOption">输入最高分</label>
					    <div class="controls">
					    	<input type="text" id="inputOption" placeholder="输入评价2" name="maxscore">
					    </div>		
					    <label class="control-label" for="inputOption">输入分值间隔</label>
					    <div class="controls">
					    	<input type="text" id="inputOption" placeholder="输入分值间隔" name="scoreinterval">
					    </div>				    
						<%if(enableCascade == 1){%>
						<div class="controls">
							<label for="o1" class="red"><input name="CascadeOption" id="CascadeOption" type="radio" value="A" />添加为A选项级联</label>
  							<label for="o2" class="red"><input name="CascadeOption" id="CascadeOption" type="radio" value="B" />添加为B选项级联</label>
			    	    </div>
			    	    <%}%>		    		
					    <input type="submit" name="Sumbit" class="btn btn-success" value="添加评分题">
				    </div>
				</div>		
    		</form>  
    		
      		<form action="addQuestions" method="post" class="form-horizontal">
    		<input type="hidden" value="6" name="qstType" id="cascade_single" >		    						
    			<div id="tp6" class = "t6">
				    <div class="control-group">
				        <h3>添加级联题问题</h3>
				        <label>请选择:</label>
					    <label class="control-label" for="inputTitle">问题题目</label>
					    <div class="controls">
					    <textarea rows="3" cols="50" name="qstTitle" placeholder="输入级联题题目 " ></textarea>
					    </div>
				    </div>
				    
				    <div class="control-group">
					    <label class="control-label" for="inputOption">A、</label>
					    <div class="controls">
					      <input type="text" id="inputOption" placeholder="输入选项内容" name="cascade_qstOption1" >
				    	</div>

				    </div>
				    
				    <div class="control-group">
					    <label class="control-label" for="inputOption">B、</label>
					    <div class="controls">
					      <input type="text" id="inputOption" placeholder="输入选项内容" name="cascade_qstOption2">
					   	</div>
					    
				    </div>
				    
					<div class="control-group">				    
				    <label class="control-label" for="inputTitle">开始级联</label>
					        <div class="controls">
				    	  	<input type="radio" name="startcascade" id="startcascade" value = "1">
				    	</div>
				    </div>		
				        
				    <div class="control-group">				    
				    <label class="control-label" for="inputTitle">停止级联</label>
					        <div class="controls">
				    	  	<input type="radio" name="endcascade" id="endcascade" value = "1">
				    	</div>
				    </div>
				    
				    <div>
						<input type="Submit" name="sumbit" class="btn btn-success" value="添加级联题">	
					</div>
				</div>
    		</form>   			
    	</div>  
  </body>
</html>
