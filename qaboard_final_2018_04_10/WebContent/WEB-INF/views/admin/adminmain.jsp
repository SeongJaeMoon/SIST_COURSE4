<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>SIST_쌍용교육센터</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<script
	src="${pageContext.request.contextPath}/resources/script/util.js"></script>

<script src="https://maps.googleapis.com/maps/api/js"></script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<style>
div#input:hover, div#output:hover {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
}
</style>
<script>
	$(document).ready(function() {

	});
</script>


<script>
	var position01 = new google.maps.LatLng(37.500197, 127.033471);
	var position02 = new google.maps.LatLng(37.499362, 127.033202);

	function myMap() {

		//구글 맵 정보 설정
		var mapProp = {
			center : position01,
			zoom : 17,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		var map = new google.maps.Map(document.getElementById("googleMap"),
				mapProp);

		//마커 정보 설정
		var marker = new google.maps.Marker({
			position : position02,
		});
		marker.setMap(map);

		//윈포윈도우 설정
		var infowindow = new google.maps.InfoWindow(
				{
					content : "한독약품빌딩<br>서울특별시 강남구 역삼1동 735<br><img src=\"${pageContext.request.contextPath}/resources/img/handok_small.png\">"
				});
		google.maps.event.addListener(marker, 'click', function() {
			infowindow.open(map, marker);
		});

	}
</script>

</head>
<body>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header" style="padding: 10px;">
				<a href="${pageContext.request.contextPath}/admin/main"><img
					src="${pageContext.request.contextPath}/resources/img/sist_logo.png"
					alt="sist_logo.png" style="vertical-align: bottom;"></a>
			</div>
			<div>
				<ul class="nav navbar-nav">
					<li class="active"><a
						href="${pageContext.request.contextPath}/admin/main">Home</a></li>
					<li><a href="#">과정</a></li>
					<li><a href="#">공지사항</a></li>
					<li><a
						href="${pageContext.request.contextPath}/admin/qaboardlist">문의게시판</a></li>
					<li><a href="#">회원</a></li>
					<li><a href="#">상담</a></li>
					<li><a href="#">성적</a></li>
					<li><a href="#">교재</a></li>
					<li><a href="${pageContext.request.contextPath}/login/logout">관리자(${sessionScope.adminlogin.id_})
							로그아웃</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container">
		<div class="panel-group">
			<div class="panel panel-primary" id="output">
				<div class="panel-heading">
					강남캠퍼스 02-3482-4632 서울특별시 강남구 테헤란로 132 (역삼동) 한독약품빌딩 8층
					<button type="button" class="btn btn-default btn-xs btnMap"
						id="map">Map</button>
				</div>
				<div class="panel-body">

					<table class="table">
						<thead>
							<tr>
								<th>번호</th>
								<th>구분</th>
								<th>과정명</th>
								<th>교육기간</th>
								<th>교육시간</th>
								<th>교육비용</th>
								<th>정원</th>
								<th>과정신청/<br>상세보기
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>155</td>
								<td>정부지원</td>
								<td>웹프로그래머 취업 전문 과정<br> <span
									class="text-danger small">(매월 316,000원 수당 지급)</span></td>
								<td>2018.01.10~2018.05.24</td>
								<td>09:00~18:00</td>
								<td><span class="text-danger">전액 무료</span></td>
								<td>25명</td>
								<td><button type="button" class="btn btn-default btn-xs">상세보기</button></td>
							</tr>
							<tr>
								<td>154</td>
								<td>정부지원</td>
								<td>사물인터넷 기술 구현 과정</td>
								<td>2018.02.16~2018.04.13</td>
								<td>09:00~18:00</td>
								<td><span class="text-danger">전액 무료</span></td>
								<td>25명</td>
								<td><button type="button" class="btn btn-default btn-xs">상세보기</button></td>
							</tr>
							<tr>
								<td>153</td>
								<td>주말과정</td>
								<td>개발자를 위한 Java Programming</td>
								<td>2018.02.7, 14, 21, 28, 03.5</td>
								<td>10:00~18:00</td>
								<td>263,480원<br> <span class="text-danger small">(재직자
										환급 210,784원)</span></td>
								<td>20명</td>
								<td><button type="button" class="btn btn-default btn-xs">상세보기</button></td>
							</tr>
							<tr>
								<td>152</td>
								<td>주말과정</td>
								<td>빅데이터 설계 및 분석 과정</td>
								<td>2018.03.7, 14, 21, 28, 04.5</td>
								<td>10:00~18:00</td>
								<td>230,090원<br> <span class="text-danger small">(재직자
										환급 184,072원)</span></td>
								<td>20명</td>
								<td><button type="button" class="btn btn-default btn-xs">상세보기</button></td>
							</tr>
							<tr>
								<td>151</td>
								<td>주말과정</td>
								<td>실무 중심의 Oracle SQL &amp; PL/SQL</td>
								<td>2018.03.7, 14, 21, 28, 04.5</td>
								<td>10:00~18:00</td>
								<td>263,480원<br> <span class="text-danger small">(재직자
										환급 210,784원)</span></td>
								<td>20명</td>
								<td><button type="button" class="btn btn-default btn-xs">상세보기</button></td>
							</tr>
						</tbody>
					</table>

				</div>
			</div>

			<div class="panel panel-default" id="output">
				<div class="panel-heading">공지사항</div>
				<div class="panel-body">

					<table class="table">
						<thead>
							<tr>
								<th>번호</th>
								<th style="width: 70%;">제목</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>114</td>
								<td><a href="#demo137" data-toggle="collapse">Framework를
										활용한 빅데이터 개발자 과정 수료 안내</a>
									<div id="demo137" class="collapse"
										style="width: 80%; margin: 10px;">
										<p>
											당 교육센터에서는 Framwork를 활용한 빅데이터 개발자 과정이 수료함 알려드립니다.<br>
											교육장소 : 강남교육센터<br> 교육일정 : 2017.06.3~2017.12.03 매주
											월~금(09:00~18:00)<br>
										</p>
									</div></td>
								<td>2017-11-03</td>
							</tr>
							<tr>
								<td>113</td>
								<td><a href="#demo136" data-toggle="collapse">2018년
										정부지원 무료 교육 안내</a>
									<div id="demo136" class="collapse"
										style="width: 80%; margin: 10px;">
										<p>
											당 교육센터에서는 고용노동부와 한국산업인력공단 주관으로 국가기간전략산업직종훈련 교육생을 아래와 같이
											모집합니다.<br> 교육장소 : 강남교육센터 , 강북교육센터<br> 교육일정 : 총
											5.5~6개월 매주 월~금(09:00~18:00)<br> 교육대상 : 미취업자 /
											졸업예정자(2018년 2월 졸업예정자)<br> 교육비용 :국비전액지원(교육비 및 교재비 전액지원)<br>
											훈련수당 : 월 236,000원~316,000원 지급
										</p>

									</div></td>
								<td>2017-10-30</td>
							</tr>
						</tbody>
					</table>
					<ul class="pager">
						<li><button type="button" class="btn btn-default btn-sm">Previous</button></li>
						<li><button type="button" class="btn btn-default btn-sm">Next</button></li>
					</ul>

				</div>
			</div>


		</div>


		<!-- Google Map Modal -->
		<div id="mapModal" class="modal fade" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Google Map</h4>
					</div>
					<div class="modal-body">

						<div id="googleMap"
							style="width: 550px; height: 380px; margin: auto;"></div>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm"
							data-dismiss="modal">Close</button>
					</div>
				</div>

			</div>
		</div>

		<!-- Modal -->
		<div id="myLoginFormModal" class="modal fade" role="dialog">

			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header" style="padding: 35px 50px;">
						<h4>
							<span class="glyphicon glyphicon-lock"></span> 로그인
						</h4>
						<label>정상적인 서비스 사용을 위해서 로그인해야 합니다.</label>
					</div>
					<div class="modal-body" style="padding: 40px 50px;">
						<form role="form" method="post"
							action="${pageContext.request.contextPath}/login/login">
							<div class="form-group">
								<label for="id"> ID :</label> <input type="text"
									class="form-control" id="id_" name="id_" placeholder="Enter ID"
									required="required">
							</div>
							<div class="form-group">
								<label for="pw"> Password :</label> <input type="password"
									class="form-control" id="pw" name="pw"
									placeholder="Enter Password" required="required">
							</div>
							<button type="submit" class="btn btn-default btn-block">
								Login</button>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm"
							id="memberInsertForm">회원가입</button>
						<button type="button" class="btn btn-default btn-sm"
							data-dismiss="modal">Close</button>
					</div>
				</div>

			</div>

		</div>

	</div>

	<footer class="container-fluid bg-4 text-center">
		<p>www.sist.co.kr 쌍용교육센터 since 1985</p>
	</footer>

</body>
</html>