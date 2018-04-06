package com.test;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberListHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String key = "ALL";
		String value = "";
		key = request.getParameter("key");
		value = request.getParameter("value");
		if (key == null) {
			key = "ALL";
			value = "";
		}

		// 데이터베이스 정보 읽어온 결과(List<Member>)를 JSP 페이지로 연결.
		MemberDAO dao = new MemberDAO();

		// 전체 인원수 확인 기능
		int totalCount = dao.totalCount();

		// 전체 출력 및 검색
		List<Member> list = dao.list(key, value);
		int count = list.size();

		// 부서명 출력
		List<Member> deptList = dao.deptList();

		request.setAttribute("list", list);
		request.setAttribute("count", count);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("deptList", deptList);
		request.setAttribute("key", key);
		request.setAttribute("value", value);

		return "WEB-INF/views/member.jsp";
	}

}
