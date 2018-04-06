<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%-- 주의) Ajax 응답 페이지 구성시 불필요한 반환값을 작성하지 않는다. --%>
<%@ page import="java.util.*"%>
<%
	//JSP code
	request.setCharacterEncoding("UTF-8");
	String contextRoot = request.getContextPath();
	StringBuilder sb = new StringBuilder();

	String query = request.getParameter("query");

	//키 문자열 분석 및 결과 반환

	//이름 정보가 있는 배열 준비
	String[] names = { "jenna", "yeop", "minsun", "edwin", "yumiko" };
	List<String> result = new ArrayList<String>();

	//반복문 and 조건문 이용해서 분석
	//->결과를 임시 변수(컬렉션)에 저장
	for (int i = 0; i < names.length; ++i) {
		if (names[i].contains(query)) {
			result.add(names[i]);
		}
	}
	
	if (result.size() == 0) {
		result.add("no result!");
	}

	//결과 반환
	out.println(result.toString());
%>