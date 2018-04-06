package com.test;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberInsertHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 회원 정보 입력 액션 진행

		// 데이터 수신(request 객체)
		request.setCharacterEncoding("UTF-8");
		String name_ = request.getParameter("name_");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String deptId = request.getParameter("deptId");
		String regDate = request.getParameter("regDate");

		// -> DAO 클래스로 정보 전달 -> Member 객체
		Member m = new Member();
		m.setName_(name_);
		m.setPhone(phone);
		m.setEmail(email);
		m.setDeptId(deptId);
		m.setRegDate(java.time.LocalDate.parse(regDate));

		//-> memberAdd() 메소드 호출
	 	MemberDAO dao = new MemberDAO();
		int result = dao.memberAdd(m);
		
		return "redirect:memberList.it?success="+ result;
	}

}
