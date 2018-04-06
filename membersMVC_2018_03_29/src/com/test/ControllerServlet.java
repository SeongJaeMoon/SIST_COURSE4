package com.test;

import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ControllerServlet extends HttpServlet {

	private static final long serialVersionUID = 6270712217195218531L;

	// <커맨드, 핸들러인스턴스> 매핑 정보 저장
	private Map<String, CommandHandler> commandHandlerMap = new HashMap<>();

	@Override
	public void init() throws ServletException {
		String configFile = getInitParameter("configFile");
		Properties prop = new Properties();
		String configFilePath = getServletContext().getRealPath(configFile);
		try (FileReader fis = new FileReader(configFilePath)) {
			prop.load(fis);
		} catch (IOException e) {
			throw new ServletException(e);
		}
		Iterator<Object> keyIter = prop.keySet().iterator();
		while (keyIter.hasNext()) {
			String command = (String) keyIter.next();
			String handlerClassName = prop.getProperty(command);
			try {
				Class<?> handlerClass = Class.forName(handlerClassName);
				CommandHandler handlerInstance = (CommandHandler) handlerClass.newInstance();
				this.commandHandlerMap.put(command, handlerInstance);
			} catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
				throw new ServletException(e);
			}
		}
	}

	// 1단계. 사용자 요청 수신
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 사용자 정의 메소드
		process(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 사용자 정의 메소드
		process(req, resp);
	}

	private void process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 2단계. 요청 분석
		// ->요청 URI + 프로퍼티(*.properties) 기반 주소 분석
		// ->http://211.63.89.68:8090/membersMVC_20180329/memberList.it
		String uri = request.getRequestURI();
		if (uri.indexOf(request.getContextPath()) == 0) {
			uri = uri.substring(request.getContextPath().length());
		}

		// 3단계. 모델을 사용하여 요청한 기능 수행 -> 결과
		CommandHandler handler = this.commandHandlerMap.get(uri);
		String viewPage = handler.process(request, response);

		// 5단계. 
		// 뷰(WEB-INF/views/member.jsp)로 포워딩 -> RequestDispatcher
		// 또는 리다이렉트(redirect:memberList.it) -> response.sendRedirect()
		if (viewPage.contains("redirect:")) {
			response.sendRedirect(viewPage.substring("redirect:".length()));
		} else {
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
		}

	}

}
