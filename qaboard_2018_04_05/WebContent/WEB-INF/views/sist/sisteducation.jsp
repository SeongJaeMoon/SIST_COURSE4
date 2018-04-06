<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SIST_쌍용교육센터</title>
<meta name="viewport" content="width=device-width, initial-scale=1">


<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<script src="${pageContext.request.contextPath}/resources/script/util.js"></script>

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

	function initialize() {
		//한독약품빌딩
		//서울특별시 강남구 역삼1동 735
		//37.499362, 127.033202
		var myCenter = new google.maps.LatLng(37.499362, 127.033202);
		var mapProp = {
			center : myCenter,
			zoom : 16,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};

		var map = new google.maps.Map(document.getElementById("googleMap"),
				mapProp);

		var marker = new google.maps.Marker({
			position : myCenter,
		});

		marker.setMap(map);
	}
</script>

</head>
<body>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header" style="padding:10px;">
				<a href="${pageContext.request.contextPath}/main"><img src="${pageContext.request.contextPath}/resources/img/sist_logo.png" alt="sist_logo.png" style="vertical-align: bottom;"></a>
			</div>
			<div>
				<ul class="nav navbar-nav">
					<li><a
						href="${pageContext.request.contextPath}/sist/main">Home</a></li>
					<li><a
						href="${pageContext.request.contextPath}/sist/intro">센터소개</a></li>
					<li class="active"><a
						href="${pageContext.request.contextPath}/sist/education">교육과정
							소개</a></li>
					<li><a
						href="${pageContext.request.contextPath}/qaboard/list">문의게시판</a></li>
					<li><a href="#" data-toggle="modal"
						data-target="#myLoginFormModal">회원가입/로그인</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container">
		<div class="panel-group">

			<div class="panel panel-default" id="output">
				<div class="panel-heading">교육개요</div>
				<div class="panel-body">
					<p>IT는 거의 모든 산업 분야에서 연관 되어져 있으며 앞으로도 지속적으로 발전 가능성이 많은 분야입니다. 국내
						IT 서비스 시장은 지속적으로 성장을 하고 있으며, IT 서비스 산업 자체의 변화 등 다양한 시장 환경 변화 움직임
						속에 신규 사업 발굴 작업이 지속되고, 시작 경쟁 구도의 변화 움직임이 확대될 전망입니다.</p>
					<p>그에 따른 전문인력 수급이 현저히 부족한 상황이고, 구직자들의 수준은 기업에서 요구하는 직무 능력에 충족이
						되지 못하고 있는 상황입니다. 청년층의 첫 일자리 전공 불일치 비율이 80%에 달하고, 기업에서는 신입 사원을
						재교육하는데 드는 비용이 크기 때문에 사전에 전문 교육을 이수한 구직자를 선호하고 있습니다.</p>
					<p>국가직무능력표준(NCS) 기반 채용 확대가 이어질 전망이며, 성공적인 IT 취업을 위해서는 이제 자격증만이
						아닌 자신의 직무능력 전문성을 길러야 하는 시대입니다.</p>
					<p>
						<span class="text-primary">교육센터에서 진행하는 과정들은 실무 중심의 이론과 실습을
							병행하는 최적의 과정입니다.</span>
					</p>
				</div>
			</div>

			<div class="panel panel-default" id="output">
				<div class="panel-heading">교육대상</div>
				<div class="panel-body">
					<ul>
						<li>실업자/미취업자</li>
						<li>고등학교 3학년 재학 중인 사람으로서 대학교(전문대학)에 진학하지 아니할 것으로 예정된 사람</li>
						<li>대학교(전문대학)의 최종 학년에 재학중인 사람. 내년도 2월/8월 졸업예정자 가능.</li>
						<li>IT관련학과 우대 (컴퓨터공학, 정보통신 등)</li>
						<li>IT분야 신규 취업 또는 전직 희망자</li>
					</ul>
				</div>
			</div>

			<div class="panel panel-default" id="output">
				<div class="panel-heading">교육목표</div>
				<div class="panel-body">
					<ul>
						<li>다양한 프로그래밍 언어와 데이터베이스 활용 능력 배양</li>
						<li>현장에서 활용 가능한 기술 교육에 대한 필요성과 인력 수요를 충족할 수 있는 중급자 수준의 인력 양성</li>
						<li>축적된 정형화/비정형화된 데이터를 분석하여 정보를 다룰 수 있는 정보제공 서비스의 개발 및 운영이
							가능한 전문 인력 양성</li>
						<li>실무 프로젝트를 통해서 실제 현업에서 요구하는 개발 능력을 갖춘 현장 적합 인력 양성</li>
					</ul>
				</div>
			</div>

			<div class="panel panel-default" id="output">
				<div class="panel-heading">커리큘럼</div>
				<div class="panel-body">
					<p style="text-align: center;">
						<img src="${pageContext.request.contextPath}/resources/pictures/sist_curr.png" style="width:100%;">
					</p>

					<p style="text-align: center;">이외에도 과정별로 다양한 과목들이 진행됩니다.</p>
				</div>
			</div>

			<div class="panel panel-default" id="output">
				<div class="panel-heading">특장점</div>
				<div class="panel-body">
					<p style="text-align: center;">
						<img src="${pageContext.request.contextPath}/resources/pictures/sist_profile.png" style="width:80%;">
					</p>
				</div>
			</div>
			<div class="panel panel-default" id="output">
				<div class="panel-heading">상담예약</div>
				<div class="panel-body">
					<p>과정 문의 상담은 유선 02-3482-4632 / 카톡 OOOOOO / 문자 010-OOOO-OOOO 등으로
						연락 바랍니다.</p>
					<p>방문 상담 환영합니다. 매니저 장OO.</p>

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
							<form role="form" method="post" action="${pageContext.request.contextPath}/login/login">
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
	</div>

</body>
</html>