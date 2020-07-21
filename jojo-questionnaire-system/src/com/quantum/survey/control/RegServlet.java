package com.quantum.survey.control;

import java.io.IOException;
import java.util.*;
import java.text.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.quantum.survey.po.Login;
import com.quantum.survey.po.User;
import com.quantum.survey.service.LoginService;
import com.quantum.survey.service.UserService;
import com.quantum.survey.service.impl.LoginServiceImpl;
import com.quantum.survey.service.impl.UserServiceImpl;

import java.io.PrintWriter;

public class RegServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public RegServlet() {
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
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String from = request.getParameter("from");
		String userName = request.getParameter("inputUserName");
		String userMail = request.getParameter("inputEmail");
		String userPassword = request.getParameter("inputPassword");
		String userEmail = request.getParameter("inputEmail");
		Date now = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance();
		String datetime = dateFormat.format(now);
		UserService userService = new UserServiceImpl();


		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if (userService.findUserByUserName(userName) == null && userService.findUserByUserMail(userMail) == null) {
			User user = new User();
			user.setUserName(userName);
			user.setUserPassword(userPassword);
			user.setUserMail(userEmail);
			user.setUserReg(datetime);
			user.setUserRole(1);
			userService.addUsers(user);
			System.out.println("Database Insert Success !");
		}
		else if (userService.findUserByUserName(userName) != null) {
			out.print("<script language='javascript'>alert('用户名已被注册，请重新输入');window.location.href='reg.jsp';</script>");
			System.out.println("用户名已被使用，请重新输入!");
			return;
		}
		else if (userService.findUserByUserMail(userMail) != null) {
			out.print("<script language='javascript'>alert('邮箱已被注册，请重新输入');window.location.href='reg.jsp';</script>");
			return;
		}
		if (from != null && from.equals("fromAdmin")) {
			HttpSession session = request.getSession();
			session.setAttribute("tips", "SUCCESS");
			response.sendRedirect("iframe.jsp");
		} else {
			Login login = null;
			LoginService loginService = new LoginServiceImpl();
			// 鐧诲綍鎴愬姛锛屽甫鐫�鐧诲綍淇℃伅璺宠浆鍒颁釜浜轰腑蹇冿細home.jsp
			login = loginService.loginInfo(userName, userPassword);
			HttpSession session = request.getSession();
			session.setAttribute("loginInfo", login);
			out.print("<script language='javascript'>alert('注册成功，请登录!');window.location.href='index.jsp';</script>");
			System.out.println("注册成功，请登录！");
			////////添加注册成功提示
		}
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		this.doGet(request, response);
	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	@Override
	public void init() throws ServletException {
		// Put your code here
	}

}
