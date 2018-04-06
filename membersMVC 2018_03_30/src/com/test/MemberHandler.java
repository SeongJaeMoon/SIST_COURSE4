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
	
	//사용자 요청 주소별로 메소드 작성
	//주의) 요청 주소 작성시 절대주소 표기법 사용
	
	///member/list
	//주의) 요청 주소와 메소드 이름을 서로 같은 이름 사용
	public String list(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//request.setCharacterEncoding("UTF-8");
		//->com.util.CharactorEncodingFilter 클래스로 대체

		String key = "ALL";
		String value = "";
		key = request.getParameter("key");
		value = request.getParameter("value");
		if (key == null) {
			key = "ALL";
			value = "";
		}

		// 데이터베이스 정보 읽어온 결과(List<Member>)를 JSP 페이지로 연결.

		// 전체 인원수 확인 기능
		int totalCount = this.dao.totalCount();

		// 전체 출력 및 검색
		List<Member> list = this.dao.list(key, value);
		int count = list.size();

		// 부서명 출력
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
		
		// 데이터 수신(request 객체)
		//request.setCharacterEncoding("UTF-8");
		//->com.util.CharactorEncodingFilter 클래스로 대체
		
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
