<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="com.test.*, java.io.*, java.util.*, java.text.*"%>
<%@ page import="javax.servlet.*, javax.servlet.http.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.io.output.*"%>
<%-- 일반 사용자 접근 차단 기능 추가(로그인 필요) --%>
<%
	//session 내장 객체를 이용한 로그인 인증 확인
	Object sess = session.getAttribute("loginInfo");
	if (sess == null) {
		//로그인 하지 않은 사용자 접근 상태
		//->접근 차단(강제 페이지 전환)
		response.sendRedirect("accessdenied.jsp");
		//out.write("접근할 수 없는 페이지입니다.");
	}
%>
<%
	// JSP code
	request.setCharacterEncoding("UTF-8");
	StringBuilder sb = new StringBuilder();

	//commons fileupload를 이용한 파일 업로드 처리
	//commons-fileupload-1.3.3.jar, commons-io-2.6.jar 라이브러리 필요

	//업로드된 파일에 대한 물리적 처리
	File file;
	int maxFileSize = 1 * 1024 * 1024;
	int maxMemSize = 1 * 1024 * 1024;
	ServletContext context = pageContext.getServletContext();
	String filePath = request.getServletContext().getRealPath("pictures");
	// Verify the content type
	String contentType = request.getContentType();
	String newFileName = "";
	String picContent = "";
	int result = 0;

	if ((contentType.indexOf("multipart/form-data") >= 0)) {
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// maximum size that will be stored in memory
		factory.setSizeThreshold(maxMemSize);

		// Location to save data that is larger than maxMemSize. (임시폴더)
		factory.setRepository(new File("c:\\temp"));

		// Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(factory);

		// maximum file size to be uploaded.
		upload.setSizeMax(maxFileSize);

		try {
			// Parse the request to get file items.
			List<FileItem> fileItems = upload.parseRequest(request);

			// Process the uploaded file items
			Iterator<FileItem> i = fileItems.iterator();

			while (i.hasNext()) {
				FileItem fi = (FileItem) i.next();
				if (fi.isFormField()) {
					picContent = fi.getString("UTF-8");
				} else {
					// Get the uploaded file parameters
					String fieldName = fi.getFieldName();
					String fileName = fi.getName();
					boolean isInMemory = fi.isInMemory();
					long sizeInBytes = fi.getSize();

					// Write the file
					/* if( fileName.lastIndexOf("\\") >= 0 ) {
					   file = new File( filePath + "\\" + fileName.substring( fileName.lastIndexOf("\\"))) ;
					} else {
					   file = new File( filePath + "\\" + fileName.substring(fileName.lastIndexOf("\\")+1)) ;
					} */

					// 주의) 물리적 파일이름이 같은 파일인 경우 덮어쓰기가 된다. -> 유니크 파일 이름 생성 -> 확장자는 그대로 유지해야 한다. -> "동적 생성된 파일 이름.확장자"

					if (fileName.lastIndexOf(".") >= 0) {
						String ext = fileName.substring(fileName.lastIndexOf(".")); // 현재 파일의 확장자;
						newFileName = Util.randomFileName() + ext;//동적 생성된 이름 + 기존 확장자;
						file = new File(filePath + "\\" + newFileName);
					} else {
						newFileName = Util.randomFileName();//동적 생성된 이름 + 기존 확장자;
						file = new File(filePath + "\\" + newFileName);
					}
					System.out.println("new FileName:" + filePath + "\\" + newFileName);

					fi.write(file); // 서버의 데이터를 물리적으로 기록(저장)

					//데이터 베이스에 사진 정보(파일 이름, 사진 설명) 저장
					AdminGuestBook agb = new AdminGuestBook();
					agb.setPicContent(picContent);
					agb.setPicName(newFileName);

					AdminGuestBookDAO dao = new AdminGuestBookDAO();
					result = dao.pictureAdd(agb);
				}
			}
		} catch (Exception ex) {
			System.out.println(ex);
		}
	} else {

	}

	// 강제 페이지 전환
	response.sendRedirect("adminpicturelist.jsp?success=" + result);
%>