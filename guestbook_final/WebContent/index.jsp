<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.test.domain.*, com.test.dao.*"%>
<%
	//JSP code
	request.setCharacterEncoding("UTF-8");
	String contextRoot = request.getContextPath();
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

	int totalCount = dao.totalCount();
	
	//페이징 처리 전--------------
	//List<GuestBook> gbList = dao.guestBookList(key, value);
	//-----------------------------
	
	//페이징 처리 후--------------
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "1";
	}
	int limit_count = 10;
	int limit_offset = (limit_count * (Integer.parseInt(pageNum) - 1));
	int previous = Integer.parseInt(pageNum) - 1; 
	int next = Integer.parseInt(pageNum) + 1;
	List<GuestBook> gbList = dao.guestBookList(key, value, limit_offset, limit_count);
	//-----------------------------
	
	int count = gbList.size();

	if (count == 0) {
		//출력 자료가 존재하지 않는 경우
		sb.append(String.format(
				"<tr><td colspan=\"5\" style=\"text-align:center;\"> <strong>출력 대상이 없습니다.</strong> </td></tr>"));
	} else {
		//출력 자료가 존재하는 경우
		for (GuestBook gb : gbList) {
			/* 삭제 버튼에 이벤트 등록(jQuery) 및 삭제 기능 진행 */
			/* 주의) 식별자 추가시 class 식별자로 등록해야 한다. */
			/* 주의) 오늘 날짜는 시간 출력, 이전 날짜는 날짜 출력 */
			sb.append(String.format(
					"<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td><button type=\"button\" class=\"btn btn-default btn-xs btnDelete\"  value=\"%s\">삭제</button></td></tr>",
					gb.getGid(), gb.getName_(), gb.getContent(), gb.getRegDate(), gb.getGid()));
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
		pic2.append(String.format("<img src=\"%s/resources/pictures/%s\" alt=\"%s\"", contextRoot, gb.getPicName(), gb.getPicContent()));
		pic2.append(String.format(" style=\"width: 100%%;\">"));
		pic2.append(String.format("<div class=\"carousel-caption\">"));
		pic2.append(String.format("<h3>%s</h3>", gb.getPicContent()));
		pic2.append(String.format("</div>"));
		pic2.append(String.format("</div>"));

	}
	//---------------------------------

	//성공, 실패 메시지 출력용 변수 ----------------------
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


div#topBtn {
	position: fixed;
	bottom: 10px;
	right: 10px;
}

div#bottomBtn {
	position: fixed;
	top: 10px;
	right: 10px;
}

</style>

<!-- 사용자 정의 함수 등록 -->
<script src="<%=contextRoot%>/resources/script/util.js"></script>

<!-- Google Map API -->
<script src="https://maps.googleapis.com/maps/api/js"></script>

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<script>
	$(document).ready(function() {
		
        //------------------------------------------------------------------------------
		//남은 날짜 계산 함수 호출
		$("span#date").text(myDate("2018-06-01"));
        //------------------------------------------------------------------------------

        //------------------------------------------------------------------------------
		//검색 진행하는 경우 key, value를 가지고 현재 컨트롤의 상태를 이전값으로 설정 필요.
		var key = "<%=key%>";
		var value = "<%=value%>";
		$("select#key > option[value=" + key + "]").attr("selected", "selected");
		$("input#value").val(value);
		//------------------------------------------------------------------------------

		//------------------------------------------------------------------------------
		//삭제 버튼 클릭시 모달창 오픈하는 과정
		$("button.btnDelete").on("click", function() {
			//삭제를 위한 번호를 지정하는 액션 추가
			//-><input type="hidden"> 태그의 value="" 속성
			$("div#deleteFormModal input#gid").val($(this).val());
			//모달창 오픈
			$("div#deleteFormModal").modal();
		});
		//------------------------------------------------------------------------------

		//------------------------------------------------------------------------------
		//맵 버튼 클릭시 (구글맵)모달창 오픈하는 과정
		$("button.map").on("click", function() {
			$("div#googleMapModal").modal();
		});
		//모달창 이벤트 등록 -> myMap() 함수 호출, 동적 생성된 엘리먼트 삭제 연계
		$("div#googleMapModal").on("shown.bs.modal", function() {
			myMap();
		});
		$("div#googleMapModal").on("hidden.bs.modal", function() {
			$("div#googleMap").empty();
		});
		//------------------------------------------------------------------------------

		
		//----------------
		//이전, 다음 버튼에 대한 이벤트 등록 및 비활성/활성 처리
		
		//검색 진행시 이전, 다음 버튼 전체를 비활성.
		if ("<%=key%>" != "ALL") {
		 	$("button.btnPrevious").attr("disabled", "disabled");
			$("button.btnNext").attr("disabled", "disabled")
		}
		 
		 // 첫 페이지 Previous 버튼 비활성화
		 if(<%=previous%>==0){
		 	$("button.btnPrevious").attr("disabled", "disabled");
		 }
		 
		 // 마지막 페이지 Next 버튼 비활성화
		 if(<%=next%> > Math.ceil(<%=totalCount%>/<%=limit_count%>)){
		       $("button.btnNext").attr("disabled", "disabled")
		 }
		 
		 // 이전, 다음 버튼에 대한 이벤트 처리
		 $("button.btnPrevious").on("click", function() {
		  location.assign("?pageNum=<%=previous%>");
		 });
		 
		 
		 $("button.btnNext").on("click", function() {
		  location.assign("?pageNum=<%=next%>");
		 });

		//
		
		
	});
