<%@page import="com.quantum.survey.po.Login"%>
<%@page import="com.quantum.survey.po.Paper"%>
<%@page import="java.net.InetAddress"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
	<style type="text/css">
		body {
			padding-top: 20px;
			padding-bottom: 40px;
		}
		.container1{
		width:960px;
		margin:auto;
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
			margin-top:15px;
			padding:20px 0px 0px 3px; 
		}
		
	</style>

  </head>
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
  <body>
    <%
    	InetAddress addr = InetAddress.getLocalHost();
		String ip=addr.getHostAddress();
		Integer paperIdInt = (Integer) session.getAttribute("paperId");
		int paperId = paperIdInt.intValue();
		String remoteAddr=getIpAddr(request);
		String fileUrl = null;

   %>
    	<h1>
    			问卷链接为:
    	</h1>
    	
    	<h1>
				http://<%=ip%>:8080/SurveySystem/surveypage.jsp?paperId=<%=paperId%>
    	</h1>
		
		<h1>
    			<a href="surveypage.jsp?paperId=<%=paperId%>" class="btn btn-small">填写问卷</a>
    	</h1>
  </body>
</html>
