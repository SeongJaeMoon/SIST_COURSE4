package com.test.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SISTHandler {

	///sist/main
	//->메소드 추가
	public String main(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		return "/WEB-INF/views/sist/sistmain.jsp";
	}


	///sist/intro
	//->메소드 추가
	public String intro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		return "/WEB-INF/views/sist/sistintro.jsp";
	}


	///sist/education
	//->메소드 추가
	public String education(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		return "/WEB-INF/views/sist/sisteducation.jsp";
	}

	
}
