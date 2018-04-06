package com.test;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberInsertHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// ȸ�� ���� �Է� �׼� ����

		// ������ ����(request ��ü)
		request.setCharacterEncoding("UTF-8");
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
	 	MemberDAO dao = new MemberDAO();
		int result = dao.memberAdd(m);
		
		return "redirect:memberList.it?success="+ result;
	}

}
