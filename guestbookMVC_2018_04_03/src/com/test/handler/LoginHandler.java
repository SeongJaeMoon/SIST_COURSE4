package com.test.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.test.dao.LoginDAO;
import com.test.domain.Login;

//로그인 핸들러 클래스
public class LoginHandler {
	
	private LoginDAO dao;
	
	public LoginHandler() {
		this.dao = new LoginDAO();
	}
	
	///login/loginForm 
	//-> 메소드 추가
	public String loginForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		return "";
	}

	///login/login 
	//-> 메소드 추가
	public String login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");

		Login l = new Login();
		//ID, PW 설정
		l.setId(id);
		l.setPw(pw);

		//로그인 인증 여부 액션 추가
		Login result = this.dao.login(l);

		String url = "";
		if (result == null) {
			//로그인 실패
			url = "login/loginFail";
		} else {
			//로그인 성공
			//->로그인 사용자의 개인정보(Login 자료형의 객체)를 session객체에 저장
			HttpSession session = request.getSession();
			session.setAttribute("loginInfo", result);
			url = "admin/booklist";
		}
		
		return String.format("redirect:%s/%s", request.getContextPath(), url);
	}
	
	///login/logout 
	//-> 메소드 추가
	public String logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		session.invalidate();

		return String.format("redirect:%s/login/logoutForm", request.getContextPath());
	}
	
	///login/logoutForm 
	//-> 메소드 추가
	public String logoutForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//포워딩
		return "/WEB-INF/views/login/logoutForm.jsp";
	}
	
	///login/loginFail 
	//-> 메소드 추가
	public String loginFail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//포워딩
		return "/WEB-INF/views/login/loginFail.jsp";
	}
	
}
