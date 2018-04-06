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

		// �����ͺ��̽� ���� �о�� ���(List<Member>)�� JSP �������� ����.
		MemberDAO dao = new MemberDAO();

		// ��ü �ο��� Ȯ�� ���
		int totalCount = dao.totalCount();

		// ��ü ��� �� �˻�
		List<Member> list = dao.list(key, value);
		int count = list.size();

		// �μ��� ���
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
