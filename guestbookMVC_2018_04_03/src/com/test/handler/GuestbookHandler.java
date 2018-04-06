package com.test.handler;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.dao.GuestBookDAO;
import com.test.domain.GuestBook;

public class GuestbookHandler {
	
	private GuestBookDAO dao;
	
	public GuestbookHandler() {
		this.dao = new GuestBookDAO();
	}
	
	///guestbook/list
	public String list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//��ü ��� �� �˻� ��� ���� -> GuestbookDAO Ŭ������ guestBookList() �޼ҵ� ȣ��
		String key = "ALL";
		String value = "";

		//���� ���(�˻�) �׼� ------------
		key = request.getParameter("key");
		value = request.getParameter("value");
		if (key == null) {
			key = "ALL";
			value = "";
		}

		int totalCount = this.dao.totalCount();
		List<GuestBook> gbList = this.dao.guestBookList(key, value);
		int count = gbList.size();
		List<GuestBook> picList = this.dao.picList();
		
		//������ ���� -> request ��ü �̿�
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("count", count);
		request.setAttribute("picList", picList);
		request.setAttribute("gbList", gbList);
		request.setAttribute("key", key);
		request.setAttribute("value", value);
		
		return "/WEB-INF/views/guestbook/guestbook.jsp";
	}
	
	///guestbook/insert
	public String insert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//������ ����
		String name_ = request.getParameter("name_");
		String pw = request.getParameter("pw");
		String content = request.getParameter("content");
		//Ŭ���̾�Ʈ IP ȹ���ϴ� ���� �߰�
		String clientIP = request.getRemoteAddr();
		 
		//�����ͺ��̽� �׼� -> ��� ��ȯ -> result ������ ����
		//DAO Ŭ������ ���� -> GuestBook ��ü
		GuestBook gb = new GuestBook();
		gb.setName_(name_);
		gb.setPw(pw);
		gb.setContent(content);
		gb.setClientIP(clientIP);

		//guestBookAdd() �޼ҵ� ȣ��
		int result = this.dao.guestBookAdd(gb);
		
		return String.format("redirect:%s/guestbook/list?success=%s", request.getContextPath(), result);

	}

	
	///guestbook/delete
	//->�޼ҵ� �߰�
	public String delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//������ ����
		String gid = request.getParameter("gid");
		String pw = request.getParameter("pw");
		 
		//�����ͺ��̽� �׼� -> ��� ��ȯ -> result ������ ����
		//DAO Ŭ������ ���� -> GuestBook ��ü
		GuestBook gb = new GuestBook();
		gb.setPw(pw);
		gb.setGid(gid);

		//guestbookRemove() �޼ҵ� ȣ��
		int result = this.dao.guestbookRemove(gb);
		
		return String.format("redirect:%s/guestbook/list?success=%s", request.getContextPath(), result);

	}

	
	
	
}
