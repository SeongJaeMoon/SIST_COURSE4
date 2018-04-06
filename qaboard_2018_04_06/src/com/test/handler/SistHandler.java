package com.test.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SistHandler {

	//sist/main
	public String main(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		return "/WEB-INF/views/sist/sistmain.jsp";
	}
	//sist/education
	public String education(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		return "/WEB-INF/views/sist/sisteducation.jsp";
	}
	//sist/intro
	public String intro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		return "/WEB-INF/views/sist/sistintro.jsp";
	}
}
