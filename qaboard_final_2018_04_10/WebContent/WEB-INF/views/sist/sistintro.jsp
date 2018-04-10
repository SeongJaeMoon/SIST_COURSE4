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
<meta name="viewport" content="width=device-width, initial-scale=1">

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
				<a href="${pageContext.request.contextPath}/sist/main"><img
					src="${pageContext.request.contextPath}/resources/img/sist_logo.png"
					alt="sist_logo.png" style="vertical-align: bottom;"></a>
			</div>
			<div>
				<ul class="nav navbar-nav">
					<li><a href="${pageContext.request.contextPath}/sist/main">Home</a></li>
					<li class="active"><a
						href="${pageContext.request.contextPath}/sist/intro">센터소개</a></li>
					<li><a
						href="${pageContext.request.contextPath}/sist/education">교육과정
							소개</a></li>
					<li><a href="${pageContext.request.contextPath}/qaboard/list">문의게시판</a></li>
					<li><a href="#" data-toggle="modal"
						data-target="#myLoginFormModal">회원가입/로그인</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container">
		<div class="panel-group">

			<div class="panel panel-default" id="output">
				<div class="panel-heading">Vision</div>
				<div class="panel-body">
					<p style="text-align: center;">
						<img
							src="${pageContext.request.contextPath}/resources/pictures/sist_vision.jpg">
					</p>
				</div>
			</div>

			<div class="panel panel-default" id="output">
				<div class="panel-heading">History</div>
				<div class="panel-body">
					<p style="text-align: center;">
						<img
							src="${pageContext.request.contextPath}/resources/pictures/sist_history.jpg">
					</p>
				</div>
			</div>

			<div class="panel panel-default" id="output">
				<div class="panel-heading">Computer</div>
				<div class="panel-body">
					<p style="text-align: center;">
						<img
							src="${pageContext.request.contextPath}/resources/pictures/sist_com.jpg">
					</p>
				</div>
			</div>

			<div class="panel panel-default" id="output">
				<div class="panel-heading">Location</div>
				<div class="panel-body">
					<div id="googleMap"
						style="width: 100%; height: 350px; margin: auto;"></div>

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
										class="form-control" id="id_" name="id_"
										placeholder="Enter ID" required="required">
								</div>
								<div class="form-group">
									<label for="pw"> Password :</label> <input type="password"
										class="form-control" id="loginformpw" name="pw_"
										placeholder="Enter Password" required="required">
								</div>

								<!-- 등급 정보 제공을 위한 체크박스 추가 -->
								<div class="form-group">
									 <label><input type="checkbox" name="grade" value="0"> Admin</label>
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

</body>
</html>