package com.test.handler;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.dao.QABoardDAO;
import com.test.domain.QABoard;

public class QABoardHandler {
	
	private QABoardDAO dao;
	
	public QABoardHandler() {
		this.dao = new QABoardDAO();
	}

	///qaboard/list
	//->메소드 추가
	public String list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int totalCount = this.dao.totalCount();
		
		//List<QABoard> list = this.dao.list();
		
		String pageNum = request.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}
		int limit_count = 20;
		int limit_offset = (limit_count * (Integer.parseInt(pageNum) - 1));
		int previous = Integer.parseInt(pageNum) - 1; 
		int next = Integer.parseInt(pageNum) + 1;
		List<QABoard> list = this.dao.list(limit_offset, limit_count);
		int size = list.size();
		
		request.setAttribute("list", list);
		request.setAttribute("size", size);
		request.setAttribute("previous", previous);
		request.setAttribute("next", next);
		request.setAttribute("limit_count", limit_count);
		request.setAttribute("totalCount", totalCount);
		
		return "/WEB-INF/views/qaboard/qaboardlist.jsp";
	}

	
	///qaboard/insert
	//->메소드 추가
	public String insert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int result = 0;
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String pw = request.getParameter("pw");
		String clientIP = request.getRemoteAddr();
		
		QABoard qa = new QABoard();
		qa.setTitle(title);
		qa.setContent(content);
		qa.setPw(pw);
		qa.setClientIP(clientIP);
		
		result = this.dao.add(qa);
		
		return String.format("redirect:%s/qaboard/list?success=%s", request.getContextPath(), result);
	}
	
	
	///qaboard/ajaxContent
	//-> 메소드 추가
	public String ajaxContent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String result = "Error:Bad Request.";
		
		String qid = request.getParameter("qid");
		String pw = request.getParameter("pw");
		
		QABoard q = new QABoard();
		q.setQid(qid);
		q.setPw(pw);
		
		QABoard qa = this.dao.ajaxContent(q);
		if (qa != null) {
			result = qa.getContent();
		}
		
		request.setAttribute("result", result);
		
		return "/WEB-INF/views/qaboard/ajaxContent.jsp";
	}
	
}
