package com.test.handler;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.dao.AdminQABoardDAO;
import com.test.dao.QABoardDAO;
import com.test.domain.QABoard;

public class AdminHandler {

	private AdminQABoardDAO dao;
	
	public AdminHandler() {
		this.dao = new AdminQABoardDAO();
	}
	
	///admin/main
	//->�޼ҵ� �߰�
	public String main(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		return "/WEB-INF/views/admin/adminmain.jsp";
	}

	///admin/qaboardlist
	//-> �޼ҵ� �߰�
	public String qaboardlist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int totalcount = this.dao.totalCount();
		List<QABoard> list = this.dao.list();
		
		request.setAttribute("list", list);
		request.setAttribute("totalcount", totalcount);
		
		return "/WEB-INF/views/admin/adminqaboardlist.jsp";
	}
	
	
	///admin/replyinsert
	//->�޼ҵ� �߰�
	public String replyinsert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int result = 0;
		
		String qid = request.getParameter("qid");
		String replycontent = request.getParameter("replycontent");
		
		QABoard qa = new QABoard();
		qa.setQid(qid);
		qa.setReplyContent(replycontent);
		
		result = this.dao.replyAdd(qa);		
		
		return String.format("redirect:%s/admin/qaboardlist?success=%s", request.getContextPath(), result);

	}
	
	///admin/replydelete
	//->�޼ҵ� �߰�
	public String replydelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int result = 0;
		
		String qid = request.getParameter("qid");
		
		QABoard qa = new QABoard();
		qa.setQid(qid);

		result = this.dao.replyRemove(qa);		
		
		return String.format("redirect:%s/admin/qaboardlist?success=%s", request.getContextPath(), result);

	}
	
	///admin/blind
	//->�޼ҵ� �߰�
	public String blind(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int result = 0;
		
		String qid = request.getParameter("qid");
		String blind = request.getParameter("blind");
		
		QABoard qa = new QABoard();
		qa.setQid(qid);
		qa.setBlind(Integer.parseInt(blind));

		result = this.dao.blind(qa);		
		
		return String.format("redirect:%s/admin/qaboardlist?success=%s", request.getContextPath(), result);

	}
	
}
