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
	//->�޼ҵ� �߰�
	//->�Ϲ� ����� ���� ���� ��� �߰�(�α��� �ʿ�) => LoginFilter�� ��ü
	public String booklist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		return "/WEB-INF/views/admin/adminbooklist.jsp";
	}
	

}
