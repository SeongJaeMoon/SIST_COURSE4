package com.test.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.dao.QABoardDAO;
import com.test.domain.QABoard;
import java.util.*;

public class QaBoardHandler {

	QABoardDAO dao;
	
	public QaBoardHandler() {
		this.dao = new QABoardDAO();
	}
	
	//qaboard/list
	public String list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<QABoard>qaList = this.dao.list();
		int qaListSize = qaList.size();
		
		request.setAttribute("qaList", qaList);
		request.setAttribute("qaListSize", qaListSize);
		
		return "/WEB-INF/views/qaboard/qaboardlist.jsp";
	}
	
	//qaboard/insert
	public String insert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String title = request.getParameter("title");
		String content_ = request.getParameter("content_");
		String clientip = request.getRemoteAddr();
		String pw = request.getParameter("pw");
		
		QABoard qa = new QABoard();
		
		qa.setTitle(title);
		qa.setContent_(content_);
		qa.setClientip(clientip);
		qa.setPw(pw);
		
		int ret = this.dao.add(qa);
		
		return String.format("redirect:%s/qaboard/list?ret=%s", request.getContextPath(), ret);
	}
	
	//qaboard/ajaxContent
	public String ajaxContent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String result = "잘못된 요청입니다.";
		String qid = request.getParameter("qid");
		String pw = request.getParameter("pw");
		
		QABoard qa = this.dao.pwlist(qid, pw);
		
		if(qa != null) {
			result = qa.getContent_();
		}
		request.setAttribute("result", result);
		
		return "/WEB-INF/views/qaboard/ajaxContent.jsp";
	}
}
