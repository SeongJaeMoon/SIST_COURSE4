package com.test.handler;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.dao.GuestBookDAO;
import com.test.domain.AdminGuestBook;
import com.test.domain.GuestBook;

public class GuestbookHandler {
	
	private GuestBookDAO dao;
	
	public GuestbookHandler() {
		this.dao = new GuestBookDAO();
	}
	
	///guestbook/list
	public String list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		String key = "ALL";
		String value = "";

		key = request.getParameter("key");
		value = request.getParameter("value");
		if (key == null) {
			key = "ALL";
			value = "";
		}
		String pageNum = "1";
		pageNum = request.getParameter("pageNum");

		if(pageNum == null) pageNum = "1";
		
		int limitCount = 10;
		
		int limitOffset = (limitCount * (Integer.parseInt(pageNum) - 1)); 
		int prev = Integer.parseInt(pageNum) - 1; //현재 페이지 -1
		int next =  Integer.parseInt(pageNum) + 1; //현재 페이지 +1
		
		
		List<GuestBook> gbList = dao.guestBookList(key, value, limitOffset, limitCount);

		int totalCount = this.dao.totalCount();
		int count = gbList.size();
		
		List<GuestBook> picList = this.dao.picList();
		
		int picListLength = picList.size();
		
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("count", count);
		request.setAttribute("picList", picList);
		request.setAttribute("picListLength", picListLength);
		request.setAttribute("gbList", gbList);
		request.setAttribute("key", key);
		request.setAttribute("value", value);
		request.setAttribute("prev", prev);
		request.setAttribute("next", next);
		request.setAttribute("limitCount", limitCount);
		
		return "/WEB-INF/views/guestbook/guestbook.jsp";
	}
	
	///guestbook/insert
	public String insert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name_ = request.getParameter("name_");
		String pw = request.getParameter("pw");
		String content = request.getParameter("content");
		
		String clientIP = request.getRemoteAddr();
		 
		
		GuestBook gb = new GuestBook();
		gb.setName_(name_);
		gb.setPw(pw);
		gb.setContent(content);
		gb.setClientIP(clientIP);

		int result = this.dao.guestBookAdd(gb);
		
		return String.format("redirect:%s/guestbook/list?success=%s", request.getContextPath(), result);

	}

	
	///guestbook/delete
	public String delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	
		String gid = request.getParameter("gid");
		String pw = request.getParameter("pw");
		 
		GuestBook gb = new GuestBook();
		gb.setPw(pw);
		gb.setGid(gid);

		int result = this.dao.guestbookRemove(gb);
		
		return String.format("redirect:%s/guestbook/list?success=%s", request.getContextPath(), result);

	}

	
	
	
}
