<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	//JSP code
	request.setCharacterEncoding("UTF-8");
	StringBuilder sb = new StringBuilder();
	
	//로그아웃 액션 추가
	session.invalidate();
	
	
	//강제 페이지 전환
	//-> response 내장 객체 이용
	//-> 주의) 현재 문장 이후에 작성된 코드는 실행되지 않는다.
	//-> 주의) 현재 페이지에 있는 HTML 코드는 클라이언트에게 전달되지 않는다.
	response.sendRedirect("logoutform.jsp");	
%>