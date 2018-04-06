<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.test.*" %>	
<%
		//JSP code
		request.setCharacterEncoding("UTF-8");
		StringBuilder sb = new StringBuilder();
		StringBuilder pic1 = new StringBuilder();
		StringBuilder pic2 = new StringBuilder();
		
		String key = "ALL";
		String value = "";
		
		GuestBookDAO dao = new GuestBookDAO();

		//방명록 출력(검색) 액션 ------------
		key = request.getParameter("key");
		value = request.getParameter("value");
		if (key == null) {
			key = "ALL";
			value = "";
		}

		List<GuestBook> gbList = dao.guestBookList(key, value);
		int totalCount = dao.totalCount();
		int count = gbList.size();

		if (count == 0) {
			//출력 자료가 존재하지 않는 경우
			sb.append(String.format("<tr><td colspan=\"5\" style=\"text-align:center;\"> <strong>출력 대상이 없습니다.</strong> </td></tr>"));
		} else {
			//출력 자료가 존재하는 경우
			for(GuestBook gb : gbList){
				/* 삭제 버튼에 이벤트 등록(jQuery) 및 삭제 기능 진행 */
				/* 주의) 식별자 추가시 class 식별자로 등록해야 한다. */
				sb.append(String.format("<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td><button type=\"button\" class=\"btn btn-default btn-xs btnDelete\"  value=\"%s\">삭제</button></td></tr>", gb.getGid(), gb.getName_(), gb.getContent(), gb.getRegDate(), gb.getGid()));  
			}
		}
		//-----------------------------

		//사진 출력 액션 --------------
		List<GuestBook> picList = dao.picList();

		//주의) 인덱스 사용을 위해서 일반 for문 사용
		int picListLength = picList.size();
		for (int a = 0; a < picListLength; ++a) {

			GuestBook gb = picList.get(a);

			//주의) 첫 번째 항목만 class="active" 지정 필요
			pic1.append(String.format("<li data-target=\"#myCarousel\" data-slide-to=\"%s\"  %s></li>", a,
					(a == 0) ? "class=\"active\"" : ""));

			//주의) 첫 번째 항목만 active 지정 필요
			pic2.append(String.format("<div class=\"item  %s\">", (a == 0) ? "active" : ""));
			pic2.append(String.format("<img src=\"pictures/%s\" alt=\"%s\"", gb.getPicName(), gb.getPicContent()));
			pic2.append(String.format(" style=\"width: 100%%;\">"));
			pic2.append(String.format("<div class=\"carousel-caption\">"));
			pic2.append(String.format("<h3>%s</h3>", gb.getPicContent()));
			pic2.append(String.format("</div>"));
			pic2.append(String.format("</div>"));

		}
		//---------------------------------
		
		
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
        $("select#key > option[value="+key+"]").attr("selected","selected");
        $("input#value").val(value);
        //------------------------------------------------------------------------------


	});
</script>
</head>
<body>

	<div class="container">

		<div class="panel page-header" style="text-align: center;">
			<h1 style="font-size: xx-large;">
				<a href="guestbook.jsp"><img src="img/sist_logo.png"
					alt="sist_logo.png"></a> 방명록 <small>v1.0</small> <span
					style="font-size: small; color: #777777;"></span>
			</h1>
		</div>

		<div class="nanel panel-default" style="padding-bottom: 10px;">
			<div class="panel-heading">
				서울특별시 강남구 역삼 1동 735 한독약품빌딩 8층 쌍용교육센터 / 지하철 2호선 역삼역 3번출구<br>
				Java&amp;Python 기반 응용SW 개발자 양성과정 2017.11.01 ~ 2018.06.01<span
					style="color: red;">(D-84)</span>
				<button class="btn btn-default btn-xs">Map</button>
				<button class="btn btn-default btn-xs">Admin</button>
			</div>
		</div>

		<div class="panel panel-default" id="carousel">
			<div class="panel-heading">Picture List</div>
			<div class="panel-body">
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
					<!-- Indicators -->
					<ol class="carousel-indicators">
						<!-- 
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
						 -->
						<%=pic1.toString()%>
					</ol>

					<!-- Wrapper for slides -->
					<div class="carousel-inner">
						<!-- 
						<div class="item active">
							<img src="pictures/la.jpg" alt="Los Angeles" style="width: 100%;">
							<div class="carousel-caption">
								<h3>Los Angeles</h3>
							</div>
						</div>

						<div class="item">
							<img src="pictures/chicago.jpg" alt="Chicago"
								style="width: 100%;">
							<div class="carousel-caption">
								<h3>Chicago</h3>
							</div>
						</div>

						<div class="item">
							<img src="pictures/ny.jpg" alt="New york" style="width: 100%;">
							<div class="carousel-caption">
								<h3>New york</h3>
							</div>
						</div>
						 -->
						<%=pic2.toString()%>
					</div>

					<!-- Left and right controls -->
					<a class="left carousel-control" href="#myCarousel"
						data-slide="prev"> <span
						class="glyphicon glyphicon-chevron-left"></span> <span
						class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#myCarousel"
						data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>
			</div>
		</div>

		<div class="panel panel-default" id="input">
			<div class="panel-heading">방명록 글쓰기</div>
			<div class="panel-body">

				<form action="guestbookInsert.jsp" method="post">
					<div class="form-group">
						<input type="text" class="form-control" id="name_" name="name_"
							placeholder="Name(max 20)" required>
					</div>
					<div class="form-group">
						<input type="password" class="form-control" id="pw"
							name="pw" placeholder="PASSWORD(max:20)" required>
					</div>
					<div class="form-group">
						<input type="text" class="form-control" id="content"
							name="content" placeholder="CONTENT(max:500)">
					</div>


					<button type="submit" class="btn btn-default">Submit</button>
					<!-- 입력, 수정, 삭제 성공, 실패 메시지 출력 -->
    				<%=successMsg%>
    				
				</form>


			</div>
		</div>


		<div class="panel panel-default" id="output">
			<div class="panel-heading">방명록 글목록</div>
			<div class="panel-body">

				<table class="table table-striped">
					<thead>
						<tr>
							<th>번호</th>
							<th>글쓴이</th>
							<th>글내용</th>
							<th>작성일</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
						<!-- 
						<tr>
							<td>1</td>
							<td>관리자</td>
							<td>JSP 과정 진행 중입니다. 프로젝트 발표 사진도 올릴 예정입니다.</td>
							<td>2018-03-12</td>
							<td><div class="btn-group">
									<button type="button" class="btn btn-default btn-xs">삭제</button>
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