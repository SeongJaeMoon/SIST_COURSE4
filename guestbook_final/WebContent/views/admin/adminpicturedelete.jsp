<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="com.test.domain.*, com.test.dao.*, java.io.*, java.util.*, java.text.*"%>
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
	// JSP code
	request.setCharacterEncoding("UTF-8");
	String contextRoot = request.getContextPath();
	StringBuilder sb = new StringBuilder();

	//데이터 수신 -> pid
	String pid = request.getParameter("pid");
	System.out.println("pid: " + pid);
	
	//데이터베이스에서 정보 확인 -> picName(파일이름)
	AdminGuestBookDAO dao = new AdminGuestBookDAO();
 	List<AdminGuestBook> list = dao.picList("pid", pid);
 
 	int result = 0;
	//물리적 파일 삭제 -> 물리적경로명/파일이름
	if (list.size() > 0) {
		String filePath = request.getServletContext().getRealPath("resources//pictures");
		String fileName = list.get(0).getPicName();
		
		File file = new File(filePath + "\\" + fileName);
		System.out.println("File Delete: "+filePath + "\\" + fileName);
		
		if (file.exists()) {
			file.delete();
		}

		// 데이터베이스에서 정보 삭제
		result = dao.pictureRemove(pid);
	}

	// 강제 페이지 전환
	response.sendRedirect(String.format("%s/views/admin/adminpicturelist.jsp?success=%s", contextRoot, result));
%>