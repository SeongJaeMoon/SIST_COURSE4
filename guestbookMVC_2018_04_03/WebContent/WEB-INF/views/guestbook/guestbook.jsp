<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%-- jstl-1.2.jar 파일 필요 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script src="${pageContext.request.contextPath}/resources/script/util.js"></script>

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
		//구글맵
		$("button.map").on("click", function() {
			$("div#googleMapModal").modal();
		});
		$("div#googleMapModal").on("shown.bs.modal", function() {
			myMap();
		});
		$("div#googleMapModal").on("hidden.bs.modal", function() {
			$("div#googleMap").empty();
		});
		

		//검색
		var key = "${key}";
		var value = "${value}";
        $("select#key > option[value='"+key+"']").attr("selected","selected");
        $("input#value").val(value);
        
        
		//삭제 버튼 클릭시 모달창 오픈하는 과정
		$("button.btnDelete").on("click", function() {
			$("div#deleteFormModal input#gid").val($(this).val());
			$("div#deleteFormModal").modal();
		});
		
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
					content : "<div style=\"text-align:center;\"><strong>한독약품빌딩</strong><br>서울특별시 강남구 역삼1동 735<br><img src=\"${pageContext.request.contextPath}/resources/img/handok_small.png\"></div>"
				});
		infowindow.open(map, marker);

	}
</script>

</head>
<body>

	<div class="container" id="top">

		<div class="panel page-header" style="text-align: center;">
			<h1 style="font-size: xx-large;">
				<a href="${pageContext.request.contextPath}/guestbook/list"><img
					src="${pageContext.request.contextPath}/resources/img/sist_logo.png"
					alt="sist_logo.png"></a> 방명록 <small>v2.1</small> <span
					style="font-size: small; color: #777777;"></span>
			</h1>
		</div>

		<div class="nanel panel-default" style="padding-bottom: 10px;">
			<div class="panel-heading">
				서울특별시 강남구 역삼 1동 735 한독약품빌딩 8층 쌍용교육센터 / 지하철 2호선 역삼역 3번출구<br>
				Java&amp;Python 기반 응용SW 개발자 양성과정 2017.11.01 ~ 2018.06.01 <span
					style="color: red;" id="date">(D day)</span>
				<button class="btn btn-default btn-xs map">Map</button>
				<button class="btn btn-default btn-xs admin" 
					data-toggle="modal"
					data-target="#adminFormModal">Admin</button>
			</div>
		</div>

		<div class="panel panel-default" id="carousel">
			<div class="panel-heading">Picture List</div>
			<div class="panel-body">
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
					<!-- Indicators -->
					<ol class="carousel-indicators">
						
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						
					</ol>

					<!-- Wrapper for slides -->
					<div class="carousel-inner">

						<div class="item active">
							<img src="${pageContext.request.contextPath}/resources/pictures/ny.jpg" alt="New york" style="width: 100%;">
							<div class="carousel-caption">
								<h3>New york</h3>
							</div>
						</div>
						
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

				<form action="${pageContext.request.contextPath}/guestbook/insert"
					method="post">
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
					<c:if test="${param.success==1}">
					<div class="alert alert-success alert-dismissible fade in" style="display:inline-block; padding-top:5px; padding-bottom:5px; margin:0px;">  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>  <strong>Success!</strong> 요청한 작업이 처리되었습니다. </div>
					</c:if>
					<c:if test="${param.success==0}">
					<div class="alert alert-danger alert-dismissible fade in" style="display:inline-block; padding-top:5px; padding-bottom:5px; margin:0px;">  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>  <strong>Fail!</strong> 요청한 작업 처리가 실패했습니다. </div>
					</c:if>

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
							<td>ServletMVC 과정 진행 중입니다. 프로젝트 발표 사진도 올릴 예정입니다.</td>
							<td>2018-04-02</td>
							<td><div class="btn-group">
									<button type="button" class="btn btn-default btn-xs">삭제</button>
								</div></td>
						</tr>
						 -->
						<!-- EL, JSTL를 이용한 방명록 게시물 출력 -->
						<c:if test="${count==0}">
						<tr><td colspan="5" style="text-align:center;"> <strong>출력 대상이 없습니다.</strong> </td></tr>
						</c:if>
						<c:if test="${count>0}">
						<c:forEach var="g" items="${gbList}">
						<tr>
							<td>${g.gid}</td>
							<td>${g.name_}</td>
							<td>${g.content}</td>
							<td>${g.regDate}</td>
							<td><div class="btn-group">
									<button type="button" class="btn btn-default btn-xs btnDelete" value="${g.gid}">삭제</button>
								</div></td>
						</tr>
						</c:forEach>
						</c:if>
						
					</tbody>
				</table>

				<form class="form-inline" method="post">
					<div class="form-group">
						<button type="button" class="btn btn-default">
							TotalCount <span class="badge">${totalCount}</span>
						</button>
						<button type="button" class="btn btn-default">
							Count <span class="badge">${count}</span>
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

					<form action="${pageContext.request.contextPath}/guestbook/delete"
						method="post">

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

					<form action="${pageContext.request.contextPath}/login/login" method="post">

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