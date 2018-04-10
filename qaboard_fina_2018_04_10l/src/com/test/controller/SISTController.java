package com.test.controller;

import com.test.handler.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SISTController extends HttpServlet {

	private static final long serialVersionUID = -6413578377395577027L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		process(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		process(request, response);
	}

	private void process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 사용자 요청 주소 분석
		// ->요청 URI + invoke() 메소드 기반 주소 분석
		String viewPage = "error";

		String uri = request.getRequestURI();
		System.out.println("uri:" + uri);

		if (uri.contains("/sist")) {
			uri = uri.substring(request.getContextPath().length());
			uri = uri.substring("/sist/".length());

			// 주소 분석 결과 -> 특정 액션 요청
			try {
				SISTHandler handler = new SISTHandler();
				Method m = SISTHandler.class.getMethod(uri, HttpServletRequest.class, HttpServletResponse.class);
				viewPage = (String) m.invoke(handler, request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

			// 요청 결과 -> 뷰 정보 -> 포워딩 또는 리다이렉트
			if (viewPage.contains("redirect:")) {
				response.sendRedirect(viewPage.substring("redirect:".length()));
			} else if (viewPage.contains(".jsp")) {
				RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
				dispatcher.forward(request, response);
			} else {
				PrintWriter out = response.getWriter();
				out.println("<!DOCTYPE html>");
				out.println("<html>");
				out.println("<head>");
				out.println("<title></title>");
				out.println("</head>");
				out.println("<body>");
				out.println("Error:bad request!");
				out.println("</body>");
				out.println("</html>");
			}
		}

	}
}