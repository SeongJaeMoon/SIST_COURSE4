package com.test;

import java.io.IOException;
import java.lang.reflect.Method;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberController extends HttpServlet {

	private static final long serialVersionUID = -27777817186348165L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}
	
	private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//사용자 요청 주소 분석
		// ->요청 URI + invoke() 메소드 기반 주소 분석
		// ->http://211.63.89.68:8090/membersMVC_20180330/member/list
		String uri = request.getRequestURI();
		System.out.println("uri:"+uri);
		
		uri = uri.substring(request.getContextPath().length());
		uri = uri.substring("/member/".length());
		
		//주소 분석 결과 -> 특정 액션 요청
		String viewPage = "error";
		try {
			MemberHandler handler = new MemberHandler();
			Method m = MemberHandler.class.getMethod(uri, HttpServletRequest.class, HttpServletResponse.class);
			viewPage = (String)m.invoke(handler, request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}

		//요청 결과 -> 뷰 정보 -> 포워딩 또는 리다이렉트
		if (viewPage.contains("redirect:")) {
			response.sendRedirect(viewPage.substring("redirect:".length()));
		} else if (viewPage.contains(".jsp")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
		} else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/error.html");
			dispatcher.forward(request, response);
		}
	}

}
