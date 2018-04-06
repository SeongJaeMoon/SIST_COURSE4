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

        //------------------------------------------------------------------------------
		//검색
		var key = "${key}";
		var value = "${value}";
		$("select#key > option[value='" + key + "']").attr("selected", "selected");
		$("input#value").val(value);
		//------------------------------------------------------------------------------

		
		//-----------------
		//블라인드
		$("button.blindON").on("click", function() {
			if (confirm("선택한 게시물을 블라인드 지정할까요?")) {
				location.assign("${pageContext.request.contextPath}/admin/blind?gid="+$(this).val()+"&blind=1");
			}
		});
		$("button.blindOFF").on("click", function() {
			if (confirm("선택한 게시물을 블라인드 해제할까요?")) {
				location.assign("${pageContext.request.contextPath}/admin/blind?gid="+$(this).val()+"&blind=0");
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
				<a href="${pageContext.request.contextPath}/admin/booklist"><img src="${pageContext.request.contextPath}/resources/img/sist_logo.png"
					alt="sist_logo.png"></a> 방명록 <small>v2.1</small> <span
					style="font-size: small; color: #777777;"></span>
			</h1>
		</div>

		<nav class="navbar navbar-default">
			<div class="container-fluid">
				<div class="navbar-header"></div>
				<ul class="nav navbar-nav">
					<li class="active"><a href="${pageContext.request.contextPath}/admin/booklist">방명록 관리</a></li>
					<li><a href="${pageContext.request.contextPath}/admin/picturelist">사진 관리</a></li>
					<li><a href="${pageContext.request.contextPath}/login/logout">[${sessionScope.loginInfo.name_}/${sessionScope.loginInfo.id}] 로그 아웃</a></li>
				</ul>
			</div>
		</nav>


		<div class="panel panel-default" id="output">
			<div class="panel-heading">방명록 글목록 </div>
			<c:if test="${param.ret==1}">
				<div class="alert alert-success alert-dismissible fade in"
					style="display: inline-block; padding-top: 5px; padding-bottom: 5px; margin: 0px;">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					<strong>Success!</strong> 요청한 작업이 처리되었습니다.
				</div>
			</c:if>
			<c:if test="${param.ret==0}">
				<div class="alert alert-danger alert-dismissible fade in"
					style="display: inline-block; padding-top: 5px; padding-bottom: 5px; margin: 0px;">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					<strong>Fail!</strong> 요청한 작업 처리가 실패했습니다.
				</div>
			</c:if>

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
						
					
						
						<c:if test="${gbListCount == 0}">
						<tr><td colspan="5" style="text-align:center;"> <strong>출력 대상이 없습니다.</strong> </td></tr>
						</c:if>
						
						<c:if test="${gbListCount > 0}">
						
						<c:set var="blindCount" value="0" />
						
						
						<c:forEach var="g" items="${gbList}" >
						
						<c:if test ="${g.blind == 1}">
							<c:set var="blindCount" value = "${blindCount+1}"/>
						</c:if>	
						
						
						</c:forEach>
						</c:if>	 
											
						<c:if test="${totalCount == 0}">
						<tr><td colspan="5" style="text-align:center;"> <strong>출력 대상이 없습니다.</strong> </td></tr>
						</c:if>
						
						<c:if test="${totalCount > 0}">
						<c:forEach var="g" items="${gbList}">
						<tr>
							<td>${g.gid}</td>
							<td>${g.name_}</td>
							<td>${g.content}</td>
							<td>${g.regDate}</td>
							<td>${g.clientIP }
							<td><div class="input-group-btn">
									<button type="button" class="btn btn-default btn-xs blindON ${g.blind == 1? 'active' : ''}" value ="${g.gid}">On</button>
									<button type="button" class="btn btn-default btn-xs blindOFF ${g.blind == 0 ? 'active' : ''}" value="${g.gid}">Off</button>
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
							Count <span class="badge">${gbListCount}</span>
						</button>
						<button type="button" class="btn btn-default">
							BlindCount <span class="badge">${blindCount}</span>
						</button>
						<button type="button" class="btn btn-default" disabled>
							<span class="glyphicon glyphicon-step-backward"></span> Previous
						</button>
						<button type="button" class="btn btn-default" disabled>
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
