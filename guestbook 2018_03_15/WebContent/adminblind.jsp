<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.test.*"%>
<%-- 일반 사용자 접근 차단 기능 추가(로그인 필요) --%>
<%
	//session 내장 객체를 이용한 로그인 인증 확인
	Object sess = session.getAttribute("loginInfo");
	if (sess == null) {
		//로그인 하지 않은 사용자 접근 상태
		//->접근 차단(강제 페이지 전환)
		response.sendRedirect("accessdenied.jsp");
		//out.write("접근할 수 없는 페이지입니다.");
	}
%>
<%
	//JSP code
	request.setCharacterEncoding("UTF-8");
	StringBuilder sb = new StringBuilder();
	
	//블라인드 처리를 위한 자료 수신
	//->글번호, 블라인드값(1 or 0)
	String gid = request.getParameter("gid");
	String blind = request.getParameter("blind");

	//데이터베이스 액션 -> AdminGuestBookDAO클래스 blind() 메소드 호출
 	AdminGuestBook agb = new AdminGuestBook();
	agb.setGid(gid);
	agb.setBlind(Integer.parseInt(blind));
	AdminGuestBookDAO dao = new AdminGuestBookDAO();
	int result = dao.blind(agb);
	 
	//강제 페이지 전환
	response.sendRedirect("adminbooklist.jsp?success="+ result);
%>