<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="com.test.domain.*, com.test.dao.*" %>
<%
	//JSP code
	request.setCharacterEncoding("UTF-8");
	String contextRoot = request.getContextPath();
	StringBuilder sb = new StringBuilder();

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");

	Login l = new Login();
	//ID, PW 설정
	l.setId(id);
	l.setPw(pw);

	//로그인 인증 여부 액션 추가
	LoginDAO dao = new LoginDAO();
	Login result = dao.login(l);

	if (result == null) {
		//로그인 실패
		response.sendRedirect(String.format("%s/views/login/loginfailform.jsp", contextRoot));
	} else {
		//로그인 성공
		//->로그인 사용자의 개인정보(Login 자료형의 객체)를 session객체에 저장
		session.setAttribute("loginInfo", result);
		response.sendRedirect(String.format("%s/views/admin/adminbooklist.jsp", contextRoot));
	}
%>