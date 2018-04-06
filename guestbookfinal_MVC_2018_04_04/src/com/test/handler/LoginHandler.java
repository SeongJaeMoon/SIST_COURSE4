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
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");

		Login l = new Login();
		//ID, PW 
		l.setId(id);
		l.setPw(pw);

		Login result = this.dao.login(l);

		String url = "";
		if (result == null) {
			
			url = "login/loginFail";
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("loginInfo", result);
			url = "admin/booklist";
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
