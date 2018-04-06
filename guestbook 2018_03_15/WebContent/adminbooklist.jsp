<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	
	//검색 진행 -> key, value
	
	//AdminGuestBookDAO 클래스의 guestBookList() 메소드 호출
	//반복문을 이용해서 동적 테이블 태그 생성
	//totalCount -> 전체 게시물 수 -> totalCount() 메소드 호출
	//count -> 블라인드 처리 안된 게시물 수
	//blindcount -> 블라인드 처리된 게시물 수

	String key = request.getParameter("key");
	String value = request.getParameter("value");

	//최초 실행 시 key, value는 null값
	if (key == null) {
		key = "ALL";
		value = "";
	}

	AdminGuestBookDAO dao = new AdminGuestBookDAO();
	List<AdminGuestBook> gbList = dao.guestBookList(key, value);

	int totalCount = dao.totalCount();
	int count = 0;
	int blindCount = 0;
	//int count = gbList.size();

	if (gbList.size() == 0) {
		//결과가 없는 경우
		sb.append(String.format("<tr><td colspan=\"6\" style=\"text-align:center;\"><strong>출력 대상이 없습니다.</strong></td></tr>"));
	} else {

		for (AdminGuestBook gb : gbList) {
			if (gb.getBlind() == 0) {
				count++;
			} else if (gb.getBlind() == 1) {
				blindCount++;
			}

			sb.append(String.format("<tr %s ><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td>"
						,(gb.getBlind() == 1)?"class=\"text-warning\"":"",  gb.getGid(), gb.getName_(), gb.getContent(), gb.getRegDate(), gb.getClientIP()));

			//Blind 버튼
			//->클릭 이벤트 등록(class 식별자 추가)
			//->on버튼 -> confirm창 -> 글번호, 1 값 전송 -> GET or POST
			//->off버튼 -> confirm창 -> 글번호, 0 값 전송 -> GET or POST
			sb.append(String.format("<td><div class=\"btn-group\"><button type=\"button\"class=\"btn btn-default btn-xs %s blindON\" value=\"%s\">on</button><button type=\"button\" class=\"btn btn-default btn-xs %s  blindOFF \"  value=\"%s\">off</button></div></td>",	(gb.getBlind() == 1) ? "active" : "", gb.getGid(), (gb.getBlind() == 0) ? "active" : "", gb.getGid()));
		}
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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<style>
div#input:hover, div#output:hover {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
}
</style>

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<script>
	$(document).ready(function() {

        //------------------------------------------------------------------------------
		//검색 진행하는 경우 key, value를 가지고 현재 컨트롤의 상태를 이전값으로 설정 필요.
		var key = "<%=key%>";
		var value = "<%=value%>";
		$("select#key > option[value=" + key + "]").attr("selected", "selected");
		$("input#value").val(value);
		//------------------------------------------------------------------------------

		
		//-----------------
		//블라인드 처리 액션 추가
		$("button.blindON").on("click", function() {
			if (confirm("선택한 게시물을 블라인드 지정할까요?")) {
				location.assign("adminblind.jsp?gid="+$(this).val()+"&blind=1");
			}
		});
		$("button.blindOFF").on("click", function() {
			if (confirm("선택한 게시물을 블라인드 해제할까요?")) {
				location.assign("adminblind.jsp?gid="+$(this).val()+"&blind=0");
			}
		});
		//-----------------
		
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
					<li class="active"><a href="adminbooklist.jsp">방명록 관리</a></li>
					<li><a href="adminpicturelist.jsp">사진 관리</a></li>
					<li><a href="logout.jsp">[<%=name_%>/<%=id%>]로그 아웃</a></li>
				</ul>
			</div>
		</nav>


		<div class="panel panel-default" id="output">
			<div class="panel-heading">방명록 글목록 <%=successMsg%></div>
			<div class="panel-body">

				<table class="table table-striped">
					<thead>
						<tr>
							<th>번호</th>
							<th>글쓴이</th>
							<th>글내용</th>
							<th>작성일</th>
							<th>Client IP</th>
							<th>Blind</th>
						</tr>
					</thead>
					<tbody>
						<!-- 
						<tr>
							<td>1</td>
							<td>관리자</td>
							<td>JSP 과정 진행 중입니다. 프로젝트 발표 사진도 올릴 예정입니다.</td>
							<td>2018-03-09</td>
							<td>211.63.89.86</td>
							<td><div class="input-group-btn">
									<button type="button" class="btn btn-default btn-xs">On</button>
									<button type="button" class="btn btn-default btn-xs active">Off</button>
								</div></td>
						</tr>
						 -->
						<%=sb.toString()%>

					</tbody>
				</table>

				<form class="form-inline" method="post">
					<div class="form-group">
						<button type="button" class="btn btn-default">
							TotalCount <span class="badge"><%=totalCount%></span>
						</button>
						<button type="button" class="btn btn-default">
							Count <span class="badge"><%=count%></span>
						</button>
						<button type="button" class="btn btn-default">
							BlindCount <span class="badge"><%=blindCount%></span>
						</button>
						<button type="button" class="btn btn-default">
							<span class="glyphicon glyphicon-step-backward"></span> Previous
						</button>
						<button type="button" class="btn btn-default">
							Next <span class="glyphicon glyphicon-step-forward"></span>
						</button>
						
						<!-- 검색 기준 선택 항목 추가 -->
						<select class="form-control" id="key" name="key">
							<option value="name_">Name</option>
							<option value="content">Content</option>
							<option value="regDate">RegDate</option>
						</select>

					</div>
					<div class="input-group">
						<input type="text" class="form-control" id="value" name="value"
							placeholder="Search">

						<div class="input-group-btn">
							<button class="btn btn-default" type="submit">
								<i class="glyphicon glyphicon-search"></i>
							</button>
						</div>
					</div>
				</form>

			</div>


		</div>

	</div>


</body>
</html>
