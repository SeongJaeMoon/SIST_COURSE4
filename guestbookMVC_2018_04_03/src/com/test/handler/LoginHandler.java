package com.test.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.test.dao.LoginDAO;
import com.test.domain.Login;

//�α��� �ڵ鷯 Ŭ����
public class LoginHandler {
	
	private LoginDAO dao;
	
	public LoginHandler() {
		this.dao = new LoginDAO();
	}
	
	///login/loginForm 
	//-> �޼ҵ� �߰�
	public String loginForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		return "";
	}

	///login/login 
	//-> �޼ҵ� �߰�
	public String login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");

		Login l = new Login();
		//ID, PW ����
		l.setId(id);
		l.setPw(pw);

		//�α��� ���� ���� �׼� �߰�
		Login result = this.dao.login(l);

		String url = "";
		if (result == null) {
			//�α��� ����
			url = "login/loginFail";
		} else {
			//�α��� ����
			//->�α��� ������� ��������(Login �ڷ����� ��ü)�� session��ü�� ����
			HttpSession session = request.getSession();
			session.setAttribute("loginInfo", result);
			url = "admin/booklist";
		}
		
		return String.format("redirect:%s/%s", request.getContextPath(), url);
	}
	
	///login/logout 
	//-> �޼ҵ� �߰�
	public String logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		session.invalidate();

		return String.format("redirect:%s/login/logoutForm", request.getContextPath());
	}
	
	///login/logoutForm 
	//-> �޼ҵ� �߰�
	public String logoutForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//������
		return "/WEB-INF/views/login/logoutForm.jsp";
	}
	
	///login/loginFail 
	//-> �޼ҵ� �߰�
	public String loginFail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//������
		return "/WEB-INF/views/login/loginFail.jsp";
	}
	
}
