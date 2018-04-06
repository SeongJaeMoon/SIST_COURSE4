package com.test;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberListHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {

	
		//�����ͺ��̽� ���� �о�� ���(List<Member>)�� JSP �������� ����.
		MemberDAO dao = new MemberDAO();
		
		//��ü �ο��� Ȯ�� ���
		int totalCount = dao.totalCount();
		
		//��ü ���
		List<Member> list = dao.list();
		int count = list.size();
		
		//�μ��� ���
		List<Member> deptList = dao.deptList();
		
		request.setAttribute("list", list);
		request.setAttribute("count", count);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("deptList", deptList);
		
		return "WEB-INF/views/member.jsp";
	}

}
