<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
</style>

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<script>
	$(document).ready(function() {

		//사진 삭제 버튼에 대한 클릭 이벤트 등록
		//->confirm()
		//->서버에 pid 값 GET 방식 전송
		$("button.btnDelete").on("click", function() {
			if (confirm("선택한 사진을 삭제하시겠습니까?")) {
				location.assign("${pageContext.request.contextPath}/admin/picturedelete?pid=" + $(this).val());
			}
		});

	});
</script>
</head>
<body>

	<div class="container">

		<div class="panel page-header" style="text-align: center;">
			<h1 style="font-size: xx-large;">
				<a href="${pageContext.request.contextPath}/admin/booklist"><img
					src="${pageContext.request.contextPath}/resources/img/sist_logo.png"
					alt="sist_logo.png"></a> 방명록 <small>v2.1</small> <span
					style="font-size: small; color: #777777;"></span>
			</h1>
		</div>

		<nav class="navbar navbar-default">
			<div class="container-fluid">
				<div class="navbar-header"></div>
				<ul class="nav navbar-nav">
					<li><a
						href="${pageContext.request.contextPath}/admin/booklist">방명록	관리</a></li>
					<li class="active"><a
						href="${pageContext.request.contextPath}/admin/picturelist">사진 관리</a></li>
					<li><a href="${pageContext.request.contextPath}/login/logout">[${sessionScope.loginInfo.name_}/${sessionScope.loginInfo.id}] 로그 아웃 </a></li>
				</ul>
			</div>
		</nav>

		<div class="panel panel-default">
			<div class="panel-heading">사진 업로드</div>
			<div class="panel-body">
				<form
					action="${pageContext.request.contextPath}/admin/pictureinsert"
					method="post" enctype="multipart/form-data">

					<div class="form-group">
						<input type="text" class="form-control" id="picContent"
							name="picContent" placeholder="사진 설명(max:50)" required>
					</div>
					<div class="form-group">
						<input type="file" class="form-control" id="picName"
							name="picName" required> <span class="help-block">(.jpg or .png, max 1M)</span>
					</div>

					<button type="submit" class="btn btn-default">Submit</button>


				</form>

			</div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">사진 목록</div>
			<div class="panel-body">

				<div class="row">

					<div class="col-md-3">
						<div class="thumbnail">
							<a
								href="${pageContext.request.contextPath}/resources/pictures/ny.jpg"
								target="_blank"> <img src="${pageContext.request.contextPath}/resources/pictures/ny.jpg" alt="2"
								style="width: 100%"></a>
							<div class="caption">
								<p>뉴욕 공연</p>
							</div>

						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>

</body>
</html>