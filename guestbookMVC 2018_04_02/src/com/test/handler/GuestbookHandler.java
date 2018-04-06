package com.test.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GuestbookHandler {
	
	///guestbook/list
	public String list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		return "/WEB-INF/views/guestbook/guestbook.jsp";
	}
	
}
