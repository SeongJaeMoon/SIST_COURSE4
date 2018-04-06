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

		//전체 출력 및 검색 기능 구현 -> GuestbookDAO 클래스의 guestBookList() 메소드 호출
		String key = "ALL";
		String value = "";

		//방명록 출력(검색) 액션 ------------
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
		
		//데이터 저장 -> request 객체 이용
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
		
		//데이터 수신
		String name_ = request.getParameter("name_");
		String pw = request.getParameter("pw");
		String content = request.getParameter("content");
		//클라이언트 IP 획득하는 과정 추가
		String clientIP = request.getRemoteAddr();
		 
		//데이터베이스 액션 -> 결과 반환 -> result 변수에 저장
		//DAO 클래스에 전달 -> GuestBook 객체
		GuestBook gb = new GuestBook();
		gb.setName_(name_);
		gb.setPw(pw);
		gb.setContent(content);
		gb.setClientIP(clientIP);

		//guestBookAdd() 메소드 호출
		int result = this.dao.guestBookAdd(gb);
		
		return String.format("redirect:%s/guestbook/list?success=%s", request.getContextPath(), result);

	}

	
	///guestbook/delete
	//->메소드 추가
	public String delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//데이터 수신
		String gid = request.getParameter("gid");
		String pw = request.getParameter("pw");
		 
		//데이터베이스 액션 -> 결과 반환 -> result 변수에 저장
		//DAO 클래스에 전달 -> GuestBook 객체
		GuestBook gb = new GuestBook();
		gb.setPw(pw);
		gb.setGid(gid);

		//guestbookRemove() 메소드 호출
		int result = this.dao.guestbookRemove(gb);
		
		return String.format("redirect:%s/guestbook/list?success=%s", request.getContextPath(), result);

	}

	
	
	
}
