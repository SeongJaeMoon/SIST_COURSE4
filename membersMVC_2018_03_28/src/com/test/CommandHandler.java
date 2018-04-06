package com.test;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface CommandHandler {
	
	public String process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

}
