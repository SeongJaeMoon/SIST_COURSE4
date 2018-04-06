<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="com.test.domain.*, com.test.dao.*" %>
<%
	//JSP code
	request.setCharacterEncoding("UTF-8");
	String contextRoot = request.getContextPath();
	StringBuilder sb = new StringBuilder();

	//데이터 수신(request 내장 객체) 
	//->클라이언트 IP 획득 과정 추가
	String name_ = request.getParameter("name_");
	String pw = request.getParameter("pw");
	String content = request.getParameter("content");
	//클라이언트 IP 획득하는 과정 추가
	String clientIP = request.getRemoteAddr();
	 
	//DAO 클래스에 전달 -> GuestBook 객체
	GuestBook gb = new GuestBook();
	gb.setName_(name_);
	gb.setPw(pw);
	gb.setContent(content);
	gb.setClientIP(clientIP);

	//guestBookAdd() 메소드 호출
	GuestBookDAO dao = new GuestBookDAO();
	int result = dao.guestBookAdd(gb);

	//강제 페이지 전환
	//-> response 내장 객체 이용
	//-> 주의) 현재 문장 이후에 작성된 코드는 실행되지 않는다.
	//-> 주의) 현재 페이지에 있는 HTML 코드는 클라이언트에게 전달되지 않는다.
	//-> 성공, 실패 여부를 GET 방식으로 전달 가능
	response.sendRedirect(String.format("%s/index.jsp?success=%s", contextRoot, result));
%>