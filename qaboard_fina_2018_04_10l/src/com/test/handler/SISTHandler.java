package com.test.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SISTHandler {

	///sist/main
	//->�޼ҵ� �߰�
	public String main(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		return "/WEB-INF/views/sist/sistmain.jsp";
	}


	///sist/intro
	//->�޼ҵ� �߰�
	public String intro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		return "/WEB-INF/views/sist/sistintro.jsp";
	}


	///sist/education
	//->�޼ҵ� �߰�
	public String education(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		return "/WEB-INF/views/sist/sisteducation.jsp";
	}

	
}
