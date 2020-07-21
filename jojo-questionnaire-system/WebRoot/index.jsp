<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <base href="<%=basePath%>">
    
    <title>Quantum-Survey</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="">
	<meta http-equiv="description" content="">
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/bootstrap-responsive.min.css">
	<link rel="stylesheet" href="css/index.css" />
	<link rel="stylesheet" href="css/font-awesome.min.css">
	<!--[if lt IE 9]>
      	<script src="js/html5shiv.js"></script>
    <![endif]-->
    <script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<style type="text/css">
	</style>
	
</head>
<body>
    <div class="container-narrow">
    	<div class="masthead">
    		<ul class="nav nav-pills pull-right">
    			<li><a href="login.jsp" role="button" class="btn">登录</a></li>
    			<li>&nbsp;</li>
    			<li><a href="reg.jsp" role="button" class="btn">注册</a></li>
    		</ul>
    		<h1><a href="index.jsp">Quantum-Survey</a></h1>
    	</div>
    	<hr>

    		<div id="container">
	    		<div class="wrap">
	    			<img src="img/jojo.jpg">
	    			<p>A Questionnaire Website</p>
                	</div>
            	</div>
    	<hr>
    	<!--
    	<div class="footer">
    		<p>&copy; RoboticsZhang</p>
    	</div>
    	-->
    </div>
</body>
</html>