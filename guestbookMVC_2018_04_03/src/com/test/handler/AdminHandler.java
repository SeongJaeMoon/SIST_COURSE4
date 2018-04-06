package com.test.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.dao.AdminGuestBookDAO;

public class AdminHandler {
	
	private AdminGuestBookDAO dao;
	
	public AdminHandler() {
		this.dao = new AdminGuestBookDAO();
	}
	
	
	///admin/booklist
	//->메소드 추가
	//->일반 사용자 접근 차단 기능 추가(로그인 필요) => LoginFilter로 대체
	public String booklist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		return "/WEB-INF/views/admin/adminbooklist.jsp";
	}
	

}
