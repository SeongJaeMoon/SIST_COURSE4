package com.test.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.handler.QaBoardHandler;

public class QaBoardController extends HttpServlet {

	private static final long serialVersionUID = -8234090728007116611L;

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
	
		String viewPage = "error";

		String uri = request.getRequestURI();
		System.out.println("uri:" + uri);

		if (uri.contains("/qaboard")) {
			uri = uri.substring(request.getContextPath().length());
			uri = uri.substring("/qaboard/".length());

			try {
				QaBoardHandler handler = new QaBoardHandler();
				Method m = QaBoardHandler.class.getMethod(uri, HttpServletRequest.class, HttpServletResponse.class);
				viewPage = (String) m.invoke(handler, request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

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
