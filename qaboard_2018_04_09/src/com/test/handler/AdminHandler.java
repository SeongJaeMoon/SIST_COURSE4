package com.test.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.*;
import com.test.dao.AdimQABoardDAO;
import com.test.domain.AdminGuestBook;
import com.test.domain.QABoard;

public class AdminHandler {
	
	private AdimQABoardDAO dao;
	
	public AdminHandler() {
		this.dao = new AdimQABoardDAO();
	}
	
	
	public String main(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return "/WEB-INF/views/admin/main.jsp";
	}
	
	//admin/qaboardlist
	public String qaboardlist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<QABoard>qaList = this.dao.list();
		int qaListSize = qaList.size();
		
		request.setAttribute("qaList", qaList);
		request.setAttribute("qaListSize", qaListSize);
		
		return "/WEB-INF/views/admin/qaboardlist.jsp";
	}
	
	//admin/replyinsert
	public String replyinsert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String qid = request.getParameter("qid");
		String replyContent = request.getParameter("replyContent");
		
		QABoard qa = new QABoard();
		qa.setQid(qid);
		qa.setReplyContent(replyContent);
		
		int ret = this.dao.insert(qa);
	
		return String.format("redirect:%s/admin/qaboardlist?ret=%s", request.getContextPath(), ret);
	}
	
	//admin/replydelete
	public String replydelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String qid = request.getParameter("qid");
		
		int ret = this.dao.remove(qid);
		return String.format("redirect:%s/admin/qaboardlist?ret=%s", request.getContextPath(), ret);
	}
	
	//admin/blind
		public String blind(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException {
			
			String blind = request.getParameter("blind");
			String qid = request.getParameter("qid");
			
			QABoard qa = new QABoard();
			
			qa.setBlind(Integer.parseInt(blind));
			qa.setQid(qid);
			
			int ret = this.dao.blind(qa);
			
			return String.format("redirect:%s/admin/qaboardlist?ret=%s", request.getContextPath(), ret);
	}
}
