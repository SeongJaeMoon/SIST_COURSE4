package com.test.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.test.dao.LoginDAO;
import com.test.domain.Login;

public class LoginHandler {
	
	private LoginDAO dao;
	
	public LoginHandler() {
		this.dao = new LoginDAO();
	}
	
	///login/loginForm 

	public String loginForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		return "";
	}

	///login/login 
	
	public String login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id_");
		String pw = request.getParameter("pw_");
		String grade = request.getParameter("grade");
		
		Login l = new Login();
		//ID, PW, 등급 
		l.setId_(id);
		l.setPw_(pw);
		l.setGrade(Integer.parseInt(grade));
		
		Login result = this.dao.login(l);

		String url = "";
		if (result == null) {
			url = "login/loginFail";
		} else {
			HttpSession session = request.getSession();
			if(result.getGrade() == 0) {
				session.setAttribute("adminLogin", result);
				url = "admin/main";
			}else if(result.getGrade() == 1) {
				session.setAttribute("userLogin", result);
				url = "user/main";
			}
		}
		
		return String.format("redirect:%s/%s", request.getContextPath(), url);
	}
	
	///login/logout 
	
	public String logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		session.invalidate();

		return String.format("redirect:%s/login/logoutForm", request.getContextPath());
	}
	
	///login/logoutForm 
	
	public String logoutForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		return "/WEB-INF/views/login/logoutForm.jsp";
	}
	
	///login/loginFail 
	
	public String loginFail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		return "/WEB-INF/views/login/loginFail.jsp";
	}
	
}