</script>


<script>
	function myMap() {

		//위도, 경도 
		var handok = new google.maps.LatLng(37.499285, 127.033271);
		var center = new google.maps.LatLng(37.500544, 127.033215);

		//맵 정보
		var mapProp = {
			center : center,
			zoom : 17,
		};
		//맵 요청
		var map = new google.maps.Map(document.getElementById("googleMap"),
				mapProp);

		//마커 표시
		var marker = new google.maps.Marker({
			position : handok
		});
		marker.setMap(map);

		//InfoWindow
		var infowindow = new google.maps.InfoWindow(
				{
					content : "<div style=\"text-align:center;\"><strong>한독약품빌딩</strong><br>서울특별시 강남구 역삼1동 735<br><img src=\"<%=contextRoot%>/resources/img/handok_small.png\"></div>"
				});
		infowindow.open(map, marker);

	}
</script>

</head>
<body>

	<div class="container" id="top">

		<div class="panel page-header" style="text-align: center;">
			<h1 style="font-size: xx-large;">
				<a href="<%=contextRoot%>/index.jsp"><img src="<%=contextRoot%>/resources/img/sist_logo.png"
					alt="sist_logo.png"></a> 방명록 <small>v1.5</small> <span
					style="font-size: small; color: #777777;"></span>
			</h1>
		</div>

		<div class="nanel panel-default" style="padding-bottom: 10px;">
			<div class="panel-heading">
				서울특별시 강남구 역삼 1동 735 한독약품빌딩 8층 쌍용교육센터 / 지하철 2호선 역삼역 3번출구<br>
				Java&amp;Python 기반 응용SW 개발자 양성과정 2017.11.01 ~ 2018.06.01 <span
					style="color: red;" id="date">(D day)</span>
				<button class="btn btn-default btn-xs map">Map</button>
				<button class="btn btn-default btn-xs admin" data-toggle="modal" data-target="#adminFormModal">Admin</button>
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

				<form action="<%=contextRoot%>/views/guestbook/guestbookInsert.jsp" method="post">
					<div class="form-group">
						<input type="text" class="form-control" id="name_" name="name_"
							placeholder="Name(max 20)" required>
					</div>
					<div class="form-group">
						<input type="password" class="form-control" id="pw" name="pw"
							placeholder="PASSWORD(max:20)" required>
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
						<button type="button" class="btn btn-default btnPrevious">
							<span class="glyphicon glyphicon-step-backward"></span> Previous
						</button>
						<button type="button" class="btn btn-default btnNext">
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
	

	<!-- Modal -->
	<div id="deleteFormModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Delete</h4>
				</div>
				<div class="modal-body">

					<p>본인이 작성한 글인지 확인하는 절차입니다.</p>

					<form action="<%=contextRoot%>/views/guestbook/guestbookDelete.jsp" method="post">

						<!-- 주의) 삭제 진행을 위해서 글번호 정보가 필요합니다. -->
						<input type="hidden" id="gid" name="gid" value="G00001">

						<div class="form-group">
							<input type="password" class="form-control" id="pw" name="pw"
								placeholder="PASSWORD(max:20)" required>
						</div>

						<button type="submit" class="btn btn-default">Submit</button>

					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>


	<!-- Modal -->
	<div id="adminFormModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Admin Login</h4>
				</div>
				<div class="modal-body">

					<p>관리자인지 확인하는 절차입니다.</p>

					<form action="<%=contextRoot%>/views/login/login.jsp" method="post">

						<div class="form-group">
							<input type="text" class="form-control" id="id" name="id"
								placeholder="ID(max:20)" required>
						</div>

						<div class="form-group">
							<input type="password" class="form-control" id="pw" name="pw"
								placeholder="PASSWORD(max:20)" required>
						</div>

						<button type="submit" class="btn btn-default">Submit</button>

					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>


	<!-- Modal -->
	<div id="googleMapModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Google Map</h4>
				</div>
				<div class="modal-body">

					<!-- 맵 출력 -->
					<div id="googleMap" style="width: 100%; height: 500px;"></div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>
<!-- 
	<div id="bottomBtn">
		<button type="button" class="btn btn-default" onclick="location.assign('#bottom')">
			Bottom <span class="glyphicon glyphicon-arrow-down"></span>
		</button>
	</div>

	<div id="topBtn">
		<button type="button" class="btn btn-default" onclick="location.assign('#top')">
			Top <span class="glyphicon glyphicon-arrow-up"></span>
		</button>
	</div>
 -->
	<div id="bottom"></div>

</body>
</html>