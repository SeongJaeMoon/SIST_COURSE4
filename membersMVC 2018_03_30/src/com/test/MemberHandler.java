package com.test;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberHandler {

	private MemberDAO dao;
	public MemberHandler() {
		this.dao = new MemberDAO();
	}
	
	//����� ��û �ּҺ��� �޼ҵ� �ۼ�
	//����) ��û �ּ� �ۼ��� �����ּ� ǥ��� ���
	
	///member/list
	//����) ��û �ּҿ� �޼ҵ� �̸��� ���� ���� �̸� ���
	public String list(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//request.setCharacterEncoding("UTF-8");
		//->com.util.CharactorEncodingFilter Ŭ������ ��ü

		String key = "ALL";
		String value = "";
		key = request.getParameter("key");
		value = request.getParameter("value");
		if (key == null) {
			key = "ALL";
			value = "";
		}

		// �����ͺ��̽� ���� �о�� ���(List<Member>)�� JSP �������� ����.

		// ��ü �ο��� Ȯ�� ���
		int totalCount = this.dao.totalCount();

		// ��ü ��� �� �˻�
		List<Member> list = this.dao.list(key, value);
		int count = list.size();

		// �μ��� ���
		List<Member> deptList = this.dao.deptList();

		request.setAttribute("list", list);
		request.setAttribute("count", count);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("deptList", deptList);
		request.setAttribute("key", key);
		request.setAttribute("value", value);
		
		return "/WEB-INF/views/member.jsp";
	}
	
	///member/insert
	public String insert(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// ������ ����(request ��ü)
		//request.setCharacterEncoding("UTF-8");
		//->com.util.CharactorEncodingFilter Ŭ������ ��ü
		
		String name_ = request.getParameter("name_");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String deptId = request.getParameter("deptId");
		String regDate = request.getParameter("regDate");

		// -> DAO Ŭ������ ���� ���� -> Member ��ü
		Member m = new Member();
		m.setName_(name_);
		m.setPhone(phone);
		m.setEmail(email);
		m.setDeptId(deptId);
		m.setRegDate(java.time.LocalDate.parse(regDate));

		//-> memberAdd() �޼ҵ� ȣ��
		int result = this.dao.memberAdd(m);
		
		return String.format("redirect:%s/member/list?success=%s", request.getContextPath(), result);
	}
	
	///member/delete
	public String delete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		return String.format("redirect:%s/member/list", request.getContextPath());
	}

	///member/update
	public String update(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		return String.format("redirect:%s/member/list", request.getContextPath());
	}

	

}
