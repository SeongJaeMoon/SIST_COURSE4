<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.test.*"%>
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
	//JSP code
	request.setCharacterEncoding("UTF-8");
	StringBuilder sb = new StringBuilder();
	
	
	//데이터베이스에 저장된 사진 목록을 읽어와서 동적 <img> 태그 생성
	AdminGuestBookDAO dao = new AdminGuestBookDAO();
	List<AdminGuestBook> picList = dao.picList();

	//주의) 인덱스 사용을 위해서 일반 for문 사용
	int picListLength = picList.size();
	for (int a = 0; a < picListLength; ++a) {
		AdminGuestBook gb = picList.get(a);
		sb.append(String.format("<div class=\"col-md-3\"><div class=\"thumbnail\"><a href=\"pictures/%s\" target=\"_blank\">", gb.getPicName())); 
		sb.append(String.format("<img src=\"pictures/%s\" alt=\"%s\" style=\"width: 100%%;\">", gb.getPicName(), gb.getPicContent()));
		sb.append(String.format("<div class=\"caption\"><p>%s</p></div></a></div></div>", gb.getPicContent()));  
	}
	
	//로그인 사용자 개인정보 확인
	String id = "";
	String name_ = "";
	if (sess != null) {
		Login loginInfo = (Login)sess;
		id =  loginInfo.getId();
		name_ = loginInfo.getName_();
	}
	
	//입력, 수정, 삭제 성공, 실패 메시지 출력용 변수 ----------------------
	String success = request.getParameter("success");
	String successMsg = "";
	if (success == null) {
		//최초 실행시 메시지
	} else {
		if (success.equals("1")) {
			//성공 메시지 출력 및 메시지 삭제 버튼 추가
			successMsg = "<div class=\"alert alert-success alert-dismissible fade in\" style=\"display:inline-block; padding-top:5px; padding-bottom:5px; margin:0px;\">  <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>  <strong>Success!</strong> 요청한 작업이 처리되었습니다. </div>";
		} else if (success.equals("0")) {
			//실패 메시지 출력 및 메시지 삭제 버튼 추가
			successMsg = "<div class=\"alert alert-danger alert-dismissible fade in\" style=\"display:inline-block; padding-top:5px; padding-bottom:5px; margin:0px;\">  <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>  <strong>Fail!</strong> 요청한 작업 처리가 실패했습니다. </div>";
		}
	}
	//---------------------------------------------------------------------
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">

<title>SIST_쌍용교육센터</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<style>

div#input:hover, div#output:hover {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

</style>

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<script>
$(document).ready(function(){

	   // jQuery methods go here...

});
</script>
</head>
<body>

	<div class="container">

		<div class="panel page-header" style="text-align: center;">
			<h1 style="font-size: xx-large;">
				<a href="adminbooklist.jsp"><img src="img/sist_logo.png"
					alt="sist_logo.png"></a> 방명록 <small>v1.3</small> <span
					style="font-size: small; color: #777777;"></span>
			</h1>
		</div>

		<nav class="navbar navbar-default">
			<div class="container-fluid">
				<div class="navbar-header"></div>
				<ul class="nav navbar-nav">
					<li><a href="adminbooklist.jsp">방명록 관리</a></li>
					<li class="active"><a href="adminpicturelist.jsp">사진 관리</a></li>
					<li><a href="logout.jsp">[<%=name_%>/<%=id%>]로그 아웃
					</a></li>
				</ul>
			</div>
		</nav>

		<div class="panel panel-default">
			<div class="panel-heading">사진 업로드</div>
			<div class="panel-body">
				<form action="adminpictureinsert.jsp" method="post" enctype="multipart/form-data">
				
					<div class="form-group">
						<input type="text" class="form-control" id="picContent"
							name="picContent" placeholder="사진 설명(max:50)" required>
					</div>
					<div class="form-group">
						<input type="file" class="form-control" id="picName"
							name="picName"  required>
						<span class="help-block">(.jpg or .png, max 1M)</span>
					</div>

					<button type="submit" class="btn btn-default">Submit</button>
					<%=successMsg%>
					
				</form>

			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">사진 목록</div>
			<div class="panel-body">

				<div class="row">
					<!--
					<div class="col-md-3">
				      <div class="thumbnail">
				       <a href="img/la.jpg" target="_blank"> <img src="img/la.jpg" alt="1" style="width: 100%">
				        <div class="caption">
				         <p>LA 공연</p>
				        </div>
				       </a>
				      </div>
				     </div>
				     <div class="col-md-3">
				      <div class="thumbnail">
				       <a href="img/ny.jpg" target="_blank"> <img src="img/ny.jpg" alt="2" style="width: 100%">
				        <div class="caption">
				         <p>뉴욕 공연</p>
				        </div>
				       </a>
				      </div>
				     </div>
				     <div class="col-md-3">
				      <div class="thumbnail">
				       <a href="img/chicago.jpg" target="_blank"> <img src="img/chicago.jpg" alt="3" style="width: 100%">
				        <div class="caption">
				         <p>시카고 공연</p>
				        </div>
				       </a>
				      </div>
				     </div>
					 -->
					<%=sb.toString()%>
				</div>
			</div>
		</div>
	</div>

</body>
</html>